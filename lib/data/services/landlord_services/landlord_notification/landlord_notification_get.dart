import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_notification/landlord_notification_get_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class GetLandLordtNotificationsServices {
  static Future<dynamic> getNotifications(String status) async {
    var url = AppConfig().getLandlordNotifications;
    Map data;
    if (status == "") {
      data = {"pageNo": 1.toString(), "pageSize": 500.toString()};
    } else {
      data = {
        "status": status,
        "pageNo": 1.toString(),
        "pageSize": 500.toString()
      };
    }

    var completeUrl = url;
    print(completeUrl);
    var response = await BaseClientClass.post(completeUrl??"", data);
    if (response is http.Response) {
      GetLandLordNotificationsModel data =
          getLandLordNotificationsModelFromJson(response.body);
      return data;
    }
    return response;
  }

  static Future<dynamic> getNotificationsPagination(
      String status, String pageNoP) async {
    var url = AppConfig().getLandlordNotifications;
    Map data;
    if (status == "") {
      data = {"pageNo": pageNoP, "pageSize": '20'};
    } else {
      data = {"status": status, "pageNo": pageNoP, "pageSize": '20'};
    }
    var completeUrl = url;
    var response = await BaseClientClass.post(completeUrl??"", data);
    if (response is http.Response) {
      GetLandLordNotificationsModel data =
          getLandLordNotificationsModelFromJson(response.body);
      return data;
    }
    return response;
  }
}
