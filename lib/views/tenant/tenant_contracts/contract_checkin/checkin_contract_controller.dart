import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/contracts_with_action/contracts_with_actions_controller.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_tabs.dart/tenant_contracts_details.dart/tenant_contracts_detail_controller.dart';
import 'package:get/get.dart';

class CheckinContractController extends GetxController {
  RxBool checkingIn = false.obs;
  int? caseNo;

  @override
  void onInit() {
    super.onInit();
  }

  Future<String> checkinContract(int contractId, String caller) async {
    checkingIn.value = true;
    var resp = await TenantRepository.checkinContract(contractId);
    checkingIn.value = false;
    if (resp is int) {
      if (caller == 'contract') {
        final contractController = Get.find<GetContractsDetailsController>();
        contractController.canCheckin(contractId);
      }
      final contractsWithActionsController =
          Get.put(ContractsWithActionsController());
      contractsWithActionsController.getContracts();
      caseNo = resp;
      return 'ok';
    }
    return resp;
  }
}
