import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_get_profile_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constants/meta_labels.dart';

class GetVendorProfileSvc {
  static Future<dynamic> getData() async {
    var completeUrl = AppConfig().getVendorProfile;
    var data;

    var response = await BaseClientClass.post(completeUrl, data);
    if (response is http.Response) {
      try {
        return vendorGetProfileModelFromJson(response.body);
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    } else
      return response;
  }
}
