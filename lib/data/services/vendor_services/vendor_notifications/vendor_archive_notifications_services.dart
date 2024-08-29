import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_notificaton/vendor_notification_archived_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class VendorArchiveNotificationsServices {
  static Future<dynamic> getData() async {
    var url = AppConfig().vendorArchiveNotification;
    var data = {
      "notificationId": SessionController().getNotificationId(),
    };

    var response = await BaseClientClass.post(url ?? "", data);

    if (response is http.Response) {
      var data = vendorNotificationArchivedModelFromJson(response.body);
      return data;
    }
    return response;
  }
}
