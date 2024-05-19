import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/public_models/public_bookingreq_feedback/public_bookingreq_get_feedback_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../../helpers/session_controller.dart';

class PublicGetFeedbackServices {
  static Future<dynamic> getfeedback(int casedNo) async {
    var url = AppConfig().getPublicFeedback;
    var data = {"caseNo":casedNo.toString()};
    var response = await BaseClientClass.post(url, data,
        token: SessionController().getPublicToken());
    if (response is http.Response) {
      PublicBookingReqGetFeedbackModel feedbackModel =
          publicBookingReqGetFeedbackModelFromJson(response.body);
      return feedbackModel;
    }
    return response;
  }
}
