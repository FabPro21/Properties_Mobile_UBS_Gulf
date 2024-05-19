import 'package:fap_properties/data/models/tenant_models/service_request/survey_question_answers.dart';
import 'package:fap_properties/data/models/tenant_models/service_request/survey_questions.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:get/get.dart';

class TakeSurveyController extends GetxController {
  TakeSurveyController({this.catId, this.caseNo});
  final int catId;
  final int caseNo;
  SurveyQuestions questions;
  RxBool loadingQuestions = true.obs;
  String errorLoadingQuestions;
  RxInt currentQuestion = 0.obs;
  RxBool savingAnswer = false.obs;
  RxDouble progress = 0.0.obs;

  @override
  void onInit() {
    // getSurveyQuestions();
    super.onInit();
  }

  Future<bool> getSurveyQuestions() async {
    loadingQuestions.value = true;
    errorLoadingQuestions = '';
    var resp = await TenantRepository.getSurveyQuestions(caseNo);
    loadingQuestions.value = false;
    if (resp is SurveyQuestions) {
      if (resp.faqQuestion.isNotEmpty) {
        questions = resp;
        print('::::::::::::::::::::::::::::::::::::::::::');
        for (int i = 0; i < resp.faqQuestion.length; i++) {
          print(resp.faqQuestion[i].title);
        }
        getSurveyQuestionAnswers(questions.faqQuestion[0].questionId);
        progress.value = 1 / questions.faqQuestion.length;
        return true;
      } else {
        errorLoadingQuestions = AppMetaLabels().noSurveyFound;
      }
    } else
      errorLoadingQuestions = resp;
    return false;
  }

  void getSurveyQuestionAnswers(int qId) async {
    questions.faqQuestion[currentQuestion.value.toInt()].loadingAnswers.value =
        true;
    questions.faqQuestion[currentQuestion.value.toInt()].errorLoadingAnswers =
        '';
    var resp = await TenantRepository.getSurveyQuestionAnswers(qId);
    if (resp is SurveyQuestionAnswers) {
      if (resp.faqOptions.isEmpty) {
        questions.faqQuestion[currentQuestion.value.toInt()]
            .errorLoadingAnswers = AppMetaLabels().noOptionsfound;
      } else
        questions.faqQuestion[currentQuestion.value.toInt()].answers = resp;
    }
    questions.faqQuestion[currentQuestion.value.toInt()].loadingAnswers.value =
        false;
  }

  Future<bool> nextQuestion() async {
    if (await saveAnswer()) {
      if (currentQuestion.value < questions.faqQuestion.length - 1) {
        currentQuestion.value = currentQuestion.value + 1;
        progress.value =
            (currentQuestion.value + 1) / questions.faqQuestion.length;
        if (questions.faqQuestion[currentQuestion.value.toInt()].answers ==
            null)
          getSurveyQuestionAnswers(
              questions.faqQuestion[currentQuestion.value.toInt()].questionId);
        return true;
      } else
        return false;
    }
    return null;
  }

  Future<bool> saveAnswer() async {
    savingAnswer.value = true;
    var resp = await TenantRepository.saveSurveyAnswer(
        questions
            .faqQuestion[currentQuestion.value.toInt()]
            .answers
            .faqOptions[questions.faqQuestion[currentQuestion.value.toInt()]
                .selectedAnswer.value]
            .optionId,
        questions.faqQuestion[currentQuestion.value.toInt()].answerId,
        'desc',
        currentQuestion.value == questions.faqQuestion.length - 1 ? 1 : 0);
    savingAnswer.value = false;
    if (resp == 'ok') {
      return true;
    } else {
      Get.snackbar(AppMetaLabels().error, resp,
          backgroundColor: AppColors.white54);
      return false;
    }
  }
}
