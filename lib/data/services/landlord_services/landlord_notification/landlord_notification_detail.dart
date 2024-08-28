import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_notification/landlord_notification_detail_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class LandLordNotificationsDetailServices {
  static Future<dynamic> notificationDetails(String notificationId) async {
    var url = AppConfig().landLordNotificationsDetails;
    print(url);
    Map data = {
      "NotificationId": SessionController().getNotificationId().toString()
    };

    // NotificationId

    var response = await BaseClientClass.post(url ?? "", data);

    if (response is http.Response) {
      LandlordNotificationsDetailModel readNotificationsModel =
          landlordNotificationsDetailModelFromJson(response.body);
      return readNotificationsModel;
    }
    return response;
  }
}
