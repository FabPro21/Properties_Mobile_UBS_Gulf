import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/public_models/public_offers/public_offer_details_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import "package:http/http.dart" as http;

import '../../../helpers/session_controller.dart';

class PublicOffersDetailsService {
  static Future<dynamic> getOffersDetails(String offerId) async {
    var url = AppConfig().getPublicOffersDetails;
var data = {"OfferId":offerId};
    var response = await BaseClientClass.post(url ?? "", data,
        token: SessionController().getPublicToken());

    if (response is http.Response) {
      var getModel = publicOffersDetailsModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
