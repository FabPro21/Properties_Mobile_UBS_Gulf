// ignore_for_file: unnecessary_type_check, unnecessary_null_comparison

import 'dart:io';
import 'dart:math';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/tenant_models/card_model.dart';
import 'package:fap_properties/data/models/tenant_models/service_request/doc_file.dart';
import 'package:fap_properties/data/models/tenant_models/service_request/get_docs_model.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/utils/constants/check_file_extension.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/contracts_with_action/contracts_with_actions_controller.dart';
import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request_details/tenant_request_details_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_cropper/image_cropper.dart' as LatestCropper;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import '../../../../../utils/image_compress.dart';
import '../../../../widgets/snackbar_widget.dart';
import '../../../card_scanner/card_scanner.dart';
import '../../../tenant_contracts/tenant_contracts_tabs.dart/tenant_contracts_details.dart/tenant_contracts_detail_controller.dart';
import 'package:path/path.dart' as p;

class SvcReqDocsController extends GetxController {
  final String? caseNo;
  SvcReqDocsController({
    this.caseNo,
  });

  GetDocsModel? docsModel;
  RxBool isLength = false.obs;
  //
  // isDocUploaded for restrict the user to setct the other document pla upload karny sy
  RxList isDocUploaded = [].obs;
  RxBool loadingDocs = false.obs;
  String errorLoadingDocs = '';
  RxBool enableSubmit = false.obs;

  RxBool updatingDocStage = false.obs;

  RxBool updateTheDataOFEID = false.obs;

  CardScanModel cardScanModel = CardScanModel();
  File? mergedId;

  //
  String sourceForScanningFun = '';
  int indexForScanning = -1;

  @override
  // ignore: missing_return
  Future<void> onInit() async {
    super.onInit();
  }

  bool isValidDate(String value, [String? format]) {
    try {
      DateTime d;
      if (format == null) {
        d = new DateFormat.yMd().parseStrict(value);
      } else {
        d = new DateFormat(format).parseStrict(value);
      }
      //print('Validated $value using the locale of ${Intl.getCurrentLocale()} - result $d');
      return d != null;
    } catch (e) {
      return false;
    }
  }

  getFiles() async {
    try {
      print('============>>>>>> hhh THIS');
      docsModel = GetDocsModel();
      errorLoadingDocs = '';
      loadingDocs.value = true;
      var resp =
          await TenantRepository.getDocsByType(int.parse(caseNo!), 1, 41);
      loadingDocs.value = false;
      if (resp is GetDocsModel) {
        isDocUploaded.clear();
        for (int i = 0; i < resp.docs!.length; i++) {
          isDocUploaded.add('false');
        }

        if (resp.docs?.length == 0) {
          isLength.value = true;
          print(
              '=====resp.docs?.length=======>>>>>> doc length ${resp.docs?.length}  $isDocUploaded');
          errorLoadingDocs = AppMetaLabels().noDatafound;
          loadingDocs.value = false;
        } else {
          docsModel = resp;
          // if documents are rejected then will make empty the expiry
          for (int i = 0; i < docsModel!.docs!.length; i++) {
            if (docsModel?.docs?[i].isRejected == true) {
              docsModel?.docs?[i].expiry = '';
            }
          }
          print(
              '=====resp.docs?.length=======>>>>>> doc length ${resp.docs?.length}  $isDocUploaded');
          print(docsModel?.caseStageInfo?.stageId);
          update();
          enableSubmitButton();
        }
        // Future.delayed(Duration(seconds: 1));
        loadingDocs.value = false;
      } else {
        errorLoadingDocs = resp;
        loadingDocs.value = false;
      }
    } catch (e) {
      errorLoadingDocs = AppMetaLabels().anyError;
      loadingDocs.value = false;
    }
  }
  // 112233 enable the submit button
  // for SR enable button

  void enableSubmitButton() {
    enableSubmit.value = true;
    for (int i = 0; i < 2; i++) {
      if (docsModel?.docs?[i].id == null) enableSubmit.value = false;
    }
    // commented the below code coz we want to make fisrt two mandatary and other all show b optional
    // for (int i = 0; i < docsModel?.docs?.length; i++) {
    //   if (docsModel?.docs?[i].id == null) enableSubmit.value = false;
    // }
  }

  removeFile(int index) async {
    docsModel?.docs?[index].removing.value = true;
    docsModel?.docs?[index].errorRemoving = false;
    var resp = await TenantRepository.removeReqPhoto(
        docsModel?.docs?[index].id.toString());
    if (resp == 200) {
      loadingDocs.value = true;
      docsModel?.docs?[index].path = null;
      docsModel?.docs?[index].file = null;
      docsModel?.docs?[index].size = null;
      docsModel?.docs?[index].id = null;
      docsModel?.docs?[index].expiry = null;
      enableSubmitButton();
      loadingDocs.value = false;
    } else {
      docsModel?.docs?[index].errorRemoving = true;
    }
    docsModel?.docs?[index].removing.value = false;
  }

  int selectedIndexForUploadedDocument = -1;

  // passport and other select from gallery
  pickDoc(int index) async {
    docsModel?.docs?[index].loading.value = true;
    final ImagePicker _picker = ImagePicker();
    XFile? result = await _picker.pickImage(source: ImageSource.gallery);
    docsModel?.docs?[index].loading.value = false;

    if (!CheckFileExtenstion().checkImageExtFunc(result!.path)) {
      Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileExtensionError,
          duration: Duration(seconds: 5),
          backgroundColor: AppColors.redColor,
          colorText: AppColors.white54);
      docsModel?.docs?[index].loading.value = false;
      return;
    }

    if (result != null) {
      // if file is not empty then
      File file = File(result.path);
      var byteFile = await file.readAsBytes();

      print('Extension :::::: ${p.extension(result.path)}');
      // Uint8List editedImage;
      // if doc's extension will .pdf then will not compress or crop
      // if doc's extension will jpg,png or jpeg then will edit and crop
      if (p.extension(result.path) == 'pdf') {
        print('This is pdf :::::: ');
      } else {
        print('This is not pdf :::::: ');
        // crop the image
        // editedImage = await Get.to(() => ImageCropper(
        //       image: byteFile,
        //     ));
        final crop = await LatestCropper.ImageCropper()
            .cropImage(sourcePath: result.path, uiSettings: [
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

        var editedImage;
        if (crop == null) {
          docsModel?.docs?[index].loading.value = false;
          return;
        }
        print('Edited Image :::::2  crop $crop');
        editedImage = await convertCroppedFileToUint8List(crop);
        print('Edited Image :::::2  ${(editedImage == null)}');
        byteFile = await compressImage(editedImage);
      }
      // // crop the image
      // final editedImage = await Get.to(() => ImageCropper(
      //       image: byteFile,
      //     ));
      // // compress the image
      // byteFile = await compressImage(editedImage);

      // checking file size Passport and other
      var size = CheckFileExtenstion().getFileSize(byteFile).split(' ')[0];
      var extension = CheckFileExtenstion().getFileSize(byteFile).split(' ')[1];
      if (extension.contains('MB')) {
        if (double.parse(size) > 10) {
          Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileSizenError,
              duration: Duration(seconds: 5),
              backgroundColor: AppColors.redColor,
              colorText: AppColors.white54);
          return;
        }
      }
      // reconvert Uint8 into File an save in the catche
      Uint8List imageInUnit8List = byteFile;
      final tempDir = await getTemporaryDirectory();
      // File fileNew = await File('${tempDir.path}/image.png').create();
      String fileName = SessionController().getLanguage() == 1
          ? docsModel?.docs![index].name ?? ""
          : docsModel?.docs?[index].nameAr ?? "";
      File fileNew =
          await File('${tempDir.path}/$fileName${p.extension(result.path)}')
              .create();
      fileNew.writeAsBytesSync(imageInUnit8List);

      print('New File Path : ${fileNew.path}');
      // set values
      docsModel?.docs?[index].path = fileNew.path;
      docsModel?.docs?[index].file = byteFile;
      docsModel?.docs?[index].size = size;
      selectedIndexForUploadedDocument = index;
      if (docsModel?.docs?[index].path != null) {
        isDocUploaded[index] = 'true';
        update();
      }
    }
    docsModel?.docs?[index].loading.value = false;
  }

  //   // passport and other select from gallery
  pickDocFilePicker(int index) async {
    docsModel?.docs?[index].loading.value = true;
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowedExtensions: [
      'pdf',
      'jpeg',
      'jpg',
      'png',
    ], type: FileType.custom);
    docsModel?.docs?[index].loading.value = false;

    if (!CheckFileExtenstion().checkFileExtFunc(result!)) {
      Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileExtensionError,
          duration: Duration(seconds: 5),
          backgroundColor: AppColors.redColor,
          colorText: AppColors.white54);
      docsModel?.docs?[index].loading.value = false;
      return;
    }

    if (result != null) {
      // if file is not empty then
      File file = File(result.files.single.path ?? "");
      var byteFile = await file.readAsBytes();
      // Uint8List editedImage;

      print('Extension ::::1:: ${result.files[0].extension}');
      // if doc's extension will .pdf then will not compress or crop
      // if doc's extension will jpg,png or jpeg then will edit and crop
      if (result.files[0].extension == 'pdf') {
        print('This is pdf :::::: ');
      } else {
        print('This is not pdf :::::: ');
        print('File :::1::: $byteFile');
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
        var editedImage;
        if (crop == null) {
          docsModel?.docs?[index].loading.value = false;
          return;
        }
        print('Edited Image :::::2  crop $crop');
        editedImage = await convertCroppedFileToUint8List(crop);
        print('Edited Image :::::2  ${(editedImage == null)}');
        byteFile = await compressImage(editedImage);
      }

      // final editedImage = await Get.to(() => ImageCropper(
      //       image: byteFile,
      //     ));
      // // compress the image
      // byteFile = await compressImage(editedImage);

      // checking file size Passport and other
      var size = CheckFileExtenstion().getFileSize(byteFile).split(' ')[0];
      var extension = CheckFileExtenstion().getFileSize(byteFile).split(' ')[1];
      if (extension.contains('MB')) {
        if (double.parse(size) > 10) {
          Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileSizenError,
              duration: Duration(seconds: 5),
              backgroundColor: AppColors.redColor,
              colorText: AppColors.white54);
          return;
        }
      }

      // reconvert Uint8 into File an save in the catche
      Uint8List imageInUnit8List = byteFile;
      final tempDir = await getTemporaryDirectory();
      // File fileNew = await File('${tempDir.path}/image.png').create();
      String fileName = SessionController().getLanguage() == 1
          ? docsModel?.docs![index].name ?? ""
          : docsModel?.docs?[index].nameAr ?? "";
      File fileNew = await File(
              '${tempDir.path}/$fileName${p.extension(result.files.single.path ?? "")}')
          .create();
      fileNew.writeAsBytesSync(imageInUnit8List);

      print('New File Path : ${fileNew.path}');
      // set values
      docsModel?.docs?[index].path = fileNew.path;
      docsModel?.docs?[index].file = byteFile;
      docsModel?.docs?[index].size = size;
      selectedIndexForUploadedDocument = index;
      if (docsModel?.docs?[index].path != null) {
        isDocUploaded[index] = 'true';
        update();
      }
    }
    docsModel?.docs?[index].loading.value = false;
  }

  // passport and other take photo
  Future<void> takePhoto(int index) async {
    // From Camera
    docsModel?.docs?[index].loading.value = true;

    // picking file
    final ImagePicker _picker = ImagePicker();
    XFile? result = await _picker.pickImage(
      source: ImageSource.camera,
    );
    docsModel?.docs?[index].loading.value = false;

    // checking extension
    if (!CheckFileExtenstion().checkImageExtFunc(result!.path)) {
      Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileExtensionError,
          duration: Duration(seconds: 5),
          backgroundColor: AppColors.redColor,
          colorText: AppColors.white54);
      docsModel?.docs?[index].loading.value = false;
      return;
    }

    // if file is not empty then
    if (result != null) {
      File file = File(result.path);
      var byteFile = await file.readAsBytes();

      // crop the image
      // final editedImage = await Get.to(() => ImageCropper(
      //       image: byteFile,
      //     ));
      final crop = await LatestCropper.ImageCropper()
          .cropImage(sourcePath: result.path, uiSettings: [
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

      var editedImage;
      if (crop == null) {
        docsModel?.docs?[index].loading.value = false;
        return;
      }
      print('Edited Image :::::2  crop $crop');
      editedImage = await convertCroppedFileToUint8List(crop);
      print('Edited Image :::::2  ${(editedImage == null)}');

      // compress the image
      byteFile = await compressImage(editedImage);

      // checking file size Passport and other
      var size = CheckFileExtenstion().getFileSize(byteFile).split(' ')[0];
      var extension = CheckFileExtenstion().getFileSize(byteFile).split(' ')[1];
      if (extension.contains('MB')) {
        if (double.parse(size) > 10) {
          Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileSizenError,
              duration: Duration(seconds: 5),
              backgroundColor: AppColors.redColor,
              colorText: AppColors.white54);
          return;
        }
      }

      // reconvert Uint8 into File an save in the catche
      Uint8List imageInUnit8List = byteFile;
      final tempDir = await getTemporaryDirectory();
      String fileName = SessionController().getLanguage() == 1
          ? docsModel?.docs![index].name ?? ""
          : docsModel?.docs?[index].nameAr ?? "";
      File fileNew =
          await File('${tempDir.path}/$fileName${p.extension(result.path)}')
              .create();
      fileNew.writeAsBytesSync(imageInUnit8List);

      // set values
      docsModel?.docs?[index].path = fileNew.path;
      docsModel?.docs?[index].file = byteFile;
      docsModel?.docs?[index].size = size;
      selectedIndexForUploadedDocument = index;
      if (docsModel?.docs?[index].path != null) {
        isDocUploaded[index] = 'true';
        update();
      }
    }
    docsModel?.docs?[index].loading.value = false;
  }

  RxBool isLoadingForScanning = false.obs;

  Future<Uint8List> convertCroppedFileToUint8List(
      LatestCropper.CroppedFile croppedFile) async {
    // Read the file as bytes
    final File file = File(croppedFile.path);
    final Uint8List bytes = await file.readAsBytes();
    return bytes;
  }

  final controllerTRDC = Get.find<TenantRequestDetailsController>();
  ImageSource? selectedImageSource;

  RxBool isbothScane = false.obs;
  Future scanEmirateId(ImageSource source, int index) async {
    docsModel?.docs?[index].loading.value = false;
    XFile? xfile;
    try {
      xfile = await ImagePicker().pickImage(
        source: source,
      );
      docsModel?.docs?[index].loading.value = false;
      if (!CheckFileExtenstion().checkImageExtFunc(xfile!.path)) {
        Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileExtensionError,
            duration: Duration(seconds: 5),
            backgroundColor: AppColors.redColor,
            colorText: AppColors.white54);
        docsModel?.docs?[index].loading.value = false;
        return;
      }
    } catch (e) {
      docsModel?.docs?[index].loading.value = false;
      cardScanModel = CardScanModel();
      mergedId = null;
      isLoadingForScanning.value = false;
      update();
    }
    if (xfile != null) {
      Uint8List photo = await xfile.readAsBytes();

      photo = await compressImage(photo);

      // checking file size EID
      print(
          'Size of file  After Compress ::: ${CheckFileExtenstion().getFileSize(photo)}');
      var size = CheckFileExtenstion().getFileSize(photo).split(' ')[0];
      var extension = CheckFileExtenstion().getFileSize(photo).split(' ')[1];
      if (extension.contains('MB')) {
        if (double.parse(size) > 10) {
          Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileSizenError,
              duration: Duration(seconds: 5),
              backgroundColor: AppColors.redColor,
              colorText: AppColors.white54);
          return;
        }
      }

      // final editedImage = await Get.to(() => ImageCropper(
      //       image: photo,
      //     ));

      final crop = await LatestCropper.ImageCropper()
          .cropImage(sourcePath: xfile.path, uiSettings: [
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
      var editedImage;
      if (crop == null) {
        await SnakBarWidget.getSnackBarErrorBlue(
            AppMetaLabels().alert, AppMetaLabels().bothSideScaneFullMessage);
        docsModel?.docs?[index].loading.value = false;
        return;
      }
      editedImage = await convertCroppedFileToUint8List(crop);
      if (editedImage == null) {
        await SnakBarWidget.getSnackBarErrorBlue(
            AppMetaLabels().alert, AppMetaLabels().bothSideScaneFullMessage);
        docsModel?.docs?[index].loading.value = false;
        return;
      }
      if (editedImage != null) photo = editedImage;
      // ###1 permission
      // if (photo != null && await getStoragePermission()) {
      if (photo != null) {
        final newPath = await getTemporaryDirectory();
        final newFile = File("${newPath.path}/${xfile.path.split('/').last}");

        if (newFile != null) {
          await newFile.writeAsBytes(photo);
          print('- - - - - - - - - - - -- - - -- - - - -- - - - - - -- ');
          final result = await Get.to(() => CardScanner(
                file: newFile,
              ));
          if (result is CardScanModel) {
            if (result.name != null) {
              cardScanModel.name = result.name;
            }
            if (result.idNumber != null) {
              cardScanModel.idNumber = result.idNumber;
            }
            if (result.idNumber != null && isbothScane.value == false) {
              cardScanModel.frontImage = photo;
            }
            if (isbothScane.value == false &&
                cardScanModel.frontImage == null) {
              cardScanModel.frontImage = photo;
            }
            if (result.nationality != null) {
              cardScanModel.nationality = result.nationality;
            }
            if (result.issuingDate != null) {
              cardScanModel.issuingDate = result.issuingDate;
            }
            if (result.gender != null) {
              cardScanModel.gender = result.gender;
            }
            if (result.dob != null) {
              cardScanModel.dob = result.dob;
            }
            if (result.expiry != null) {
              cardScanModel.expiry = result.expiry;
            }
            if (result.cardNumber != null) {
              cardScanModel.cardNumber = result.cardNumber;
            }
            if (result.cardNumber != null && isbothScane.value == true) {
              cardScanModel.backImage = photo;
            }

            if (isbothScane.value == true && cardScanModel.backImage == null) {
              cardScanModel.backImage = photo;
            }

            if (isbothScane.value == false) {
              SessionController().getLanguage() == 1
                  ? await SnakBarWidget.getSnackBarErrorBlueRichTExt(
                      AppMetaLabels().alert, AppMetaLabels().otherSide)
                  : await SnakBarWidget.getSnackBarTAKEBlueRichTExt();
              await Future.delayed(Duration(seconds: 5));
              isbothScane.value = true;
              await scanEmirateId(source, index);
            } else if (!isbothScane.value) {
              docsModel?.docs?[index].loading.value = false;
              cardScanModel = CardScanModel();
              mergedId = null;
              isLoadingForScanning.value = false;
              update();
              SnakBarWidget.getSnackBarError(AppMetaLabels().cardScanningFailed,
                  AppMetaLabels().pleaseTryValidCardScanning);
            }
          }
        }
      }
    } else {
      docsModel?.docs?[index].loading.value = false;
      cardScanModel = CardScanModel();
      mergedId = null;
      docsModel?.docs?[index].loading.value = false;
      isLoadingForScanning.value = false;
      isbothScane.value = false;
      update();
      update();
      await SnakBarWidget.getSnackBarErrorBlue(
          AppMetaLabels().alert, AppMetaLabels().bothSideScaneFullMessage);
      await Future.delayed(Duration(seconds: 2));

      return;
    }
    if (isbothScane.value == true) {
      docsModel?.docs?[index].loading.value = false;

      if (mergedId == null && cardScanModel.backImage != null) {
        SessionController().getLanguage() == 1
            ? await SnakBarWidget.getSnackBarErrorBlueRichTExtForPrepareData(
                AppMetaLabels().alert, AppMetaLabels().data)
            : await SnakBarWidget
                .getSnackBarErrorBlueRichTExtForPrepareDataAr();
        await Future.delayed(Duration(seconds: 2));
      }
      await mergeEmirateIdSides();
      var byteFile;
      if (mergedId != null) {
        isDocUploaded[index] = 'true';
        byteFile = await mergedId!.readAsBytes();
        String fileSize = await getFileSize(mergedId!.path);
        docsModel?.docs?[index].path = mergedId!.path;
        docsModel?.docs?[index].file = byteFile;
        docsModel?.docs?[index].size = fileSize;
      }

      // Set the Expiry Date
      if (cardScanModel.expiry == null) {
        docsModel?.docs?[index].expiry = '.';
        cardScanModel.expiry = null;
      } else {
        try {
          bool isValid = isValidDate(
              '${DateFormat('dd-MM-yyyy').format(cardScanModel.expiry!)}',
              'dd-MM-yyyy');
          print(
            'Date is valid :::::: $isValid',
          );
          if (isValid) {
            if (cardScanModel.expiry!.isBefore(DateTime.now()) ||
                cardScanModel.expiry!.isAtSameMomentAs(DateTime.now())) {
              docsModel?.docs?[index].expiry = '.';
              cardScanModel.expiry = null;
            } else {
              docsModel?.docs?[index].expiry =
                  '${DateFormat('dd-MM-yyyy').format(cardScanModel.expiry!)}';
            }
          } else {
            docsModel?.docs?[index].expiry = '.';
            cardScanModel.expiry = null;
          }
        } catch (e) {
          docsModel?.docs?[index].expiry = '.';
          cardScanModel.expiry = null;
        }
      }
      // Set the DOB Date
      if (cardScanModel.dob != null) {
        try {
          bool isValid = isValidDate(
              '${DateFormat('dd-MM-yyyy').format(cardScanModel.dob!)}',
              'dd-MM-yyyy');
          print(
            'Date is valid :::::: $isValid',
          );
          if (isValid) {
            if (cardScanModel.dob!.isAfter(DateTime.now()) ||
                cardScanModel.dob!.isAtSameMomentAs(DateTime.now())) {
              cardScanModel.dob = null;
            } else {
              cardScanModel.dob = cardScanModel.dob;
            }
          } else {
            cardScanModel.dob = null;
          }
        } catch (e) {
          cardScanModel.dob = null;
        }
      }
      print(isDocUploaded);
    }
    docsModel?.docs?[index].update.value = true;
    docsModel?.docs?[index].update.value = false;
    docsModel?.docs?[index].loading.value = false;
  }

  // Future scanEmirateId(ImageSource source, int index) async {
  //   docsModel?.docs?[index].loading.value = false;
  //   XFile xfile;
  //   try {
  //     xfile = await ImagePicker().pickImage(
  //       source: source,
  //     );
  //     if (!CheckFileExtenstion().checkImageExtFunc(xfile.path)) {
  //       Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileExtensionError,
  //           duration: Duration(seconds: 5),
  //           backgroundColor: AppColors.redColor,
  //           colorText: AppColors.white54);
  //       docsModel?.docs?[index].loading.value = false;
  //       return;
  //     }
  //   } catch (e) {
  //     docsModel?.docs?[index].loading.value = false;
  //     cardScanModel = CardScanModel();
  //     mergedId! = null;
  //     isLoadingForScanning.value = false;
  //     update();
  //   }
  //   if (xfile != null) {
  //     Uint8List photo = await xfile.readAsBytes();
  //     photo = await compressImage(photo);
  //     // checking file size EID
  //     print('Size of file ::: ${CheckFileExtenstion().getFileSize(photo)}');
  //     var size = CheckFileExtenstion().getFileSize(photo).split(' ')[0];
  //     var extension = CheckFileExtenstion().getFileSize(photo).split(' ')[1];
  //     if (extension.contains('MB')) {
  //       if (double.parse(size) > 10) {
  //         Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileSizenError,
  //             duration: Duration(seconds: 5),
  //             backgroundColor: AppColors.redColor,
  //             colorText: AppColors.white54);
  //         return;
  //       }
  //     }
  //     final editedImage = await Get.to(() => ImageCropper(
  //           image: photo,
  //         ));
  //     if (editedImage == null) {
  //       docsModel?.docs?[index].loading.value = false;
  //       return;
  //     }
  //     if (editedImage != null) photo = editedImage;
  //     if (photo != null && await getStoragePermission()) {
  //       final newPath = await getTemporaryDirectory();
  //       final newFile = File("${newPath.path}/${xfile.path.split('/').last}");
  //       if (newFile != null) {
  //         await newFile.writeAsBytes(photo);
  //         print('- - - - - - - - - - - -- - - -- - - - -- - - - - - -- ');
  //         print(
  //             'Front Side Funll Condition ::::: ${isbothScane.value == false && cardScanModel.frontImage == null}');
  //         print('Front Side isbothScane val ::::: ${isbothScane.value}');
  //         print(
  //             'cardScanModel.frontImage val::::: ${cardScanModel.frontImage}');
  //         print('**********************************************');
  //         print(
  //             'Back Side Full Conditionc ::::: ${isbothScane.value == true && cardScanModel.backImage == null}');
  //         print('Back Side isbothScane val::::: ${isbothScane.value}');
  //         print('cardScanModel.backImage val::::: ${cardScanModel.backImage}');
  //         print('- - - - - - - - - - - -- - - -- - - - -- - - - - - -- ');
  //         final result = await Get.to(() => CardScanner(
  //               file: newFile,
  //             ));
  //         if (result is CardScanModel) {
  //           if (result.name != null) {
  //             cardScanModel.name = result.name;
  //           }
  //           if (result.idNumber != null) {
  //             cardScanModel.idNumber = result.idNumber;
  //           }
  //           if (result.idNumber != null && isbothScane.value == false) {
  //             cardScanModel.frontImage = photo;
  //           }
  //           if (isbothScane.value == false &&
  //               cardScanModel.frontImage == null) {
  //             cardScanModel.frontImage = photo;
  //           }
  //           if (result.nationality != null) {
  //             cardScanModel.nationality = result.nationality;
  //           }
  //           if (result.issuingDate != null) {
  //             cardScanModel.issuingDate = result.issuingDate;
  //           }
  //           if (result.gender != null) {
  //             cardScanModel.gender = result.gender;
  //           }
  //           if (result.dob != null) {
  //             cardScanModel.dob = result.dob;
  //           }
  //           if (result.expiry != null) {
  //             cardScanModel.expiry = result.expiry;
  //           }
  //           if (result.cardNumber != null) {
  //             cardScanModel.cardNumber = result.cardNumber;
  //           }
  //           if (result.cardNumber != null && isbothScane.value == true) {
  //             cardScanModel.backImage = photo;
  //           }
  //           if (isbothScane.value == true && cardScanModel.backImage == null) {
  //             cardScanModel.backImage = photo;
  //           }
  //           if (isbothScane.value == false) {
  //             await SnakBarWidget.getSnackBarErrorBlueRichTExt(
  //                 AppMetaLabels().alert, AppMetaLabels().otherSide);
  //             await Future.delayed(Duration(seconds: 5));
  //             isbothScane.value = true;
  //             await scanEmirateId(source, index);
  //           } else if (!isbothScane.value) {
  //             docsModel?.docs?[index].loading.value = false;
  //             cardScanModel = CardScanModel();
  //             mergedId! = null;
  //             isLoadingForScanning.value = false;
  //             update();
  //             SnakBarWidget.getSnackBarError(AppMetaLabels().cardScanningFailed,
  //                 AppMetaLabels().pleaseTryValidCardScanning);
  //           }
  //         }
  //       }
  //     }
  //   } else {
  //     docsModel?.docs?[index].loading.value = false;
  //     cardScanModel = CardScanModel();
  //     mergedId! = null;
  //     docsModel?.docs?[index].loading.value = false;
  //     isLoadingForScanning.value = false;
  //     isbothScane.value = false;
  //     update();
  //     update();
  //     await SnakBarWidget.getSnackBarErrorBlue(
  //         AppMetaLabels().alert, AppMetaLabels().bothSideScaneFullMessage);
  //     await Future.delayed(Duration(seconds: 2));
  //     return;
  //   }
  //   if (isbothScane.value == true) {
  //     docsModel?.docs?[index].loading.value = false;
  //     if (mergedId! == null ) {
  //       // if (mergedId! == null) {
  //       await SnakBarWidget.getSnackBarErrorBlueRichTExtForPrepareData(
  //           AppMetaLabels().alert, AppMetaLabels().data);
  //       await Future.delayed(Duration(seconds: 2));
  //     }
  //     await mergeEmirateIdSides();
  //     var byteFile;
  //     if (mergedId! != null) {
  //       isDocUploaded[index] = 'true';
  //       byteFile = await mergedId!.readAsBytes();
  //       String fileSize = await getFileSize(mergedId!.path);
  //       docsModel?.docs?[index].path = mergedId!.path;
  //       docsModel?.docs?[index].file = byteFile;
  //       docsModel?.docs?[index].size = fileSize;
  //     }
  //     // Set the Expiry Date
  //     if (cardScanModel.expiry == null) {
  //       docsModel?.docs?[index].expiry = '.';
  //       cardScanModel.expiry = null;
  //     }
  //     // if (cardScanModel.expiry != null) {
  //     else {
  //       try {
  //         // DateTime dT = DateTime(2023, int.parse('A'), 12);
  //         bool isValid = isValidDate(
  //             // '${DateFormat('dd-MM-yyyy').format(dT)}',
  //             '${DateFormat('dd-MM-yyyy').format(cardScanModel.expiry)}',
  //             'dd-MM-yyyy');
  //         print(
  //           'Date is valid :::::: $isValid',
  //         );
  //         if (isValid) {
  //           if (cardScanModel.expiry.isBefore(DateTime.now()) ||
  //               cardScanModel.expiry.isAtSameMomentAs(DateTime.now())) {
  //             docsModel?.docs?[index].expiry = '.';
  //             cardScanModel.expiry = null;
  //           } else {
  //             docsModel?.docs?[index].expiry =
  //                 '${DateFormat('dd-MM-yyyy').format(cardScanModel.expiry)}';
  //           }
  //         } else {
  //           docsModel?.docs?[index].expiry = '.';
  //           cardScanModel.expiry = null;
  //         }
  //       } catch (e) {
  //         docsModel?.docs?[index].expiry = '.';
  //         cardScanModel.expiry = null;
  //       }
  //     }
  //     // Set the DOB Date
  //     if (cardScanModel.dob != null) {
  //       try {
  //         // DateTime dT = DateTime(2023, int.parse('A'), 12);
  //         bool isValid = isValidDate(
  //             // '${DateFormat('dd-MM-yyyy').format(dT)}',
  //             '${DateFormat('dd-MM-yyyy').format(cardScanModel.dob)}',
  //             'dd-MM-yyyy');
  //         print(
  //           'Date is valid :::::: $isValid',
  //         );
  //         if (isValid) {
  //           if (cardScanModel.dob.isAfter(DateTime.now()) ||
  //               cardScanModel.dob.isAtSameMomentAs(DateTime.now())) {
  //             cardScanModel.dob = null;
  //           } else {
  //             cardScanModel.dob = cardScanModel.dob;
  //           }
  //         } else {
  //           cardScanModel.dob = null;
  //         }
  //       } catch (e) {
  //         cardScanModel.dob = null;
  //       }
  //     }
  //     // isDocUploaded[index] = 'true';
  //     print(isDocUploaded);
  //   }
  //   docsModel?.docs?[index].update.value = true;
  //   docsModel?.docs?[index].update.value = false;
  //   docsModel?.docs?[index].loading.value = false;
  // }

  Future<File> convertUint8ListToFile(
      Uint8List uint8List, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(uint8List);
    return file;
  }

  Uint8List convertImageToUint8List(img.Image image) {
    // Encode the image to PNG format
    final encodedImage = img.encodePng(image);
    if (encodedImage == null) {
      throw Exception('Failed to encode image to PNG.');
    }
    return Uint8List.fromList(encodedImage);
  }

  Future mergeEmirateIdSides() async {
    try {
      // Decode images using the `image` package
      final front = img.decodeImage(cardScanModel.frontImage!)!;
      final back = img.decodeImage(cardScanModel.backImage!)!;

      // Create a new image with the combined height and maximum width
      final width = front.width > back.width ? front.width : back.width;
      final height = front.height + back.height;
      img.Image mergedImage = img.Image(width: width, height: height);
      // Fill the background with a color if needed (e.g., white)
      img.fill(mergedImage,
          color: img.ColorRgb8(255, 255, 255)); // White background
      // merge both images
      img.compositeImage(
        mergedImage,
        front,
        dstX: 0,
      );
      img.compositeImage(
        mergedImage,
        back,
        dstY: back.height,
      );

      final byteImage = img.encodePng(mergedImage);
      final resizedImage = await compressImage(byteImage);

      String path = await saveFile(DocFile(
          name: 'emirateID${DateTime.now().microsecondsSinceEpoch}',
          type: '.jpg',
          file: resizedImage));

      mergedId = new File(path);
    } catch (e) {
      print('Exception :::::: mergeEmirateIdSides $e');
    }
    // try {
    // with older package
    // final front = img.decodeImage(cardScanModel.frontImage!);
    // final back = img.decodeImage(cardScanModel.backImage!);
    // final mergedImage;=img.Image(width: (front!.width, back!.width), front.height + back.height);
    // img.copyInto(mergedImage, front, blend: false);
    // img.copyInto(mergedImage, back, dstY: front.height, blend: false);

    // Uint8List byteImage = img.encodePng(mergedImage) as Uint8List;

    // final byteImage = encodePng(mergedImage);
    // final resizedImage = await compressImage(byteImage);
    // 112233 image extension issue
    // String path = await saveFile(
    //     DocFile(name: 'emirateID', type: '.jpg', file: resizedImage));
    // mergedId = new File(path);
    // } catch (e) {
    //   print('Exception :::::: mergeEmirateIdSides $e');
    // }
  }

  // comparingUint8List comparing the both images if both will same then will
  // return true
  bool comparingUint8List<E>(List<E> list1, List<E> list2) {
    if (identical(list1, list2)) {
      return true;
    } else {
      return false;
    }
  }

  setExpDate(int index, String date) {
    docsModel?.docs?[index].update.value = true;
    docsModel?.docs?[index].expiry = date;
    docsModel?.docs?[index].update.value = false;
  }

  clearExpDate(int index) {
    docsModel?.docs?[index].update.value = true;
    docsModel?.docs?[index].expiry = null;
    docsModel?.docs?[index].update.value = false;
  }

  Future uploadDoc(int index) async {
    try {
      docsModel?.docs?[index].loading.value = true;
      docsModel?.docs?[index].errorLoading = false;
      var resp = await TenantRepository.uploadFile(
          caseNo!,
          docsModel?.docs?[index].path ?? "",
          docsModel?.docs?[index].name ?? "",
          docsModel?.docs?[index].expiry ?? "",
          docsModel?.docs?[index].documentTypeId.toString() ?? "");
      var id = resp['photoId'];
      docsModel?.docs?[index].id = id;
      enableSubmitButton();
      isDocUploaded[index] = 'false';
      update();

      SnakBarWidget.getSnackBarSuccess(
        AppMetaLabels().success,
        AppMetaLabels().fileUploaded,
      );

      cardScanModel = CardScanModel();
      mergedId = null;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      print(e);
      docsModel?.docs?[index].errorLoading = true;
    }
    docsModel?.docs?[index].loading.value = false;
    loadingDocs.value = true;
    loadingDocs.value = false;
  }

  // uploadDocWithEIDParameter this func created because we want to send name,nationaity,ID after
  // scanne the emirate ID
  Future uploadDocWithEIDParameter(
    int index,
    String emirateIdNumber,
    nationality,
    nameEng,
    nameAr,
    issueDate,
    String dOB,
    // DateTime dOB
  ) async {
    try {
      print('Inside the func ::::');
      // docsModel?.docs?[index].loading.value = true;
      docsModel?.docs?[index].errorLoading = false;
      print(
          'path of Emirate ID while Testing ::::::${docsModel?.docs?[index].path}');
      var resp = await TenantRepository.uploadDocWithEIDParameter(
        caseNo ?? "",
        docsModel?.docs?[index].path ?? "",
        docsModel?.docs?[index].name ?? "",
        docsModel?.docs?[index].expiry ?? "",
        docsModel?.docs?[index].documentTypeId.toString() ?? "",
        emirateIdNumber,
        nationality,
        nameEng,
        nameAr,
        issueDate,
        dOB,
      );
      print('Inside the func :::: Result ::::********');
      isLoadingForScanning.value = false;
      var id = resp['photoId'];
      docsModel?.docs?[index].id = id;
      isDocUploaded[index] = 'false';
      isLoadingForScanning.value = false;
      enableSubmitButton();

      SnakBarWidget.getSnackBarSuccess(
        AppMetaLabels().success,
        AppMetaLabels().fileUploaded,
      );
      cardScanModel = CardScanModel();
      mergedId = null;
    } catch (e) {
      isLoadingForScanning.value = false;
      if (kDebugMode) {
        print(e);
      }
      print(e);
      docsModel?.docs?[index].errorLoading = true;
    }
    docsModel?.docs?[index].loading.value = false;
    loadingDocs.value = true;
    loadingDocs.value = false;
  }

  Future updateDoc(int index) async {
    try {
      docsModel?.docs?[index].loading.value = true;
      isLoadingForScanning.value = true;
      docsModel?.docs?[index].errorLoading = false;
      var resp = await TenantRepository.updateFile(
          docsModel?.docs?[index].id ?? -1,
          docsModel?.docs?[index].path ?? "",
          docsModel?.docs?[index].expiry ?? "");
      isLoadingForScanning.value = false;
      if (resp == 200) {
        docsModel?.docs?[index].loading.value = false;
        docsModel?.docs?[index].isRejected = false;
        enableSubmitButton();
        isDocUploaded[index] = 'false';
        update();

        SnakBarWidget.getSnackBarSuccess(
          AppMetaLabels().success,
          AppMetaLabels().fileUploaded,
        );
        cardScanModel = CardScanModel();
        mergedId = null;
      } else {
        docsModel?.docs?[index].loading.value = false;
        docsModel?.docs?[index].errorLoading = true;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      docsModel?.docs?[index].errorLoading = true;
    }
    docsModel?.docs?[index].loading.value = false;
    loadingDocs.value = true;
    loadingDocs.value = false;
  }

  removePickedFile(int index) {
    docsModel?.docs?[index].update.value = true;
    docsModel?.docs?[index].path = null;
    docsModel?.docs?[index].file = null;
    docsModel?.docs?[index].size = null;
    docsModel?.docs?[index].expiry = null;
    cardScanModel = CardScanModel();
    mergedId = null;
    docsModel?.docs?[index].update.value = false;
  }

  Future<String> getFileSize(String filepath) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(2)) + ' ' + suffixes[i];
  }

  void downloadDoc(int index) async {
    docsModel?.docs?[index].loading.value = true;
    var resp = await TenantRepository.downloadDoc(
        int.parse(caseNo!), 1, docsModel?.docs?[index].id ?? -1);
    docsModel?.docs?[index].loading.value = false;

    if (resp is Uint8List) {
      if (docsModel?.docs?[index].isRejected! == false)
        docsModel?.docs?[index].file = resp;
      showFile(docsModel?.docs?[index]);
    } else {
      SnakBarWidget.getSnackBarSuccess(
        AppMetaLabels().success,
        AppMetaLabels().fileUploaded,
      );
    }
  }

  void downloadDocRejected(int index) async {
    isLoadingForScanning.value = true;
    if (docsModel?.docs?[index].path != null) {
      OpenFile.open(docsModel?.docs?[index].path);
      isLoadingForScanning.value = false;
    } else {
      Uint8List result = await TenantRepository.downloadDocIsRejected(
          int.parse(caseNo!), 1, docsModel?.docs?[index].id ?? -1);
      print('::::::__>>>>Download<<<<___:::::::');
      if (result is Uint8List) {
        // ###1 permission
        // if (await getStoragePermission()) {
        var name = docsModel?.docs?[index].name ?? "";
        var type = docsModel?.docs?[index].type ?? "";
        String path = await createFile(result, name + '.' + type);
        final result1 = await OpenFile.open(path);
        print('Result 1 :::: 111 :::: 1 1 $result1');
        isLoadingForScanning.value = false;
        // }
        isLoadingForScanning.value = false;
      } else {
        isLoadingForScanning.value = false;
        Get.snackbar(
          AppMetaLabels().error,
          AppMetaLabels().noFileReceived,
          backgroundColor: AppColors.white54,
        );
      }
      isLoadingForScanning.value = false;
    }
  }

  Future<String> createFile(Uint8List? data, String? fileName) async {
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/$fileName");
    print("File Path :::::::: Downoad ${output.path}/$fileName");
    await file.writeAsBytes(data!.buffer.asUint8List());
    return "${output.path}/$fileName";
  }

  void showFile(DocFile? file) async {
    print('********');
    print(file?.path ?? "");
    print(file?.type ?? "");
    print('********');
    if (file?.path == null) {
      // ###1 permission
      // if (await getStoragePermission()) {
      var name = file?.name ?? "";
      var type = file?.type ?? "";
      String path = await createFile(file?.file, name + '.' + type);
      try {
        final result = await OpenFile.open(path);
        if (result.message != 'done') {
          Get.snackbar(
            AppMetaLabels().error,
            result.message,
            backgroundColor: AppColors.white54,
          );
        }
      } catch (e) {
        print(e);
        Get.snackbar(
          AppMetaLabels().error,
          e.toString(),
          backgroundColor: AppColors.white54,
        );
      }
      // }
    } else {
      await OpenFile.open(file?.path);
    }
    // OpenFile.open(file.path);
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

  updateDocStage(String caller) async {
    updatingDocStage.value = true;
    final resp = await TenantRepository.updateContractDocumentStage(
        docsModel?.caseStageInfo?.dueActionid ?? -1);
    updatingDocStage.value = false;
    if (resp == 200) {
      // Get.snackbar(AppMetaLabels().success, AppMetaLabels().stageUpdated,
      //     backgroundColor: AppColors.white54);
      docsModel?.caseStageInfo?.stageId!.value = 3;
      enableSubmit.value = false;
      if (caller == 'contract') {
        final contractController = Get.find<GetContractsDetailsController>();
        contractController.getData();
      }
      final contractsWithActionsController =
          Get.put(ContractsWithActionsController());
      contractsWithActionsController.getContracts();
    } else if (resp is String) {
      Get.snackbar(AppMetaLabels().error, resp,
          backgroundColor: AppColors.white54);
    }
  }
}

// Before Compress Image Func and Add Croper
// import 'dart:io';
// import 'dart:math';
// import 'package:fap_properties/data/models/tenant_models/card_model.dart';
// import 'package:fap_properties/data/models/tenant_models/service_request/doc_file.dart';
// import 'package:fap_properties/data/models/tenant_models/service_request/get_docs_model.dart';
// import 'package:fap_properties/data/repository/tenant_repository.dart';
// import 'package:fap_properties/utils/constants/check_file_extension.dart';
// import 'package:fap_properties/utils/constants/meta_labels.dart';
// import 'package:fap_properties/utils/styles/colors.dart';
// import 'package:fap_properties/views/tenant/tenant_contracts/contracts_with_action/contracts_with_actions_controller.dart';
// import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request_details/tenant_request_details_controller.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:get/get.dart';
// import 'package:image/image.dart';
// import 'package:image_editor_plus/image_editor_plus.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:open_file/open_file.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/foundation.dart';
// import '../../../../../utils/image_compress.dart';
// import '../../../../widgets/snackbar_widget.dart';
// import '../../../card_scanner/card_scanner.dart';
// import '../../../tenant_contracts/tenant_contracts_tabs.dart/tenant_contracts_details.dart/tenant_contracts_detail_controller.dart';

// class SvcReqDocsController extends GetxController {
//   SvcReqDocsController({this.caseNo});
//   String caseNo;
//   GetDocsModel docsModel?;
//   RxBool isLength = false.obs;
//   //
//   // isDocUploaded for restrict the user to setct the other document pla upload karny sy
//   RxList isDocUploaded = [].obs;
//   RxBool loadingDocs = false.obs;
//   String errorLoadingDocs = '';
//   RxBool enableSubmit = false.obs;

//   RxBool updatingDocStage = false.obs;

//   RxBool updateTheDataOFEID = false.obs;

//   CardScanModel cardScanModel = CardScanModel();
//   File mergedId!;

//   //
//   String sourceForScanningFun = '';
//   int indexForScanning = -1;

//   @override
//   // ignore: missing_return
//   Future<void> onInit() {
//     super.onInit();
//   }

//   bool isValidDate(String value, [String format]) {
//     try {
//       DateTime d;
//       if (format == null) {
//         d = new DateFormat.yMd().parseStrict(value);
//       } else {
//         d = new DateFormat(format).parseStrict(value);
//       }
//       //print('Validated $value using the locale of ${Intl.getCurrentLocale()} - result $d');
//       return d != null;
//     } catch (e) {
//       return false;
//     }
//   }

//   getFiles() async {
//     try {
//       print('============>>>>>> hhh THIS');
//       docsModel? = GetDocsModel();
//       errorLoadingDocs = '';
//       loadingDocs.value = true;
//       var resp = await TenantRepository.getDocsByType(int.parse(caseNo), 1, 41);
//       loadingDocs.value = false;
//       if (resp is GetDocsModel) {
//         isDocUploaded.clear();
//         for (int i = 0; i < resp.docs?.length; i++) {
//           isDocUploaded.add('false');
//         }

//         if (resp.docs?.length == 0) {
//           isLength.value = true;
//           print(
//               '=====resp.docs?.length=======>>>>>> doc length ${resp.docs?.length}  $isDocUploaded');
//           errorLoadingDocs = AppMetaLabels().noDatafound;
//           loadingDocs.value = false;
//         } else {
//           docsModel? = resp ?? GetDocsModel();
//           // if documents are rejected then will make empty the expiry
//           for (int i = 0; i < docsModel?.docs?.length; i++) {
//             if (docsModel?.docs?[i].isRejected) {
//               docsModel?.docs?[i].expiry = '';
//             }
//           }
//           print(
//               '=====resp.docs?.length=======>>>>>> doc length ${resp.docs?.length}  $isDocUploaded');
//           print(docsModel?.caseStageInfo.stageId);
//           update();
//           enableSubmitButton();
//         }
//         Future.delayed(Duration(seconds: 1));
//         loadingDocs.value = false;
//       } else {
//         errorLoadingDocs = resp;
//         loadingDocs.value = false;
//       }
//     } catch (e) {
//       errorLoadingDocs = AppMetaLabels().anyError;
//       loadingDocs.value = false;
//     }
//   }
//   // 112233 enable the submit button
//   // for SR enable button

//   void enableSubmitButton() {
//     enableSubmit.value = true;
//     for (int i = 0; i < 2; i++) {
//       if (docsModel?.docs?[i].id == null) enableSubmit.value = false;
//     }
//     // commented the below code coz we want to make fisrt two mandatary and other all show b optional
//     // for (int i = 0; i < docsModel?.docs?.length; i++) {
//     //   if (docsModel?.docs?[i].id == null) enableSubmit.value = false;
//     // }
//   }

//   removeFile(int index) async {
//     docsModel?.docs?[index].removing.value = true;
//     docsModel?.docs?[index].errorRemoving = false;
//     var resp = await TenantRepository.removeReqPhoto(
//         docsModel?.docs?[index].id.toString());
//     if (resp == 200) {
//       loadingDocs.value = true;
//       docsModel?.docs?[index].path = null;
//       docsModel?.docs?[index].file = null;
//       docsModel?.docs?[index].size = null;
//       docsModel?.docs?[index].id = null;
//       docsModel?.docs?[index].expiry = null;
//       enableSubmitButton();
//       loadingDocs.value = false;
//     } else {
//       docsModel?.docs?[index].errorRemoving = true;
//     }
//     docsModel?.docs?[index].removing.value = false;
//   }

//   int selectedIndexForUploadedDocument = -1;

//   // passport and other select from gallery
//   pickDoc(int index) async {
//     print('>>>>>>>>>>><<<<<<<<<<<<<<');
//     docsModel?.docs?[index].loading.value = true;

//     FilePickerResult result =
//         await FilePicker.platform.pickFiles(allowedExtensions: [
//       'pdf',
//       'jpeg',
//       'jpg',
//       'png',
//     ], type: FileType.custom);
//     docsModel?.docs?[index].loading.value = false;

//     if (!CheckFileExtenstion().checkFileExtFunc(result)) {
//       Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileExtensionError,
//           duration: Duration(seconds: 5),
//           backgroundColor: AppColors.redColor,
//           colorText: AppColors.white54);
//       docsModel?.docs?[index].loading.value = false;
//       return;
//     }

//     if (result != null) {
//       File file = File(result.files.single.path);
//       var byteFile = await file.readAsBytes();
//       // checking file size Passport and other
//       print('Size of file ::: ${CheckFileExtenstion().getFileSize(byteFile)}');
//       var size = CheckFileExtenstion().getFileSize(byteFile).split(' ')[0];
//       var extension = CheckFileExtenstion().getFileSize(byteFile).split(' ')[1];
//       if (extension.contains('MB')) {
//         if (double.parse(size) > 10) {
//           Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileSizenError,
//               duration: Duration(seconds: 5),
//               backgroundColor: AppColors.redColor,
//               colorText: AppColors.white54);
//           return;
//         }
//       }

//       String fileSize = await getFileSize(file.path);
//       docsModel?.docs?[index].path = file.path;
//       docsModel?.docs?[index].file = byteFile;
//       docsModel?.docs?[index].size = fileSize;
//       selectedIndexForUploadedDocument = index;
//       if (docsModel?.docs?[index].path != null) {
//         isDocUploaded[index] = 'true';
//         update();
//       }
//     }
//     docsModel?.docs?[index].loading.value = false;
//   }

//   // passport and other take photo
//   Future<void> takePhoto(int index) async {
//     print('>>>>>>>>>>><<<<<<<<<<<<<<');
//     docsModel?.docs?[index].loading.value = true;
//     // old one
//     final ImagePicker _picker = ImagePicker();
//     XFile result = await _picker.pickImage(source: ImageSource.camera);
//     docsModel?.docs?[index].loading.value = false;

//     if (!CheckFileExtenstion().checkImageExtFunc(result.path)) {
//       Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileExtensionError,
//           duration: Duration(seconds: 5),
//           backgroundColor: AppColors.redColor,
//           colorText: AppColors.white54);
//       docsModel?.docs?[index].loading.value = false;
//       return;
//     }

//     if (result != null) {
//       File file = File(result.path);
//       var byteFile = await file.readAsBytes();
//       // checking file size Passport and other
//       print('Size of file ::: ${CheckFileExtenstion().getFileSize(byteFile)}');
//       var size = CheckFileExtenstion().getFileSize(byteFile).split(' ')[0];
//       var extension = CheckFileExtenstion().getFileSize(byteFile).split(' ')[1];
//       if (extension.contains('MB')) {
//         if (double.parse(size) > 10) {
//           Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileSizenError,
//               duration: Duration(seconds: 5),
//               backgroundColor: AppColors.redColor,
//               colorText: AppColors.white54);
//           return;
//         }
//       }
//       String fileSize = await getFileSize(file.path);
//       docsModel?.docs?[index].path = file.path;
//       docsModel?.docs?[index].file = byteFile;
//       docsModel?.docs?[index].size = fileSize;
//       selectedIndexForUploadedDocument = index;
//       if (docsModel?.docs?[index].path != null) {
//         isDocUploaded[index] = 'true';
//         update();
//       }
//     }
//     docsModel?.docs?[index].loading.value = false;
//   }

//   RxBool isLoadingForScanning = false.obs;

//   final controllerTRDC = Get.find<TenantRequestDetailsController>();
//   ImageSource selectedImageSource;

//   RxBool isbothScane = false.obs;
//   Future scanEmirateId(ImageSource source, int index) async {
//     docsModel?.docs?[index].loading.value = false;
//     XFile xfile;
//     try {
//       xfile = await ImagePicker().pickImage(
//         source: source,
//       );

//       if (!CheckFileExtenstion().checkImageExtFunc(xfile.path)) {
//         Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileExtensionError,
//             duration: Duration(seconds: 5),
//             backgroundColor: AppColors.redColor,
//             colorText: AppColors.white54);
//         docsModel?.docs?[index].loading.value = false;
//         return;
//       }
//     } catch (e) {
//       docsModel?.docs?[index].loading.value = false;
//       cardScanModel = CardScanModel();
//       mergedId! = null;
//       isLoadingForScanning.value = false;
//       update();
//     }
//     if (xfile != null) {
//       Uint8List photo = await xfile.readAsBytes();

//       photo = await compressImage(photo);

//       // checking file size EID
//       print('Size of file ::: ${CheckFileExtenstion().getFileSize(photo)}');
//       var size = CheckFileExtenstion().getFileSize(photo).split(' ')[0];
//       var extension = CheckFileExtenstion().getFileSize(photo).split(' ')[1];
//       if (extension.contains('MB')) {
//         if (double.parse(size) > 10) {
//           Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileSizenError,
//               duration: Duration(seconds: 5),
//               backgroundColor: AppColors.redColor,
//               colorText: AppColors.white54);
//           return;
//         }
//       }

//       final editedImage = await Get.to(() => ImageCropper(
//             image: photo,
//           ));
//       if (editedImage == null) {
//         docsModel?.docs?[index].loading.value = false;
//         return;
//       }
//       if (editedImage != null) photo = editedImage;

//       if (photo != null && await getStoragePermission()) {
//         final newPath = await getTemporaryDirectory();
//         final newFile = File("${newPath.path}/${xfile.path.split('/').last}");

//         if (newFile != null) {
//           await newFile.writeAsBytes(photo);
//           print('- - - - - - - - - - - -- - - -- - - - -- - - - - - -- ');
//           print(
//               'Front Side Funll Condition ::::: ${isbothScane.value == false && cardScanModel.frontImage == null}');
//           print('Front Side isbothScane val ::::: ${isbothScane.value}');
//           print(
//               'cardScanModel.frontImage val::::: ${cardScanModel.frontImage}');
//           print('**********************************************');
//           print(
//               'Back Side Full Conditionc ::::: ${isbothScane.value == true && cardScanModel.backImage == null}');

//           print('Back Side isbothScane val::::: ${isbothScane.value}');
//           print('cardScanModel.backImage val::::: ${cardScanModel.backImage}');

//           print('- - - - - - - - - - - -- - - -- - - - -- - - - - - -- ');
//           final result = await Get.to(() => CardScanner(
//                 file: newFile,
//               ));
//           if (result is CardScanModel) {
//             if (result.name != null) {
//               cardScanModel.name = result.name;
//             }
//             if (result.idNumber != null) {
//               cardScanModel.idNumber = result.idNumber;
//             }
//             if (result.idNumber != null && isbothScane.value == false) {
//               cardScanModel.frontImage = photo;
//             }
//             if (isbothScane.value == false &&
//                 cardScanModel.frontImage == null) {
//               cardScanModel.frontImage = photo;
//             }
//             if (result.nationality != null) {
//               cardScanModel.nationality = result.nationality;
//             }
//             if (result.issuingDate != null) {
//               cardScanModel.issuingDate = result.issuingDate;
//             }
//             if (result.gender != null) {
//               cardScanModel.gender = result.gender;
//             }
//             if (result.dob != null) {
//               cardScanModel.dob = result.dob;
//             }
//             if (result.expiry != null) {
//               cardScanModel.expiry = result.expiry;
//             }
//             if (result.cardNumber != null) {
//               cardScanModel.cardNumber = result.cardNumber;
//             }
//             if (result.cardNumber != null && isbothScane.value == true) {
//               cardScanModel.backImage = photo;
//             }

//             if (isbothScane.value == true && cardScanModel.backImage == null) {
//               cardScanModel.backImage = photo;
//             }

//             if (isbothScane.value == false) {
//               await SnakBarWidget.getSnackBarErrorBlueRichTExt(
//                   AppMetaLabels().alert, AppMetaLabels().otherSide);
//               await Future.delayed(Duration(seconds: 5));
//               isbothScane.value = true;
//               await scanEmirateId(source, index);
//             } else if (!isbothScane.value) {
//               docsModel?.docs?[index].loading.value = false;
//               cardScanModel = CardScanModel();
//               mergedId! = null;
//               isLoadingForScanning.value = false;
//               update();
//               SnakBarWidget.getSnackBarError(AppMetaLabels().cardScanningFailed,
//                   AppMetaLabels().pleaseTryValidCardScanning);
//             }
//           }
//         }
//       }
//     } else {
//       docsModel?.docs?[index].loading.value = false;
//       cardScanModel = CardScanModel();
//       mergedId! = null;
//       docsModel?.docs?[index].loading.value = false;
//       isLoadingForScanning.value = false;
//       update();
//       await SnakBarWidget.getSnackBarErrorBlueRichTExt(
//           AppMetaLabels().alert, AppMetaLabels().bothSideScane);
//       await Future.delayed(Duration(seconds: 2));

//       return;
//     }
//     if (isbothScane.value == true) {
//       docsModel?.docs?[index].loading.value = false;

//       if (mergedId! == null) {
//         await SnakBarWidget.getSnackBarErrorBlueRichTExtForPrepareData(
//             AppMetaLabels().alert, AppMetaLabels().data);
//         await Future.delayed(Duration(seconds: 2));
//       }

//       await mergeEmirateIdSides();
//       var byteFile;
//       if (mergedId! != null) {
//         byteFile = await mergedId!.readAsBytes();
//         String fileSize = await getFileSize(mergedId!.path);
//         docsModel?.docs?[index].path = mergedId!.path;
//         docsModel?.docs?[index].file = byteFile;
//         docsModel?.docs?[index].size = fileSize;
//       }

//       // Set the Expiry Date
//       if (cardScanModel.expiry == null) {
//         docsModel?.docs?[index].expiry = '.';
//         cardScanModel.expiry = null;
//       }
//       // if (cardScanModel.expiry != null) {
//       else {
//         try {
//           // DateTime dT = DateTime(2023, int.parse('A'), 12);
//           bool isValid = isValidDate(
//               // '${DateFormat('dd-MM-yyyy').format(dT)}',
//               '${DateFormat('dd-MM-yyyy').format(cardScanModel.expiry)}',
//               'dd-MM-yyyy');
//           print(
//             'Date is valid :::::: $isValid',
//           );
//           if (isValid) {
//             if (cardScanModel.expiry.isBefore(DateTime.now()) ||
//                 cardScanModel.expiry.isAtSameMomentAs(DateTime.now())) {
//               docsModel?.docs?[index].expiry = '.';
//               cardScanModel.expiry = null;
//             } else {
//               docsModel?.docs?[index].expiry =
//                   '${DateFormat('dd-MM-yyyy').format(cardScanModel.expiry)}';
//             }
//           } else {
//             docsModel?.docs?[index].expiry = '.';
//             cardScanModel.expiry = null;
//           }
//         } catch (e) {
//           docsModel?.docs?[index].expiry = '.';
//           cardScanModel.expiry = null;
//         }
//       }
//       // Set the DOB Date
//       if (cardScanModel.dob != null) {
//         try {
//           // DateTime dT = DateTime(2023, int.parse('A'), 12);
//           bool isValid = isValidDate(
//               // '${DateFormat('dd-MM-yyyy').format(dT)}',
//               '${DateFormat('dd-MM-yyyy').format(cardScanModel.dob)}',
//               'dd-MM-yyyy');
//           print(
//             'Date is valid :::::: $isValid',
//           );
//           if (isValid) {
//             if (cardScanModel.dob.isAfter(DateTime.now()) ||
//                 cardScanModel.dob.isAtSameMomentAs(DateTime.now())) {
//               cardScanModel.dob = null;
//             } else {
//               cardScanModel.dob = cardScanModel.dob;
//             }
//           } else {
//             cardScanModel.dob = null;
//           }
//         } catch (e) {
//           cardScanModel.dob = null;
//         }
//       }

//       isDocUploaded[index] = 'true';
//       print(isDocUploaded);
//     }
//     docsModel?.docs?[index].update.value = true;
//     docsModel?.docs?[index].update.value = false;
//     docsModel?.docs?[index].loading.value = false;
//   }

//   Future mergeEmirateIdSides() async {
//     try {
//       final front = decodeImage(cardScanModel.frontImage);
//       final back = decodeImage(cardScanModel.backImage);
//       final mergedImage =
//           Image(max(front.width, back.width), front.height + back.height);
//       copyInto(mergedImage, front, blend: false);
//       copyInto(mergedImage, back, dstY: front.height, blend: false);
//       final byteImage = encodePng(mergedImage);
//       final resizedImage = await compressImage(byteImage);
//       // 112233 image extension issue
//       String path = await saveFile(
//           DocFile(name: 'emirateID', type: '.jpg', file: resizedImage));
//       mergedId! = new File(path);
//     } catch (e) {
//       print('Exception :::::: mergeEmirateIdSides $e');
//     }
//   }

//   // comparingUint8List comparing the both images if both will same then will
//   // return true
//   bool comparingUint8List<E>(List<E> list1, List<E> list2) {
//     if (identical(list1, list2)) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   setExpDate(int index, String date) {
//     docsModel?.docs?[index].update.value = true;
//     docsModel?.docs?[index].expiry = date;
//     docsModel?.docs?[index].update.value = false;
//   }

//   clearExpDate(int index) {
//     docsModel?.docs?[index].update.value = true;
//     docsModel?.docs?[index].expiry = null;
//     docsModel?.docs?[index].update.value = false;
//   }

//   Future uploadDoc(int index) async {
//     try {
//       docsModel?.docs?[index].loading.value = true;
//       docsModel?.docs?[index].errorLoading = false;
//       var resp = await TenantRepository.uploadFile(
//           caseNo,
//           docsModel?.docs?[index].path,
//           docsModel?.docs?[index].name,
//           docsModel?.docs?[index].expiry,
//           docsModel?.docs?[index].documentTypeId.toString());
//       var id = resp['photoId'];
//       docsModel?.docs?[index].id = id;
//       enableSubmitButton();
//       isDocUploaded[index] = 'false';
//       update();

//       SnakBarWidget.getSnackBarSuccess(
//         AppMetaLabels().success,
//         AppMetaLabels().fileUploaded,
//       );

//       cardScanModel = CardScanModel();
//       mergedId! = null;
//     } catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//       print(e);
//       docsModel?.docs?[index].errorLoading = true;
//     }
//     docsModel?.docs?[index].loading.value = false;
//     loadingDocs.value = true;
//     loadingDocs.value = false;
//   }

//   // uploadDocWithEIDParameter this func created because we want to send name,nationaity,ID after
//   // scanne the emirate ID
//   Future uploadDocWithEIDParameter(
//     int index,
//     String emirateIdNumber,
//     nationality,
//     nameEng,
//     nameAr,
//     issueDate,
//     String dOB,
//     // DateTime dOB
//   ) async {
//     try {
//       print('Inside the func');
//       // docsModel?.docs?[index].loading.value = true;
//       docsModel?.docs?[index].errorLoading = false;
//       var resp = await TenantRepository.uploadDocWithEIDParameter(
//         caseNo,
//         docsModel?.docs?[index].path,
//         docsModel?.docs?[index].name,
//         docsModel?.docs?[index].expiry,
//         docsModel?.docs?[index].documentTypeId.toString(),
//         emirateIdNumber,
//         nationality,
//         nameEng,
//         nameAr,
//         issueDate,
//         dOB,
//       );
//       print(resp);
//       isLoadingForScanning.value = false;
//       var id = resp['photoId'];
//       docsModel?.docs?[index].id = id;
//       isDocUploaded[index] = 'false';
//       isLoadingForScanning.value = false;
//       enableSubmitButton();

//       SnakBarWidget.getSnackBarSuccess(
//         AppMetaLabels().success,
//         AppMetaLabels().fileUploaded,
//       );
//       cardScanModel = CardScanModel();
//       mergedId! = null;
//     } catch (e) {
//       isLoadingForScanning.value = false;
//       if (kDebugMode) {
//         print(e);
//       }
//       print(e);
//       docsModel?.docs?[index].errorLoading = true;
//     }
//     docsModel?.docs?[index].loading.value = false;
//     loadingDocs.value = true;
//     loadingDocs.value = false;
//   }

//   Future updateDoc(int index) async {
//     try {
//       docsModel?.docs?[index].loading.value = true;
//       isLoadingForScanning.value = true;
//       docsModel?.docs?[index].errorLoading = false;
//       var resp = await TenantRepository.updateFile(docsModel?.docs?[index].id,
//           docsModel?.docs?[index].path, docsModel?.docs?[index].expiry);
//       isLoadingForScanning.value = false;
//       if (resp == 200) {
//         docsModel?.docs?[index].loading.value = false;
//         docsModel?.docs?[index].isRejected = false;
//         enableSubmitButton();
//         isDocUploaded[index] = 'false';
//         update();

//         SnakBarWidget.getSnackBarSuccess(
//           AppMetaLabels().success,
//           AppMetaLabels().fileUploaded,
//         );
//         cardScanModel = CardScanModel();
//         mergedId! = null;
//       } else {
//         docsModel?.docs?[index].loading.value = false;
//         docsModel?.docs?[index].errorLoading = true;
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//       docsModel?.docs?[index].errorLoading = true;
//     }
//     docsModel?.docs?[index].loading.value = false;
//     loadingDocs.value = true;
//     loadingDocs.value = false;
//   }

//   removePickedFile(int index) {
//     docsModel?.docs?[index].update.value = true;
//     docsModel?.docs?[index].path = null;
//     docsModel?.docs?[index].file = null;
//     docsModel?.docs?[index].size = null;
//     docsModel?.docs?[index].expiry = null;
//     cardScanModel = CardScanModel();
//     mergedId! = null;
//     docsModel?.docs?[index].update.value = false;
//   }

//   Future<String> getFileSize(String filepath) async {
//     var file = File(filepath);
//     int bytes = await file.length();
//     if (bytes <= 0) return "0 B";
//     const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
//     var i = (log(bytes) / log(1024)).floor();
//     return ((bytes / pow(1024, i)).toStringAsFixed(2)) + ' ' + suffixes[i];
//   }

//   void downloadDoc(int index) async {
//     docsModel?.docs?[index].loading.value = true;
//     var resp = await TenantRepository.downloadDoc(
//         int.parse(caseNo), 1, docsModel?.docs?[index].id);
//     docsModel?.docs?[index].loading.value = false;

//     if (resp is Uint8List) {
//       if (!docsModel?.docs?[index].isRejected) docsModel?.docs?[index].file = resp;
//       showFile(docsModel?.docs?[index]);
//     } else {
//       SnakBarWidget.getSnackBarSuccess(
//         AppMetaLabels().success,
//         AppMetaLabels().fileUploaded,
//       );
//     }
//   }

//   void downloadDocRejected(int index) async {
//     isLoadingForScanning.value = true;
//     if (docsModel?.docs?[index].path != null) {
//       OpenFile.open(docsModel?.docs?[index].path);
//       isLoadingForScanning.value = false;
//     } else {
//       Uint8List result = await TenantRepository.downloadDocIsRejected(
//           int.parse(caseNo), 1, docsModel?.docs?[index].id);
//       print('::::::__>>>>Download<<<<___:::::::');
//       if (result is Uint8List) {
//         if (await getStoragePermission()) {
//           String path = await createFile(result, docsModel?.docs?[index].name);
//           OpenResult result1 = await OpenFile.open(path);
//           print('Result 1 :::: 111 :::: 1 1 $result1');
//           isLoadingForScanning.value = false;
//         }
//         isLoadingForScanning.value = false;
//       } else {
//         isLoadingForScanning.value = false;
//         Get.snackbar(
//           AppMetaLabels().error,
//           AppMetaLabels().noFileReceived,
//           backgroundColor: AppColors.white54,
//         );
//       }
//       isLoadingForScanning.value = false;
//     }
//   }

//   Future<String> createFile(Uint8List data, String fileName) async {
//     final output = await getTemporaryDirectory();
//     final file = File("${output.path}/$fileName");
//     await file.writeAsBytes(data.buffer.asUint8List());
//     return "${output.path}/$fileName";
//   }

//   void showFile(DocFile file) async {
//     if (file.path == null) {
//       if (await getStoragePermission()) {
//         String path = await saveFile(file);
//         file.path = path;
//       }
//     }
//     OpenFile.open(file.path);
//   }

//   Future<bool> getStoragePermission() async {
//     if (await Permission.storage.request().isGranted) {
//       return true;
//     } else if (await Permission.storage.request().isPermanentlyDenied) {
//       return await openAppSettings();
//     } else if (await Permission.storage.request().isDenied) {
//       return false;
//     }
//     return false;
//   }

//   Future<String> saveFile(DocFile reqFile) async {
//     final path = await getTemporaryDirectory();
//     final file = File("${path.path}/${reqFile.name}${reqFile.type}");
//     await file.writeAsBytes(reqFile.file);
//     return file.path;
//   }

//   updateDocStage(String caller) async {
//     updatingDocStage.value = true;
//     final resp = await TenantRepository.updateContractDocumentStage(
//         docsModel?.caseStageInfo.dueActionid);
//     updatingDocStage.value = false;
//     if (resp == 200) {
//       // Get.snackbar(AppMetaLabels().success, AppMetaLabels().stageUpdated,
//       //     backgroundColor: AppColors.white54);
//       docsModel?.caseStageInfo.stageId.value = 3;
//       enableSubmit.value = false;
//       if (caller == 'contract') {
//         final contractController = Get.find<GetContractsDetailsController>();
//         contractController.getData();
//       }
//       final contractsWithActionsController =
//           Get.put(ContractsWithActionsController());
//       contractsWithActionsController.getContracts();
//     } else if (resp is String) {
//       Get.snackbar(AppMetaLabels().error, resp,
//           backgroundColor: AppColors.white54);
//     }
//   }
// }

// // With full validation
// import 'dart:io';
// import 'dart:math';
// import 'package:fap_properties/data/models/tenant_models/card_model.dart';
// import 'package:fap_properties/data/models/tenant_models/service_request/doc_file.dart';
// import 'package:fap_properties/data/models/tenant_models/service_request/get_docs_model.dart';
// import 'package:fap_properties/data/repository/tenant_repository.dart';
// import 'package:fap_properties/utils/constants/check_file_extension.dart';
// import 'package:fap_properties/utils/constants/meta_labels.dart';
// import 'package:fap_properties/utils/styles/colors.dart';
// import 'package:fap_properties/views/tenant/tenant_contracts/contracts_with_action/contracts_with_actions_controller.dart';
// import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request_details/tenant_request_details_controller.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:get/get.dart';
// import 'package:image/image.dart';
// import 'package:image_editor_plus/image_editor_plus.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:open_file/open_file.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/foundation.dart';
// import '../../../../../utils/image_compress.dart';
// import '../../../../widgets/snackbar_widget.dart';
// import '../../../card_scanner/card_scanner.dart';
// import '../../../tenant_contracts/tenant_contracts_tabs.dart/tenant_contracts_details.dart/tenant_contracts_detail_controller.dart';

// class SvcReqDocsController extends GetxController {
//   SvcReqDocsController({this.caseNo});
//   String caseNo;
//   GetDocsModel docsModel?;
//   RxBool isLength = false.obs;
//   //
//   // isDocUploaded for restrict the user to setct the other document pla upload karny sy
//   RxList isDocUploaded = [].obs;
//   RxBool loadingDocs = false.obs;
//   String errorLoadingDocs = '';
//   RxBool enableSubmit = false.obs;

//   RxBool updatingDocStage = false.obs;

//   RxBool updateTheDataOFEID = false.obs;

//   CardScanModel cardScanModel = CardScanModel();
//   File mergedId!;

//   //
//   String sourceForScanningFun = '';
//   int indexForScanning = -1;

//   @override
//   // ignore: missing_return
//   Future<void> onInit() {
//     super.onInit();
//   }

//   bool isValidDate(String value, [String format]) {
//     try {
//       DateTime d;
//       if (format == null) {
//         d = new DateFormat.yMd().parseStrict(value);
//       } else {
//         d = new DateFormat(format).parseStrict(value);
//       }
//       //print('Validated $value using the locale of ${Intl.getCurrentLocale()} - result $d');
//       return d != null;
//     } catch (e) {
//       return false;
//     }
//   }

//   getFiles() async {
//     try {
//       print('============>>>>>> hhh THIS');
//       docsModel? = GetDocsModel();
//       errorLoadingDocs = '';
//       loadingDocs.value = true;
//       var resp = await TenantRepository.getDocsByType(int.parse(caseNo), 1, 41);
//       loadingDocs.value = false;
//       if (resp is GetDocsModel) {
//         isDocUploaded.clear();
//         for (int i = 0; i < resp.docs?.length; i++) {
//           isDocUploaded.add('false');
//         }

//         if (resp.docs?.length == 0) {
//           isLength.value = true;
//           print(
//               '=====resp.docs?.length=======>>>>>> doc length ${resp.docs?.length}  $isDocUploaded');
//           errorLoadingDocs = AppMetaLabels().noDatafound;
//           loadingDocs.value = false;
//         } else {
//           docsModel? = resp ?? GetDocsModel();
//           // if documents are rejected then will make empty the expiry
//           for (int i = 0; i < docsModel?.docs?.length; i++) {
//             if (docsModel?.docs?[i].isRejected) {
//               docsModel?.docs?[i].expiry = '';
//             }
//           }
//           print(
//               '=====resp.docs?.length=======>>>>>> doc length ${resp.docs?.length}  $isDocUploaded');
//           print(docsModel?.caseStageInfo.stageId);
//           update();
//           enableSubmitButton();
//         }
//         Future.delayed(Duration(seconds: 1));
//         loadingDocs.value = false;
//       } else {
//         errorLoadingDocs = resp;
//         loadingDocs.value = false;
//       }
//     } catch (e) {
//       errorLoadingDocs = AppMetaLabels().anyError;
//       loadingDocs.value = false;
//     }
//   }
//   // 112233 enable the submit button
//   // for SR enable button

//   void enableSubmitButton() {
//     enableSubmit.value = true;
//     for (int i = 0; i < 2; i++) {
//       if (docsModel?.docs?[i].id == null) enableSubmit.value = false;
//     }
//     // commented the below code coz we want to make fisrt two mandatary and other all show b optional
//     // for (int i = 0; i < docsModel?.docs?.length; i++) {
//     //   if (docsModel?.docs?[i].id == null) enableSubmit.value = false;
//     // }
//   }

//   removeFile(int index) async {
//     docsModel?.docs?[index].removing.value = true;
//     docsModel?.docs?[index].errorRemoving = false;
//     var resp = await TenantRepository.removeReqPhoto(
//         docsModel?.docs?[index].id.toString());
//     if (resp == 200) {
//       loadingDocs.value = true;
//       docsModel?.docs?[index].path = null;
//       docsModel?.docs?[index].file = null;
//       docsModel?.docs?[index].size = null;
//       docsModel?.docs?[index].id = null;
//       docsModel?.docs?[index].expiry = null;
//       enableSubmitButton();
//       loadingDocs.value = false;
//     } else {
//       docsModel?.docs?[index].errorRemoving = true;
//     }
//     docsModel?.docs?[index].removing.value = false;
//   }

//   int selectedIndexForUploadedDocument = -1;

//   // passport and other select from gallery
//   pickDoc(int index) async {
//     print('>>>>>>>>>>><<<<<<<<<<<<<<');
//     docsModel?.docs?[index].loading.value = true;

//     FilePickerResult result = await FilePicker.platform
//         .pickFiles(allowedExtensions: [
//       'pdf',
//       'jpeg',
//       'jpg',
//       'png',
//     ], type: FileType.custom);
//     docsModel?.docs?[index].loading.value = false;

//     if (!CheckFileExtenstion().checkFileExtFunc(result)) {
//       Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileExtensionError,
//           duration: Duration(seconds: 5),
//           backgroundColor: AppColors.redColor,
//           colorText: AppColors.white54);
//       docsModel?.docs?[index].loading.value = false;
//       return;
//     }

//     if (result != null) {
//       File file = File(result.files.single.path);
//       var byteFile = await file.readAsBytes();
//       // checking file size Passport and other
//       print('Size of file ::: ${CheckFileExtenstion().getFileSize(byteFile)}');
//       var size = CheckFileExtenstion().getFileSize(byteFile).split(' ')[0];
//       var extension = CheckFileExtenstion().getFileSize(byteFile).split(' ')[1];
//       if (extension.contains('MB')) {
//         if (double.parse(size) > 10) {
//           Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileSizenError,
//               duration: Duration(seconds: 5),
//               backgroundColor: AppColors.redColor,
//               colorText: AppColors.white54);
//           return;
//         }
//       }

//       String fileSize = await getFileSize(file.path);
//       docsModel?.docs?[index].path = file.path;
//       docsModel?.docs?[index].file = byteFile;
//       docsModel?.docs?[index].size = fileSize;
//       selectedIndexForUploadedDocument = index;
//       if (docsModel?.docs?[index].path != null) {
//         isDocUploaded[index] = 'true';
//         update();
//       }
//     }
//     docsModel?.docs?[index].loading.value = false;
//   }

//   // passport and other take photo
//   Future<void> takePhoto(int index) async {
//     print('>>>>>>>>>>><<<<<<<<<<<<<<');
//     docsModel?.docs?[index].loading.value = true;
//     // old one
//     final ImagePicker _picker = ImagePicker();
//     XFile result = await _picker.pickImage(source: ImageSource.camera);
//     docsModel?.docs?[index].loading.value = false;

//     if (!CheckFileExtenstion().checkImageExtFunc(result.path)) {
//       Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileExtensionError,
//           duration: Duration(seconds: 5),
//           backgroundColor: AppColors.redColor,
//           colorText: AppColors.white54);
//       docsModel?.docs?[index].loading.value = false;
//       return;
//     }

//     if (result != null) {
//       File file = File(result.path);
//       var byteFile = await file.readAsBytes();
//       // checking file size Passport and other
//       print('Size of file ::: ${CheckFileExtenstion().getFileSize(byteFile)}');
//       var size = CheckFileExtenstion().getFileSize(byteFile).split(' ')[0];
//       var extension = CheckFileExtenstion().getFileSize(byteFile).split(' ')[1];
//       if (extension.contains('MB')) {
//         if (double.parse(size) > 10) {
//           Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileSizenError,
//               duration: Duration(seconds: 5),
//               backgroundColor: AppColors.redColor,
//               colorText: AppColors.white54);
//           return;
//         }
//       }
//       String fileSize = await getFileSize(file.path);
//       docsModel?.docs?[index].path = file.path;
//       docsModel?.docs?[index].file = byteFile;
//       docsModel?.docs?[index].size = fileSize;
//       selectedIndexForUploadedDocument = index;
//       if (docsModel?.docs?[index].path != null) {
//         isDocUploaded[index] = 'true';
//         update();
//       }
//     }
//     docsModel?.docs?[index].loading.value = false;
//   }

//   RxBool isLoadingForScanning = false.obs;

//   final controllerTRDC = Get.find<TenantRequestDetailsController>();
//   ImageSource selectedImageSource;
//   Future scanEmirateId(ImageSource source, int index) async {
//     docsModel?.docs?[index].loading.value = false;
//     XFile xfile;
//     try {
//       xfile = await ImagePicker().pickImage(
//         source: source,
//       );

//       if (!CheckFileExtenstion().checkImageExtFunc(xfile.path)) {
//         Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileExtensionError,
//             duration: Duration(seconds: 5),
//             backgroundColor: AppColors.redColor,
//             colorText: AppColors.white54);
//         docsModel?.docs?[index].loading.value = false;
//         return;
//       }
//     } catch (e) {
//       docsModel?.docs?[index].loading.value = false;
//       cardScanModel = CardScanModel();
//       mergedId! = null;
//       isLoadingForScanning.value = false;
//       update();
//     }
//     if (xfile != null) {
//       Uint8List photo = await xfile.readAsBytes();

//       photo = await compressImage(photo);

//       // checking file size EID
//       print('Size of file ::: ${CheckFileExtenstion().getFileSize(photo)}');
//       var size = CheckFileExtenstion().getFileSize(photo).split(' ')[0];
//       var extension = CheckFileExtenstion().getFileSize(photo).split(' ')[1];
//       if (extension.contains('MB')) {
//         if (double.parse(size) > 10) {
//           Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileSizenError,
//               duration: Duration(seconds: 5),
//               backgroundColor: AppColors.redColor,
//               colorText: AppColors.white54);
//           return;
//         }
//       }

//       final editedImage = await Get.to(() => ImageCropper(
//             image: photo,
//           ));
//       if (editedImage == null) {
//         docsModel?.docs?[index].loading.value = false;
//         return;
//       }
//       if (editedImage != null) photo = editedImage;

//       if (photo != null && await getStoragePermission()) {
//         final newPath = await getTemporaryDirectory();
//         final newFile = File("${newPath.path}/${xfile.path.split('/').last}");

//         if (newFile != null) {
//           await newFile.writeAsBytes(photo);
//           final result = await Get.to(() => CardScanner(
//                 file: newFile,
//               ));
//           if (result is CardScanModel) {
//             if (result.name != null) {
//               cardScanModel.name = result.name;
//             }
//             if (result.idNumber != null) {
//               cardScanModel.idNumber = result.idNumber;
//               cardScanModel.frontImage = photo;
//             }
//             if (result.nationality != null) {
//               cardScanModel.nationality = result.nationality;
//             }
//             if (result.issuingDate != null) {
//               cardScanModel.issuingDate = result.issuingDate;
//             }
//             if (result.gender != null) {
//               cardScanModel.gender = result.gender;
//             }
//             if (result.dob != null) {
//               cardScanModel.dob = result.dob;
//             }
//             if (result.expiry != null) {
//               cardScanModel.expiry = result.expiry;
//             }
//             if (result.cardNumber != null) {
//               cardScanModel.cardNumber = result.cardNumber;
//               cardScanModel.backImage = photo;
//             }
//             // Alerts for scanner
//             if (cardScanModel.scanFront()) {
//               await SnakBarWidget.getSnackBarErrorBlueRichTExt(
//                   AppMetaLabels().alert, AppMetaLabels().frontSide);
//               await Future.delayed(Duration(seconds: 5));
//               await scanEmirateId(source, index);
//             } else if (cardScanModel.scanBack()) {
//               await SnakBarWidget.getSnackBarErrorBlueRichTExt(
//                   AppMetaLabels().alert, AppMetaLabels().backSide);
//               await Future.delayed(Duration(seconds: 5));
//               await scanEmirateId(source, index);
//             } else if (!cardScanModel.bothSidesScannedSuccessfully()) {
//               docsModel?.docs?[index].loading.value = false;
//               cardScanModel = CardScanModel();
//               mergedId! = null;
//               isLoadingForScanning.value = false;
//               update();

//               print('<=:::::::EID INFO::::::::CardScanModel=> $cardScanModel');
//               print('<=:::::::EID INFO::::::::Name=> ${cardScanModel.name}');
//               print(
//                   '<=:::::::EID INFO::::::::CardNumber=> ${cardScanModel.cardNumber}');
//               print('<=:::::::EID INFO::::::::DOB=> ${cardScanModel.dob}');
//               print(
//                   '<=:::::::EID INFO::::::::IssuingDate=> ${cardScanModel.issuingDate}');
//               print(
//                   '<=:::::::EID INFO::::::::Gender=> ${cardScanModel.gender}');
//               print(
//                   '<=:::::::EID INFO::::::::Front Image=> ${cardScanModel.frontImage}');
//               print(
//                   '<=:::::::EID INFO::::::::Back Image=> ${cardScanModel.backImage}');

//               SnakBarWidget.getSnackBarError(AppMetaLabels().cardScanningFailed,
//                   AppMetaLabels().pleaseTryValidCardScanning);
//             }
//           }
//         }
//       }
//     } else {
//       docsModel?.docs?[index].loading.value = false;
//       cardScanModel = CardScanModel();
//       mergedId! = null;
//       docsModel?.docs?[index].loading.value = false;
//       isLoadingForScanning.value = false;
//       update();
//       await SnakBarWidget.getSnackBarErrorBlueRichTExt(
//           AppMetaLabels().alert, AppMetaLabels().bothSideScane);
//       await Future.delayed(Duration(seconds: 2));

//       return;
//     }
//     if (cardScanModel.bothSidesScannedSuccessfully()) {
//       docsModel?.docs?[index].loading.value = false;

//       if (mergedId! == null) {
//         await SnakBarWidget.getSnackBarErrorBlueRichTExtForPrepareData(
//             AppMetaLabels().alert, AppMetaLabels().data);
//         await Future.delayed(Duration(seconds: 2));
//       }

//       await mergeEmirateIdSides();
//       var byteFile = await mergedId!.readAsBytes();
//       String fileSize = await getFileSize(mergedId!.path);
//       docsModel?.docs?[index].path = mergedId!.path;
//       docsModel?.docs?[index].file = byteFile;
//       docsModel?.docs?[index].size = fileSize;
//       // latest 9:01
//       // docsModel?.docs?[index].expiry =
//       //     DateFormat('dd-MM-yyyy').format(cardScanModel.expiry);

//       // Set the Expiry Date
//       try {
//         // DateTime dT = DateTime(2023, int.parse('A'), 12);
//         bool isValid = isValidDate(
//             // '${DateFormat('dd-MM-yyyy').format(dT)}',
//             '${DateFormat('dd-MM-yyyy').format(cardScanModel.expiry)}',
//             'dd-MM-yyyy');
//         print(
//           'Date is valid :::::: $isValid',
//         );
//         if (isValid) {
//           if (cardScanModel.expiry.isBefore(DateTime.now()) ||
//               cardScanModel.expiry.isAtSameMomentAs(DateTime.now())) {
//             docsModel?.docs?[index].expiry = '.';
//             cardScanModel.expiry = null;
//           } else {
//             docsModel?.docs?[index].expiry =
//                 '${DateFormat('dd-MM-yyyy').format(cardScanModel.expiry)}';
//           }
//         } else {
//           docsModel?.docs?[index].expiry = '.';
//           cardScanModel.expiry = null;
//         }
//       } catch (e) {
//         docsModel?.docs?[index].expiry = '.';
//         cardScanModel.expiry = null;
//       }
//       // Set the DOB Date
//       try {
//         // DateTime dT = DateTime(2023, int.parse('A'), 12);
//         bool isValid = isValidDate(
//             // '${DateFormat('dd-MM-yyyy').format(dT)}',
//             '${DateFormat('dd-MM-yyyy').format(cardScanModel.dob)}',
//             'dd-MM-yyyy');
//         print(
//           'Date is valid :::::: $isValid',
//         );
//         if (isValid) {
//           if (cardScanModel.dob.isAfter(DateTime.now()) ||
//               cardScanModel.dob.isAtSameMomentAs(DateTime.now())) {
//             cardScanModel.dob = null;
//           } else {
//             cardScanModel.dob = cardScanModel.dob;
//           }
//         } else {
//           cardScanModel.dob = null;
//         }
//       } catch (e) {
//         cardScanModel.dob = null;
//       }

//       isDocUploaded[index] = 'true';
//       print(isDocUploaded);
//     }
//     docsModel?.docs?[index].update.value = true;
//     docsModel?.docs?[index].update.value = false;
//     docsModel?.docs?[index].loading.value = false;
//   }

//   Future mergeEmirateIdSides() async {
//     final front = decodeImage(cardScanModel.frontImage);
//     final back = decodeImage(cardScanModel.backImage);
//     final mergedImage =
//         Image(max(front.width, back.width), front.height + back.height);
//     copyInto(mergedImage, front, blend: false);
//     copyInto(mergedImage, back, dstY: front.height, blend: false);
//     final byteImage = encodePng(mergedImage);
//     final resizedImage = await compressImage(byteImage);
//     // 112233 image extension issue
//     String path = await saveFile(
//         DocFile(name: 'emirateID', type: '.jpg', file: resizedImage));
//     mergedId! = new File(path);
//   }

//   // comparingUint8List comparing the both images if both will same then will
//   // return true
//   bool comparingUint8List<E>(List<E> list1, List<E> list2) {
//     if (identical(list1, list2)) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   setExpDate(int index, String date) {
//     docsModel?.docs?[index].update.value = true;
//     docsModel?.docs?[index].expiry = date;
//     docsModel?.docs?[index].update.value = false;
//   }

//   clearExpDate(int index) {
//     docsModel?.docs?[index].update.value = true;
//     docsModel?.docs?[index].expiry = null;
//     docsModel?.docs?[index].update.value = false;
//   }

//   Future uploadDoc(int index) async {
//     try {
//       docsModel?.docs?[index].loading.value = true;
//       docsModel?.docs?[index].errorLoading = false;
//       var resp = await TenantRepository.uploadFile(
//           caseNo,
//           docsModel?.docs?[index].path,
//           docsModel?.docs?[index].name,
//           docsModel?.docs?[index].expiry,
//           docsModel?.docs?[index].documentTypeId.toString());
//       var id = resp['photoId'];
//       docsModel?.docs?[index].id = id;
//       enableSubmitButton();
//       isDocUploaded[index] = 'false';
//       update();

//       SnakBarWidget.getSnackBarSuccess(
//         AppMetaLabels().success,
//         AppMetaLabels().fileUploaded,
//       );

//       cardScanModel = CardScanModel();
//       mergedId! = null;
//     } catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//       print(e);
//       docsModel?.docs?[index].errorLoading = true;
//     }
//     docsModel?.docs?[index].loading.value = false;
//     loadingDocs.value = true;
//     loadingDocs.value = false;
//   }

//   // uploadDocWithEIDParameter this func created because we want to send name,nationaity,ID after
//   // scanne the emirate ID
//   Future uploadDocWithEIDParameter(
//     int index,
//     String emirateIdNumber,
//     nationality,
//     nameEng,
//     nameAr,
//     issueDate,
//     String dOB,
//     // DateTime dOB
//   ) async {
//     try {
//       print('Inside the func');
//       // docsModel?.docs?[index].loading.value = true;
//       docsModel?.docs?[index].errorLoading = false;
//       var resp = await TenantRepository.uploadDocWithEIDParameter(
//         caseNo,
//         docsModel?.docs?[index].path,
//         docsModel?.docs?[index].name,
//         docsModel?.docs?[index].expiry,
//         docsModel?.docs?[index].documentTypeId.toString(),
//         emirateIdNumber,
//         nationality,
//         nameEng,
//         nameAr,
//         issueDate,
//         dOB,
//       );
//       print(resp);
//       isLoadingForScanning.value = false;
//       var id = resp['photoId'];
//       docsModel?.docs?[index].id = id;
//       isDocUploaded[index] = 'false';
//       isLoadingForScanning.value = false;
//       enableSubmitButton();

//       SnakBarWidget.getSnackBarSuccess(
//         AppMetaLabels().success,
//         AppMetaLabels().fileUploaded,
//       );
//       cardScanModel = CardScanModel();
//       mergedId! = null;
//     } catch (e) {
//       isLoadingForScanning.value = false;
//       if (kDebugMode) {
//         print(e);
//       }
//       print(e);
//       docsModel?.docs?[index].errorLoading = true;
//     }
//     docsModel?.docs?[index].loading.value = false;
//     loadingDocs.value = true;
//     loadingDocs.value = false;
//   }

//   Future updateDoc(int index) async {
//     try {
//       docsModel?.docs?[index].loading.value = true;
//       isLoadingForScanning.value = true;
//       docsModel?.docs?[index].errorLoading = false;
//       var resp = await TenantRepository.updateFile(docsModel?.docs?[index].id,
//           docsModel?.docs?[index].path, docsModel?.docs?[index].expiry);
//       isLoadingForScanning.value = false;
//       if (resp == 200) {
//         docsModel?.docs?[index].loading.value = false;
//         docsModel?.docs?[index].isRejected = false;
//         enableSubmitButton();
//         isDocUploaded[index] = 'false';
//         update();

//         SnakBarWidget.getSnackBarSuccess(
//           AppMetaLabels().success,
//           AppMetaLabels().fileUploaded,
//         );
//         cardScanModel = CardScanModel();
//         mergedId! = null;
//       } else {
//         docsModel?.docs?[index].loading.value = false;
//         docsModel?.docs?[index].errorLoading = true;
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//       docsModel?.docs?[index].errorLoading = true;
//     }
//     docsModel?.docs?[index].loading.value = false;
//     loadingDocs.value = true;
//     loadingDocs.value = false;
//   }

//   removePickedFile(int index) {
//     docsModel?.docs?[index].update.value = true;
//     docsModel?.docs?[index].path = null;
//     docsModel?.docs?[index].file = null;
//     docsModel?.docs?[index].size = null;
//     docsModel?.docs?[index].expiry = null;
//     cardScanModel = CardScanModel();
//     mergedId! = null;
//     docsModel?.docs?[index].update.value = false;
//   }

//   Future<String> getFileSize(String filepath) async {
//     var file = File(filepath);
//     int bytes = await file.length();
//     if (bytes <= 0) return "0 B";
//     const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
//     var i = (log(bytes) / log(1024)).floor();
//     return ((bytes / pow(1024, i)).toStringAsFixed(2)) + ' ' + suffixes[i];
//   }

//   void downloadDoc(int index) async {
//     docsModel?.docs?[index].loading.value = true;
//     var resp = await TenantRepository.downloadDoc(
//         int.parse(caseNo), 1, docsModel?.docs?[index].id);
//     docsModel?.docs?[index].loading.value = false;

//     if (resp is Uint8List) {
//       if (!docsModel?.docs?[index].isRejected) docsModel?.docs?[index].file = resp;
//       showFile(docsModel?.docs?[index]);
//     } else {
//       SnakBarWidget.getSnackBarSuccess(
//         AppMetaLabels().success,
//         AppMetaLabels().fileUploaded,
//       );
//     }
//   }

//   void downloadDocRejected(int index) async {
//     isLoadingForScanning.value = true;
//     if (docsModel?.docs?[index].path != null) {
//       OpenFile.open(docsModel?.docs?[index].path);
//       isLoadingForScanning.value = false;
//     } else {
//       Uint8List result = await TenantRepository.downloadDocIsRejected(
//           int.parse(caseNo), 1, docsModel?.docs?[index].id);
//       print('::::::__>>>>Download<<<<___:::::::');
//       if (result is Uint8List) {
//         if (await getStoragePermission()) {
//           String path = await createFile(result, docsModel?.docs?[index].name);
//           OpenResult result1 = await OpenFile.open(path);
//           print('Result 1 :::: 111 :::: 1 1 $result1');
//           isLoadingForScanning.value = false;
//         }
//         isLoadingForScanning.value = false;
//       } else {
//         isLoadingForScanning.value = false;
//         Get.snackbar(
//           AppMetaLabels().error,
//           AppMetaLabels().noFileReceived,
//           backgroundColor: AppColors.white54,
//         );
//       }
//       isLoadingForScanning.value = false;
//     }
//   }

//   Future<String> createFile(Uint8List data, String fileName) async {
//     final output = await getTemporaryDirectory();
//     final file = File("${output.path}/$fileName");
//     await file.writeAsBytes(data.buffer.asUint8List());
//     return "${output.path}/$fileName";
//   }

//   void showFile(DocFile file) async {
//     if (file.path == null) {
//       if (await getStoragePermission()) {
//         String path = await saveFile(file);
//         file.path = path;
//       }
//     }
//     OpenFile.open(file.path);
//   }

//   Future<bool> getStoragePermission() async {
//     if (await Permission.storage.request().isGranted) {
//       return true;
//     } else if (await Permission.storage.request().isPermanentlyDenied) {
//       return await openAppSettings();
//     } else if (await Permission.storage.request().isDenied) {
//       return false;
//     }
//     return false;
//   }

//   Future<String> saveFile(DocFile reqFile) async {
//     final path = await getTemporaryDirectory();
//     final file = File("${path.path}/${reqFile.name}${reqFile.type}");
//     await file.writeAsBytes(reqFile.file);
//     return file.path;
//   }

//   updateDocStage(String caller) async {
//     updatingDocStage.value = true;
//     final resp = await TenantRepository.updateContractDocumentStage(
//         docsModel?.caseStageInfo.dueActionid);
//     updatingDocStage.value = false;
//     if (resp == 200) {
//       // Get.snackbar(AppMetaLabels().success, AppMetaLabels().stageUpdated,
//       //     backgroundColor: AppColors.white54);
//       docsModel?.caseStageInfo.stageId.value = 3;
//       enableSubmit.value = false;
//       if (caller == 'contract') {
//         final contractController = Get.find<GetContractsDetailsController>();
//         contractController.getData();
//       }
//       final contractsWithActionsController =
//           Get.put(ContractsWithActionsController());
//       contractsWithActionsController.getContracts();
//     } else if (resp is String) {
//       Get.snackbar(AppMetaLabels().error, resp,
//           backgroundColor: AppColors.white54);
//     }
//   }
// }

