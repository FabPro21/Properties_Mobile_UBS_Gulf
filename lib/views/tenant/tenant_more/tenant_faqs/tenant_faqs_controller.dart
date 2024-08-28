import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_faqs/tenant_faqs_model.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_faqs/tenant_faqs_question_model.dart';
import 'package:get/get.dart';

class TenantFaqsController extends GetxController {
  var faqsCategories = TenantFaqsModel().obs;
  var faqsQuestions = TenantFaqsQuestionsModel().obs;
  //List <TenantFaqsQuestionsModel> faqsQuestions=[];

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
    try {
      loadingFaqsCatg.value = true;
      var result = await TenantRepository.getFaqs();
      if (result is TenantFaqsModel) {
        faqsCategories.value = result;
        length = faqsCategories.value.faqCategories!.length;

        loadingFaqsCatg.value = false;
      } else {
        errorFaqsCatg.value = AppMetaLabels().noDatafound;
        loadingFaqsCatg.value = false;
      }
    } catch (e) {
      loadingFaqsCatg.value = false;
      print("this is the error from controller= $e");
    }
  }

  getfaqsQuestionData(
    int categoryId,
  ) async {
    errorQuestions.value = '';
    try {
      loadingQuestions.value = true;
      var result = await TenantRepository.getFaqsQuestions(categoryId);
      if (result is TenantFaqsQuestionsModel) {
        faqsQuestions.value = result;
        questionLength = faqsQuestions.value.faq!.length;
        loadingQuestions.value = false;
      } else {
        errorQuestions.value = AppMetaLabels().noDatafound;
        loadingQuestions.value = false;
      }
    } catch (e) {
      loadingQuestions.value = false;
      print("this is the error from controller= $e");
    }
  }
}
