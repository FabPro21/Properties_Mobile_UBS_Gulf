import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/get_vendor_contracts_status_model.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_get_contracts_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class VendorGetContractsWithFilterServices {
  static Future<dynamic> getData(VendorContractFilterData filterData) async {
    var url = AppConfig().getVendorContractswithFilter;

    Map data = {
      "Property": filterData.propName,
      "ContractStausId": filterData.contractStatusId.toString(),
      "ContractDateFrom": filterData.fromDate,
      "ContractDateTo": filterData.toDate,
      "pageNo": 1.toString(),
      "pageSize": 100.toString()
    };

    var response = await BaseClientClass.post(url ?? "", data);

    if (response is http.Response) {
      VendorContractsModel vendorContractsModel =
          vendorContractsModelFromJson(response.body);
      return vendorContractsModel;
    }
    return response;
  }
  static Future<dynamic> getDataPagination(VendorContractFilterData filterData,String pageNo) async {
    var url = AppConfig().getVendorContractswithFilter;

    Map data = {
      "Property": filterData.propName,
      "ContractStausId": filterData.contractStatusId.toString(),
      "ContractDateFrom": filterData.fromDate,
      "ContractDateTo": filterData.toDate,
      "pageNo": pageNo.toString(),
      "pageSize": 20.toString()
    };

    var response = await BaseClientClass.post(url ?? "", data);

    if (response is http.Response) {
      VendorContractsModel vendorContractsModel =
          vendorContractsModelFromJson(response.body);
      return vendorContractsModel;
    }
    return response;
  }
}
