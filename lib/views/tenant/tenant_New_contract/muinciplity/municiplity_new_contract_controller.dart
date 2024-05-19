import 'package:fap_properties/data/models/tenant_models/municipal_instructions.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_tabs.dart/tenant_contracts_details.dart/tenant_contracts_detail_controller.dart';
import 'package:fap_properties/views/tenant/tenant_New_contract/contracts_new_action/contracts_new_actions_controller.dart';
import 'package:get/get.dart';

class MunicipalApprovalNewContractController extends GetxController {
  MunicipalInstructions municipalInstructions = MunicipalInstructions();
  RxBool loadingInstructions = true.obs;
  String errorLoadingData = '';
  RxBool approved = false.obs;
  RxBool loading = false.obs;
  RxBool isShowpopUp = false.obs;

  RxBool isHideSubmitButton = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void getInstructions(int contractId) async {
    errorLoadingData = '';
    loadingInstructions.value = true;
    final response = await TenantRepository.getMinicipalApproval(contractId);
    // final response = await TenantRepository.getMinicipalApprovalNew(contractId);
    loadingInstructions.value = false;
    if (response is MunicipalInstructions) {
      municipalInstructions = response;
    } else
      errorLoadingData = response;
  }

  RxBool updatingStage = false.obs;
  updateContractStage(int dueActionId, int stageId, String caller) async {
    updatingStage.value = true;
    final resp =
        await TenantRepository.updateContractStage(dueActionId, stageId);
    updatingStage.value = false;
    if (resp == 200) {
      if (caller == 'contract') {
        final contractController = Get.find<GetContractsDetailsController>();
        contractController.getData();
      }
      final contractsWithActionsController =
          Get.put(ContractEndActionsController());
      contractsWithActionsController.getContractsNew();
      if (resp == 200) {
        isHideSubmitButton.value = true;
      }
      isShowpopUp.value = true;
    } else if (resp is String) {
      Get.snackbar(AppMetaLabels().error, resp,
          backgroundColor: AppColors.white54);
    }
  }
}
