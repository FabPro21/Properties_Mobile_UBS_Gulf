import 'package:fap_properties/data/models/landlord_models/landlord_invoice_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import '../../helpers/base_client.dart';
import 'package:http/http.dart' as http;

class LandlordInvoiceServices {
  static Future<dynamic> getData() async {
    var data = {"search": '', "pageNo": '1', "pageSize": '20'};
    var url = AppConfig().landlordInvoces;

    var response = await BaseClientClass.post(url, data);
    if (response is http.Response) {
      var allInvoices =
          landlordDashboardAllInvoicesModelFromJson(response.body);
      return allInvoices;
    }
    return response;
  }

  static Future<dynamic> getDataPagination(String pageNoP, searchtext) async {
    var data = {"search": searchtext, "pageNo": pageNoP, "pageSize": '20'};
    var url = AppConfig().landlordInvoces;

    var response = await BaseClientClass.post(url, data);
    print('Condition ::::: ${(response is http.Response)}');
    if (response is http.Response) {
      var allInvoices =
          landlordDashboardAllInvoicesModelFromJson(response.body);
      return allInvoices;
    }
    return response;
  }
}
