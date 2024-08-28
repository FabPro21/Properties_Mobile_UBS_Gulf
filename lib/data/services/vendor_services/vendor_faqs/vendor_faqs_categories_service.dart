import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_faqs/vendor_faqs_categories_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import "package:http/http.dart" as http;

class VendorFaqsCategoriesSerice {
  static Future<dynamic> getVendorFaqsCatg() async {
    var url = AppConfig().getVendorFaqsCatg;

    var response = await BaseClientClass.post(url ?? "", {});

    if (response is http.Response) {
      VendorFaqsCategoriesModel getModel =
          vendorFaqsCategoriesModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
