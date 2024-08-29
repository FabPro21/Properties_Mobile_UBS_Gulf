import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/vendor_models/get_lpo_properties_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class GetLpoPropertiesServices {
  static Future<dynamic> getData() async {
    var url = AppConfig().getlpoproperties;

    var lpoId = SessionController().getLpoId().toString();

    Map data = {
      "LpoId": lpoId,
      "pageNo": 1.toString(),
      "pageSize": 100.toString()
    };

    var response = await BaseClientClass.post(url ?? "", data);
    if (response is http.Response) {
      GetLpoPropertiesModel lpoPropertiesModel =
          getLpoPropertiesModelFromJson(response.body);
      return lpoPropertiesModel;
    }
    return response;
  }
}
