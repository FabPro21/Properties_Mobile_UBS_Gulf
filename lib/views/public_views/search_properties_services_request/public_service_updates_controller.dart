// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'dart:typed_data';

import 'package:fap_properties/data/repository/public_repository.dart';
import 'package:fap_properties/utils/constants/check_file_extension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

import '../../../data/models/tenant_models/service_request/doc_file.dart';
import '../../../data/models/tenant_models/service_request/get_ticket_replies_model.dart';
import '../../../utils/constants/meta_labels.dart';
import '../../../utils/styles/colors.dart';

class PublicServiceUpdatesController extends GetxController {
  RxBool gettingReplies = false.obs;
  String errorGettingReplies = '';
  GetTicketRepliesModel? ticketReplies;

  RxBool typing = false.obs;
  RxBool addingReply = false.obs;
  String errorReplying = '';

  Rx<DocFile> fileToUpload = DocFile().obs;

  bool chatUpdate = true;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  InternalFinalCallback<void> get onDelete {
    chatUpdate = false;
    return super.onDelete;
  }

  void getTicketReplies(String reqNo) async {
    chatUpdate = true;
    gettingReplies.value = true;
    var resp = await PublicRepositoryDrop2.publicGetTicketReply(reqNo);
    if (resp is GetTicketRepliesModel) {
      ticketReplies = resp;
      updateChat(reqNo);
    } else {
      errorGettingReplies = resp;
    }
    gettingReplies.value = false;
  }

  Future updateChat(String reqNo) async {
    var resp = await PublicRepositoryDrop2.publicGetTicketReply(reqNo);
    if (resp is GetTicketRepliesModel) {
      ticketReplies = resp;
    }
    gettingReplies.value = true;
    gettingReplies.value = false;
    await Future.delayed(Duration(seconds: 5));
    if (chatUpdate) updateChat(reqNo);
  }

  Future<bool> addTicketReply(String reqNo, String message) async {
    addingReply.value = true;
    var resp = await PublicRepositoryDrop2.publicAddTicketReply(
        reqNo, message, fileToUpload.value.path ?? "");
    addingReply.value = false;
    if (resp == 'Ok') {
      gettingReplies.value = true;
      final format = DateFormat('dd-MM-yyyy HH:mm a');
      String dateTime = format.format(DateTime.now());
      ticketReplies!.ticketReply!.add(TicketReply(
          reply: message,
          dateTime: dateTime,
          userId2: 123,
          fileName: fileToUpload.value.name,
          path: fileToUpload.value.path));
      gettingReplies.value = false;
      fileToUpload.value = DocFile();
      return true;
    } else {
      errorReplying = resp.toString();
      return false;
    }
  }

  ///////////////////download file////////////
  RxBool isLoadingDownload = false.obs;
  RxInt isLoadingSelectedIndex = (-1).obs;
  void downloadFile(int index) async {
    isLoadingDownload.value = true;
    if (ticketReplies!.ticketReply![index].path != null) {
      OpenFile.open(ticketReplies!.ticketReply![index].path);
      isLoadingDownload.value = false;
    } else {
      ticketReplies!.ticketReply![index].downloadingFile!.value = true;

      var result = await PublicRepositoryDrop2.downloadTicketFile(
          ticketReplies!.ticketReply![index].ticketReplyId ?? 0);

      ticketReplies!.ticketReply![index].downloadingFile!.value = false;
      if (result is Uint8List) {
        // ###1 permission
        // if (await getStoragePermission()) {
        String path = await createFile(
            result, ticketReplies!.ticketReply![index].fileName ?? "");
        try {
          final result = await OpenFile.open(path);
          // OpenResult result = await OpenFile.open(path);
          isLoadingDownload.value = false;
          if (result.message != 'done') {
            Get.snackbar(
              AppMetaLabels().error,
              result.message,
              backgroundColor: AppColors.white54,
            );
          }
        } catch (e) {
          print(e);
          isLoadingDownload.value = false;
          Get.snackbar(
            AppMetaLabels().error,
            e.toString(),
            backgroundColor: AppColors.white54,
          );
        }
        // }
        isLoadingDownload.value = false;
      } else {
        isLoadingDownload.value = false;
        Get.snackbar(
          AppMetaLabels().error,
          AppMetaLabels().noFileReceived,
          backgroundColor: AppColors.white54,
        );
      }
    }
  }

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    /// checking file extension cheque
    if (!CheckFileExtenstion().checkFileExtFunc(result!)) {
      Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileExtensionError,
          duration: Duration(seconds: 5),
          backgroundColor: AppColors.redColor,
          colorText: AppColors.white54);
      return;
    }

    if (result != null) {
      File file = File(result.files.single.path ?? "");
      Uint8List bytesFile = await file.readAsBytes();

      // checking file size Cheque
      print('Size of file ::: ${CheckFileExtenstion().getFileSize(bytesFile)}');
      print('Path of file ::: ${result.files.single.path}');
      var size = CheckFileExtenstion().getFileSize(bytesFile).split(' ')[0];
      var extension =
          CheckFileExtenstion().getFileSize(bytesFile).split(' ')[1];
      if (extension.contains('MB')) {
        if (double.parse(size) > 10) {
          Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileSizenError,
              duration: Duration(seconds: 5),
              backgroundColor: AppColors.redColor,
              colorText: AppColors.white54);
          return;
        }
      }
      String path = file.path;
      fileToUpload.value =
          DocFile(path: path, file: bytesFile, name: path.split('/').last);
    }
  }

  Future<bool> getStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      return true;
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      return await openAppSettings();
    } else if (await Permission.storage.request().isDenied) {
      return false;
    }
    return false;
  }

  Future<String> createFile(Uint8List data, String fileName) async {
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/$fileName");
    await file.writeAsBytes(data.buffer.asUint8List());
    return "${output.path}/$fileName";
  }
}
