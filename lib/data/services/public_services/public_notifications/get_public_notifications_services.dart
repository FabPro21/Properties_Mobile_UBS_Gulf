import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/public_models/public_notifications/public_get_notifications_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../../helpers/session_controller.dart';

class PublicGetNotificationsServices {
  static Future<dynamic> getNotification(String status) async {
    var url = AppConfig().getPublicNotification;

    var dataa;
    if (status == "") {
      dataa = {"status": "All", "pageNo": "1", "pageSize": "500"};
    } else {
      dataa = {"status": status, "pageNo": "1", "pageSize": "500"};
    }

    var response = await BaseClientClass.post(url, dataa,
        token: SessionController().getPublicToken());
    if (response is http.Response) {
      var data = publicGetNotificationModelFromJson(response.body);
      return data;
    }
    return response;
  }

  static Future<dynamic> getNotificationPagination(String status, pageNo) async {
    var url = AppConfig().getPublicNotification;

    var dataa;
    if (status == "") {
      dataa = {"status": "All", "pageNo": pageNo.toString(), "pageSize": "20"};
    } else {
      dataa = {"status": status, "pageNo": pageNo.toString(), "pageSize": "20"};
    }

    var response = await BaseClientClass.post(url, dataa,
        token: SessionController().getPublicToken());
    if (response is http.Response) {
      var data = publicGetNotificationModelFromJson(response.body);
      return data;
    }
    return response;
  }
}
