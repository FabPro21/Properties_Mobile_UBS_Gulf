import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/landlord_models/unverified_payment.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class UnverfiedContractPaymentServicesLandlord {
  static Future<dynamic> getData() async {
    var url = AppConfig().getLandlordUnVeridiedPayments;
    var contractId = SessionController().getContractID();
    Map data = {"ContractId": contractId.toString()};
    var response = await BaseClientClass.post(url ?? "", data);
    if (response is http.Response) {
      try {
        return unverifiedLLDContractPaymentsFromJson(response.body);
      } catch (e) {
        if (kDebugMode) print(e);
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
}
