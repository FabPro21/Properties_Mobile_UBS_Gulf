import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../models/tenant_models/contract_payment_model.dart';

class PaymentsServices {
  static Future<dynamic> getData() async {
    var url = AppConfig().paymentsGet;
    var data = {
      "Page": 1.toString(),
      "PageSize": 20.toString(),
      "SearchParam": ''
    };
    // var data;

    var response = await BaseClientClass.post(url ?? "", data);
    if (response is http.Response) {
      final paymentsModel = contractPaymentModelFromJson(response.body);
      return paymentsModel;
    }
    return response;
  }

  static Future<dynamic> getDataPagination(String pageNo) async {
    var url = AppConfig().paymentsGet;
    // var data = {
    //   "Page": pageNo,
    //   "PageSize": 20.toString(),
    // };
    var data = {"Page": pageNo, "PageSize": 20.toString(), "SearchParam": ''};
    // var data;

    var response = await BaseClientClass.post(url ?? "", data);
    if (response is http.Response) {
      final paymentsModel = contractPaymentModelFromJson(response.body);
      return paymentsModel;
    }
    return response;
  }

  static Future<dynamic> paymentsSearch(String pageNo, searchText) async {
    var url = AppConfig().paymentsGet;
    pageNo = '1';
    var data = {
      "Page": pageNo,
      "PageSize": 20.toString(),
      "SearchParam": searchText
    };
    var response = await BaseClientClass.post(url ?? "", data);
    if (response is http.Response) {
      final paymentsModel = contractPaymentModelFromJson(response.body);
      return paymentsModel;
    }
    return response;
  }
}
