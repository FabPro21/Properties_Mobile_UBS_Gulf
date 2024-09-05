import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/get_tenant_service_requests_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class GetTenantServiceRequestsServices {
  static Future<dynamic> getData(String type,String fromDate,String toDate,String search) async {
    var url = AppConfig().getTenantServiceRequests;

    var data = {
      "type": type,
      "fromDate": fromDate,
      "toDate": toDate,
      "search": search
    };
    print('Data ::::: $data');
    print('URl :::::: $url');

    var response = await BaseClientClass.post(url ?? "", data);

    if (response is http.Response) {
      GetTenantServiceRequestsModel getContractsModel =
          getTenantServiceRequestsModelFromJson(response.body);
      return getContractsModel;
    }
    return response;
  }

  // static Future<dynamic> getData(String type) async {
  //   var url = AppConfig().getTenantServiceRequests;

  //   var data = {"Type": type};

  //   var response = await BaseClientClass.post(url ?? "", data);

  //   if (response is http.Response) {
  //     GetTenantServiceRequestsModel getContractsModel =
  //         getTenantServiceRequestsModelFromJson(response.body);
  //     return getContractsModel;
  //   }
  //   return response;
  // }
}
