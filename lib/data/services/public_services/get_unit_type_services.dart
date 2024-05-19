import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/public_models/get_unit_type_model.dart';
import '../../helpers/session_controller.dart';

class GetUnitTypeServices {
  static Future<dynamic> getData(String category) async {
    var url = AppConfig().getUnitTypeByCategoryId;

    var data=  {"Category":category};

    var response = await BaseClientClass.post(url, data,
        token: SessionController().getPublicToken());

    if (response is http.Response) {
      GetUnitTypeModel getModel = getUnitTypeModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
