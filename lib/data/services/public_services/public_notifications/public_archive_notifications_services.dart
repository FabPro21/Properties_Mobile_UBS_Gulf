import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/public_models/public_notifications/public_archived_notifications_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class PublicArchiveNotificationsServices {
  static Future<dynamic> getArchivedNotifications() async {
    var url = AppConfig().publicArchivedNotifications;
    var data = {
      "notificationId": SessionController().getNotificationId(),
    };
    var response = await BaseClientClass.post(url ?? "", data,
        token: SessionController().getPublicToken());

    if (response is http.Response) {
      var data = publicArchivedNotificationModelFromJson(response.body);
      return data;
    }
    return response;
  }
}
