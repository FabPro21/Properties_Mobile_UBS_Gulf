import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_offers/vendor_offers_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import "package:http/http.dart" as http;

class VendorOffersSerice {
  static Future<dynamic> getOffers() async {
    var url = AppConfig().getVendorOffers;

    var response = await BaseClientClass.post(url ?? "", {});

    if (response is http.Response) {
      var getModel = vendorOffersModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
