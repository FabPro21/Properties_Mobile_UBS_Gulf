import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_contracts_filter/filter_data.dart';
import 'package:fap_properties/data/models/tenant_models/get_contracts_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

class GetContractswithFilterService {
  static Future<dynamic> getData(FilterData filterData) async {
    var completeUrl = AppConfig().getContractswithFilter;
    Map data = {
      'PropertyName': filterData.propertyName.toString(),
      "PropertyTypeId": filterData.propertyTypeId.toString(),
      "PropertyStausId": filterData.contractStatusId.toString(),
      "ContractDateFrom": filterData.fromDate,
      "ContractDateTo": filterData.toDate,
    };
    print(data);
    var response = await BaseClientClass.post(completeUrl, data);
    if (response is http.Response) {
      try {
        GetContractsModel contractsWithFilter =
            getContractsModelFromJson(response.body);
        return contractsWithFilter;
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }

  static Future<dynamic> getDataPagination(
      FilterData filterData, pageNo, searchtext) async {
    var completeUrl = AppConfig().getContractswithFilter;
    Map data = {
      'PropertyName': filterData.propertyName.toString(),
      "PropertyTypeId": filterData.propertyTypeId.toString(),
      "PropertyStausId": filterData.contractStatusId.toString(),
      "ContractDateFrom": filterData.fromDate,
      "ContractDateTo": filterData.toDate,
      "pageNo": pageNo,
      "pageSize": '20',
      "Search": searchtext
    };
    print(data);
    var response = await BaseClientClass.post(completeUrl, data);
    if (response is http.Response) {
      try {
        GetContractsModel contractsWithFilter =
            getContractsModelFromJson(response.body);
        return contractsWithFilter;
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
}
