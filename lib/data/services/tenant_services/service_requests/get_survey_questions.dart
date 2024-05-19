import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/service_request/survey_questions.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class GetSurveyQuestions {
  static Future<dynamic> getData(int caseNo) async {
    var url = AppConfig().getSurveyQuestions;

    var response = await BaseClientClass.post(url, {"CaseNo":caseNo.toString()});
    // log(response.body);
    if (response is http.Response) {
      return surveyQuestionsFromJson(response.body);
    }
    return response;
  }
}
