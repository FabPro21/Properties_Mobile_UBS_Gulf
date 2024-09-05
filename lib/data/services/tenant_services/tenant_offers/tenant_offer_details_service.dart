import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_offers/tenant_offer_details_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import "package:http/http.dart" as http;

class TenantOffersDetailsSerice {
  static Future<dynamic> getOffersDetails(String offerId) async {
    var url = AppConfig().getOffersDetails;

    Map data = {"OfferId": offerId};

    var response = await BaseClientClass.post(url ?? "", data);

    if (response is http.Response) {
      var getModel = tenantOffersDetailsModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
