import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_get_data_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart';

class VendorGetDataSvc {
  static Future<dynamic> getData() async {
    var completeUrl = AppConfig().getststs;
    var data;

    var response = await BaseClientClass.post(completeUrl, data);

    if (response is Response) {
    
      return vendorGetDataModelFromJson(response.body);
     
    } else
      return response;
  }
}
