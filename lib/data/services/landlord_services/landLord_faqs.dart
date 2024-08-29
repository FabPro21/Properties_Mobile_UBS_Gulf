import 'dart:developer';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_faqs/landLord_faqs_model.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_faqs/landLord_faqs_question_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import "package:http/http.dart" as http;

class LandLordFaqsSerice {
  static Future<dynamic> getFaqs() async {
    var url = AppConfig().getLandlordFaqsCatg;
    var response = await BaseClientClass.post(url ?? "", {});
    if (response is http.Response) {
      log(response.body);
      LandLordFaqsModel getModel = landLordFaqsModelFromJson(response.body);
      return getModel;
    }
    return response;
  }

  static Future<dynamic> getFaqsQuestions(int categoryId) async {
    var url = AppConfig().getLandlordFaqs;
    Map data = {"CategoryId": categoryId.toString()};

    var response = await BaseClientClass.post(url ?? "", data);
    if (response is http.Response) {
      LandLordFaqsQuestionsModel getModel =
          landLordFaqsQuestionsModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
