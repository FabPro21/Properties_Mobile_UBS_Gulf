import 'dart:convert';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_status_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

class GetContractsStatusServiceVendor {
  static Future<dynamic> getData() async {
    print(':::::::::::::+++++>>>>+++++++::::::::::::::::::::');
    var url = AppConfig().getVendorContractsStatus;
    Map data;
    var response = await BaseClientClass.post(url, data);
    if (response is http.Response) {
      try {
        GetContractStatusModelVendor contractStatusModel =
            GetContractStatusModelVendor.fromJson(json.decode(response.body));
        return contractStatusModel;
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
}
