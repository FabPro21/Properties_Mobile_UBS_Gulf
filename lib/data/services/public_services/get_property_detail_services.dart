import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/public_models/get_property_detail_model.dart';

class GetPropertyDetailServices {
  static Future<dynamic> getData() async {
    var url = AppConfig().getPropertyDetail ;

    var data= {"UnitID":SessionController().getPropId()};

    var response = await BaseClientClass.post(url ?? "", data,
        token: SessionController().getPublicToken());

    if (response is http.Response) {
      GetPropertyDetailModel getModel =
          getPropertyDetailModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
