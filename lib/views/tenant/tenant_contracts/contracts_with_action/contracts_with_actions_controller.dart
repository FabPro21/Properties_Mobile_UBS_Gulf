import 'dart:io';
import 'dart:typed_data';
import 'package:fap_properties/data/models/tenant_models/contract_payable/outstanding_payments_model.dart';
import 'package:fap_properties/data/models/tenant_models/contract_with_due_action.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../data/helpers/base_client.dart';
import '../../../../utils/constants/meta_labels.dart';
import '../../../../utils/styles/colors.dart';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../../common/no_internet_screen.dart';

class ContractsWithActionsController extends GetxController {
  List<ContractWithDueAction> contractsList = [];
  RxBool loadingContracts = false.obs;
  String errorLoadingContracts = '';
  RxBool isEnableScreen = true.obs;

  @override
  void onInit() {
    // if (contractsList.isEmpty) getContracts();
    super.onInit();
  }

// getOnlinePayableForPayment
// this fuction calling for the payment
// if payment done the show message => stage 5.1_5
// if payment not done then stage 5
  RxBool isPendingPayment = false.obs;
  Future<String> getOnlinePayableForPayment(
    int index,
  ) async {
    try {
      bool _isIntenetConnected = await BaseClientClass.isInternetConnected();
      if (!_isIntenetConnected) {
        Get.to(() => NoInternetScreen());
      }
      print(
          'Contract ID From List ::::$index::: ${contractsList[index].contractid}');

      var resp = await TenantRepository.getContractOnlinePayable(
          contractsList[index].contractid);
      print(resp);
      print(AppMetaLabels().noDatafound);
      if (resp is OutstandingPaymentsModel) {
        // ignore: unrelated_type_equality_checks
        if (resp == AppMetaLabels().noDatafound) {
          update();
          return 'No Payment pending';
        } else {
          update();
          return 'Some payments pending';
        }
      }
      update();
      return '';
    } catch (e) {
      update();
      print('EEEE::::::::====> $e');
      return 'Something went wrong';
    }
  }

  void getContracts() async {
    loadingContracts.value = true;
    errorLoadingContracts = '';
    final response = await TenantRepository.getRenewalActions();
    if (response is List<ContractWithDueAction>) {
      contractsList = response;
      // was not here
      makingFalsForToolTip();
    } else
      errorLoadingContracts = response;
    loadingContracts.value = false;
  }

  RxBool isShowCustomToolTip = true.obs;
  makingFalsForToolTip() async {
    await Future.delayed(Duration(seconds: 5));
    isShowCustomToolTip.value = false;
  }

  RxBool updatingStage = false.obs;
  bool errorUpdatingStage = false;
  Future<bool> updateContracStage(int dueActionId, int stageId) async {
    updatingStage.value = true;
    errorUpdatingStage = false;
    final resp =
        await TenantRepository.updateContractStage(dueActionId, stageId);
    updatingStage.value = false;
    if (resp == 200) {
      getContracts();
      return true;
    } else if (resp is String) {
      Get.snackbar(AppMetaLabels().error, resp,
          backgroundColor: AppColors.white54);
      errorUpdatingStage = true;
      return false;
    }
    return false;
  }

  downloadOfferLetter(ContractWithDueAction contract) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    contract.downloading.value = true;
    var result =
        await TenantRepository.downloadOfferLetter(contract.contractid);

    contract.downloading.value = false;
    if (result is Uint8List) {
      if (await getStoragePermission()) {
        String path = await createPdf(result, contract.contractno);
        try {
          Get.back();
          OpenFile.open(path);
        } catch (e) {
          Get.back();
          print(e);
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
        AppMetaLabels().noFileReceived,
        backgroundColor: AppColors.white54,
      );
    }

    return null;
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

  Future<String> createPdf(Uint8List data, String contractNo) async {
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/contract$contractNo.pdf");
    await file.writeAsBytes(data.buffer.asUint8List());
    return "${output.path}/contract$contractNo.pdf";
  }
}
