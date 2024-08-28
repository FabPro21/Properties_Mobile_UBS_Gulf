import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_feedback/tenant_save_feedback_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class TenantSaveFeedbackServices {
  static Future<dynamic> saveFeedbackData(
      String casedId, String description, double rating) async {
    var url = AppConfig().saveTenantFeedback;
    var data = {
      "caseId": casedId.toString(),
      "description": description,
      "rating": rating.toString(),
    };

    var response = await BaseClientClass.post(url ?? "", data);
    if (response is http.Response) {
      TenantSaveFeedbackModel feedbackModel =
          tenantSaveFeedbackModelFromJson(response.body);
      return feedbackModel;
    }
    return response;
  }
}
