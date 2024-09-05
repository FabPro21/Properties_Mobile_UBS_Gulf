import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_faqs/vendor_faqs_question_and_description_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import "package:http/http.dart" as http;

class VendorFaqsQuestionsAndDescriptionSerice {
  static Future<dynamic> getFaqsQuestion(int categoryId) async {
    var url = AppConfig().getVendorFaqsQuestionAndDescription;
    Map data = {"CategoryId": categoryId.toString()};
    var response = await BaseClientClass.post(url ?? "", data);
    if (response is http.Response) {
      VendorFaqsQuestionAndDescriptionModel getModel =
          vendorFaqsQuestionAndDescriptionModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
