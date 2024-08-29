import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/public_models/public_bookingreq_feedback/public_bookingreq_feedback_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../../helpers/session_controller.dart';

class PublicSaveFeedbackServices {
  static Future<dynamic> saveFeedbackData(
      int casedId, String description, double rating) async {
    var url = AppConfig().savePublicFeedback;

    var data = {
      "caseId": casedId,
      "description": description,
      "rating": rating,
    };

    var response = await BaseClientClass.post(url ?? "", data,
        token: SessionController().getPublicToken());
    if (response is http.Response) {
      PublicBookingReqSaveFeedbackModel feedbackModel =
          publicBookingReqSaveFeedbackModelFromJson(response.body);
      return feedbackModel;
    }
    return response;
  }
}
