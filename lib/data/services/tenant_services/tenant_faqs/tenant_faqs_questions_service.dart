import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_faqs/tenant_faqs_question_model.dart';
import "package:http/http.dart" as http;

class TenantFaqsQuestionsSerice {
  static Future<dynamic> getFaqsQuestion(int categoryId) async {
    var url = AppConfig().getTenanatFaqsQuestions;
    Map data = {"CategoryId": categoryId.toString()};

    var response = await BaseClientClass.post(url, data);
    if (response is http.Response) {
      TenantFaqsQuestionsModel getModel =
          tenantFaqsQuestionsModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
