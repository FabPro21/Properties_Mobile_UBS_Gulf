import 'dart:developer';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/landlord_models/filter_property_category_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

class GetLandlordCategoryService {
  static Future<dynamic> getPropertyCategory() async {
    var url = AppConfig().getLandlordCategory;
    var response = await BaseClientClass.post(url, '');
    if (response is http.Response) {
      try {
        log(response.body);
        GetLandLordCategoryModel propertyCategoryModel =
            landlordCategoryModelFromJson(response.body);
        return propertyCategoryModel;
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
}
