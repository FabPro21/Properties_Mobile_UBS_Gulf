import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/contract_payable/tenant_contract_payable_model.dart';
import 'package:fap_properties/data/models/tenant_models/contract_requests/can_checkin.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_contracts_details_model.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/contracts_with_action/contracts_with_actions_controller.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_tabs.dart/tenant_contracts_details.dart/tenant_contract_download/tenant_contract_download_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../data/helpers/session_controller.dart';
import '../../../../../data/models/tenant_models/can_download_contract.dart';
import '../../../../../utils/styles/colors.dart';
import 'package:flutter/foundation.dart';

class GetContractsDetailsController extends GetxController {
  var getContractsDetails = GetContractDetailsModel().obs;
  var loadingContract = true.obs;
  RxString errorLoadingContract = "".obs;
  RxString onSearch = "".obs;
  RxBool downloading = false.obs;
  RxBool isEnableScreen = true.obs;
  RxString amount = "".obs;
  int daysPassed = 0;
  double comPtg = 0.0;
  bool showExtend = true;

  var contractPayables = TenantContractPayableModel();
  var loadingContractPayables = true.obs;
  RxString errorLoadingContractPayables = "".obs;
  RxString sumOfAllPayments = '0.00'.obs;
  RxString totalRentalPayment = '0.00'.obs;
  RxString totalAdditionalCharges = '0.00'.obs;
  RxString totalVatOnRent = '0.00'.obs;
  RxString totalVatOnCharges = '0.00'.obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    // try {
    errorLoadingContract.value = '';
    loadingContract.value = true;
    var result = await TenantRepository.getContractsDetails();
    if (result is GetContractDetailsModel) {
      if (getContractsDetails.value.status == AppMetaLabels().notFound) {
        errorLoadingContract.value = AppMetaLabels().noDatafound;
        loadingContract.value = false;
      } else {
        getContractsDetails.value = result;
        double am = getContractsDetails.value.contract.rentforstay ?? 0;
        final paidFormatter = NumberFormat('#,##0.00', 'AR');
        amount.value = paidFormatter.format(am);
        DateTime startDate =
            DateFormat('dd-MM-yyyy').parse(result.contract.contractStartDate);
        DateTime endDate =
            DateFormat('dd-MM-yyyy').parse(result.contract.contractEndDate);
        DateTime now = DateTime.now();
        if (now.compareTo(startDate) <= 0) {
          daysPassed = 0;
          comPtg = 0;
        } else if (now.compareTo(endDate) >= 0) {
          daysPassed = result.contract.noOfDays;
          comPtg = 1;
        } else {
          daysPassed = now.difference(startDate).inDays + 1;
          comPtg = daysPassed / result.contract.noOfDays;
        }
        if (now.difference(endDate).inDays >= 15) showExtend = false;
        loadingContract.value = false;
        getContractPayables();
        print('Stage ID when this :::::::::: ${result.caseStageInfo.stageId}');
        //canCheckin(result.contract.contractId);
        // for testing FEEDBACK Start
        // canDownloadSignedContract(result.contract.contractId);
        // for testing FEEDBACK End
        // ************************
        // for real FEEDBACK Start
        if (result.caseStageInfo.stageId != null &&
            result.caseStageInfo.stageId > 7)
          canDownloadSignedContract(result.contract.contractId);
        // for testing FEEDBACK End
      }
    } else {
      errorLoadingContract.value = AppMetaLabels().noDatafound;
      loadingContract.value = false;
    }
  }

  void getContractPayables() async {
    bool _isIntenetConnected = await BaseClientClass.isInternetConnected();
    if (!_isIntenetConnected) {
      Get.to(() => NoInternetScreen());
    }
    loadingContractPayables.value = true;
    contractPayables = TenantContractPayableModel();
    sumOfAllPayments.value = '0.00';
    totalRentalPayment.value = '0.00';
    totalAdditionalCharges.value = '0.00';
    totalVatOnRent.value = '0.00';
    totalVatOnCharges.value = '0.00';
    try {
      var resp = await TenantRepository.getContractPayable(
          SessionController().getContractID());

      if (resp is TenantContractPayableModel) {
        if (kDebugMode) print('Response Status ::::: ${resp.status}');
        if (resp.status == AppMetaLabels().notFound) {
          errorLoadingContractPayables.value = AppMetaLabels().noDatafound;
        } else {
          contractPayables = resp;
          removeZeroBalance();
          sumPayments();
          if (kDebugMode) print('Sum Val ::::: ${sumOfAllPayments.value}');
          if (sumOfAllPayments.value == '0.00')
            errorLoadingContractPayables.value = AppMetaLabels().noDatafound;
        }
      } else {
        errorLoadingContractPayables.value = resp;
      }
    } catch (e) {
      print("This is the error from controller : $e");
    } finally {
      loadingContractPayables.value = false;
    }
  }

  void removeZeroBalance() {
    contractPayables.contractPayable.forEach((element) {
      if (element.balance == 0)
        contractPayables.contractPayable.remove(element);
    });
    contractPayables.additionalCharges.forEach((element) {
      if (element.balance == 0)
        contractPayables.contractPayable.remove(element);
    });
    contractPayables.vatCharges.forEach((element) {
      if (element.balance == 0)
        contractPayables.contractPayable.remove(element);
    });
    contractPayables.vatOnRent.forEach((element) {
      if (element.balance == 0)
        contractPayables.contractPayable.remove(element);
    });
  }

  void sumPayments() {
    double rentalSum = 0;
    double additionalSum = 0;
    double vatRentSum = 0;
    double vatChargesSum = 0;
    contractPayables.contractPayable.forEach((element) {
      rentalSum = rentalSum + element.balance;
    });
    contractPayables.additionalCharges.forEach((element) {
      additionalSum = additionalSum + element.balance;
    });
    contractPayables.vatCharges.forEach((element) {
      vatChargesSum = vatChargesSum + element.balance;
    });
    contractPayables.vatOnRent.forEach((element) {
      vatRentSum = vatRentSum + element.balance;
    });
    final amountFormat = NumberFormat('#,##0.00', 'AR');
    this.totalRentalPayment.value = amountFormat.format(rentalSum);
    this.totalAdditionalCharges.value = amountFormat.format(additionalSum);
    this.totalVatOnRent.value = amountFormat.format(vatRentSum);
    this.totalVatOnCharges.value = amountFormat.format(vatChargesSum);
    this.sumOfAllPayments.value = amountFormat
        .format(rentalSum + additionalSum + vatRentSum + vatChargesSum);
  }

  RxBool loadingCanCheckin = false.obs;
  String errorLoadingCanCheckin = '';
  CanCheckinModel canCheckinModel;
  void canCheckin(int contractId) async {
    loadingCanCheckin.value = true;
    final resp = await TenantRepository.canCheckingContract(contractId);
    if (resp is CanCheckinModel) {
      canCheckinModel = resp;
    } else
      errorLoadingCanCheckin = resp;
    loadingCanCheckin.value = false;
  }

  RxBool loadingCanDownload = true.obs;
  RxBool canDownload = false.obs;
  String errorLoadingCanDownload = '';
  CanDownloadContract canDownloadContract = CanDownloadContract();
  void canDownloadSignedContract(int contractId) async {
    loadingCanDownload.value = true;
    final resp = await TenantRepository.canDownloadContract(contractId);
    print(resp);
    if (resp is CanDownloadContract) {
      canDownloadContract = resp;

      // for testing FEEDBACK Start
      // canDownload.value = true;
      // canDownloadContract.canDownload = '1';
      // getContractsDetails.value.caseStageInfo.stageId = 9;
      // for testing FEEDBACK END
      // commentting this because when contract stage is 9 means in download stage
      // then will show to the user that
      // "Your Contract iszz"
      // if (canDownloadContract.canDownload == '1') {
      //   canDownload.value = true;
      // }
      
      // for real FEEDBACK START
      canDownload.value = true;
      // for real FEEDBACK END
    } else {
      errorLoadingCanDownload = resp;
    }
    loadingCanDownload.value = false;
  }

  RxBool downloadingContract = false.obs;
  void downloadContract() async {
    if (canDownloadContract.canDownload == '1') {
      final contractDownloadController = Get.put(ContractDownloadController());
      downloadingContract.value = true;
      if (await contractDownloadController.downloadSignedContract(
        getContractsDetails.value.contract.contractno,
        getContractsDetails.value.contract.contractId,
      )) {
        if (getContractsDetails.value.caseStageInfo.stageId == 9)
          updateContractStage(
              getContractsDetails.value.caseStageInfo.dueActionid, 11);
      }
      downloadingContract.value = false;
    } else {
      Get.snackbar(AppMetaLabels().error, canDownloadContract.message ?? '',
          backgroundColor: AppColors.white54);
    }
  }

  RxBool updatingStage = false.obs;
  bool errorUpdatingStage = false;
  Future<bool> updateContractStage(int dueActionId, int stageId) async {
    updatingStage.value = true;
    errorUpdatingStage = false;
    final resp =
        await TenantRepository.updateContractStage(dueActionId, stageId);
    updatingStage.value = false;
    if (resp == 200) {
      final dueActionsController = Get.put(ContractsWithActionsController());
      dueActionsController.getContracts();
      return true;
    } else if (resp is String) {
      Get.snackbar(AppMetaLabels().error, resp,
          backgroundColor: AppColors.white54);
      errorUpdatingStage = true;
      return false;
    }
    return false;
  }
}
