import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_dashboard_all_invoices/vendor_dashboard_all_invoices_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class VendorDashboardAllInvoicesServices {
  static Future<dynamic> getData() async {
    var data = {"search": '', "pageNo": '1', "pageSize": '20'};
    var url = AppConfig().vendorDashboardAllInvoces;

    var response = await BaseClientClass.post(url, data);
    if (response is http.Response) {
      var allInvoices = vendorDashboardAllInvoicesModelFromJson(response.body);
      return allInvoices;
    }
    return response;
  }

  static Future<dynamic> getDataPagination(String pageNoP, searchtext) async {
    var data = {"search": searchtext, "pageNo": pageNoP, "pageSize": '20'};
    var url = AppConfig().vendorDashboardAllInvoces;

    var response = await BaseClientClass.post(url, data);
    if (response is http.Response) {
      var allInvoices = vendorDashboardAllInvoicesModelFromJson(response.body);
      return allInvoices;
    }
    return response;
  }
}
