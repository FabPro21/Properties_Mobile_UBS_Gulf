import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/public_models/public_notifications/public_notification_details_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class PublicNotificationsDetailServices {
  static Future<dynamic> getNotificationDetails(String notificationId) async {
    var url = AppConfig().publicNotificationDetails ;
  
    var data = {
      "NotificationId": SessionController().getNotificationId()
    };

    var response = await BaseClientClass.post(url,data,
        token: SessionController().getPublicToken());

    if (response is http.Response) {
      var data = publicNotificationDetailsModelFromJson(response.body);
      return data;
    }
    return response;
  }
}
