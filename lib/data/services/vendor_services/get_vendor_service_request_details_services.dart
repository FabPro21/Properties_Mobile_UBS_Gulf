import 'dart:convert';
import 'dart:developer';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/vendor_models/sr_rport_detail_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../models/vendor_models/get_vendor_service_request_details_model.dart';

class GetVendorDetailsServiceRequestsServices {
  static Future<dynamic> getData() async {
    var caseNo = SessionController().getCaseNo().toString();
    print(caseNo);
    var url = AppConfig().getVendorServiceRequestDetails;
    Map data = {
      "CaseNo": caseNo.toString(),
    };

    var response = await BaseClientClass.post(url, data);

    if (response is http.Response) {
      GetVendorServiceRequestDetailsModel getContractsModel =
          getVendorServiceRequestDetailsModelFromJson(response.body);
      return getContractsModel;
    }
    return response;
  }

  static Future<dynamic> getVendorSRReportDetail() async {
    var caseNo = SessionController().getCaseNo().toString();
    print(caseNo);
    var url = AppConfig().vendorGetSRReportDetail;

    Map data = {
      "caseNo": caseNo.toString(),
    };
    print(url);
    var response = await BaseClientClass.post(url, data);

    if (response is http.Response) {
      SRReportDetailModel resp =
          SRReportDetailModel.fromJson(jsonDecode(response.body));
      log(resp.toString());
      return resp;
    }
    return response;
  }
}
