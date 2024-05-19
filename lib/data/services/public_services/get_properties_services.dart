import 'dart:developer';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/public_models/get_properties_model.dart';

class GetPropertiesServices {
  static Future<dynamic> getData(
      String propName,
      String minRentAmount,
      String maxRentAmount,
      String areaType,
      String minAreaSize,
      String maxAreaSize,
      String minRoom,
      String maxRoom,
      String pagenum) async {
    var url = AppConfig().getProperties;

    var data = {
      if (propName != "") "PropertyName": propName,
      if (areaType != "") "AreaType": areaType ?? '""',
      if (SessionController().getPropCatId() != "")
        "PropertyCategoryID": SessionController().getPropCatId(),
      if (SessionController().getCityId() != "")
        "EmirateId": SessionController().getCityId(),
      if (minRentAmount != "") "MinAmount": minRentAmount ?? '""',
      if (maxRentAmount != "") "MaxAmount": maxRentAmount ?? '""',
      if (SessionController().getUnitTypeName() != "")
        "UnitType": SessionController().getUnitTypeName(),
      if (minAreaSize != "") "MinArea": minAreaSize,
      if (maxAreaSize != "") "MaxArea": maxAreaSize,
      if (minRoom != "") "NoofRoomMin": minRoom,
      if (maxRoom != "") "NoofRoomMax": maxRoom,
      "pageNo": pagenum,
      "pageSize": 15,
    };
    var response = await BaseClientClass.post(url, data,
        token: SessionController().getPublicToken());

    if (response is http.Response) {
      GetPropertiesModel getModel = getPropertiesModelFromJson(response.body);
      return getModel;
    }
    return response;
  }

  static Future<dynamic> getDataPagination(
      String propName,
      String minRentAmount,
      String maxRentAmount,
      String areaType,
      String minAreaSize,
      String maxAreaSize,
      String minRoom,
      String maxRoom,
      String pageNo) async {
    var url = AppConfig().getProperties;

    var data = {
      if (propName != "") "PropertyName": propName,
      if (areaType != "") "AreaType": areaType ?? '""',
      if (SessionController().getPropCatId() != "")
        "PropertyCategoryID": SessionController().getPropCatId(),
      if (SessionController().getCityId() != "")
        "EmirateId": SessionController().getCityId(),
      if (minRentAmount != "") "MinAmount": minRentAmount ?? '""',
      if (maxRentAmount != "") "MaxAmount": maxRentAmount ?? '""',
      if (SessionController().getUnitTypeName() != "")
        "UnitType": SessionController().getUnitTypeName(),
      if (minAreaSize != "") "MinArea": minAreaSize,
      if (maxAreaSize != "") "MaxArea": maxAreaSize,
      if (minRoom != "") "NoofRoomMin": minRoom,
      if (maxRoom != "") "NoofRoomMax": maxRoom,
      "pageNo": pageNo,
      "pageSize": 6,
    };
    var response = await BaseClientClass.post(url, data,
        token: SessionController().getPublicToken());

    if (response is http.Response) {
      log(response.body);
      GetPropertiesModel getModel = getPropertiesModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
