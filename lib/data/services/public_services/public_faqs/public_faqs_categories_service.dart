import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/public_models/public_faqs/public_faqs_categories_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import "package:http/http.dart" as http;

import '../../../helpers/session_controller.dart';

class PublicFaqsCategoriesSerice {
  static Future<dynamic> getPublicFaqsCatg() async {
    var url = AppConfig().getPublicFaqsCatg;

    var response = await BaseClientClass.post(url ?? "", {},
        token: SessionController().getPublicToken());

    if (response is http.Response) {
      PublicFaqsCategoriesModel getModel =
          publicFaqsCategoriesModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
