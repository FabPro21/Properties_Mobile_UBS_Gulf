import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_notificaton/vendor_notification_details_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class VendorNotificationsDetailServices {
  static Future<dynamic> getNotificationDetails(String notificationId) async {
    var url = AppConfig().vendorNotificationDetails;
    Map data = {"NotificationId": SessionController().getNotificationId()};

    // NotificationId

    var response = await BaseClientClass.post(url, data);
    print('::::::::::$response:::::::::::::');
    if (response is http.Response) {
      
      var data = vendorNotificationDetailsModelFromJson(response.body);
      print('::::::===>$data');
      return data;
    }
    return response;
  }
}
