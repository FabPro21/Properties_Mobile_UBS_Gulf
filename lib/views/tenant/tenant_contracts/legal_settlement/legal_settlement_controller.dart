import 'package:get/get.dart';

import '../../../../data/repository/tenant_repository.dart';
import '../tenant_contracts_tabs.dart/tenant_contracts_details.dart/tenant_contracts_detail_controller.dart';

class LegalSettlementController extends GetxController {
  RxBool submitting = false.obs;
  int? caseNo;

  final contractController = Get.find<GetContractsDetailsController>();

  Future<String> submitRequest(int contractId, String desc) async {
    submitting.value = true;
    var resp =
        await TenantRepository.submitLegalSettlementReq(contractId, desc);
    submitting.value = false;
    if (resp is int) {
      contractController.getData();
      caseNo = resp;
      return 'ok';
    }
    return resp;
  }
}
