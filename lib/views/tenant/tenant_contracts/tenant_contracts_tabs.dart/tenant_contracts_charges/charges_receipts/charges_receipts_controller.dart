import 'package:fap_properties/data/models/tenant_models/contract_charge_receipts_model.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:get/get.dart';

class ChargesReceiptsController extends GetxController {
  List<Receipt> receipts = [];
  RxBool loading = false.obs;
  String error = '';

  void getContractChargesReceipts(int chargesTypeId) async {
    error = '';
    loading.value = true;
    var resp = await TenantRepository.getContractChargeReceipts(chargesTypeId);
    loading.value = false;
    if (resp is ContractChargeReceiptsModel) {
      receipts = resp.receipts!;
    } else
      error = resp;
  }
}
