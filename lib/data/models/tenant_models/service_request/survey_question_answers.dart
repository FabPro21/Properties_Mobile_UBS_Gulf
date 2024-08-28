// To parse this JSON data, do
//
//     final surveyQuestionAnswers = surveyQuestionAnswersFromJson(jsonString);

import 'dart:convert';

SurveyQuestionAnswers surveyQuestionAnswersFromJson(String? str) =>
    SurveyQuestionAnswers.fromJson(json.decode(str!));

String? surveyQuestionAnswersToJson(SurveyQuestionAnswers data) =>
    json.encode(data.toJson());

class SurveyQuestionAnswers {
  SurveyQuestionAnswers({
    this.faqOptions,
  });

  List<FaqOption>? faqOptions;

  factory SurveyQuestionAnswers.fromJson(Map<String?, dynamic> json) =>
      SurveyQuestionAnswers(
        faqOptions: List<FaqOption>.from(
            json["faqOptions"].map((x) => FaqOption.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "faqOptions": List<dynamic>.from(faqOptions!.map((x) => x.toJson())),
      };
}

class FaqOption {
  FaqOption({
    this.optionId,
    this.questionId,
    this.optionTitle,
    this.optionTitleAr,
    this.descriptionRequired,
  });

  int? optionId;
  int? questionId;
  String? optionTitle;
  String? optionTitleAr;
  bool? descriptionRequired;

  factory FaqOption.fromJson(Map<String?, dynamic> json) => FaqOption(
        optionId: json["optionId"],
        questionId: json["questionId"],
        optionTitle: json["optionTitle"],
        optionTitleAr: json["optionTitleAR"],
        descriptionRequired: json["descriptionRequired"],
      );

  Map<String?, dynamic> toJson() => {
        "optionId": optionId,
        "questionId": questionId,
        "optionTitle": optionTitle,
        "optionTitleAR": optionTitleAr,
        "descriptionRequired": descriptionRequired,
      };
}
