import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/get_all_lpos_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constants/meta_labels.dart';

class GetLposwithFilterService {
  static Future<dynamic> getData(LpoFilterData filterData) async {
    Map data = {
      "Property": filterData.propName,
      "LpoStatusId": filterData.statusId.toString(),
      "LpoDateFrom": filterData.dateFrom,
      "LpoDateTo": filterData.dateTo,
      "pageNo": 1.toString(),
      "pageSize": 20.toString(),
    };
    var response =
        await BaseClientClass.post(AppConfig().getLpowithFilter, data);
    if (response is http.Response) {
      try {
        GetAllLpoModel getLpoDataResponse =
            getAllLpoModelFromJson(response.body);
        return getLpoDataResponse;
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }

  static Future<dynamic> getDataPagnination(
      LpoFilterData filterData, String pageNo) async {
    Map data = {
      "Property": filterData.propName,
      "LpoStatusId": filterData.statusId.toString(),
      "LpoDateFrom": filterData.dateFrom,
      "LpoDateTo": filterData.dateTo,
      "pageNo": pageNo.toString(),
      "pageSize": 20.toString(),
    
    };
    var response =
        await BaseClientClass.post(AppConfig().getLpowithFilter, data);
    if (response is http.Response) {
      try {
        GetAllLpoModel getLpoDataResponse =
            getAllLpoModelFromJson(response.body);
        return getLpoDataResponse;
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
}
