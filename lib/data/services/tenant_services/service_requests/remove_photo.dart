import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class RemoveSvcReqPhoto {
  static Future<dynamic> removePhoto(var photoId) async {
    var resp = await BaseClientClass.post(
        AppConfig().removeSvcReqPhoto??"", {"PhotoId":photoId.toString()});
    if (resp is http.Response) {
      return resp.statusCode;
    }
    return resp;
  }
}
