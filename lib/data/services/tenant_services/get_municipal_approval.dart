import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/municipal_instructions.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class GetMunicipalApproval {
  static Future<dynamic> getData(int contractId) async {
    Map data = {"ContractId": contractId.toString()};
    var response =
        await BaseClientClass.post(AppConfig().getApproveMunicipal??"", data);
    if (response is http.Response) {
      final data = municipalInstructionsFromJson(response.body);
      if (data.statusCode == '200')
        return data;
      else
        return data.message;
    }
    return response;
  }
}
class GetMunicipalApprovalNew {
  static Future<dynamic> getDataNew(int contractId) async {
    Map data = {"ContractId": contractId.toString()};
    var response =
        await BaseClientClass.post(AppConfig().getApproveMunicipalNew??"", data);
    if (response is http.Response) {
      final data = municipalInstructionsFromJson(response.body);
      if (data.statusCode == '200')
        return data;
      else
        return data.message;
    }
    return response;
  }
}
