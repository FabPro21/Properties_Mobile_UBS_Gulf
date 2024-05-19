import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/public_models/public_offers/public_offers_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import "package:http/http.dart" as http;

import '../../../helpers/session_controller.dart';

class PublicOffersSerice {
  static Future<dynamic> getOffers() async {
    var url = AppConfig().getPublicOffers;

    var response = await BaseClientClass.post(url, {},
        token: SessionController().getPublicToken());

    if (response is http.Response) {
      var getModel = publicOffersModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
