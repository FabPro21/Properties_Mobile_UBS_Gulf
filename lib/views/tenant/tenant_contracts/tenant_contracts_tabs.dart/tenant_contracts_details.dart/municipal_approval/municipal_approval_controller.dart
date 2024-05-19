import 'package:fap_properties/data/models/tenant_models/municipal_instructions.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/meta_labels.dart';
import '../../../../../../utils/styles/colors.dart';
import '../../../contracts_with_action/contracts_with_actions_controller.dart';
import '../tenant_contracts_detail_controller.dart';

class MunicipalApprovalController extends GetxController {
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
    print('(((((((((((((((((Inside)))))))))))))))))');
    errorLoadingData = '';
    loadingInstructions.value = true;
    final response = await TenantRepository.getMinicipalApproval(contractId);
    loadingInstructions.value = false;
    if (response is MunicipalInstructions) {
      municipalInstructions = response;
      print('((((((((((((((((($municipalInstructions)))))))))))))))))');
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
          Get.put(ContractsWithActionsController());
      contractsWithActionsController.getContracts();
      if(resp == 200){
        isHideSubmitButton.value = true;
      }
      isShowpopUp.value = true;
      
      // Get.back();
      // Get.snackbar(AppMetaLabels().success, AppMetaLabels().stageUpdated,
      //     backgroundColor: AppColors.white54);
    } else if (resp is String) {
      Get.snackbar(AppMetaLabels().error, resp,
          backgroundColor: AppColors.white54);
    }
  }
}
