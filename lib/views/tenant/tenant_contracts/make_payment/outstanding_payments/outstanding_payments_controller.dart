import 'dart:convert';
import 'dart:io';
import 'package:fap_properties/data/models/tenant_models/contract_payable/outstanding_payments_model.dart';
import 'package:fap_properties/data/models/tenant_models/download_cheque_model.dart';
import 'package:fap_properties/utils/constants/check_file_extension.dart';
import 'package:fap_properties/utils/image_compress.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:image_editor_plus/image_editor_plus.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../data/helpers/base_client.dart';
import '../../../../../data/helpers/session_controller.dart';
import '../../../../../data/repository/tenant_repository.dart';
import '../../../../../utils/constants/meta_labels.dart';
import '../../../../common/no_internet_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
// import 'package:path/path.dart' as path;

class OutstandingPaymentsController extends GetxController {
  var outstandingPayments = OutstandingPaymentsModel();
  RxBool isShowpopUp = false.obs;

  TextEditingController locationTextController = TextEditingController();
  var loadingOutstandingPayments = true.obs;
  RxString errorPickupDelivery = "".obs;
  RxString pickupDeliveryText = "".obs;
  RxString errorLoadingOutstandingPayments = "".obs;
  RxString sumOfAllPayments = '0.00'.obs;
  RxString totalRentalPayment = '0.00'.obs;
  RxString totalAdditionalCharges = '0.00'.obs;
  RxString totalVatOnRent = '0.00'.obs;
  RxString totalVatOnCharges = '0.00'.obs;
  List<dynamic> paymentsToShow = [];
  List<String> chequesToShowAddress = [];
  RxBool showDeliveryOptions = false.obs;
  RxBool showDeliveryOptionsTest = false.obs;
  RxBool showDeliveryOptionsTestForButton = false.obs;
  RxBool gotoOnlinePayments = false.obs;
  RxBool gotoOnlinePaymentsTest = false.obs;
  RxInt chequeDeliveryOption = 2.obs;

  RxBool isEnableCancelButton = true.obs;
  RxBool isChequeSampleShow = false.obs;

  Future<int> getOutstandingPayments() async {
    bool _isIntenetConnected = await BaseClientClass.isInternetConnected();
    if (!_isIntenetConnected) {
      Get.to(() => NoInternetScreen());
    }
    errorLoadingOutstandingPayments.value = '';
    loadingOutstandingPayments.value = true;
    outstandingPayments = OutstandingPaymentsModel();
    sumOfAllPayments.value = '0.00';
    totalRentalPayment.value = '0.00';
    totalAdditionalCharges.value = '0.00';
    totalVatOnRent.value = '0.00';
    totalVatOnCharges.value = '0.00';
    chequesToShowAddress.clear();
    try {
      var resp = await TenantRepository.getOutstandingPayments(
          SessionController().getContractID());

      if (resp is OutstandingPaymentsModel) {
        if (kDebugMode) print(resp);
        if (resp.status == AppMetaLabels().notFound) {
          isChequeSampleShow.value = false;
          errorLoadingOutstandingPayments.value = AppMetaLabels().noDatafound;
        } else {
          outstandingPayments = resp;
          if (outstandingPayments.record.first.aramexAddress != '') {
            locationTextController.text =
                outstandingPayments.record.first.aramexAddress ?? '';
            pickupDeliveryText.value = locationTextController.text;
            print(locationTextController.text);
            print('Location is  not empty :::::::::: => :::::::::');
          } else {
            print('Location is empty :::::::::: => :::::::::');
          }

          removeZeroBalance();
          sumPayments();
          insertInPaymentsToShow();
          shouldShowAddressField();
          shouldGoToOnlinePayments();
          if (sumOfAllPayments.value == '0.00')
            errorLoadingOutstandingPayments.value = AppMetaLabels().noDatafound;
        }
      } else {
        errorLoadingOutstandingPayments.value = resp;
      }
    } catch (e) {
      print("This is the error from controller : $e");
    } finally {
      loadingOutstandingPayments.value = false;
    }
    int noOfPayments = 0;
    if (outstandingPayments.record != null)
      noOfPayments = outstandingPayments.record.length;
    return noOfPayments;
  }

  updatePaymentMethod(
      Record payable, int index, BuildContext context, String type) async {
    payable.errorUpdatingPaymentMethod = false;
    payable.updatingPaymentMethod.value = true;
    final response = await TenantRepository.updatePaymentMethod(payable);
    if (response['status'] == 'ok') {
      print('Index  :::: $index => ${index - 1}');
      print('chequesToShowAddress  ::::  $chequesToShowAddress');
      if (type == 'Cheque') {
        chequesToShowAddress[index - 1] = 'true';
        print('Inside func Cheque::::: $chequesToShowAddress');
        print('Inside func Cheque::::: ${chequesToShowAddress.length}');
        (context as Element).markNeedsBuild();
      } else if (type == 'bankTransfer') {
        chequesToShowAddress[index - 1] = 'false';
        print('Inside func Cheque::::: $chequesToShowAddress');
        (context as Element).markNeedsBuild();
      } else {
        chequesToShowAddress[index - 1] = 'false';
        print('Inside func Cheque::::: $chequesToShowAddress');
        (context as Element).markNeedsBuild();
      }
      // check weather all are online or cheques etc
      shouldGoToOnlinePayments();
    } else {
      payable.errorUpdatingPaymentMethod = true;
      Get.snackbar(AppMetaLabels().error, AppMetaLabels().someThingWentWrong);
    }
    payable.updatingPaymentMethod.value = false;
  }

  uploadCheque(Record payable) async {
    payable.errorUploadingCheque = false;
    payable.uploadingCheque.value = true;
    final response = await TenantRepository.updatePaymentMethod(payable);
    // final response = await TenantRepository.updatePaymentMethod(payable);
    try {
      print(' $response');

      if (response['status'] == 'ok' && response['statusCode'] == '200') {
        print(
            'Iniside If of status and statusCode::=> ${(response['status'] == 'ok' && response['statusCode'] == '200')}');

        // if (response['status'] == 'ok') {
        payable.forceUploadCheque.value = false;
        payable.cheque = payable.filePath.split('/').last;
        payable.isRejected = false;
      } else {
        payable.errorUploadingCheque = true;
        SnakBarWidget.getSnackBarErrorBlue(
            AppMetaLabels().error, AppMetaLabels().someThingWentWrong);
      }
    } catch (e) {
      payable.errorUploadingCheque = true;
      SnakBarWidget.getSnackBarErrorBlue(
          AppMetaLabels().error, AppMetaLabels().someThingWentWrong);
    }
    payable.uploadingCheque.value = false;
  }

  downloadCheque(Record payable) async {
    payable.errorDownloadingCheque = false;
    payable.downloadingCheque.value = true;
    final response =
        await TenantRepository.downloadCheque(payable.paymentSettingId);
    print('Response :::::: $response');
    if (response is DownloadChequeModel) {
      var base64DecodeAble = base64Decode(response.cheque.replaceAll('\n', ''));
      showFile(payable, base64DecodeAble,
          'cheque${payable.contractPaymentId}${response.chequeName}');
    } else {
      payable.errorDownloadingCheque = true;
      SnakBarWidget.getSnackBarErrorBlue(AppMetaLabels().error, AppMetaLabels().someThingWentWrong);
    }
    payable.downloadingCheque.value = false;
  }

  void removeZeroBalance() {
    outstandingPayments.record.forEach((element) {
      if (element.amount == 0) outstandingPayments.record.remove(element);
    });
  }

  void sumPayments() {
    double rentalSum = 0;
    double additionalSum = 0;
    double vatRentSum = 0;
    double vatChargesSum = 0;
    for (int i = 0; i < outstandingPayments.record.length; i++) {
      if (outstandingPayments.record[i].type == 'Contract Payable')
        rentalSum = rentalSum + (outstandingPayments.record[i].amount ?? 0);
      else if (outstandingPayments.record[i].type == 'Additional Charges')
        additionalSum =
            additionalSum + (outstandingPayments.record[i].amount ?? 0);
      else if (outstandingPayments.record[i].type.toLowerCase() ==
          'Vat On Rent'.toLowerCase())
        vatRentSum = vatRentSum + (outstandingPayments.record[i].amount ?? 0);
      else if (outstandingPayments.record[i].type.toLowerCase() ==
          'Vat On Charges'.toLowerCase())
        vatChargesSum =
            vatChargesSum + (outstandingPayments.record[i].amount ?? 0);
      if (outstandingPayments.record[i].isRejected) {
        outstandingPayments.record[i].filePath = null;
      }
    }
    final amountFormat = NumberFormat('#,##0.00', 'AR');
    this.totalRentalPayment.value = amountFormat.format(rentalSum);
    this.totalAdditionalCharges.value = amountFormat.format(additionalSum);
    this.totalVatOnRent.value = amountFormat.format(vatRentSum);
    this.totalVatOnCharges.value = amountFormat.format(vatChargesSum);
    this.sumOfAllPayments.value = amountFormat
        .format(rentalSum + additionalSum + vatRentSum + vatChargesSum);
  }

  void insertInPaymentsToShow() {
    paymentsToShow.clear();
    if (totalRentalPayment.value != '0.00') {
      paymentsToShow.add(AppMetaLabels().renatalpayments);
      // chequesToShowAddress
      // adding false as a string in chequesToShowAddress because we want to
      // show some fields on the base of payment Mode type if the payment  type is
      // cheque then will show delivery field that is why we are adding fals in this array
      // => Its value update in inside updatePaymentMethod() func  and where it is called
      chequesToShowAddress.add('false');
      for (Record payable in outstandingPayments.record) {
        if (payable.type.toLowerCase() == 'Contract Payable'.toLowerCase()) {
          if (payable.defaultpaymentmethodtype.value == 2) {
            chequesToShowAddress.add('true');
            showDeliveryOptionsTestForButton.value = true;
          } else {
            chequesToShowAddress.add('false');
          }
          paymentsToShow.add(payable);
        }
      }
    }
    if (totalAdditionalCharges.value != '0.00') {
      paymentsToShow.add(AppMetaLabels().additionalCharges);
      chequesToShowAddress.add('false');
      for (Record payable in outstandingPayments.record) {
        if (payable.type.toLowerCase() == 'Additional Charges'.toLowerCase()) {
          paymentsToShow.add(payable);
          if (payable.defaultpaymentmethodtype.value == 2) {
            chequesToShowAddress.add('true');
            showDeliveryOptionsTestForButton.value = true;
          } else {
            chequesToShowAddress.add('false');
          }
        }
      }
    }
    if (totalVatOnRent.value != '0.00') {
      paymentsToShow.add(AppMetaLabels().vatOnRent);
      chequesToShowAddress.add('false');
      for (Record payable in outstandingPayments.record) {
        if (payable.type.toLowerCase() == 'Vat On Rent'.toLowerCase()) {
          paymentsToShow.add(payable);
          if (payable.defaultpaymentmethodtype.value == 2) {
            chequesToShowAddress.add('true');
            showDeliveryOptionsTestForButton.value = true;
          } else {
            chequesToShowAddress.add('false');
          }
        }
      }
    }
    if (totalVatOnCharges.value != '0.00') {
      paymentsToShow.add(AppMetaLabels().vatOnCharges);
      chequesToShowAddress.add('false');
      for (Record payable in outstandingPayments.record) {
        if (payable.type.toLowerCase() == 'Vat On Charges'.toLowerCase()) {
          // chequesToShowAddress.add('false');
          if (payable.defaultpaymentmethodtype.value == 2) {
            chequesToShowAddress.add('true');
            showDeliveryOptionsTestForButton.value = true;
          } else {
            chequesToShowAddress.add('false');
          }
          paymentsToShow.add(payable);
        }
      }
    }
    update();
    print(chequesToShowAddress);
  }

  Future<void> pickDoc(Record payable) async {
    XFile xfile;
    try {
      xfile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (!CheckFileExtenstion().checkImageExtFunc(xfile.path)) {
        Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileExtensionError,
            duration: Duration(seconds: 5),
            backgroundColor: AppColors.redColor,
            colorText: AppColors.white54);
        return;
      }
    } catch (e) {
      update();
    }
    if (xfile != null) {
      Uint8List photo = await xfile.readAsBytes();
      print(
          'Size of file Before Compress ::: ${CheckFileExtenstion().getFileSize(photo)}  Path:${xfile.path}');

      try {
        final editedImage = await Get.to(() => ImageCropper(
              image: photo,
            ));
        photo = editedImage;

        photo = await compressImage(photo);

        print(
            'Size of file After Compress ::: ${CheckFileExtenstion().getFileSize(photo)}  Path:${xfile.path}');
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

        final newPath = await getTemporaryDirectory();
        final newFile = File("${newPath.path}/${xfile.path.split('/').last}");
        if (newFile != null) {
          await newFile.writeAsBytes(photo);
          payable.filePath = newFile.path;
          payable.chequeFile = photo ?? photo;
        }
        payable.filePath = newFile.path;
        payable.chequeFile = photo;
        payable.uploadingCheque.value = true;
        payable.uploadingCheque.value = false;
        print('Selecte Path ::::::::: after store ${payable.filePath} ');
      } catch (e) {
        print('Exception :::::::: $e');
      }
    }
  }

  Future<void> takePhoto(Record payable) async {
    XFile xfile;
    try {
      xfile = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );

      if (!CheckFileExtenstion().checkImageExtFunc(xfile.path)) {
        Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileExtensionError,
            duration: Duration(seconds: 5),
            backgroundColor: AppColors.redColor,
            colorText: AppColors.white54);
        return;
      }
    } catch (e) {
      update();
    }
    if (xfile != null) {
      Uint8List photo = await xfile.readAsBytes();

      try {
        final editedImage = await Get.to(() => ImageCropper(
              image: photo,
            ));
        photo = editedImage;
        print('editedImage Path ::::::::: before store $editedImage ');
        print(
            'Size of file Before Compress ::: ${CheckFileExtenstion().getFileSize(photo)}  Path:${xfile.path}');

        photo = await compressImage(photo);

        // checking file size EID
        print(
            'Size of file After Compress ::: ${CheckFileExtenstion().getFileSize(photo)}  Path:${xfile.path}');
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
        final newPath = await getTemporaryDirectory();
        final newFile = File("${newPath.path}/${xfile.path.split('/').last}");
        if (newFile != null) {
          await newFile.writeAsBytes(photo);
          payable.filePath = newFile.path;
          payable.chequeFile = photo ?? photo;
        }

        payable.filePath = newFile.path;
        payable.chequeFile = photo;
        payable.uploadingCheque.value = true;
        payable.uploadingCheque.value = false;
        print('Selecte Path ::::::::: after store ${payable.filePath} ');
      } catch (e) {
        print('Exception :::::::: $e');
      }
    }
  }

  removeCheque(Record payable) async {
    payable.errorRemovingCheque.value = false;
    payable.removingCheque.value = true;
    final response =
        await TenantRepository.removeCheque(payable.paymentSettingId);
    payable.removingCheque.value = false;
    if (response == 200) {
      payable.filePath = null;
      payable.chequeFile = null;
      payable.cheque = null;
      // adding this
      payable.chequeNo = '';
    } else
      payable.errorRemovingCheque.value = true;
  }

  int areAllChequesUploaded() {
    for (int i = 0; i < outstandingPayments.record.length; i++) {
      Record payable = outstandingPayments.record[i];
      payable.forceUploadCheque.value = false;
      if (payable.defaultpaymentmethodtype.value == 2 &&
          (payable.cheque == null ||
              payable.cheque.isEmpty ||
              payable.errorUploadingCheque ||
              payable.isRejected)) {
        SnakBarWidget.getSnackBarError(
            AppMetaLabels().error, AppMetaLabels().pleaseUploadCheque);
        return i;
      }
      // if (payable.defaultpaymentmethodtype.value == 2 &&
      //     (payable.cheque == null ||
      //         payable.cheque.isEmpty ||
      //         payable.errorUploadingCheque)) {
      //   SnakBarWidget.getSnackBarError(
      //       AppMetaLabels().error, AppMetaLabels().pleaseUploadCheque);
      //   return i;
      // }
    }
    return -1;
  }

  shouldShowAddressFieldTest() {
    for (int i = 0; i < outstandingPayments.record.length; i++) {
      Record payable = outstandingPayments.record[i];
      print(payable);
      print('Here:::::::::');
      print(chequeDeliveryOption.value);
      if (payable.defaultpaymentmethodtype.value == 2) {
        chequesToShowAddress[i] = 'true';
        showDeliveryOptionsTest.value = true;
      }
    }
  }

  void shouldShowAddressField() {
    for (int i = 0; i < outstandingPayments.record.length; i++) {
      Record payable = outstandingPayments.record[i];
      print(payable);
      if (payable.defaultpaymentmethodtype.value == 2) {
        showDeliveryOptions.value = true;
        showDeliveryOptionsTest.value = true;
      }

      print('Self Delivery :::::: ${payable.selfDelivery}');
      if (payable.selfDelivery == '2') {
        chequeDeliveryOption.value = 2;
      } else if (payable.selfDelivery == '1') {
        chequeDeliveryOption.value = 1;
      } else {
        print('Self Delivery if Null  :::::: ${payable.selfDelivery}');
        chequeDeliveryOption.value = 2;
      }
      // for howing default textfield
      // if (payable.selfDelivery == '2') {
      //   chequeDeliveryOption.value = 2;
      // } else {
      //   chequeDeliveryOption.value = 1;
      // }
    }
  }

  void shouldGoToOnlinePayments() {
    gotoOnlinePayments.value = false;
    for (int i = 0; i < outstandingPayments.record.length; i++) {
      Record payable = outstandingPayments.record[i];
      if (payable.defaultpaymentmethodtype.value == 1 ||
          payable.defaultpaymentmethodtype.value == 3) {
        gotoOnlinePayments.value = true;
      }
    }
  }

  RxBool updatingAddress = false.obs;
  Future<bool> updateDeliveryAddress(
      String address, int contractId, String contractNo) async {
    updatingAddress.value = true;
    final resp = await TenantRepository.updateAramexAddress(
        contractId, address, chequeDeliveryOption.value);
    if (resp == 'ok') {
      for (Record payable in outstandingPayments.record) {
        payable.aramexAddress = address;
        payable.confirmed = 1;
      }
      // gotoOnlinePayments.value = true;
      insertInPaymentsToShow();
      updatingAddress.value = false;
      // updateDeliveryOption = false;
      return true;
    } else {
      Get.snackbar(AppMetaLabels().error, resp);
      updatingAddress.value = false;
    }
    return false;
  }

  void showFile(Record payable, Uint8List file, String name) async {
    print('Payable File Path :::: ${payable.filePath}');
    if (payable.filePath == null) {
      if (await getStoragePermission()) {
        String path = await saveFile(file, name);
        payable.filePath = path;
        print('Payable File Path :::: ${payable.filePath}');
        OpenFile.open(path);
      }
    } else {
      OpenFile.open(payable.filePath);
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

  Future<String> saveFile(Uint8List file, String name) async {
    final path = await getTemporaryDirectory();
    final newFile = File("${path.path}/$name");
    print('New Path ::::inside Save File :::::: $newFile');
    await newFile.writeAsBytes(file);
    return newFile.path;
  }
}


// Before disable the paymentMethodId
// import 'dart:convert';
// import 'dart:io';
// import 'package:fap_properties/data/models/tenant_models/contract_payable/outstanding_payments_model.dart';
// import 'package:fap_properties/data/models/tenant_models/download_cheque_model.dart';
// import 'package:fap_properties/utils/constants/check_file_extension.dart';
// import 'package:fap_properties/utils/image_compress.dart';
// import 'package:fap_properties/utils/styles/colors.dart';
// import 'package:fap_properties/views/widgets/snackbar_widget.dart';
// import 'package:get/get.dart';
// import 'package:flutter/foundation.dart';
// import 'package:image_editor_plus/image_editor_plus.dart';

// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:open_file/open_file.dart';
// import 'package:permission_handler/permission_handler.dart';
// import '../../../../../data/helpers/base_client.dart';
// import '../../../../../data/helpers/session_controller.dart';
// import '../../../../../data/repository/tenant_repository.dart';
// import '../../../../../utils/constants/meta_labels.dart';
// import '../../../../common/no_internet_screen.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/material.dart';
// // import 'package:path/path.dart' as path;

// class OutstandingPaymentsController extends GetxController {
//   var outstandingPayments = OutstandingPaymentsModel();
//   RxBool isShowpopUp = false.obs;

//   TextEditingController locationTextController = TextEditingController();
//   var loadingOutstandingPayments = true.obs;
//   RxString errorPickupDelivery = "".obs;
//   RxString pickupDeliveryText = "".obs;
//   RxString errorLoadingOutstandingPayments = "".obs;
//   RxString sumOfAllPayments = '0.00'.obs;
//   RxString totalRentalPayment = '0.00'.obs;
//   RxString totalAdditionalCharges = '0.00'.obs;
//   RxString totalVatOnRent = '0.00'.obs;
//   RxString totalVatOnCharges = '0.00'.obs;
//   List<dynamic> paymentsToShow = [];
//   List<String> chequesToShowAddress = [];
//   RxBool showDeliveryOptions = false.obs;
//   RxBool showDeliveryOptionsTest = false.obs;
//   RxBool showDeliveryOptionsTestForButton = false.obs;
//   RxBool gotoOnlinePayments = false.obs;
//   RxBool gotoOnlinePaymentsTest = false.obs;
//   RxInt chequeDeliveryOption = 2.obs; 

//   RxBool isEnableCancelButton = true.obs;


//   Future<int> getOutstandingPayments() async {
//     bool _isIntenetConnected = await BaseClientClass.isInternetConnected();
//     if (!_isIntenetConnected) {
//       Get.to(() => NoInternetScreen());
//     }
//     errorLoadingOutstandingPayments.value = '';
//     loadingOutstandingPayments.value = true;
//     outstandingPayments = OutstandingPaymentsModel();
//     sumOfAllPayments.value = '0.00';
//     totalRentalPayment.value = '0.00';
//     totalAdditionalCharges.value = '0.00';
//     totalVatOnRent.value = '0.00';
//     totalVatOnCharges.value = '0.00';
//     chequesToShowAddress.clear();
//     try {
//       var resp = await TenantRepository.getOutstandingPayments(
//           SessionController().getContractID());

//       if (resp is OutstandingPaymentsModel) {
//         if (kDebugMode) print(resp);
//         if (resp.status == AppMetaLabels().notFound) {
//           errorLoadingOutstandingPayments.value = AppMetaLabels().noDatafound;
//         } else {
//           outstandingPayments = resp;
//           if (outstandingPayments.record.first.aramexAddress != '') {
//             locationTextController.text =
//                 outstandingPayments.record.first.aramexAddress ?? '';
//             pickupDeliveryText.value = locationTextController.text;
//             print(locationTextController.text);
//             print('Location is  not empty :::::::::: => :::::::::');
//           } else {
//             print('Location is empty :::::::::: => :::::::::');
//           }

//           removeZeroBalance();
//           sumPayments();
//           insertInPaymentsToShow();
//           shouldShowAddressField();
//           shouldGoToOnlinePayments();
//           if (sumOfAllPayments.value == '0.00')
//             errorLoadingOutstandingPayments.value = AppMetaLabels().noDatafound;
//         }
//       } else {
//         errorLoadingOutstandingPayments.value = resp;
//       }
//     } catch (e) {
//       print("This is the error from controller : $e");
//     } finally {
//       loadingOutstandingPayments.value = false;
//     }
//     int noOfPayments = 0;
//     if (outstandingPayments.record != null)
//       noOfPayments = outstandingPayments.record.length;
//     return noOfPayments;
//   }

//   updatePaymentMethod(
//       Record payable, int index, BuildContext context, String type) async {
//     payable.errorUpdatingPaymentMethod = false;
//     payable.updatingPaymentMethod.value = true;
//     final response = await TenantRepository.updatePaymentMethod(payable);
//     if (response['status'] == 'ok') {
//       print('Index  :::: $index => ${index - 1}');
//       print('chequesToShowAddress  ::::  $chequesToShowAddress');
//       if (type == 'Cheque') {
//         chequesToShowAddress[index - 1] = 'true';
//         print('Inside func Cheque::::: $chequesToShowAddress');
//         print('Inside func Cheque::::: ${chequesToShowAddress.length}');
//         (context as Element).markNeedsBuild();
//       } else if (type == 'bankTransfer') {
//         chequesToShowAddress[index - 1] = 'false';
//         print('Inside func Cheque::::: $chequesToShowAddress');
//         (context as Element).markNeedsBuild();
//       } else {
//         chequesToShowAddress[index - 1] = 'false';
//         print('Inside func Cheque::::: $chequesToShowAddress');
//         (context as Element).markNeedsBuild();
//       }
//       // check weather all are online or cheques etc
//       shouldGoToOnlinePayments();
//     } else {
//       payable.errorUpdatingPaymentMethod = true;
//       Get.snackbar(AppMetaLabels().error, AppMetaLabels().someThingWentWrong);
//     }
//     payable.updatingPaymentMethod.value = false;
//   }

//   uploadCheque(Record payable) async {
//     payable.errorUploadingCheque = false;
//     payable.uploadingCheque.value = true;
//     final response = await TenantRepository.updatePaymentMethod(payable);
//     // final response = await TenantRepository.updatePaymentMethod(payable);
//     try {
//       if (response['status'] == 'ok') {
//         payable.forceUploadCheque.value = false;
//         payable.cheque = payable.filePath.split('/').last;
//         payable.isRejected = false;
//      } else {
//         payable.errorUploadingCheque = true;
//         Get.snackbar(AppMetaLabels().error, AppMetaLabels().someThingWentWrong);
//       }
//     } catch (e) {
//       payable.errorUploadingCheque = true;
//       Get.snackbar(AppMetaLabels().error, AppMetaLabels().someThingWentWrong);
//     }
//     payable.uploadingCheque.value = false;
//   }

//   downloadCheque(Record payable) async {
//     payable.errorDownloadingCheque = false;
//     payable.downloadingCheque.value = true;
//     final response =
//         await TenantRepository.downloadCheque(payable.paymentSettingId);
//     print('Response :::::: $response');
//     if (response is DownloadChequeModel) {
//       var base64DecodeAble = base64Decode(response.cheque.replaceAll('\n', ''));
//       showFile(payable, base64DecodeAble,
//           'cheque${payable.contractPaymentId}${response.chequeName}');
//     } else {
//       payable.errorDownloadingCheque = true;
//       Get.snackbar(AppMetaLabels().error, AppMetaLabels().someThingWentWrong);
//     }
//     payable.downloadingCheque.value = false;
//   }
//   void removeZeroBalance() {
//     outstandingPayments.record.forEach((element) {
//       if (element.amount == 0) outstandingPayments.record.remove(element);
//     });
//   }

//   void sumPayments() {
//     double rentalSum = 0;
//     double additionalSum = 0;
//     double vatRentSum = 0;
//     double vatChargesSum = 0;
//     for (int i = 0; i < outstandingPayments.record.length; i++) {
//       if (outstandingPayments.record[i].type == 'Contract Payable')
//         rentalSum = rentalSum + (outstandingPayments.record[i].amount ?? 0);
//       else if (outstandingPayments.record[i].type == 'Additional Charges')
//         additionalSum =
//             additionalSum + (outstandingPayments.record[i].amount ?? 0);
//       else if (outstandingPayments.record[i].type.toLowerCase() ==
//           'Vat On Rent'.toLowerCase())
//         vatRentSum = vatRentSum + (outstandingPayments.record[i].amount ?? 0);
//       else if (outstandingPayments.record[i].type.toLowerCase() ==
//           'Vat On Charges'.toLowerCase())
//         vatChargesSum =
//             vatChargesSum + (outstandingPayments.record[i].amount ?? 0);
//       if (outstandingPayments.record[i].isRejected) {
//         outstandingPayments.record[i].filePath = null;
//       }
//     }
//     final amountFormat = NumberFormat('#,##0.00', 'AR');
//     this.totalRentalPayment.value = amountFormat.format(rentalSum);
//     this.totalAdditionalCharges.value = amountFormat.format(additionalSum);
//     this.totalVatOnRent.value = amountFormat.format(vatRentSum);
//     this.totalVatOnCharges.value = amountFormat.format(vatChargesSum);
//     this.sumOfAllPayments.value = amountFormat
//         .format(rentalSum + additionalSum + vatRentSum + vatChargesSum);
//   }

//   void insertInPaymentsToShow() {
//     paymentsToShow.clear();
//     if (totalRentalPayment.value != '0.00') {
//       paymentsToShow.add(AppMetaLabels().renatalpayments);
//       // chequesToShowAddress
//       // adding false as a string in chequesToShowAddress because we want to
//       // show some fields on the base of payment Mode type if the payment  type is
//       // cheque then will show delivery field that is why we are adding fals in this array
//       // => Its value update in inside updatePaymentMethod() func  and where it is called
//       chequesToShowAddress.add('false');
//       for (Record payable in outstandingPayments.record) {
//         if (payable.type.toLowerCase() == 'Contract Payable'.toLowerCase()) {
//           if (payable.paymentMethodId.value == 2) {
//             chequesToShowAddress.add('true');
//             showDeliveryOptionsTestForButton.value = true;
//           } else {
//             chequesToShowAddress.add('false');
//           }
//           paymentsToShow.add(payable);
//         }
//       }
//     }
//     if (totalAdditionalCharges.value != '0.00') {
//       paymentsToShow.add(AppMetaLabels().additionalCharges);
//       chequesToShowAddress.add('false');
//       for (Record payable in outstandingPayments.record) {
//         if (payable.type.toLowerCase() == 'Additional Charges'.toLowerCase()) {
//           paymentsToShow.add(payable);
//           if (payable.paymentMethodId.value == 2) {
//             chequesToShowAddress.add('true');
//             showDeliveryOptionsTestForButton.value = true;
//           } else {
//             chequesToShowAddress.add('false');
//           }
//         }
//       }
//     }
//     if (totalVatOnRent.value != '0.00') {
//       paymentsToShow.add(AppMetaLabels().vatOnRent);
//       chequesToShowAddress.add('false');
//       for (Record payable in outstandingPayments.record) {
//         if (payable.type.toLowerCase() == 'Vat On Rent'.toLowerCase()) {
//           paymentsToShow.add(payable);
//           if (payable.paymentMethodId.value == 2) {
//             chequesToShowAddress.add('true');
//             showDeliveryOptionsTestForButton.value = true;
//           } else {
//             chequesToShowAddress.add('false');
//           }
//         }
//       }
//     }
//     if (totalVatOnCharges.value != '0.00') {
//       paymentsToShow.add(AppMetaLabels().vatOnCharges);
//       chequesToShowAddress.add('false');
//       for (Record payable in outstandingPayments.record) {
//         if (payable.type.toLowerCase() == 'Vat On Charges'.toLowerCase()) {
//           // chequesToShowAddress.add('false');
//           if (payable.paymentMethodId.value == 2) {
//             chequesToShowAddress.add('true');
//             showDeliveryOptionsTestForButton.value = true;
//           } else {
//             chequesToShowAddress.add('false');
//           }
//           paymentsToShow.add(payable);
//         }
//       }
//     }
//     update();
//     print(chequesToShowAddress);
//   }

//   Future<void> pickDoc(Record payable) async {
//     XFile xfile;
//     try {
//       xfile = await ImagePicker().pickImage(
//         source: ImageSource.gallery,
//       );

//       if (!CheckFileExtenstion().checkImageExtFunc(xfile.path)) {
//         Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileExtensionError,
//             duration: Duration(seconds: 5),
//             backgroundColor: AppColors.redColor,
//             colorText: AppColors.white54);
//         return;
//       }
//     } catch (e) {
//       update();
//     }
//     if (xfile != null) {
//       Uint8List photo = await xfile.readAsBytes();
//       print(
//           'Size of file Before Compress ::: ${CheckFileExtenstion().getFileSize(photo)}  Path:${xfile.path}');

//       try {
//         final editedImage = await Get.to(() => ImageCropper(
//               image: photo,
//             ));
//         photo = editedImage;

//         photo = await compressImage(photo);

//        print(
//             'Size of file After Compress ::: ${CheckFileExtenstion().getFileSize(photo)}  Path:${xfile.path}');
//         var size = CheckFileExtenstion().getFileSize(photo).split(' ')[0];
//         var extension = CheckFileExtenstion().getFileSize(photo).split(' ')[1];
//         if (extension.contains('MB')) {
//           if (double.parse(size) > 10) {
//             Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileSizenError,
//                 duration: Duration(seconds: 5),
//                 backgroundColor: AppColors.redColor,
//                 colorText: AppColors.white54);
//             return;
//           }
//         }

//         final newPath = await getTemporaryDirectory();
//         final newFile = File("${newPath.path}/${xfile.path.split('/').last}");
//         if (newFile != null) {
//           await newFile.writeAsBytes(photo);
//           payable.filePath = newFile.path;
//           payable.chequeFile = photo ?? photo;
//         }
//         payable.filePath = newFile.path;
//         payable.chequeFile = photo;
//         payable.uploadingCheque.value = true;
//         payable.uploadingCheque.value = false;
//         print('Selecte Path ::::::::: after store ${payable.filePath} ');
//       } catch (e) {
//         print('Exception :::::::: $e');
//       }
//     }
//   }

//   Future<void> takePhoto(Record payable) async {
//     XFile xfile;
//     try {
//       xfile = await ImagePicker().pickImage(
//         source: ImageSource.camera,
//       );

//       if (!CheckFileExtenstion().checkImageExtFunc(xfile.path)) {
//         Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileExtensionError,
//             duration: Duration(seconds: 5),
//             backgroundColor: AppColors.redColor,
//             colorText: AppColors.white54);
//         return;
//       }
//     } catch (e) {
//       update();
//     }
//     if (xfile != null) {
//       Uint8List photo = await xfile.readAsBytes();

//       try {
//         final editedImage = await Get.to(() => ImageCropper(
//               image: photo,
//             ));
//         photo = editedImage;
//         print('editedImage Path ::::::::: before store $editedImage ');
//         print(
//             'Size of file Before Compress ::: ${CheckFileExtenstion().getFileSize(photo)}  Path:${xfile.path}');

//         photo = await compressImage(photo);

//         // checking file size EID
//         print(
//             'Size of file After Compress ::: ${CheckFileExtenstion().getFileSize(photo)}  Path:${xfile.path}');
//         var size = CheckFileExtenstion().getFileSize(photo).split(' ')[0];
//         var extension = CheckFileExtenstion().getFileSize(photo).split(' ')[1];
//         if (extension.contains('MB')) {
//           if (double.parse(size) > 10) {
//             Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileSizenError,
//                 duration: Duration(seconds: 5),
//                 backgroundColor: AppColors.redColor,
//                 colorText: AppColors.white54);
//             return;
//           }
//         }
//         final newPath = await getTemporaryDirectory();
//         final newFile = File("${newPath.path}/${xfile.path.split('/').last}");
//         if (newFile != null) {
//           await newFile.writeAsBytes(photo);
//           payable.filePath = newFile.path;
//           payable.chequeFile = photo ?? photo;
//         }

//         payable.filePath = newFile.path;
//         payable.chequeFile = photo;
//         payable.uploadingCheque.value = true;
//         payable.uploadingCheque.value = false;
//         print('Selecte Path ::::::::: after store ${payable.filePath} ');
//       } catch (e) {
//         print('Exception :::::::: $e');
//       }
//     }
//   }

//   removeCheque(Record payable) async {
//     payable.errorRemovingCheque.value = false;
//     payable.removingCheque.value = true;
//     final response =
//         await TenantRepository.removeCheque(payable.paymentSettingId);
//     payable.removingCheque.value = false;
//     if (response == 200) {
//       payable.filePath = null;
//       payable.chequeFile = null;
//       payable.cheque = null;
//     } else
//       payable.errorRemovingCheque.value = true;
//   }

//   int areAllChequesUploaded() {
//     for (int i = 0; i < outstandingPayments.record.length; i++) {
//       Record payable = outstandingPayments.record[i];
//       payable.forceUploadCheque.value = false;
//       if (payable.paymentMethodId.value == 2 &&
//           (payable.cheque == null ||
//               payable.cheque.isEmpty ||
//               payable.errorUploadingCheque)) {
//         SnakBarWidget.getSnackBarError(
//             AppMetaLabels().error, AppMetaLabels().pleaseUploadCheque);
//         return i;
//       }
//     }
//     return -1;
//   }

//   shouldShowAddressFieldTest() {
//     for (int i = 0; i < outstandingPayments.record.length; i++) {
//       Record payable = outstandingPayments.record[i];
//       print(payable);
//       print('Here:::::::::');
//       print(chequeDeliveryOption.value);
//       if (payable.paymentMethodId.value == 2) {
//         chequesToShowAddress[i] = 'true';
//         showDeliveryOptionsTest.value = true;
//       }
//     }
//   }

//   void shouldShowAddressField() {
//     for (int i = 0; i < outstandingPayments.record.length; i++) {
//       Record payable = outstandingPayments.record[i];
//       print(payable);
//       if (payable.paymentMethodId.value == 2) {
//         showDeliveryOptions.value = true;
//         showDeliveryOptionsTest.value = true;
//       }
//       if (payable.selfDelivery == '2') {
//         chequeDeliveryOption.value = 2;
//       } else {
//         chequeDeliveryOption.value = 1;
//       }
//     }
//   }

//   void shouldGoToOnlinePayments() {
//     gotoOnlinePayments.value = false;
//     for (int i = 0; i < outstandingPayments.record.length; i++) {
//       Record payable = outstandingPayments.record[i];
//       if (payable.paymentMethodId.value == 1 ||
//           payable.paymentMethodId.value == 3) {
//         gotoOnlinePayments.value = true;
//       }
//     }
//   }

//   RxBool updatingAddress = false.obs;
//   Future<bool> updateDeliveryAddress(
//       String address, int contractId, String contractNo) async {
//     updatingAddress.value = true;
//     final resp = await TenantRepository.updateAramexAddress(
//         contractId, address, chequeDeliveryOption.value);
//     if (resp == 'ok') {
//       for (Record payable in outstandingPayments.record) {
//         payable.aramexAddress = address;
//         payable.confirmed = 1;
//       }
//       // gotoOnlinePayments.value = true;
//       insertInPaymentsToShow();
//       updatingAddress.value = false;
//       // updateDeliveryOption = false;
//       return true;
//     } else {
//       Get.snackbar(AppMetaLabels().error, resp);
//       updatingAddress.value = false;
//     }
//     return false;
//   }

//   void showFile(Record payable, Uint8List file, String name) async {
//     print('Payable File Path :::: ${payable.filePath}');
//     if (payable.filePath == null) {
//       if (await getStoragePermission()) {
//         String path = await saveFile(file, name);
//         payable.filePath = path;
//         print('Payable File Path :::: ${payable.filePath}');
//         OpenFile.open(path);
//       }
//     } else {
//       OpenFile.open(payable.filePath);
//     }
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

//   Future<String> saveFile(Uint8List file, String name) async {
//     final path = await getTemporaryDirectory();
//     final newFile = File("${path.path}/$name");
//     print('New Path ::::inside Save File :::::: $newFile');
//     await newFile.writeAsBytes(file);
//     return newFile.path;
//   }
// }
