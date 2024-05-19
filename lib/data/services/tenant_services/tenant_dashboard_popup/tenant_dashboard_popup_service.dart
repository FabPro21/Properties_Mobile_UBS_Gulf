import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_dashboard_popup/tenant_dashboard_notification_popup_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import "package:http/http.dart" as http;

class TenantDashboardPopupService {
  static Future<dynamic> getPopup() async {
    var url = AppConfig().getDashboardPopup;

    var response = await BaseClientClass.post(url, {});

    if (response is http.Response) {
      var model = tenantDashboardNotificationPopupModelFromJson(response.body);
      return model;
    }
    return response;
  }
}
