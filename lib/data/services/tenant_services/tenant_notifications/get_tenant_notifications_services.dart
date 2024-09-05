import 'dart:developer';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_notifications_model/get_tenant_notifications_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class GetTenantNotificationsServices {
  static Future<dynamic> getData(String status) async {
    var url = AppConfig().getTenantNotifications;
    // var params;
    Map data;
    if (status == "") {
      data = {"pageNo": 1.toString(), "pageSize": 20.toString()};
    } else {
      data = {
        "status": status,
        "pageNo": 1.toString(),
        "pageSize": 20.toString()
      };
    }

    var completeUrl = url;
    var response = await BaseClientClass.post(completeUrl??"", data);
    if (response is http.Response) {
      log(response.body);
      GetTenantNotificationsModel data =
          getTenantNotificationsModelFromJson(response.body);
      return data;
    }
    return response;
  }

  static Future<dynamic> getDataPagination(String status, String pageNoP) async {
    var url = AppConfig().getTenantNotifications;
    Map data;
    if (status == "") {
      data = {"pageNo": pageNoP, "pageSize": '20'};
    } else {
      data = {"status": status, "pageNo": pageNoP, "pageSize": '20'};
    }
    var completeUrl = url;
    var response = await BaseClientClass.post(completeUrl??"", data);
    if (response is http.Response) {
      log(response.body);
      GetTenantNotificationsModel data =
          getTenantNotificationsModelFromJson(response.body);
      return data;
    }
    return response;
  }

}
