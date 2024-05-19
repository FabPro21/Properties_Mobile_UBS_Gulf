import 'package:fap_properties/data/models/tenant_models/contract_requests/get_extension_period_model.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_tabs.dart/tenant_contracts_details.dart/tenant_contracts_detail_controller.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/meta_labels.dart';
import '../../../../utils/styles/colors.dart';
import '../contracts_with_action/contracts_with_actions_controller.dart';

class ExtendContractController extends GetxController {
  GetExtensionPeriodModel extensionPeriods;
  RxBool loadingPeriods = false.obs;
  String errorLoadingPeriods = '';
  RxInt selectedPeriod = 0.obs;

  RxBool submitting = false.obs;
  int caseNo;

  @override
  void onInit() {
    super.onInit();
  }

  void getExtensionPeriods(int contractId) async {
    loadingPeriods.value = true;
    errorLoadingPeriods = '';
    var resp = await TenantRepository.getExtensionPeriods(contractId);
    if (resp is GetExtensionPeriodModel) {
      extensionPeriods = resp;
    } else
      errorLoadingPeriods = resp;
    loadingPeriods.value = false;
  }

  Future<String> extendContract(
      int contractId, String caller, int dueActionid) async {
    submitting.value = true;
    var resp = await TenantRepository.extendContract(
        contractId,
        extensionPeriods.extensionPeriod[selectedPeriod.value].duration,
        extensionPeriods
            .extensionPeriod[selectedPeriod.value].extensionDetail.addNewDate,
        extensionPeriods
            .extensionPeriod[selectedPeriod.value].extensionDetail.endNewDate,
        dueActionid);
    submitting.value = false;
    if (resp is int) {
      await updateContractStage(dueActionid, 11);
      if (caller == 'contract') {
        final contractController = Get.find<GetContractsDetailsController>();
        contractController.getData();
      }
      final contractsWithActionsController =
          Get.put(ContractsWithActionsController());
      contractsWithActionsController.getContracts();
      caseNo = resp;
      return 'ok';
    }
    return resp;
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
