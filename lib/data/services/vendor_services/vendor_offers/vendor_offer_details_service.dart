import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_offers/vendor_offers_details_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import "package:http/http.dart" as http;

class VendorOffersDetailsService {
  static Future<dynamic> getOffersDetails(String offerId) async {
    var url = AppConfig().getVendorOffersDetails;
    Map data = {"OfferId": offerId.toString()};

    var response = await BaseClientClass.post(url ?? "", data);

    if (response is http.Response) {
      var getModel = vendorOffersDetailsModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
