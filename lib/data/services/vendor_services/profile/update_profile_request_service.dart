import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_update_profile_request.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' as foundation;

class UpdateProfileRequestService {
  static Future<dynamic> updateProfileRequest() async {
    var resp = await BaseClientClass.post(AppConfig().updateProfileRequest??"", {});
    if (resp is http.Response) {
      try {
        return vendorUpdateProfileRequestFromJson(resp.body);
      } catch (e) {
        if (foundation.kDebugMode) print(e);
        return AppMetaLabels().anyError;
      }
    } else
      return resp;
  }
}
