// ignore_for_file: unnecessary_type_check

import 'dart:developer';

import 'package:fap_properties/data/models/landlord_models/landlord_contracts_model.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_contracts_filter/filter_data.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;
import '../../helpers/base_client.dart';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';

class LandlordGetContractsServices {
  static Future<dynamic> getContracts(String pageNo, searchText) async {
    var data = {
      "page": pageNo,
      "pageSize": "20",
      "search": searchText,
    };
    // var data = {
    //   "search": searchText,
    //   "pageSize": 20.toString(),
    //   "pageNo": pageNo.toString()
    // };
    var response =
        await BaseClientClass.post(AppConfig().getLandlordContracts??"", data);
    // await BaseClientClass.post(AppConfig().getLandlordContracts, {});
    try {
      if (response is Response) {
        log(response.body);
        return landlordContractsModelFromJson(response.body);
      } else
        return response;
    } catch (e) {
      if (kDebugMode) print(e);
      return AppMetaLabels().someThingWentWrong;
    }
  }

  static Future<dynamic> getContractsWithFilter(
      FilterData filterData, String pageNo) async {
    var completeUrl = AppConfig().getLandlordContractswithFilter;
    Map data = {
      'propertyName': filterData.propertyName.toString(),
      "propertyTypeId": filterData.propertyTypeId.toString(),
      "contractDateFrom": filterData.fromDate,
      "contractDateTo": filterData.toDate,
      "page": pageNo.toString(),
      "pageSize": 20.toString(),
      "propertyStausId": filterData.contractStatusId.toString(),
    };
    print(data);
    var response = await BaseClientClass.post(completeUrl??"", data);
    if (response is http.Response) {
      try {
        if (response is Response) {
          return landlordContractsModelFromJson(response.body);
        } else
          return response;
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
}
