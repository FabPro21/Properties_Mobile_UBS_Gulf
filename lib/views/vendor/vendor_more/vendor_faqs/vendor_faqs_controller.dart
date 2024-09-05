import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_faqs/vendor_faqs_categories_model.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_faqs/vendor_faqs_question_and_description_model.dart';
import 'package:fap_properties/data/services/vendor_services/vendor_faqs/vendor_faqs_categories_service.dart';
import 'package:fap_properties/data/services/vendor_services/vendor_faqs/vendor_faqs_quesion_and_description_service.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class VendorFaqsController extends GetxController {
  var faqsCategories = VendorFaqsCategoriesModel().obs;
  var faqsQuestions = VendorFaqsQuestionAndDescriptionModel().obs;
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
      var result = await VendorFaqsCategoriesSerice.getVendorFaqsCatg();
      if (result is VendorFaqsCategoriesModel) {
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
      var result =
          await VendorFaqsQuestionsAndDescriptionSerice.getFaqsQuestion(
              categoryId);
      if (result is VendorFaqsQuestionAndDescriptionModel) {
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
