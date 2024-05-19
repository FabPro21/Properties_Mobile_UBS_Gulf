import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/payments/online_payments_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';

class GetOnlinePaymentsService {
  static Future<dynamic> getPayments() async {
    var response =
        await BaseClientClass.post(AppConfig().getOnlinePayments, {});
    if (response is Response) {
      try {
        return onlinePaymentsModelFromJson(response.body);
      } catch (e) {
        if (kDebugMode) print(e);
        return AppMetaLabels().anyError;
      }
    } else
      return response;
  }
}
