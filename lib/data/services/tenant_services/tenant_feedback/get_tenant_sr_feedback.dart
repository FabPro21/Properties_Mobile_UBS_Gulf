import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_feedback/tenant_get_sr_feedback.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' as foundation;

class GetTenantSRFeedback {
  static Future<dynamic> getFeedback(int caseId) async {
    var url = AppConfig().getTenantFeedback;

    Map data = {"CaseNo": caseId.toString()};

    var response = await BaseClientClass.post(url ?? "", data);
    if (response is http.Response) {
      try {
        TenantGetSrFeedback feedbackModel =
            tenantGetSrFeedbackFromJson(response.body);
        return feedbackModel;
      } catch (e) {
        if (foundation.kDebugMode) {
          print(e);
        }
        return AppMetaLabels().anyError;
      }
    }
    return response;
  }
}
