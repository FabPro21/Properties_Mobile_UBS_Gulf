import 'dart:developer';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/landlord_models/filter_property_type_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

class GetLandlordPropertyTypesService {
  static Future<dynamic> getPropertyTypes() async {
    var url = AppConfig().getLandlordPropTypes;
    var response = await BaseClientClass.post(url ?? "", '');
    if (response is http.Response) {
      try {
        log(response.body);
        GetLandLordPropertiesTypesModel propertyTypesModel =
            landlordPropertyModelFromJson(response.body);
        return propertyTypesModel;
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
}
