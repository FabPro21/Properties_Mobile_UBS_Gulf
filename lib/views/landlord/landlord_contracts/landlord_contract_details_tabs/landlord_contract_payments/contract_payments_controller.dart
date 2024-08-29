import 'dart:io';
import 'dart:typed_data';
import 'package:fap_properties/data/models/landlord_models/contract_cheque_model.dart';
import 'package:fap_properties/data/models/landlord_models/contract_payment_model.dart';
import 'package:fap_properties/data/models/landlord_models/unverified_payment_model.dart';
import 'package:fap_properties/data/repository/landlord_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';

class LandlordContractPaymentsController extends GetxController {
  ContractPaymentModelLandlord payments = ContractPaymentModelLandlord();
  var loadingData = true.obs;
  int length = 0;
  RxString onSearch = "".obs;
  RxString error = "".obs;

  UnverifiedContractPaymentsLandlord unverifiedPayments =
      UnverifiedContractPaymentsLandlord();
  RxBool loadingUnverified = true.obs;
  String errorLoadingUnverified = '';

  // @override
  // void onInit() {
  //   getData();
  //   getUnverifiedPayments();
  //   super.onInit();
  // }

  getData() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      loadingData.value = true;
      error.value = '';
      var result = await LandlordRepository.contractPayments();
      if (result is ContractPaymentModelLandlord) {
        if (payments.status == AppMetaLabels().notFound) {
          error.value = AppMetaLabels().noDatafound;
        } else {
          payments = result;
          length = payments.payments!.length;
        }
      } else {
        error.value = AppMetaLabels().noDatafound;
      }
    } catch (e) {
      error.value = AppMetaLabels().someThingWentWrong;
      print("this is the error from controller= $e");
    }
    loadingData.value = false;
  }

  getUnverifiedPayments() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      loadingUnverified.value = true;
      errorLoadingUnverified = '';
      var result = await LandlordRepository.getUnverifiedPayments();
      if (result is UnverifiedContractPaymentsLandlord) {
        if (result.contractPayments!.isEmpty) {
          errorLoadingUnverified = AppMetaLabels().noDatafound;
        } else {
          unverifiedPayments = result;
        }
      } else {
        errorLoadingUnverified = result;
      }
    } catch (e) {
      errorLoadingUnverified = AppMetaLabels().someThingWentWrong;
    }
    loadingUnverified.value = false;
  }

  getCheque(int index) async {
    payments.payments![index].loadingCheque!.value = true;
    payments.payments![index].errorLoadingCheque = '';
    var result = await LandlordRepository.getCheque(
        payments.payments![index].transactionId.toString());
    if (result is GetContractChequesModelLandlord) {
      if (result.status == AppMetaLabels().notFound) {
        payments.payments![index].errorLoadingCheque =
            AppMetaLabels().noDatafound;
      } else {
        payments.payments![index].cheque = result;
      }
    } else {
      payments.payments![index].errorLoadingCheque = AppMetaLabels().noDatafound;
    }
    payments.payments![index].loadingCheque!.value = false;
  }

  void downloadReceipt(Payment payment) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    payment.downloadingReceipt!.value = true;
     print('Condition """"::::');
    SessionController().setTransactionId(payment.transactionId.toString());
    var result = await LandlordRepository.paymentsDownloadReceipt();
    print('Condition """"::::::"""""" ${(result is Uint8List)}');
    if (result is Uint8List) {
      if (await getStoragePermission()) {
        String path = await createPdf(result, payment.receiptNo??"");
        print('path """"::::::"""""" $path');
        try {
          print('path """"::Inside Try ::::"""""" $path');
          OpenFile.open(path);
        } catch (e) {
          print('path """" Catch:: $e');
          Get.snackbar(
            AppMetaLabels().error,
            e.toString(),
            backgroundColor: AppColors.white54,
          );
        }
      }
    } else {
      Get.snackbar(
        AppMetaLabels().error,
        result.toString(),
        backgroundColor: AppColors.white54,
      );
    }
    payment.downloadingReceipt!.value = false;
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

  Future<String> createPdf(Uint8List data, String receiptNo) async {
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/receipt$receiptNo.pdf");
    await file.writeAsBytes(data.buffer.asUint8List());
    return "${output.path}/receipt$receiptNo.pdf";
  }
}
