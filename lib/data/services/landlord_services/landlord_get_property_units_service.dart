import 'dart:convert';
import 'dart:developer';
import 'package:fap_properties/data/models/landlord_models/landlord_property_details_model.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_property_units_model.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_unit_detail_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';

import '../../helpers/base_client.dart';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';

class LandlordGetPropertyUnitsServices {
  static Future<dynamic> getPropertyUnits(String propertyId) async {
    var response = await BaseClientClass.post(
        AppConfig().getLandlordPropertyUnits, {"propertyID": propertyId});
    try {
      if (response is Response) {
        try {
          print(
              '=======> Response in Repo Try :::: ${landlordPropertyUnitsModelFromJson(response.body)}');
          return landlordPropertyUnitsModelFromJson(response.body);
        } catch (e) {
          print('=======> Response in Repo Catch :::: ${e.toString()} $e');
        }
      } else
        return response;
    } catch (e) {
      return AppMetaLabels().someThingWentWrong;
    }
  }

  static Future<dynamic> getPropertyDetail(String propertyId) async {
    var response = await BaseClientClass.post(
        AppConfig().getLandlordPropertyDetails, {"propertyID": propertyId});
    try {
      if (response is Response) {
        log(response.body);
        return landlordPropertiesDetailsModelFromJson(response.body);
      } else
        return response;
    } catch (e) {
      if (kDebugMode) print(e);
      return AppMetaLabels().someThingWentWrong;
    }
  }

  static Future<dynamic> getPropertyUnitDetail(String propertyId) async {
    var response = await BaseClientClass.post(
        AppConfig().getLandlordPropertyUnitDetails, {"unitID": propertyId});
    try {
      if (response is Response) {
        log(response.body);
        return LandLordUnitDetailModel.fromJson(jsonDecode(response.body));
      } else
        return response;
    } catch (e) {
      if (kDebugMode) print(e);
      return AppMetaLabels().someThingWentWrong;
    }
  }
}
