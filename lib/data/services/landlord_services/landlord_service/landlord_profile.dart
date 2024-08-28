import 'dart:convert';
import 'dart:developer';
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_profile/ladlord_profile_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

class LandLordProfileServices {
  static Future<dynamic> landLordProfile() async {
    try {
      var url = AppConfig().getLandLordProfile;
      var response = await BaseClientClass.post(url ?? "", {});
      if (response is http.Response) {
        print('testing :::++++++====>');

        log(response.body);
        print(
            'Testing :::: + ${LandLordProfileModel.fromJson(jsonDecode(response.body))}');
        return LandLordProfileModel.fromJson(jsonDecode(response.body));
      }
      return response;
    } catch (e) {
      print(e);
      print(e.toString());
      return AppMetaLabels().anyError;
    }
  }

  static Future<dynamic> canEditProfile() async {
    var resp =
        await BaseClientClass.post(AppConfig().canEditLandLordProfile??"", {});
    if (resp is http.Response) {
      try {
        var jsonResp = jsonDecode(resp.body);
        return jsonResp['caseNo'];
      } catch (e) {
        return AppMetaLabels().anyError;
      }
    } else
      return resp;
  }

  static Future<dynamic> updateProfile(
      String name, String mobileNo, String email, String address) async {
    var url = AppConfig().updateLandLordProfile;

    var data = {
      "caseNo": 0.toString(),
      "description": null,
      "personName": name,
      "personMobile": mobileNo,
      "personEmail": email,
      "address": address
    };
    print('Data ::: $data');
    print('URL ::: $url');

    var resp = await BaseClientClass.post(url ?? "", data);
    if (resp is http.Response) {
      return landlordProfileModelFromJson(resp.body);
    }
    return resp;
  }
}
