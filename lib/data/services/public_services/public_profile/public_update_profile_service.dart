import 'package:fap_properties/data/models/auth_models/verify_user_otp_model.dart';
import 'package:fap_properties/data/models/public_models/public_profile/public_update_model.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';

import '../../../helpers/session_controller.dart';

class PublicUpdateProfileService {
  static Future<dynamic> updateProfile(
    String name,
    String mobileNo,
    String email,
  ) async {
    var url = AppConfig().publicUpdateProfile;

    var data = {
      "caseNo": 0,
      "description": "Profile Info",
      "personName": name,
      "personMobile": mobileNo,
      "personEmail": email,
      "address": ""
    };

    var resp = await BaseClientClass.post(url ?? "", data,
        token: SessionController().getPublicToken());
    if (resp is http.Response) {
      try {
        return publicUpdateProfileModelFromJson(resp.body);
      } catch (e) {
        return AppMetaLabels().anyError;
      }
    } else {
      return resp;
    }
  }

  static Future<dynamic> updatePublicProfile(
    String name,
    String userID,
    String email,
  ) async {
    var url = AppConfig().updatePublicProfile;
    var data = {"UserId": userID, "Name": name, "EmailAddress": email};
    print('Data :::: $data');
    print('Token :::: ${SessionController().getLoginToken()}');

    var resp = await BaseClientClass.post(url ?? "", data,
        token: SessionController().getLoginToken());
    if (resp is http.Response) {
      try {
        print('Resp in repo Before:::: ${resp.body}');
        var reponse = userModelFromJson(resp.body);
        print('Resp in repo After:::: $reponse');
        return reponse;
      } catch (e) {
        return AppMetaLabels().anyError;
      }
    } else {
      return resp;
    }
  }
}
