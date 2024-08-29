import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/public_models/public_properties_service/public_services_categories_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../../helpers/session_controller.dart';

class PublicServicesCategoriesService {
  static Future<dynamic> getServiceCategories() async {
    var url = AppConfig().getPublicServiceCategories;

    var resp = await BaseClientClass.post(url ?? "", {},
        token: SessionController().getPublicToken());

    if (resp is http.Response) {
      var data = publicGetServiceCategoriesModelFromJson(resp.body);
      return data;
    }

    return resp;
  }
}
