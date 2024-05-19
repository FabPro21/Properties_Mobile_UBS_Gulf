import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/get_contracts_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constants/meta_labels.dart';

class GetContractsServices {
  static Future<dynamic> getData() async {
    var url = AppConfig().getContracts;

    var data;

    var response = await BaseClientClass.post(url, data);

    if (response is http.Response) {
      try {
        GetContractsModel getContractsModel =
            getContractsModelFromJson(response.body);
        return getContractsModel;
      } catch (e) {
        print(e.toString());
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }

  static Future<dynamic> getDataPagination(String pageNo, searchText) async {
    var url = AppConfig().getContracts;

    var data = {"pageNo": pageNo, "pageSize": '20', "Search": searchText};

    var response = await BaseClientClass.post(url, data);

    if (response is http.Response) {
      // log(response.body);
      try {
        GetContractsModel getContractsModel =
            getContractsModelFromJson(response.body);
        return getContractsModel;
      } catch (e) {
        print(e.toString());
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
}
