import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/vendor_models/get_lpo_terms_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class VendorGetLpoTermsSvc {
  static Future<dynamic> getData() async {
    var completeUrl = AppConfig().getlpoterm;
    Map data = {
      "LpoId": SessionController().getLpoId(),
    };

    var response = await BaseClientClass.post(completeUrl, data);
    if (response is http.Response) {
      GetLpoTermsModel getLpoTermsModel =
          getLpoTermsModelFromJson(response.body);
      return getLpoTermsModel;
    } else
      return response;
  }
}
