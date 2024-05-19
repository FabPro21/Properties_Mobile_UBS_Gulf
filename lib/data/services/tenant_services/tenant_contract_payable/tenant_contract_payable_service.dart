import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/tenant_models/contract_payable/tenant_contract_payable_model.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';

class TenantContractPayableService {
  Future<dynamic> getContractPayables(int contractId) async {
    var url = AppConfig().getContractPayable;
    var data = {"ContractId": SessionController().getContractID().toString()};
    print(
        'ContractId :::::: getContractPayable from GetContractsDetailsController $data');
    var resp = await BaseClientClass.post(url, data);

    if (resp is http.Response) {
      // log(resp.body);
      try {
        var model = tenantContractPayableModelFromJson(resp.body);
        return model;
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return resp;
  }
}
