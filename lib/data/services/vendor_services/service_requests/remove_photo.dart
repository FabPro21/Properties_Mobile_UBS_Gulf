import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class RemoveSvcReqPhoto {
  static Future<dynamic> removePhoto(var photoId) async {
    Map data = {"PhotoId": photoId};
    var resp =
        await BaseClientClass.post(AppConfig().vendorRemoveSvcReqPhoto??"", data);
    if (resp is http.Response) {
      return resp.statusCode;
    }
    return resp;
  }
}
