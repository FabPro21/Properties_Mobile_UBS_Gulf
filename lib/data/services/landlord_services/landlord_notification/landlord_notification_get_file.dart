import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_notifications_model/notification_files.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class GetLandLordNotificationsFiles {
  static Future<dynamic> getNotificationFiles(int id) async {
    var url = AppConfig().landLordgetNotificationFilese;
    Map data = {"NotificationId": id.toString()};
    var response = await BaseClientClass.post(url, data);
    if (response is http.Response) {
      return notificationFilesFromJson(response.body);
    }
    return response;
  }
}
