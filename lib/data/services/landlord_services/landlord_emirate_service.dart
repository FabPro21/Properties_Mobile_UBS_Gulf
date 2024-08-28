import 'dart:developer';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/landlord_models/filter_property_emirate_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

class GetLandlordEmirateService {
  static Future<dynamic> getEmirate() async {
    var url = AppConfig().getLandlordEmirate;
    var response = await BaseClientClass.post(url ?? "", '');
    if (response is http.Response) {
      try {
        log(response.body);
        GetLandLordEmirateModel emirateTypesModel =
            landlordEmirateModelFromJson(response.body);
        return emirateTypesModel;
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
}
