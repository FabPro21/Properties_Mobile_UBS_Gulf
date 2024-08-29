import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_faqs/landLord_faqs_model.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_faqs/landLord_faqs_question_model.dart';
import 'package:fap_properties/data/repository/landlord_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class LandLordFaqsController extends GetxController {
  var faqsCategories = LandLordFaqsModel().obs;
  var faqsQuestions = LandLordFaqsQuestionsModel().obs;

  var loadingFaqsCatg = true.obs;
  var loadingQuestions = false.obs;
  RxString errorQuestions = "".obs;
  int length = 0;
  int questionLength = 0;
  RxString errorFaqsCatg = "".obs;

  getfaqsData() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    var result;
    try {
      loadingFaqsCatg.value = true;
      result = await LandlordRepository.getFaqs();
      print('Result ::::: $result');
      if (result is String) {
        if (result == 'no record found') {
          errorFaqsCatg.value = AppMetaLabels().noDatafound;
        } else if (result == 'No data found') {
          errorFaqsCatg.value = AppMetaLabels().noDatafound;
        } else {
          errorFaqsCatg.value = AppMetaLabels().noDatafound;
        }
        loadingFaqsCatg.value = false;
      } else {
        if (result.statusCode == 200) {
          faqsCategories.value = result;
          length = faqsCategories.value.data!.length;
          loadingFaqsCatg.value = false;
        } else if (result.statusCode == 200 && result.data == null) {
          errorFaqsCatg.value = AppMetaLabels().noDatafound;
          length = 0;
          loadingFaqsCatg.value = false;
        } else {
          errorFaqsCatg.value = AppMetaLabels().noDatafound;
          length = 0;
          loadingFaqsCatg.value = false;
        }
      }
    } catch (e) {
      loadingFaqsCatg.value = false;
      errorFaqsCatg.value = AppMetaLabels().noDatafound;
      length = 0;
      return;
    }
  }

  getfaqsQuestionData(
    int categoryId,
  ) async {
    errorQuestions.value = '';
    var result;
    try {
      loadingQuestions.value = true;
      result = await LandlordRepository.getFaqsQuestions(categoryId);
      if (result is LandLordFaqsQuestionsModel) {
        faqsQuestions.value = result;
        questionLength = faqsQuestions.value.data!.length;
        loadingQuestions.value = false;
      } else {
        errorQuestions.value = AppMetaLabels().noDatafound;
        loadingQuestions.value = false;
      }
    } catch (e) {
      loadingQuestions.value = false;
      if (result.message == 'no record found') {
        errorQuestions.value = AppMetaLabels().noDatafound;
      } else {
        errorQuestions.value = AppMetaLabels().noDatafound;
      }
      print("this is the error from controller= ${result.message}");
    }
  }
}
