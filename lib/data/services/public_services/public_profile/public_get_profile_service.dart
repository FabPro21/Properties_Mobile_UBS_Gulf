import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/public_models/public_profile/public_get_profile_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

import '../../../helpers/session_controller.dart';

class PublicGetProfileService {
  static Future<dynamic> getProfile() async {
    var url = AppConfig().publicGetProfile;

    var resp = await BaseClientClass.post(url, {},
        token: SessionController().getPublicToken());
    if (resp is http.Response) {
      try {
        return publicGetProfileModelFromJson(resp.body);
      } catch (e) {
        return AppMetaLabels().anyError;
      }
    } else
      return resp;
  }
}
