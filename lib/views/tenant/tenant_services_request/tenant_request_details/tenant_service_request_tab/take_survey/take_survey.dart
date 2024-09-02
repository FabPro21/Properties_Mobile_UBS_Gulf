// ignore_for_file: unnecessary_null_comparison

import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request_details/tenant_service_request_tab/take_survey/take_survey_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;
import '../../tenant_request_details_controller.dart';

class TakeSurvey extends GetView<TakeSurveyController> {
  final int? reqNo;
  final int? catId;
  TakeSurvey({Key? key, this.reqNo, this.catId}) : super(key: key) {
    Get.put(TakeSurveyController(catId: catId, caseNo: reqNo));
  }

  @override
  Widget build(BuildContext context) {
    controller.getSurveyQuestions();

    return Obx(() {
      return Directionality(
        textDirection: SessionController().getLanguage() == 1
            ? ui.TextDirection.ltr
            : ui.TextDirection.rtl,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(AppMetaLabels().survey,
                  style: AppTextStyle.semiBoldWhite15),
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )),
              flexibleSpace: Image(
                image: AssetImage(AppImagesPath.appbarimg),
                fit: BoxFit.cover,
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(
                    controller.loadingQuestions.value ||
                            controller.errorLoadingQuestions != ''
                        ? 10.h
                        : 19.0.h),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(3.0.h),
                        child: Row(
                          children: [
                            Text(
                              AppMetaLabels().requestno,
                              style: AppTextStyle.semiBoldBlack12,
                            ),
                            const Spacer(),
                            Text(
                              reqNo.toString(),
                              style: AppTextStyle.semiBoldBlack12,
                            ),
                          ],
                        ),
                      ),
                      if (!controller.loadingQuestions.value &&
                          controller.errorLoadingQuestions == '')
                        Column(
                          children: [
                            const AppDivider(),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3.0.h, horizontal: 4.w),
                              child: Column(
                                children: [
                                  Text(
                                      '${controller.currentQuestion.value.toInt() + 1}/${controller.questions?.faqQuestion?.length}'),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(1.h),
                                    child: LinearProgressIndicator(
                                      value: controller.progress.value,
                                      minHeight: 1.h,
                                      color: AppColors.blueColor,
                                      backgroundColor: AppColors.blueColor2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
            ),
            body: Obx(() {
              return SafeArea(
                child: controller.loadingQuestions.value
                    ? LoadingIndicatorBlue()
                    : controller.errorLoadingQuestions != ''
                        ? AppErrorWidget(
                            errorText: controller.errorLoadingQuestions??"",
                          )
                        : controller.questions != null
                            ? Container(
                                height: 60.h,
                                margin: EdgeInsets.only(
                                    top: 4.0.h,
                                    right: 2.0.h,
                                    left: 2.0.h,
                                    bottom: 2.h),
                                padding: EdgeInsets.symmetric(
                                    vertical: 4.h, horizontal: 4.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(2.0.h),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 0.5.h,
                                      spreadRadius: 0.1.h,
                                      offset: Offset(0.1.h, 0.1.h),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      SessionController().getLanguage() == 1
                                          ? controller
                                                  .questions?.faqQuestion![controller.currentQuestion.value
                                                      .toInt()].title ??
                                              ''
                                          : controller
                                                  .questions?.faqQuestion?[controller
                                                      .currentQuestion.value
                                                      .toInt()]
                                                  .titleAr ??
                                              '-',
                                      style: AppTextStyle.semiBoldBlack12,
                                    ),
                                    Expanded(
                                        child:
                                            controller
                                                    .questions?.faqQuestion?[controller
                                                        .currentQuestion
                                                        .toInt()]
                                                    .loadingAnswers
                                                    .value==true
                                                ? LoadingIndicatorBlue()
                                                : controller
                                                            .questions?.faqQuestion?[controller
                                                                .currentQuestion
                                                                .toInt()]
                                                            .errorLoadingAnswers !=
                                                        ''
                                                    ? AppErrorWidget(
                                                        errorText: controller
                                                            .questions?.faqQuestion?[controller
                                                                .currentQuestion
                                                                .toInt()]
                                                            .errorLoadingAnswers??"",
                                                      )
                                                    : controller
                                                                .questions?.faqQuestion?[
                                                                    controller
                                                                        .currentQuestion
                                                                        .toInt()]
                                                                .answers !=
                                                            null
                                                        ? ListView.builder(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 3.h),
                                                            itemCount: controller
                                                                .questions?.faqQuestion?[controller.currentQuestion.toInt()]
                                                                .answers!
                                                                .faqOptions!
                                                                .length,
                                                            itemBuilder: (context, index) {
                                                              return InkWell(
                                                                onTap: () {
                                                                  controller
                                                                      .questions?.faqQuestion?[controller
                                                                          .currentQuestion
                                                                          .value
                                                                          .toInt()]
                                                                      .selectedAnswer
                                                                      .value = index;
                                                                  print(controller
                                                                      .questions?.faqQuestion?[controller
                                                                          .currentQuestion
                                                                          .value
                                                                          .toInt()]
                                                                      .selectedAnswer
                                                                      .value);
                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    Obx(() {
                                                                      return Radio(
                                                                        activeColor: AppColors.blueColor,
                                                                        materialTapTargetSize:
                                                                            MaterialTapTargetSize.shrinkWrap,
                                                                        groupValue: controller
                                                                            .questions?.faqQuestion?[controller.currentQuestion.value.toInt()]
                                                                            .selectedAnswer
                                                                            .value,
                                                                        onChanged:
                                                                            (value) {
                                                                          controller
                                                                              .questions?.faqQuestion?[controller.currentQuestion.value.toInt()]
                                                                              .selectedAnswer
                                                                              .value = index;

                                                                          print(controller
                                                                              .questions?.faqQuestion?[controller.currentQuestion.value.toInt()]
                                                                              .selectedAnswer
                                                                              .value);
                                                                        },
                                                                        value:
                                                                            index,
                                                                      );
                                                                    }),
                                                                    Text(
                                                                      SessionController().getLanguage() ==
                                                                              1
                                                                          ? controller.questions?.faqQuestion![controller.currentQuestion.toInt()].answers?.faqOptions![index].optionTitle ??
                                                                              ""
                                                                          : controller.questions?.faqQuestion?[controller.currentQuestion.toInt()].answers?.faqOptions?[index].optionTitleAr ??
                                                                              "",
                                                                      style: AppTextStyle
                                                                          .normalBlack12,
                                                                    )
                                                                  ],
                                                                ),
                                                              );
                                                            })
                                                        : SizedBox()),
                                    controller.savingAnswer.value
                                        ? LoadingIndicatorBlue()
                                        : Center(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          1.3.h),
                                                ),
                                                backgroundColor:
                                                    AppColors.blueColor,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 6.0.h,
                                                    vertical: 1.8.h),
                                              ),
                                              onPressed: controller
                                                          .questions?.faqQuestion?[controller
                                                              .currentQuestion
                                                              .value
                                                              .toInt()]
                                                          .selectedAnswer
                                                          .value ==
                                                      (-1)
                                                  ? null
                                                  : () async {
                                                      var resp =
                                                          await controller
                                                              .nextQuestion();
                                                      if (resp != null &&
                                                          resp == false) {
                                                        showSuccessDialog(
                                                            context);
                                                      }
                                                    },
                                              child: Text(
                                                AppMetaLabels().next,
                                                style: AppTextStyle
                                                    .semiBoldWhite12,
                                              ),
                                            ),
                                          )
                                  ],
                                ),
                              )
                            : SizedBox(),
              );
            })),
      );
    });
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              content: Container(
                  padding: EdgeInsets.all(3.0.w),
                  height: 48.0.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2.0.h),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 0.5.h,
                        spreadRadius: 0.3.h,
                        offset: Offset(0.1.h, 0.1.h),
                      ),
                    ],
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 4.0.h,
                        ),
                        Image.asset(
                          AppImagesPath.bluttickimg,
                          height: 9.0.h,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          height: 3.0.h,
                        ),
                        Text(
                          AppMetaLabels().surveyCompTitle,
                          style: AppTextStyle.semiBoldBlack13,
                        ),
                        SizedBox(
                          height: 3.0.h,
                        ),
                        Text(
                          AppMetaLabels().surveyCompMsg,
                          style: AppTextStyle.normalBlack10
                              .copyWith(color: AppColors.renewelgreyclr1),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0.h, bottom: 2.0.h),
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 7.0.h,
                              width: 65.0.w,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(1.3.h),
                                  ),
                                  backgroundColor:
                                      Color.fromRGBO(0, 61, 166, 1),
                                ),
                                onPressed: () {
                                  final srDetailsController = Get.find<
                                      TenantRequestDetailsController>();
                                  srDetailsController.getData();
                                  Get.back();
                                  Get.back();
                                },
                                child: Text(
                                  AppMetaLabels().done,
                                  style: AppTextStyle.semiBoldWhite12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ])));
        });
  }
}
