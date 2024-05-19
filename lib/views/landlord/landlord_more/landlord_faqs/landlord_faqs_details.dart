import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/landlord/landlord_more/landlord_faqs/landlord_faqs_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LandLordFaqsDetails extends StatefulWidget {
  final int categoryId;
  LandLordFaqsDetails({Key key, this.categoryId}) : super(key: key);

  @override
  _LandLordFaqsDetailsState createState() => _LandLordFaqsDetailsState();
}

class _LandLordFaqsDetailsState extends State<LandLordFaqsDetails> {
  LandLordFaqsController _controller = Get.put(LandLordFaqsController());
  bool isShowDivider = true;
  @override
  void initState() {
    _controller.getfaqsQuestionData(widget.categoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          CustomAppBar2(title: AppMetaLabels().faq),
          Expanded(
            child: Obx(() {
              return _controller.loadingQuestions.value
                  ? LoadingIndicatorBlue()
                  : _controller.errorQuestions.value != '' ||
                          _controller.questionLength == 0
                      ? Center(
                          child: CustomErrorWidget(
                            errorText: _controller.errorQuestions.value,
                            errorImage: AppImagesPath.noServicesFound,
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.only(top: 1.5.h),
                          shrinkWrap: true,
                          itemCount: _controller.questionLength,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(left: 2.0.w, right: 2.0.w),
                              child: Directionality(
                                textDirection:
                                    SessionController().getLanguage() == 1
                                        ? TextDirection.ltr
                                        : TextDirection.rtl,
                                child: Column(
                                  children: [
                                    ExpansionTile(
                                      iconColor: AppColors.blueColor,
                                      title: Text(
                                        SessionController().getLanguage() == 1
                                            ? _controller.faqsQuestions.value
                                                    .data[index].title ??
                                                ""
                                            : _controller.faqsQuestions.value
                                                    .data[index].titleAR ??
                                                "",
                                        style: AppTextStyle.semiBoldBlack13,
                                        textAlign: TextAlign.justify,
                                      ),
                                      children: <Widget>[
                                        Align(
                                          alignment: SessionController()
                                                      .getLanguage() ==
                                                  1
                                              ? Alignment.centerLeft
                                              : Alignment.centerRight,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                right: 4.0.w,
                                                left: 4.0.w,
                                                bottom: 2.0.h),
                                            child: Text(
                                              SessionController()
                                                          .getLanguage() ==
                                                      1
                                                  ? _controller
                                                          .faqsQuestions
                                                          .value
                                                          .data[index]
                                                          .description ??
                                                      ''
                                                  : _controller
                                                          .faqsQuestions
                                                          .value
                                                          .data[index]
                                                          .descriptionAR ??
                                                      '',
                                              style: AppTextStyle.normalBlack12,
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                        )
                                      ],
                                      onExpansionChanged: (val) {
                                        if (val) {
                                          setState(() {
                                            isShowDivider = false;
                                          });
                                        } else {
                                          setState(() {
                                            isShowDivider = true;
                                          });
                                        }
                                      },
                                    ),
                                    _controller.questionLength - 1 == index ||
                                            !isShowDivider
                                        ? SizedBox()
                                        : AppDivider(),
                                  ],
                                ),
                              ),
                            );
                          });
            }),
          )
        ]));
  }
}
