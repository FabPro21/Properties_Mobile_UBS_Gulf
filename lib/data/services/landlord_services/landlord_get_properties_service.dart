import 'dart:developer';

import 'package:fap_properties/data/models/landlord_models/landlord_properties_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import '../../helpers/base_client.dart';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';

class LandlordGetPropertiesServices {
  static Future<dynamic> getProperties() async {
    var data = {
      "search": '',
      "pageSize": 20.toString(),
      "pageNo": 1.toString()
    };
    var response =
        await BaseClientClass.post(AppConfig().getLandlordProperties??"", data);
    try {
      if (response is Response) {
        log(response.body);
        return landlordPropertiesModelFromJson(response.body);
      } else
        return response;
    } catch (e) {
      if (kDebugMode) print(e);
      return AppMetaLabels().someThingWentWrong;
    }
  }

  static Future<dynamic> getPropertiespagination(
      String pageNoP, searchtext) async {
    var data = {
      "search": searchtext,
      "pageSize": 20.toString(),
      "pageNo": pageNoP.toString()
    };
    var response =
        await BaseClientClass.post(AppConfig().getLandlordProperties??"", data);
    try {
      if (response is Response) {
        log(response.body);
        return landlordPropertiesModelFromJson(response.body);
      } else
        return response;
    } catch (e) {
      if (kDebugMode) print(e);
      return AppMetaLabels().someThingWentWrong;
    }
  }
}
