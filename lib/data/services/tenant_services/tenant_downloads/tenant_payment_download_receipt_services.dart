import 'dart:convert';
import 'dart:developer';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

class PaymentDownloadReceiptService {
  static Future<dynamic> getData() async {
    var url = AppConfig().paymentsDownloadReceipt;
    Map data = {
      "transactionid": SessionController().getTransactionId().toString()
    };
    var response = await BaseClientClass.post(url, data);
    log(response.body.toString());
    if (response is http.Response) {
      try {
        var jsonResp = json.decode(response.body);
        String doc = jsonResp['path'];
        if (doc.isNotEmpty) {
          return base64Decode(doc.replaceAll('\n', ''));
        } else
          return AppMetaLabels().noDatafound;
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
}
