import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_notification/landlord_archieve_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class LandlordArchiveNotificationsServices {
  static Future<dynamic> archiveNotification() async {
    var url = AppConfig().landLordArchiveNotifications;
    print(url);
    var data = {
      "notificationId": SessionController().getNotificationId().toString(),
    };
    var response = await BaseClientClass.post(url, data);

    if (response is http.Response) {
      LandlordArchiveNotificationsModel readNotificationsModel =
          landlordArchiveNotificationsModelFromJson(response.body);
      return readNotificationsModel;
    }
    return response;
  }
}
