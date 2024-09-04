// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'dart:math';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/tenant_models/service_request/doc_file.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_update_profile_request.dart';
import 'package:fap_properties/data/repository/vendor_repository.dart';
import 'package:fap_properties/utils/constants/check_file_extension.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/image_compress.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:image_cropper/image_cropper.dart' as LatestCropper;
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class UploadDocsController extends GetxController {
  UploadDocsController({this.caseNo, this.docCode});
  int? caseNo;
  int? docCode;

  List<DocFile> docs = [];
  RxBool loadingDocs = false.obs;
  String errorLoadingDocs = '';
  int selectedIndexForUploadedDocument = -1;

  @override
  void onInit() {
    print('Case Nooooooo : $caseNo');
    if (caseNo == null)
      getCaseNo();
    else
      getFiles();
    super.onInit();
  }

  void getCaseNo() async {
    print('Helo :::::::::::::::::::::::::::::::::');
    errorLoadingDocs = '';
    loadingDocs.value = true;
    var resp = await VendorRepository.updateProfileRequest();
    if (resp is VendorUpdateProfileRequest) {
      caseNo = resp.addServiceRequest!.caseNo!;
      await getFiles();
    } else {
      errorLoadingDocs = resp;
      loadingDocs.value = false;
    }
  }

  Future<void> getFiles() async {
    docs.clear();
    errorLoadingDocs = '';
    loadingDocs.value = true;
    var resp = await VendorRepository.getDocsByType(caseNo!, 3, docCode!);
    if (resp is List<DocFile>) {
      if (resp.length == 0) {
        errorLoadingDocs = AppMetaLabels().noDatafound;
      } else {
        docs = resp;
        for (int i = 0; i < resp.length; i++) {}
      }
    } else
      errorLoadingDocs = resp;
    loadingDocs.value = false;
  }

  removeFile(int index) async {
    docs[index].removing.value = true;
    docs[index].errorRemoving = false;
    var resp = await VendorRepository.removeReqPhoto(docs[index].id.toString());
    if (resp == 200) {
      loadingDocs.value = true;
      docs[index].path = null;
      docs[index].file = null;
      docs[index].size = null;
      docs[index].id = null;
      docs[index].expiry = null;
      loadingDocs.value = false;
    } else {
      docs[index].errorRemoving = true;
    }
    docs[index].removing.value = false;
  }

  Future<Uint8List> convertCroppedFileToUint8List(
      LatestCropper.CroppedFile croppedFile) async {
    // Read the file as bytes
    final File file = File(croppedFile.path);
    final Uint8List bytes = await file.readAsBytes();
    return bytes;
  }

  // vendor Doc
  pickDoc(int index) async {
    docs[index].update.value = true;
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowedExtensions: [
      'pdf',
      'jpeg',
      'jpg',
      'png',
    ], type: FileType.custom);

    if (!CheckFileExtenstion().checkFileExtFunc(result!)) {
      SnakBarWidget.getSnackBarErrorBlueWith5Sec(
        AppMetaLabels().error,
        AppMetaLabels().fileExtensionError,
      );
      docs[index].update.value = false;
      return;
    }

    if (result != null) {
      File file = File(result.files.single.path!);
      var byteFile = await file.readAsBytes();
      String fileSize = await getFileSize(file.path);
      Uint8List editedImage;

      print('Extension :::::: ${result.files[0].extension}');
      if (result.files[0].extension == 'pdf') {
        print('This is pdf :::::: ');
      } else {
        print('This is not pdf :::::: ');

        // crop the image
        // editedImage = await Get.to(() => ImageCropper(
        //       image: byteFile,
        //     ));

        final crop = await LatestCropper.ImageCropper()
            .cropImage(sourcePath: result.files.single.path ?? "", uiSettings: [
          LatestCropper.AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: AppColors.blueColor,
            toolbarWidgetColor: AppColors.whiteColor,
            lockAspectRatio: false,
            aspectRatioPresets: [
              LatestCropper.CropAspectRatioPreset.original,
              LatestCropper.CropAspectRatioPreset.square,
            ],
          ),
          LatestCropper.IOSUiSettings(
            title: 'Cropper',
            aspectRatioPresets: [
              LatestCropper.CropAspectRatioPreset.original,
              LatestCropper.CropAspectRatioPreset.square,
            ],
          )
        ]);

        if (crop == null) {
          docs[index].update.value = false;
          return;
        }
        
        print('Edited Image :::::2  crop $crop');
        editedImage = await convertCroppedFileToUint8List(crop);
        print('Edited Image :::::2  ${(editedImage == null)}');

        byteFile = await compressImage(editedImage);
      }

      var size = CheckFileExtenstion().getFileSize(byteFile).split(' ')[0];
      var extension = CheckFileExtenstion().getFileSize(byteFile).split(' ')[1];
      if (extension.contains('MB')) {
        if (double.parse(size) > 10) {
          SnakBarWidget.getSnackBarErrorBlueWith5Sec(
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
              '${tempDir.path}/$fileName${p.extension(result.files.single.path!)}')
          .create();
      fileNew.writeAsBytesSync(imageInUnit8List);
      print('New File Path : ${fileNew.path}');

      docs[index].path = fileNew.path;
      docs[index].file = byteFile;
      docs[index].size = fileSize;
      selectedIndexForUploadedDocument = index;
    }

    docs[index].update.value = false;
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

  Future uploadDoc(int index) async {
    try {
      docs[index].loading.value = true;
      docs[index].errorLoading = false;
      print('*******************=======>');
      print(docs[index].expiry);
      print('<========*******************');
      var resp = await VendorRepository.uploadFile(
          caseNo!,
          docs[index].path ?? "",
          docs[index].name ?? "",
          docs[index].expiry ?? "",
          docs[index].documentTypeId!);

      var id = resp['photoId'];
      docs[index].id = id;
      SnakBarWidget.getSnackBarErrorBlue(
          AppMetaLabels().success, AppMetaLabels().fileUploaded);
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

  Future updateDoc(int index) async {
    try {
      docs[index].loading.value = true;
      docs[index].errorLoading = false;
      var resp = await VendorRepository.updateFile(docs[index].id ?? 0,
          docs[index].path ?? "", docs[index].expiry ?? "");
      if (resp == 200) {
        docs[index].isRejected = false;

        SnakBarWidget.getSnackBarErrorBlue(
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
    docs[index].update.value = true;
  }

  Future<String> getFileSize(String filepath) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(2)) + ' ' + suffixes[i];
  }

  Future<void> downloadDoc(int index) async {
    docs[index].loading.value = true;
    var resp =
        await VendorRepository.downloadDoc(caseNo!, 3, docs[index].id ?? 0);
    docs[index].loading.value = false;
    if (resp is Uint8List) {
      docs[index].file = resp;
      showFile(docs[index]);
    } else {
      SnakBarWidget.getSnackBarErrorBlue(
        AppMetaLabels().error,
        resp,
      );
    }
  }

  void showFile(DocFile file) async {
    if (file.path == null) {
      // ###1 permission
      // if (await getStoragePermission()) {
      String path = await saveFile(file);
      file.path = path;
      // }
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
