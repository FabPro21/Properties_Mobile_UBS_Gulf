import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_offers/tenant_offers_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import "package:http/http.dart" as http;

class TenantOffersSerice {
  static Future<dynamic> getOffers(String pageNo) async {
    var url = AppConfig().getOffers;
    Map data = {"pageNo": pageNo, "pageSize": '20'};
    print('Data:::: $data');
    print('Url:::: $url');
    var response = await BaseClientClass.post(url ?? "", data);
    // var response = await BaseClientClass.post(url ?? "", {});

    if (response is http.Response) {
      var getModel = tenantOffersModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
