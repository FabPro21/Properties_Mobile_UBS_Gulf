import 'dart:io';
import 'dart:typed_data';
import 'package:fap_properties/data/models/tenant_models/service_request/get_ticket_replies_model.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/utils/constants/check_file_extension.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:path_provider/path_provider.dart';

import '../../../../../data/models/tenant_models/service_request/doc_file.dart';
import '../../../../../utils/styles/colors.dart';
import '../tenant_request_details_controller.dart';

class TenantServiceUpdatesController extends GetxController {
  TenantServiceUpdatesController({this.reqNo});
  String reqNo;
  RxBool gettingReplies = false.obs;
  String errorGettingReplies = '';
  GetTicketRepliesModel ticketReplies;

  RxBool typing = false.obs;
  RxBool addingReply = false.obs;
  String errorReplying = '';

  TenantRequestDetailsController reqDetailsController = Get.find();

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

  void getTicketReplies() async {
    chatUpdate = true;
    gettingReplies.value = true;
    var resp = await TenantRepository.getTicketReplies(reqNo);
    if (resp is GetTicketRepliesModel) {
      ticketReplies = resp;
      updateChat();
    } else {
      errorGettingReplies = resp;
    }
    gettingReplies.value = false;
  }

  Future updateChat() async {
    var resp = await TenantRepository.getTicketReplies(reqNo);
    if (resp is GetTicketRepliesModel) {
      ticketReplies = resp;
    }
    gettingReplies.value = true;
    gettingReplies.value = false;
    await Future.delayed(Duration(seconds: 5));
    if (chatUpdate) updateChat();
  }

  Future<bool> addTicketReply(String reqNo, String message) async {
    addingReply.value = true;
    var resp = await TenantRepository.addTicketReply(
        reqNo, message, fileToUpload.value.path);
    addingReply.value = false;
    if (resp == 'Ok') {
      gettingReplies.value = true;
      final format = DateFormat('dd-MM-yyyy HH:mm a');
      String dateTime = format.format(DateTime.now());
      ticketReplies.ticketReply.add(TicketReply(
          reply: message,
          dateTime: dateTime,
          userId: 123,
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

  // void downloadFilebase64(int index) async {
  //   isLoadingDownload.value = true;
  //   if (ticketReplies.ticketReply[index].path != null) {
  //     OpenFile.open(ticketReplies.ticketReply[index].path);
  //     isLoadingDownload.value = false;
  //   } else {
  //     ticketReplies.ticketReply[index].downloadingFile.value = true;
  //     var result = await TenantRepository.downloadTicketFile(
  //         ticketReplies.ticketReply[index].ticketReplyId);
  //     print('::::::__>>>>Download<<<<___:::::::');

  //     await saveFileInsideTheDevice(result);

  //     isLoadingDownload.value = false;
  //   }
  // }

  // old one which is working fine
  void downloadFile(int index) async {
    isLoadingDownload.value = true;
    if (ticketReplies.ticketReply[index].path != null) {
      OpenFile.open(ticketReplies.ticketReply[index].path);
      isLoadingDownload.value = false;
    } else {
      ticketReplies.ticketReply[index].downloadingFile.value = true;
      var result = await TenantRepository.downloadTicketFile(
          ticketReplies.ticketReply[index].ticketReplyId);
      print('::::::__>>>>Download<<<<___:::::::');
      // ticketReplies.ticketReply[index].downloadingFile.value = false;
      if (result is Uint8List) {
        if (await getStoragePermission()) {
          String path = await createFile(
              result, ticketReplies.ticketReply[index].fileName);
          print('Path :::: $path');
          try {
            OpenResult result = await OpenFile.open(path);
            ticketReplies.ticketReply[index].downloadingFile.value = false;
            isLoadingDownload.value = false;
            if (result.message != 'done') {
              Get.snackbar(
                AppMetaLabels().error,
                result.message,
                backgroundColor: AppColors.white54,
              );
            }
          } catch (e) {
            ticketReplies.ticketReply[index].downloadingFile.value = false;
            isLoadingDownload.value = false;
            print(e);
            Get.snackbar(
              AppMetaLabels().error,
              e.toString(),
              backgroundColor: AppColors.white54,
            );
          }
        }
        ticketReplies.ticketReply[index].downloadingFile.value = false;
        isLoadingDownload.value = false;
      } else {
        ticketReplies.ticketReply[index].downloadingFile.value = false;
        isLoadingDownload.value = false;
        Get.snackbar(
          AppMetaLabels().error,
          AppMetaLabels().noFileReceived,
          backgroundColor: AppColors.white54,
        );
      }
      isLoadingDownload.value = false;
    }
  }

  pickFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    print('Extension of file :::  ${result.files[0].extension}');

    // 112233 checking file extension
    if (!CheckFileExtenstion().checkFileExtFunc(result)) {
      Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileExtensionError,
          duration: Duration(seconds: 5),
          backgroundColor: AppColors.redColor,
          colorText: AppColors.white54);
      return;
    }

    if (result != null) {
      File file = File(result.files.single.path);
      Uint8List bytesFile = await file.readAsBytes();

      // 112233 checking file size file
      // "MB", "GB", "TB", "PB", "EB", "ZB", "YB"
      print('Size of file ::: ${CheckFileExtenstion().getFileSize(bytesFile)}');
      var size = CheckFileExtenstion().getFileSize(bytesFile).split(' ')[0];
      var extension =
          CheckFileExtenstion().getFileSize(bytesFile).split(' ')[1];
      if (extension.contains('MB') ||
          extension.contains('GB') ||
          extension.contains('TB') ||
          extension.contains('PB') ||
          extension.contains('EB') ||
          extension.contains('ZB') ||
          extension.contains('YB')) {
        if (double.parse(size) > 10) {
          Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileSizenError,
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
    print('::::::__>>>>Download<<<<___:::::::');
    print(Permission.storage.request().isGranted);
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

  saveFileInsideTheDevice(Uint8List bytes) async {
    // Get the directory where the file will be saved
    final status = await Permission.storage.status;
    Directory _directory = Directory("");
    if (status.isGranted) {
      if (Platform.isAndroid) {
        // Redirects it to download folder in android
        _directory = Directory("/storage/emulated/0/Download");
      } else {
        _directory = await getApplicationDocumentsDirectory();
      }
      final exPath = _directory.path;
      print("Saved Path: $exPath");
      await Directory(exPath).create(recursive: true);

      final path = exPath;

      File file = File('$path/Testing file12.jpg');

      print("Save file");

      // Write the data in the file you have created

      return file.writeAsBytes(bytes.buffer.asUint8List());
      // return file.writeAsBytes(bytes);
    } else {
      await Permission.storage.request();
    }
  }
}
