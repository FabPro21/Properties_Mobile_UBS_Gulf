import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_notifications_model/tenant_archive_notifications_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class TenantArchiveNotificationsServices {
  static Future<dynamic> getData() async {
    var url = AppConfig().tenantArchiveNotifications;
    var data = {
      "notificationId": SessionController().getNotificationId().toString(),
    };

    var response = await BaseClientClass.post(url ?? "", data);

    if (response is http.Response) {
      TenantArchiveNotificationsModel readNotificationsModel =
          tenantArchiveNotificationsModelFromJson(response.body);
      return readNotificationsModel;
    }
    return response;
  }
}
