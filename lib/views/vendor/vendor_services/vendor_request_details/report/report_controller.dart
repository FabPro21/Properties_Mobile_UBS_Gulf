// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'dart:math';
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/service_request/doc_file.dart';
import 'package:fap_properties/data/models/tenant_models/service_request/photo_file.dart';
import 'package:fap_properties/data/models/vendor_models/sr_rport_detail_model.dart';
import 'package:fap_properties/data/repository/vendor_repository.dart';
import 'package:fap_properties/utils/constants/check_file_extension.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/image_compress.dart';
import '../main_info/main_info_controller.dart';

class SvcReqReportController extends GetxController {
  //
  final mainInfoController = Get.find<SvcReqMainInfoController>();
  int? caseNo;
  bool? status;
  /////photos
  RxBool gettingPhotos = false.obs;
  String errorGettingPhotos = '';
  List<PhotoFile> photos = [PhotoFile()];
  final ImagePicker _picker = ImagePicker();
  ////report
  Rx<DocFile> report = DocFile().obs;
  RxBool loadingReport = false.obs;
  String errorLoadingReport = '';

  RxBool loadingDataReportTAB = false.obs;
  RxString errorLoadingReportTAB = ''.obs;

  RxBool editingReport = false.obs;
  bool errorEditingReport = false;

  //////close req
  RxBool canClose = false.obs;
  RxBool closingReq = false.obs;
  bool errorClosingReq = false;

  @override
  onInit() {
    super.onInit();
    canClose.value =
        mainInfoController.vendorRequestDetails.value.statusInfo!.canClose!;
  }

  Future<void> getPhotos() async {
    photos.clear();
    errorGettingPhotos = '';
    gettingPhotos.value = true;
    var resp = await VendorRepository.getReqPhotos(caseNo!, 3);
    if (resp is List<PhotoFile>) {
      photos = resp;
      if (canClose.value) photos.add(PhotoFile());
    } else if (resp == 404 || resp == AppMetaLabels().noDatafound) {
      photos.add(PhotoFile());
    } else
      errorGettingPhotos = resp;
    gettingPhotos.value = false;
  }

  pickPhoto(ImageSource source) async {
    try {
      print(source);
      XFile? file = await _picker.pickImage(source: source);

      // checking file ext Cheque
      if (!CheckFileExtenstion().checkImageExtFunc(file!.path)) {
        SnakBarWidget.getSnackBarErrorRedWith5Sec(
          AppMetaLabels().error,
          AppMetaLabels().fileExtensionError,
        );

        return;
      }

      if (file != null) {
        gettingPhotos.value = true;
        Uint8List photo = await file.readAsBytes();
        photo = await compressImage(photo);

        // checking file size Cheque
        print('Size of file **::: ${CheckFileExtenstion().getFileSize(photo)}');
        var sizeN = CheckFileExtenstion().getFileSize(photo).split(' ')[0];
        var extension = CheckFileExtenstion().getFileSize(photo).split(' ')[1];

        if (extension.contains('MB')) {
          gettingPhotos.value = false;
          if (double.parse(sizeN) > 10) {
            SnakBarWidget.getSnackBarErrorRedWith5Sec(
              AppMetaLabels().error,
              AppMetaLabels().fileSizenError,
            );
            return;
          }
        }

        // we are commenting below lines because Editor change the extension 112233
        // final editedImage = await Get.to(() => ImageEditor(
        //       image: photo,
        //     ));
        // if (editedImage != null) photo = editedImage;

        String path = file.path;

        // final extension = p.extension(path);
        // print('(((((((((((((((((((object)))))))))))))))))))');
        // print(extension);

        if (photo != null && await getStoragePermission()) {
          final newPath = await getTemporaryDirectory();
          final newFile = File("${newPath.path}/${file.path.split('/').last}");
          if (newFile != null) {
            await newFile.writeAsBytes(photo);
            path = newFile.path;
          }
          photos[photos.length - 1] =
              PhotoFile(file: photo, path: path, type: file.mimeType);
          uploadPhoto(photos.length - 1);
          photos.add(PhotoFile());
        }
        gettingPhotos.value = false;
      }
    } catch (e) {
      print('Exception ::::: $e');
    }
  }

  uploadPhoto(int index) async {
    photos[index].errorUploading = false;
    photos[index].uploading.value = true;
    try {
      var resp = await VendorRepository.uploadFile(
          caseNo??0, photos[index].path??"", 'Images', '', 0);
      photos[index].uploading.value = false;
      photos[index].id = resp['photoId'];
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      photos[index].errorUploading = true;
      photos[index].uploading.value = false;
    }
  }

  removePhoto(int index) async {
    photos[index].errorRemoving = false;
    photos[index].removing.value = true;
    var resp =
        await VendorRepository.removeReqPhoto(photos[index].id.toString());
    if (resp == 200) {
      gettingPhotos.value = true;
      photos.removeAt(index);
      gettingPhotos.value = false;
    } else {
      photos[index].errorRemoving = true;
      photos[index].removing.value = false;
    }
  }

  // 112233 Close Service Request
  // Future<bool> closeSvcReq(Uint8List signature) async {
  Future<bool> closeSvcReq(Uint8List? signature, String fabCorrectiveAction,
      remedy, description) async {
    errorClosingReq = false;
    closingReq.value = true;
    bool closed = false;
    if (await saveVendorSignature(signature!)) {
      // var resp = await VendorRepository.closeSvcReq(caseNo);
      var resp = await VendorRepository.closeSvcReq(
          caseNo, fabCorrectiveAction, remedy, description);
      if (resp == 200) {
        gettingPhotos.value = true;
        canClose.value = false;
        photos.removeLast();

        SnakBarWidget.getSnackBarErrorBlue(
          AppMetaLabels().success,
          AppMetaLabels().reqClosed,
        );
        gettingPhotos.value = false;
        closed = true;
      } else {
        errorClosingReq = true;

        SnakBarWidget.getSnackBarError(
            AppMetaLabels().error, AppMetaLabels().anyError);
      }
    } else {
      errorClosingReq = true;
    }
    closingReq.value = false;
    return closed;
  }

  pickReport() async {
    try {
      print('Insideeee::::');
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(allowedExtensions: ['pdf'], type: FileType.custom);

      if (!CheckFileExtenstion().checkFileExtFunc(result!)) {
        SnakBarWidget.getSnackBarErrorRedWith5Sec(
          AppMetaLabels().error,
          AppMetaLabels().fileExtensionError,
        );
        return;
      }

      if (result != null) {
        File file = File(result.files.single.path??"");
        Uint8List bytesFile = await file.readAsBytes();

        // checking file size Cheque
        print(
            'Size of file *:::* ${CheckFileExtenstion().getFileSize(bytesFile)}');
        var sizeN = CheckFileExtenstion().getFileSize(bytesFile).split(' ')[0];
        var extension =
            CheckFileExtenstion().getFileSize(bytesFile).split(' ')[1];
        if (extension.contains('MB')) {
          if (double.parse(sizeN) > 10) {
            SnakBarWidget.getSnackBarErrorRedWith5Sec(
              AppMetaLabels().error,
              AppMetaLabels().fileSizenError,
            );
            return;
          }
        }

        String path = file.path;
        String size = getFileSize(bytesFile);
        report.value = DocFile(path: path, file: bytesFile, size: size);
        uploadReport();
      }
    } catch (e) {
      print('Exception ::::: $e');
    }
  }

  uploadReport() async {
    errorEditingReport = false;
    editingReport.value = true;
    try {
      // 112233 upload file Repo
      var resp = await VendorRepository.uploadFile(
          caseNo!, report.value.path??"", 'Document', '', 0);

      loadingReport.value = true;
      var id = resp['photoId'];
      report.value =
          DocFile(id: id, path: report.value.path, file: report.value.file);
      loadingReport.value = false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errorEditingReport = true;
      loadingReport.value = false;
    }
    editingReport.value = false;
  }

  var getSRReportModel = SRReportDetailModel().obs;
  String listTitle = AppMetaLabels().selectFABCorrectiveAction;
  TextEditingController textEditingControlerFET1 = TextEditingController();
  TextEditingController textEditingControlerFET2 = TextEditingController();
  Future<void> getReportTABData() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    try {
      loadingDataReportTAB.value = true;
      var result = await VendorRepository.getVendorSRReportDetail();
      loadingDataReportTAB.value = false;
      print('Result ::::: $result');
      if (result is SRReportDetailModel) {
        getSRReportModel.value = result;
        if (getSRReportModel.value.status == "Data found successfully") {
          listTitle = AppMetaLabels().fABCorrectiveActionList[
              getSRReportModel.value.data!.fgpCorrectionId!];
          textEditingControlerFET1.text =
              getSRReportModel.value.data!.proposedRemedy ?? "";
          textEditingControlerFET2.text =
              getSRReportModel.value.data!.description ?? "";
        } else {
          textEditingControlerFET1.text = '';
          textEditingControlerFET2.text = '';
        }
      } else {
        errorLoadingReportTAB.value = result;
        textEditingControlerFET1.text = '';
        textEditingControlerFET2.text = '';
      }
    } catch (e) {
      print('Exception :::getReportTABData:: $e');
      textEditingControlerFET1.text = '';
      textEditingControlerFET2.text = '';
    }
  }

  void getFiles() async {
    // This
    errorLoadingReport = '';
    loadingReport.value = true;
    var resp = await VendorRepository.getReqDocs(caseNo.toString(), 3);
    if (resp is List<DocFile>) {
      if (resp.isNotEmpty) {
        report.value = resp[0];
        report.value.size = getFileSize(report.value.file!);
      }
    } else
      errorLoadingReport = resp;
    loadingReport.value = false;
  }

  removeReport() async {
    editingReport.value = true;
    errorEditingReport = false;
    var resp =
        await VendorRepository.removeReqPhoto(report.value.id.toString());
    if (resp == 200) {
      report.value = DocFile();
    } else {
      errorEditingReport = true;
    }
    editingReport.value = false;
  }

  void showReport() async {
    // This
    if (report.value.path == null) {
      if (await getStoragePermission()) {
        String path = await saveReport();
        report.value.path = path;
      }
    }
    await OpenFile.open(report.value.path);
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

  Future<String> saveReport() async {
    final path = await getTemporaryDirectory();
    print(
        'Path :::: ${path.path}/${this.report.value.name}${this.report.value.type}');
    final file =
        File("${path.path}/${this.report.value.name}${this.report.value.type}");
        // File("${path.path}/${this.report.value.name}${this.report.value.type}");
    await file.writeAsBytes(report.value.file!);
    return file.path;
  }

  RxBool savingTenantSign = false.obs;
  RxBool tenantSignatureSaved = false.obs;
  Future<bool> saveTenantSignature(Uint8List? signature) async {
    tenantSignatureSaved.value = false;
    savingTenantSign.value = true;
    bool saved = false;
    if (await getStoragePermission()) {
      String path = await createFile(signature!, 'signature.png');
      if (path != null) {
        var resp = await VendorRepository.uploadTenantSing(
          caseNo.toString(),
          path,
        );
        if (resp is int) {
          SnakBarWidget.getSnackBarErrorBlue(
            AppMetaLabels().error,
            AppMetaLabels().anyError,
          );
        } else {
          SnakBarWidget.getSnackBarErrorBlue(
            AppMetaLabels().success,
            AppMetaLabels().signatureSaved,
          );

          saved = true;
          tenantSignatureSaved.value = true;
        }
      } else {
        SnakBarWidget.getSnackBarError(
          AppMetaLabels().error,
          AppMetaLabels().anyError,
        );
      }
    } else {
      SnakBarWidget.getSnackBarError(
        AppMetaLabels().error,
        AppMetaLabels().storagePermissions,
      );
    }
    savingTenantSign.value = false;
    return saved;
  }

  Future<bool> saveVendorSignature(Uint8List signature) async {
    if (await getStoragePermission()) {
      String path = await createFile(signature, 'signature.png');
      if (path != null) {
        var resp = await VendorRepository.uploadVendorSing(
          caseNo.toString(),
          path,
        );
        if (resp is int) {
          SnakBarWidget.getSnackBarError(
            AppMetaLabels().error,
            AppMetaLabels().anyError,
          );
        } else {
          return true;
        }
      } else {
        SnakBarWidget.getSnackBarError(
          AppMetaLabels().error,
          AppMetaLabels().anyError,
        );
      }
    } else {
      SnakBarWidget.getSnackBarError(
        AppMetaLabels().error,
        AppMetaLabels().storagePermissions,
      );
    }
    return false;
  }

  Future<String> createFile(Uint8List data, String name) async {
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/$name");
    await file.writeAsBytes(data.buffer.asUint8List());
    return file.path;
  }

  String getFileSize(Uint8List file) {
    int bytes = file.length;
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(2)) + ' ' + suffixes[i];
  }
}
