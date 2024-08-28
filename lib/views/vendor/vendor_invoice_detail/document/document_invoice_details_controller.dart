// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'dart:math';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/tenant_models/service_request/doc_file.dart';
import 'package:fap_properties/data/repository/vendor_repository.dart';
import 'package:fap_properties/utils/constants/check_file_extension.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/image_compress.dart';
import 'package:fap_properties/views/vendor/vendor_invoice_detail/vendor_invoice_details_controller.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';

class VendorInvoiceDocsController extends GetxController {
  VendorInvoiceDocsController({this.caseNo});
  final controller = Get.find<VendorInvoiceDetailsController>();
  String? caseNo;
  // isDocUploaded for restrict the user to select the other document pla upload karny sy
  RxList isDocUploaded = [].obs;
  RxBool loadingDocs = false.obs;
  String errorLoadingDocs = '';
  RxBool enableSubmit = false.obs;
  RxBool isEnableScreen = true.obs;
  List<DocFile> docs = [];

  Future<void> getFiles() async {
    print("invoicee:::::::::::: new");
    docs.clear();
    errorLoadingDocs = '';
    loadingDocs.value = true;
    isEnableScreen.value = true;
    // sending dumny req no for testing
    var resp =
        await VendorRepository.getDocsByType(controller.caseNoInvoice, 3, 46);
    if (resp is List<DocFile>) {
      if (resp.length == 0) {
        errorLoadingDocs = AppMetaLabels().noDatafound;
      } else {
        docs = resp;
        for (int i = 0; i < resp.length; i++) {
          isDocUploaded.add('false');
        }
      }
    } else
      errorLoadingDocs = resp;
    loadingDocs.value = false;
  }

  // enable/disable the submit button
  void enableSubmitButton() {
    enableSubmit.value = true;
    for (int i = 0; i < docs.length; i++) {
      if (docs[i].id == null) enableSubmit.value = false;
    }
  }

  removeFile(int index) async {
    docs[index].removing.value = true;
    docs[index].errorRemoving = false;

    isEnableScreen.value = false;

    var resp = await VendorRepository.removeReqPhoto(docs[index].id.toString());
    if (resp == 200) {
      loadingDocs.value = true;
      docs[index].path = null;
      docs[index].file = null;
      docs[index].size = null;
      docs[index].id = null;
      docs[index].expiry = null;
      enableSubmitButton();
      loadingDocs.value = false;
    } else {
      docs[index].errorRemoving = true;
    }
    docs[index].removing.value = false;
  }

  int selectedIndexForUploadedDocument = -1;

  //  select from gallery
  pickDoc(int index, BuildContext context) async {
    try {
      docs[index].loading.value = true;
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowedExtensions: [
        'pdf',
        'jpeg',
        'jpg',
        'png',
      ], type: FileType.custom);

      docs[index].loading.value = false;

      if (!CheckFileExtenstion().checkFileExtFunc(result!)) {
        SnakBarWidget.getSnackBarErrorRedWith5Sec(
          AppMetaLabels().error,
          AppMetaLabels().fileExtensionError,
        );
        docs[index].loading.value = false;
        return;
      }

      if (result != null) {
        File file = File(result.files.single.path??"");
        var byteFile = await file.readAsBytes();

        Uint8List editedImage;
        // if doc's extension will .pdf then will not compress or crop
        // if doc's extension will jpg,png or jpeg then will edit and crop
        if (p.extension(result.files.single.path??"") == 'pdf' ||
            p.extension(result.files.single.path??"") == '.pdf') {
        } else {
          // crop the image
          editedImage = await Get.to(() => ImageCropper(
                image: byteFile,
              ));
          byteFile = await compressImage(editedImage);
        }
        var size = CheckFileExtenstion().getFileSize(byteFile).split(' ')[0];
        var extension =
            CheckFileExtenstion().getFileSize(byteFile).split(' ')[1];
        print('This is not pdf extension:4::::: $extension ');
        if (extension.contains('MB')) {
          if (double.parse(size) > 10) {
            SnakBarWidget.getSnackBarErrorRedWith5Sec(
              AppMetaLabels().error,
              AppMetaLabels().fileSizenError,
            );
            return;
          }
        }
        // reconvert Uint8 into File an save in the catche
        Uint8List imageInUnit8List = byteFile;
        final tempDir = await getTemporaryDirectory();
        // File fileNew = await File('${tempDir.path}/image.png').create();
        String fileName = SessionController().getLanguage() == 1
            ? docs[index].name ?? ""
            : docs[index].nameAr ?? "";
        File fileNew = await File(
                '${tempDir.path}/${fileName.replaceAll(' ', '')}${p.extension(result.files.single.path??"")}')
            .create();

        // controller.docs[index].path
        fileNew.writeAsBytesSync(imageInUnit8List);

        // set values
        docs[index].path = fileNew.path;
        docs[index].file = byteFile;
        docs[index].size = size;
        selectedIndexForUploadedDocument = index;
        if (docs[index].path != null) {
          isDocUploaded[index] = 'true';
          update();
        }
      }
      docs[index].loading.value = false;
    } catch (e) {
      docs[index].loading.value = false;
    }
  }

  //  take photo
  Future<void> takePhoto(int index, BuildContext context) async {
    try {
      docs[index].loading.value = true;
      // old one
      final ImagePicker _picker = ImagePicker();
      XFile? result = await _picker.pickImage(source: ImageSource.camera);

      docs[index].loading.value = false;

      if (!CheckFileExtenstion().checkImageExtFunc(result!.path)) {
        SnakBarWidget.getSnackBarErrorRedWith5Sec(
          AppMetaLabels().error,
          AppMetaLabels().fileExtensionError,
        );
        docs[index].loading.value = false;
        return;
      }

      if (result != null) {
        File file = File(result.path);
        var byteFile = await file.readAsBytes();

        // crop the image
        final editedImage = await Get.to(() => ImageCropper(
              image: byteFile,
            ));

        // compress the image
        byteFile = await compressImage(editedImage);

        // checking file size Passport and other
        var size = CheckFileExtenstion().getFileSize(byteFile).split(' ')[0];
        var extension =
            CheckFileExtenstion().getFileSize(byteFile).split(' ')[1];
        if (extension.contains('MB')) {
          if (double.parse(size) > 10) {
            SnakBarWidget.getSnackBarErrorRedWith5Sec(
              AppMetaLabels().error,
              AppMetaLabels().fileSizenError,
            );
            return;
          }
        }
        // reconvert Uint8 into File an save in the catche
        Uint8List imageInUnit8List = byteFile;
        final tempDir = await getTemporaryDirectory();
        String fileName = SessionController().getLanguage() == 1
            ? docs[index].name ?? ""
            : docs[index].nameAr ?? "";
        File fileNew =
            await File('${tempDir.path}/$fileName${p.extension(result.path)}')
                .create();
        fileNew.writeAsBytesSync(imageInUnit8List);

// set values
        docs[index].path = fileNew.path;
        docs[index].file = byteFile;
        docs[index].size = size;
        selectedIndexForUploadedDocument = index;
        if (docs[index].path != null) {
          isDocUploaded[index] = 'true';
          update();
        }
      }
      docs[index].loading.value = false;
    } catch (e) {
      docs[index].loading.value = false;
    }
  }

  setExpDate(int index, String date) {
    docs[index].update.value = true;
    docs[index].expiry = date;
    docs[index].update.value = false;
  }

  clearExpDate(int index) {
    docs[index].update.value = true;
    docs[index].expiry = null;
    docs[index].update.value = false;
  }

  Future uploadDoc(int index, int caseNo, String reqID) async {
    try {
      docs[index].loading.value = true;
      docs[index].errorLoading = false;
      isEnableScreen.value = false;
      var resp = await VendorRepository.uploadFileInvoiceSR(
          caseNo,
          docs[index].path??"",
          docs[index].name??"",
          '',
          docs[index].documentTypeId??0,
          reqID);
      var id = resp['photoId'];
      docs[index].id = id;
      enableSubmitButton();
      isDocUploaded[index] = 'false';
      update();

      SnakBarWidget.getSnackBarSuccess(
        AppMetaLabels().success,
        AppMetaLabels().fileUploaded,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      print(e);
      docs[index].errorLoading = true;
      isDocUploaded[index] = 'false';
    }
    docs[index].loading.value = false;
    loadingDocs.value = true;
    loadingDocs.value = false;
  }

  Future updateDoc(int index) async {
    try {
      docs[index].loading.value = true;
      docs[index].errorLoading = false;
      isEnableScreen.value = false;
      var resp = await VendorRepository.updateFile(
          docs[index].id??0, docs[index].path??"", '');
      if (resp == 200) {
        docs[index].isRejected = false;
        enableSubmitButton();
        isDocUploaded[index] = 'false';
        update();

        SnakBarWidget.getSnackBarSuccess(
          AppMetaLabels().success,
          AppMetaLabels().fileUploaded,
        );
      } else {
        docs[index].errorLoading = true;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      docs[index].errorLoading = true;
    }
    docs[index].loading.value = false;
    loadingDocs.value = true;
    loadingDocs.value = false;
  }

  removePickedFile(int index) {
    docs[index].update.value = true;
    docs[index].path = null;
    docs[index].file = null;
    docs[index].size = null;
    docs[index].expiry = null;
    docs[index].update.value = false;
  }

  Future<String> getFileSize(String filepath) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(2)) + ' ' + suffixes[i];
  }

  void downloadDoc(int index, int caseNo) async {
    // using
    docs[index].loading.value = true;
    isEnableScreen.value = false;

    var resp = await VendorRepository.downloadDoc(caseNo, 3, docs[index].id??0);
    docs[index].loading.value = false;
    if (resp is Uint8List) {
      if (!docs[index].isRejected!) docs[index].file = resp;
      showFile(docs[index]);
    } else {
      SnakBarWidget.getSnackBarSuccess(
        AppMetaLabels().success,
        AppMetaLabels().fileUploaded,
      );
    }
  }

  void showFile(DocFile file) async {
    if (file.path == null) {
      if (await getStoragePermission()) {
        String path = await saveFile(file);
        file.path = path;
      }
    }
    OpenFile.open(file.path);
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

  Future<String> saveFile(DocFile reqFile) async {
    final path = await getTemporaryDirectory();
    final file = File("${path.path}/${reqFile.name}${reqFile.type}");
    await file.writeAsBytes(reqFile.file!);
    return file.path;
  }
}
