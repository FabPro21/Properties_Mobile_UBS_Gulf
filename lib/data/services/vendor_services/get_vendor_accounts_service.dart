import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/get_vendor_accounts_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart';

import '../../../utils/constants/meta_labels.dart';

class GetVendorAccountsService {
  static Future<dynamic> getData() async {
    var url = AppConfig().getVendorAccounts;
    var response = await BaseClientClass.post(url ?? "", {});

    if (response is Response) {
      try {
        return getVendorAccountsModelFromJson(response.body);
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    } else
      return response;
  }
}
