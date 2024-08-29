import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/public_models/public_notifications/public_count_notification_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../../helpers/session_controller.dart';

class PublicCountNotificationsServices {
  static Future<dynamic> getNotificationsCount() async {
    var url = AppConfig().publicCountNotifications;

    var response = await BaseClientClass.post(url ?? "", {},
        token: SessionController().getPublicToken());
    if (response is http.Response) {
      var data = publicCountNotificationModelFromJson(response.body);
      return data;
    }
    return response;
  }
}
