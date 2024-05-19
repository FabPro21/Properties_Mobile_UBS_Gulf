import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_notificaton/vendor_get_notification_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class VendorGetNotificationsServices {
  static Future<dynamic> getData(String status) async {
    var url = AppConfig().getVendorNotification;
    Map data;
    if (status == "") {
      // params = "?pageNo=1&pageSize=500";
      data = {"pageNo": 1.toString(), "pageSize": 500.toString()};
    } else {
      // params = "?status=" + status + "&pageNo=1&pageSize=500";
      data = {
        "status": status,
        "pageNo": 1.toString(),
        "pageSize": 500.toString()
      };
    }
    var response = await BaseClientClass.post(url, data);
    if (response is http.Response) {
      var data = vendorGetNotificationModelFromJson(response.body);
      return data;
    }
    return response;
  }
  static Future<dynamic> getDataPagination(String status,pagaNoP) async {
    var url = AppConfig().getVendorNotification;
    Map data;
    if (status == "") {
      data = {"pageNo": pagaNoP.toString(), "pageSize": 20.toString()};
    } else {
      data = {
        "status": status,
        "pageNo": pagaNoP.toString(),
        "pageSize": 20.toString()
      };
    }
    var response = await BaseClientClass.post(url, data);
    if (response is http.Response) {
      var data = vendorGetNotificationModelFromJson(response.body);
      return data;
    }
    return response;
  }
}
