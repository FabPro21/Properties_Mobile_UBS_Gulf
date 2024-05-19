import 'dart:developer';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/tenant_models/get_service_request_details_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class GetServiceRequestDetailsServices {
  static Future<dynamic> getData() async {
    var caseNo = SessionController().getCaseNo();
    var url = AppConfig().getServiceRequestDetails;
    print(url);
    var data= {"CaseNo":caseNo};

    var response = await BaseClientClass.post(url, data);

    if (response is http.Response) {
      log(response.body);
      GetServiceRequestDetailsModel getModel =
          getServiceRequestDetailsModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
