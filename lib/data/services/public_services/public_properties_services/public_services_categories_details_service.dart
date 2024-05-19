import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/public_models/public_properties_service/public_Services_categories_details_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../../helpers/session_controller.dart';

class PublicServicesCategoriesDetailsService {
  static Future<dynamic> getServiceCategoriesDetails(int categoryId) async {
    var url = AppConfig().getPublicServicesCategoriesDetails;
    var data = {"CategoryId":categoryId};

    var resp = await BaseClientClass.post(url, data,
        token: SessionController().getPublicToken());

    if (resp is http.Response) {
      var data = publicGetServiceDetailsModelFromJson(resp.body);
      return data;
    }

    return resp;
  }
}
