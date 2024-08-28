import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/public_models/get_property_category_model.dart';
import '../../helpers/session_controller.dart';

class GetPropertyCategoryServices {
  static Future<dynamic> getData() async {
    var url = AppConfig().getPropertyCategory;

    var data;

    var response = await BaseClientClass.post(url ?? "", data,
        token: SessionController().getPublicToken());

    if (response is http.Response) {
      GetPropertyCategoryModel getModel =
          getPropertyCategoryModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
