import 'dart:convert';
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

class GetPropertyImageServiceVendor {
 
  static Future<dynamic> getData(int propId) async {
     print('====> Inside GetPropertyImageServiceVendor :::');
    final String url = AppConfig().getPropertyImageVendor;
        print('====> Inside GetPropertyImageServiceVendor ::: $url');
    Map data = {"PropertyId": propId.toString()};
    var response = await BaseClientClass.post(url, data);
    if (response is http.Response) {
      try {
        var resp = json.decode(response.body);
        String byteString = resp["bytes"];
        return base64Decode(byteString.replaceAll('\n', ''));
      } catch (_) {
        return AppMetaLabels().anyError;
      }
    }
    return response;
  }
}
