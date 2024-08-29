// To parse this JSON data, do
//
//     final surveyQuestions = surveyQuestionsFromJson(jsonString);

import 'dart:convert';

import 'package:fap_properties/data/models/tenant_models/service_request/survey_question_answers.dart';
import 'package:get/state_manager.dart';

SurveyQuestions surveyQuestionsFromJson(String? str) =>
    SurveyQuestions.fromJson(json.decode(str!));

String? surveyQuestionsToJson(SurveyQuestions data) =>
    json.encode(data.toJson());

class SurveyQuestions {
  SurveyQuestions({
    this.faqQuestion,
  });

  List<FaqQuestion>? faqQuestion;

  factory SurveyQuestions.fromJson(Map<String?, dynamic> json) =>
      SurveyQuestions(
        faqQuestion: List<FaqQuestion>.from(
            json["faqQuestion"].map((x) => FaqQuestion.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "faqQuestion": List<dynamic>.from(faqQuestion!.map((x) => x.toJson())),
      };
}

class FaqQuestion {
  FaqQuestion({
    this.questionId,
    this.answerId,
    this.title,
    this.titleAr,
    this.description,
    this.descriptionAr,
  });

  int? questionId;
  int? answerId;
  String? title;
  String? titleAr;
  String? description;
  String? descriptionAr;
  SurveyQuestionAnswers? answers;
  RxBool loadingAnswers = false.obs;
  String? errorLoadingAnswers = '';
  RxInt selectedAnswer = (-1).obs;

  factory FaqQuestion.fromJson(Map<String?, dynamic> json) => FaqQuestion(
        questionId: json["questionId"],
        answerId: json["answerId"],
        title: json["title"],
        titleAr: json["titleAR"],
        description: json["description"],
        descriptionAr: json["descriptionAR"],
      );

  Map<String?, dynamic> toJson() => {
        "questionId": questionId,
        "answerId": answerId,
        "title": title,
        "titleAR": titleAr,
        "description": description,
        "descriptionAR": descriptionAr,
      };
}
