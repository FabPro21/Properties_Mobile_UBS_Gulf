import 'package:fap_properties/data/models/tenant_models/contract_requests/vacating_reasons.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/views/public_views/search_properties_dashboard_tabs/search_properties_dashboard_tabs.dart';
import 'package:get/get.dart';
import '../../../../data/helpers/session_controller.dart';
import '../../../../data/models/auth_models/session_token_model.dart';
import '../../../../data/repository/auth_repository.dart';
import '../../../../utils/constants/meta_labels.dart';
import '../../../../utils/styles/colors.dart';
import '../contracts_with_action/contracts_with_actions_controller.dart';

class TerminateContractController extends GetxController {
  RxBool terminating = false.obs;
  int caseNo;
  RxString vacationDate = ''.obs;
  RxBool earlyTermination = false.obs;
  RxInt addDesc = 0.obs;

  @override
  void onInit() {
    getVacatingReasons();
    super.onInit();
  }

  Future<String> terminateContract(
      int contractId, String desc, String caller, int dueActionid) async {
    terminating.value = true;
    var resp = await TenantRepository.terminateContract(
        contractId,
        reasons.record[selectedReason.value].vacatingId,
        vacationDate.value,
        desc,
        dueActionid);

    if (resp is int) {
      terminating.value = false;
      caseNo = resp;
      return 'ok';
      // var response = await updateContractStage(dueActionid, 11);
      // terminating.value = false;
      // if (response == true) {
      //   if (caller == 'contract') {
      //     final contractController = Get.find<GetContractsDetailsController>();
      //     contractController.getData();
      //   }
      //   final contractsWithActionsController =
      //       Get.put(ContractsWithActionsController());
      //   contractsWithActionsController.getContracts();
      //   caseNo = resp;
      //   return 'ok';
      // } else {
      //   return ' not ok';
      // }
    }
    return resp;
  }

  //////////////terminate contract reasons

  VacatingReasons reasons;
  RxBool gettingReasons = false.obs;
  String errorGettingReasons = '';
  RxInt selectedReason = (-1).obs;

  void getVacatingReasons() async {
    gettingReasons.value = true;
    errorGettingReasons = '';
    var resp = await TenantRepository.getTerminateReasons();
    if (resp is VacatingReasons) {
      reasons = resp;
    } else {
      errorGettingReasons = resp;
    }
    gettingReasons.value = false;
  }

  RxBool gettingPublicToken = false.obs;
  void selectNewUnit() async {
    gettingPublicToken.value = true;
    final resp = await CommonRepository.validatePublicRole();
    gettingPublicToken.value = false;
    if (resp is SessionTokenModel) {
      SessionController().setPublicToken(resp.token);
      // update the search page 4 Nov 22
      // Get.off(() => SearchVacantUnits());
      Get.off(() => SearchPropertiesDashboardTabs());
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
