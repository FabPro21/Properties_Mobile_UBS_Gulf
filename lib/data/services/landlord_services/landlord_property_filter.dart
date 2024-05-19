import 'dart:developer';
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_properties_model.dart';
import 'package:fap_properties/data/models/landlord_models/property_filter.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

class GetLandlordPropertyWithFilterService {
  static Future<dynamic> getPropertyWithFilter(PFilterData pFilterData,String pageNo) async {
    Map data = {
      "property": pFilterData.propertyName.toString(),
      "propertyCategoryID":  pFilterData.categoryId.toString(),
      "propertyEmiratID":  pFilterData.emirateId.toString(),
      "propertyTypeID":  pFilterData.propertyTypeId.toString(),
      "pageNo": pageNo.toString(),
      "pageSize": '20'
    };
    var url = AppConfig().getPropertyWithFilter;
    var response = await BaseClientClass.post(url, data);
    if (response is http.Response) {
      try {
        log(response.body);
        LandlordPropertiesModel propertyCategoryModel =
            landlordPropertiesModelFromJson(response.body);
        return propertyCategoryModel;
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
}
