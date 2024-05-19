import 'dart:developer';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_dashboard_getdata_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../../../utils/constants/meta_labels.dart';

class LandlordDashboardGetDataServices {
  static Future<dynamic> getData() async {
    var url = AppConfig().landlordDashboardGetData;

    Map data;

    var response = await BaseClientClass.post(url, data);
    if (response is http.Response) {
      try {
         log(response.body.toString());
        LandlordDashboardGetDataModel data =
            landlordDashboardGetDataModelFromJson(response.body);
       
        return data;
      } catch (e) {
        if (kDebugMode) print(e);
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
}
