import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/auth_models/update_device_info_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class UpdateDeviceInfoService {
  static Future<dynamic> getData(
      String deviceName, String deviceTokken, String deviceType) async {
    var data = {
      "deviceName": deviceName,
      "deviceToken": deviceTokken,
      "type": deviceType,
      "userId": SessionController().getUserId(),
    };
    final String url = AppConfig().updateDeviceInfo;
    var response = await BaseClientClass.postwithheader(url, data,
        token: SessionController().getLoginToken());

    if (response is http.Response) {
      UpdateDeviceInfoModel updateDeviceInfoModel =
          updateDeviceInfoModelFromJson(response.body);
      return updateDeviceInfoModel;
    }
    return response;
  }
}
