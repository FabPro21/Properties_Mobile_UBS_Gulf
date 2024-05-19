import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_get_contact_persons_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart';

import '../../../utils/constants/meta_labels.dart';

class VendorGetContactPersonsSvc {
  static Future<dynamic> getData() async {
    var completeUrl = AppConfig().getContactPersons;
    var data;
    var response = await BaseClientClass.post(completeUrl, data);
    if (response is Response) {
      try {
        return vendorGetContactPersonsModelFromJson(response.body);
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    } else
      return response;
  }
}
