import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_notification/landlord_read_notification-model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class LandLordReadNotificationsServices {
  static Future<dynamic> readNotification() async {
    var url = AppConfig().landLordReadNotifications;
    var data = {
      "notificationId": SessionController().getNotificationId().toString(),
    };
    print(url);
    var response = await BaseClientClass.post(url, data);
    if (response is http.Response) {
      LandLordReadNotificationsModel readNotificationsModel =
          landlordReadNotificationsModelFromJson(response.body);
      return readNotificationsModel;
    }
    return response;
  }
}
