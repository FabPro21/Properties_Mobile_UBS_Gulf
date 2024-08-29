import 'dart:developer';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_get_contracts_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class VendorGetContractsServices {
  static Future<dynamic> getDataPagination(String pageNo, searchtext) async {
    var url = AppConfig().getVendorContracts;

    var data = {"pageNo": pageNo, "pageSize": '20', "search": searchtext};

    var response = await BaseClientClass.post(url ?? "", data);
    if (response is http.Response) {
      log(response.body.toString());
      VendorContractsModel vendorContractsModel =
          vendorContractsModelFromJson(response.body);
      return vendorContractsModel;
    }
    return response;
  }

  static Future<dynamic> getData() async {
    var url = AppConfig().getVendorContracts;

    var data;

    var response = await BaseClientClass.post(url ?? "", data);
    if (response is http.Response) {
      VendorContractsModel vendorContractsModel =
          vendorContractsModelFromJson(response.body);
      return vendorContractsModel;
    }
    return response;
  }
}
