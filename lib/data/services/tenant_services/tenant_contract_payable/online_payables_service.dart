import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/tenant_models/contract_payable/outstanding_payments_model.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';

class OnlinePayablesService {
  Future<dynamic> getContractPayable(int contractId) async {
    var url = AppConfig().onlinePayables;
    var data = {
      "ContractId": contractId != 0 || contractId != null
          ? contractId.toString()
          : SessionController().getContractID().toString()
    };
    // var data = {"ContractId": SessionController().getContractID().toString()};
    print('ContractId :::::: getContractPayable from getOnlinePayable $data');
    var resp = await BaseClientClass.post(url, data);

    if (resp is http.Response) {
      try {
        return outstandingPaymentsModelFromJson(resp.body);
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return resp;
  }
}
class OnlinePayablesServiceNew {
  Future<dynamic> getContractPayableNew(int contractId) async {
    var url = AppConfig().onlinePayablesNew;
    var data = {
      "ContractId": contractId != 0 || contractId != null
          ? contractId.toString()
          : SessionController().getContractID().toString()
    };
    // var data = {"ContractId": SessionController().getContractID().toString()};
    print('ContractId :::::: getContractPayable from getOnlinePayable $data');
    var resp = await BaseClientClass.post(url, data);

    if (resp is http.Response) {
      try {
        return outstandingPaymentsModelFromJson(resp.body);
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return resp;
  }
}
