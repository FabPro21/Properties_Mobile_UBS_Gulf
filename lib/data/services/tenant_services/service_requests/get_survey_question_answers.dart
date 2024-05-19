import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/service_request/survey_question_answers.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class GetSurveyQuestionAnswers {
  static Future<dynamic> getData(int qId) async {
    var url =AppConfig().getSurveyQuestionAnswers;

    var response = await BaseClientClass.post(url, {"QuestionId":qId.toString()});
    if (response is http.Response) {
      return surveyQuestionAnswersFromJson(response.body);
    }
    return response;
  }
}
