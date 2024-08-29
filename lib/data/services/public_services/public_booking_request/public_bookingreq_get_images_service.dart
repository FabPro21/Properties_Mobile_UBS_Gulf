import 'dart:convert';
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

import '../../../helpers/session_controller.dart';

class PublicBookingRequestGetImagesServices {
  static Future<dynamic> getPropertyImages(int propertyId) async {
    var url = AppConfig().getBookingReqPropertyImage;
    print(url);
    print(propertyId);
    var data = {"PropertyId": propertyId.toString()};
    var response = await BaseClientClass.post(url ?? "", data,
        token: SessionController().getPublicToken());
    if (response is http.Response) {
      // log(response.body);
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

  static Future<dynamic> getImages(int unitId) async {
    var url = AppConfig().getBookingReqImages;
    var data = {"UnitId": unitId.toString()};
    var response = await BaseClientClass.post(url ??"", data,
        token: SessionController().getPublicToken());
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
