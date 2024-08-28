import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import "package:http/http.dart" as http;

import '../../../../data/models/public_models/public_faqs/public_faqs_question_and_description_model.dart';
import '../../../helpers/session_controller.dart';

class PublicFaqsQuestionsAndDescriptionSerice {
  static Future<dynamic> getPublicFaqsQuestion(int categoryId) async {
    var url = AppConfig().getPublicFaqsQuestionAndDescription;
var data = {"CategoryId":categoryId};
    var response = await BaseClientClass.post(url ?? "", data,
        token: SessionController().getPublicToken());
    if (response is http.Response) {
      PublicFaqsQuestionAndDescriptionModel getModel =
          publicFaqsQuestionAndDescriptionModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
