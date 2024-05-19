import 'dart:convert';
import 'dart:developer';
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/download_cheque_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class TenantDownloadCheque {
  static Future<dynamic> downloadcheque(int paymentSettingId) async {
    final String url = AppConfig().downloadCheque;
    var response = await BaseClientClass.post(url, {"PaymentSettingId":paymentSettingId.toString()});
    if (response is http.Response) {
      try {
        log(response.body.toString());
       
        var res = DownloadChequeModel.fromJson(jsonDecode(response.body));
        //  var resp = json.decode(response.body);
        // return base64Decode(resp["cheque"].replaceAll('\n', ''));
        return res;
      } catch (e) {
        if (kDebugMode) print(e);
        return AppMetaLabels().anyError;
      }
    }
    return response;
  }
}
class TenantDownloadChequeNew {
  static Future<dynamic> downloadchequeNew(int paymentSettingId) async {
    final String url = AppConfig().downloadChequeNew;
    var response = await BaseClientClass.post(url, {"PaymentSettingId":paymentSettingId.toString()});
    if (response is http.Response) {
      try {
        log(response.body.toString());
       
        var res = DownloadChequeModel.fromJson(jsonDecode(response.body));
        //  var resp = json.decode(response.body);
        // return base64Decode(resp["cheque"].replaceAll('\n', ''));
        return res;
      } catch (e) {
        if (kDebugMode) print(e);
        return AppMetaLabels().anyError;
      }
    }
    return response;
  }
}
