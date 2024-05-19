import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/public_models/public_faqs/public_faqs_categories_model.dart';
import 'package:fap_properties/data/models/public_models/public_faqs/public_faqs_question_and_description_model.dart';
import 'package:fap_properties/data/services/public_services/public_faqs/public_faqs_categories_service.dart';
import 'package:fap_properties/data/services/public_services/public_faqs/public_faqs_question_and_description_service.dart';

import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class PublicFaqsController extends GetxController {
  var faqsCategories = PublicFaqsCategoriesModel().obs;
  var faqsQuestions = PublicFaqsQuestionAndDescriptionModel().obs;
  //List <TenantFaqsQuestionsModel> faqsQuestions=[];

  var loadingFaqsCatg = true.obs;
  var loadingQuestions = false.obs;
  RxString errorQuestions = "".obs;
  int length = 0;
  int questionLength = 0;
  RxString errorFaqsCatg = "".obs;

  getFaqsCatgData() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      loadingFaqsCatg.value = true;
      var result = await PublicFaqsCategoriesSerice.getPublicFaqsCatg();
      if (result is PublicFaqsCategoriesModel) {
        faqsCategories.value = result;
        length = faqsCategories.value.faqCategories.length;
        loadingFaqsCatg.value = false;
      } else {
        errorFaqsCatg.value = AppMetaLabels().noDatafound;
        loadingFaqsCatg.value = false;
      }
    } catch (e) {
      loadingFaqsCatg.value = false;
    }
  }

  getfaqsQuestionData(
    int categoryId,
  ) async {
    errorQuestions.value = '';
    try {
      loadingQuestions.value = true;
      var result =
          await PublicFaqsQuestionsAndDescriptionSerice.getPublicFaqsQuestion(
              categoryId);
      if (result is PublicFaqsQuestionAndDescriptionModel) {
        faqsQuestions.value = result;
        questionLength = faqsQuestions.value.faq.length;
        loadingQuestions.value = false;
      } else {
        errorQuestions.value = AppMetaLabels().noDatafound;
        loadingQuestions.value = false;
      }
    } catch (e) {
      loadingQuestions.value = false;
    }
  }
}
