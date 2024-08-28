import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_notifications_model/tenant_notifications_detail_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class TenantNotificationsDetailServices {
  static Future<dynamic> getData(String notificationId) async {
    var url = AppConfig().tenantNotificationsDetails;
      Map data ={"NotificationId":  SessionController().getNotificationId().toString()};

    // NotificationId

    var response = await BaseClientClass.post(url ?? "", data);

    if (response is http.Response) {
      TenantNotificationsDetailModel readNotificationsModel =
          tenantNotificationsDetailModelFromJson(response.body);
      return readNotificationsModel;
    }
    return response;
  }
}
