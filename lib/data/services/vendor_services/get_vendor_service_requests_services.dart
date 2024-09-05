import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../models/vendor_models/get_vendor_service_requests_model.dart';

class GetVendorServiceRequestsServices {
  static Future<dynamic> getData() async {
    print(SessionController().getUserId());
    var url = AppConfig().getVendorServiceRequest;
    // SessionController().vendorUserType
    // above 'SessionController().vendorUserType' show us this user is Technician or incharg or any other
    // "type" in type we are sending Vendor user Type
    var data = {"type": null, "search": '', "pageNo": '1', "pageSize": '20'};
    print('Data :::::: $data');

    var response = await BaseClientClass.post(url ?? "", data);

    if (response is http.Response) {
      GetVendorServiceRequests getContractsModel =
          getVendorServiceRequestDetailsModelFromJson(response.body);
      return getContractsModel;
    }
    return response;
  }

  static Future<dynamic> getDataPagination(String pageNoP, searchtext) async {
    print(SessionController().getUserId());
    var url = AppConfig().getVendorServiceRequest;

    // var data;
    var data = {
      "type": null, //SessionController().vendorUserType,
      "search": searchtext,
      "pageNo": pageNoP,
      "pageSize": '20'
    };

    var response = await BaseClientClass.post(url ?? "", data);

    if (response is http.Response) {
      GetVendorServiceRequests getContractsModel =
          getVendorServiceRequestDetailsModelFromJson(response.body);
      return getContractsModel;
    }
    return response;
  }
  // static Future<dynamic> getData() async {
  //   print(SessionController().getUserId());
  //   var url = AppConfig().getVendorServiceRequest;
  //   // var data;

  //   var response = await BaseClientClass.post(url ?? "", data);

  //   if (response is http.Response) {
  //     GetVendorServiceRequests getContractsModel =
  //         getVendorServiceRequestDetailsModelFromJson(response.body);
  //     return getContractsModel;
  //   }
  //   return response;
  // }
}
