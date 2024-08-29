import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/vendor/vendor_more/vendor_faqs/vendor_faqs_controller.dart';
import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../data/helpers/session_controller.dart';

class VendorFaqsQuestionsAndDescription extends StatefulWidget {
  final int? categoryId;
  const VendorFaqsQuestionsAndDescription({Key? key, this.categoryId})
      : super(key: key);

  @override
  _VendorFaqsQuestionsAndDescriptionState createState() =>
      _VendorFaqsQuestionsAndDescriptionState();
}

class _VendorFaqsQuestionsAndDescriptionState
    extends State<VendorFaqsQuestionsAndDescription> {
  VendorFaqsController _controller = Get.put(VendorFaqsController());
  bool isShowDivider = true;
  @override
  void initState() {
    _controller.getfaqsQuestionData(widget.categoryId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Directionality(
          textDirection: SessionController().getLanguage() == 1
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: Column(children: [
            CustomAppBar2(title: AppMetaLabels().faq),
            Expanded(
              child: Obx(() {
                return _controller.loadingQuestions.value
                    ? LoadingIndicatorBlue()
                    : _controller.errorQuestions.value != '' ||
                            _controller.questionLength == 0
                        ? CustomErrorWidget(
                            errorText: _controller.errorQuestions.value,
                            errorImage: AppImagesPath.noServicesFound,
                          )
                        : ListView.builder(
                            padding: EdgeInsets.only(top: 1.5.h),
                            shrinkWrap: true,
                            itemCount: _controller.questionLength,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    EdgeInsets.only(left: 2.0.w, right: 2.0.w),
                                child: Column(
                                  children: [
                                    ExpansionTile(
                                      iconColor: AppColors.blueColor,
                                      title: Text(
                                        SessionController().getLanguage() == 1
                                            // ? 'It is the world\'s fifth-most populous country, with a population of almost 243 million people, and has the world\'s \nsecond-largest Muslim population just behind Indonesia.[15] Pakistan is the 33rd-largest country in the world by area and the second-largest in South Asia, spanning 881,913 square kilometres (340,509 square miles). It has a 1,046-kilometre (650-mile) coastline along the Arabian Sea and Gulf of Oman in the south, and is bordered by India to the east, Afghanistan to the west, Iran to the southwest, and China to the northeast. It is separated narrowly from Tajikistan by Afghanistan\'s Wakhan Corridor in the north, and also shares a maritime border with Oman. Islamabad is the nations capital, while Karachi is its largest city and financial centre.'
                                            ? _controller.faqsQuestions.value
                                                    .faq![index].title??""
                                            : _controller.faqsQuestions.value
                                                    .faq![index].titleAr ??"",
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
                                                left: 4.0.w,
                                                bottom: 2.0.h,
                                                right: 4.0.h),
                                            child: Text(
                                              SessionController()
                                                          .getLanguage() ==
                                                      1
                                                  // ? 'It is the world\'s fifth-most populous country, with a population of almost 243 million people, and has the world\'s \nsecond-largest Muslim population just behind Indonesia.[15] Pakistan is the 33rd-largest country in the world by area and the second-largest in South Asia, spanning 881,913 square kilometres (340,509 square miles). It has a 1,046-kilometre (650-mile) coastline along the Arabian Sea and Gulf of Oman in the south, and is bordered by India to the east, Afghanistan to the west, Iran to the southwest, and China to the northeast. It is separated narrowly from Tajikistan by Afghanistan\'s Wakhan Corridor in the north, and also shares a maritime border with Oman. Islamabad is the nations capital, while Karachi is its largest city and financial centre.'
                                                  ? _controller
                                                      .faqsQuestions
                                                      .value
                                                      .faq![index]
                                                      .description??""
                                                  : _controller
                                                      .faqsQuestions
                                                      .value
                                                      .faq![index]
                                                      .descriptionAr??"",
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
                              );
                            });
              }),
            ),
          ]),
        ));
  }
}
