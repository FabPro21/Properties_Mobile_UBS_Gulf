import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/get_all_lpos_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class GetAllLpoServices {
  static Future<dynamic> getData() async {
    var url = AppConfig().getAllLpo;

    Map data = {
      "pageNo": 1.toString(),
      "pageSize": 100.toString(),
    };

    var response = await BaseClientClass.post(url, data);
    if (response is http.Response) {
      GetAllLpoModel getAllLpoModel = getAllLpoModelFromJson(response.body);
      return getAllLpoModel;
    }
    return response;
  }
  static Future<dynamic> getDataPagination(String pageNoP, searchtext) async {
    var url = AppConfig().getAllLpo;

    Map data = {
      "pageNo": pageNoP.toString(),
      "pageSize": 20.toString(),
      "search": searchtext
    };

    var response = await BaseClientClass.post(url, data);
    if (response is http.Response) {
      GetAllLpoModel getAllLpoModel = getAllLpoModelFromJson(response.body);
      return getAllLpoModel;
    }
    return response;
  }
}
