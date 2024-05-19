import 'package:fap_properties/data/models/tenant_models/contract_requests/contract_renewal_info.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/contracts_with_action/contracts_with_actions_controller.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_tabs.dart/tenant_contracts_details.dart/tenant_contracts_detail_controller.dart';
import 'package:get/get.dart';

class RenewContractController extends GetxController {
  ContractRenewalInfo renewalInfo;
  RxBool loadingRenewalInfo = false.obs;
  String errorLoadingInfo = '';

  RxBool submitting = false.obs;
  int caseNo;

  @override
  void onInit() {
    super.onInit();
  }

  void getContractRenewalInfo(int contractId) async {
    loadingRenewalInfo.value = true;
    errorLoadingInfo = '';
    var resp = await TenantRepository.getContractRenewalInfo(contractId);
    if (resp is ContractRenewalInfo) {
      renewalInfo = resp;
    } else
      errorLoadingInfo = resp;
    loadingRenewalInfo.value = false;
  }

  Future<String> renewContract(
      int contractId, String caller, int dueActionid) async {
    submitting.value = true;
    var resp = await TenantRepository.renewContract(
        contractId,
        renewalInfo.record.addNewDate,
        renewalInfo.record.endNewDate,
        dueActionid);
    submitting.value = false;
    if (resp is int) {
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
}
