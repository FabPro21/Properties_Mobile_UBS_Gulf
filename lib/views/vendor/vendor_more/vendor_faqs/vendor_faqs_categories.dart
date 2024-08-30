import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/vendor/vendor_more/vendor_faqs/vendor_faqs_controller.dart';
import 'package:fap_properties/views/vendor/vendor_more/vendor_faqs/vendor_faqs_question_and_description.dart';
import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../data/helpers/session_controller.dart';

class VendorFaqsCategories extends StatefulWidget {
  const VendorFaqsCategories({Key? key}) : super(key: key);

  @override
  _VendorFaqsCategoriesState createState() => _VendorFaqsCategoriesState();
}

class _VendorFaqsCategoriesState extends State<VendorFaqsCategories> {
  VendorFaqsController _controller = Get.put(VendorFaqsController());
  @override
  void initState() {
    _controller.getFaqsCatgData();
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomAppBar2(
                title: AppMetaLabels().faq,
              ),
              Expanded(
                child: Obx(() {
                  return _controller.loadingFaqsCatg.value
                      ? Center(
                          child: LoadingIndicatorBlue(),
                        )
                      : _controller.length == 0 ||
                              _controller.errorFaqsCatg.value != ""
                          ? CustomErrorWidget(
                              errorImage: AppImagesPath.noServicesFound,
                              errorText: _controller.errorFaqsCatg.value,
                            )
                          : Container(
                              child: ListView.builder(
                                  padding: EdgeInsets.only(top: 1.5.h),
                                  shrinkWrap: true,
                                  itemCount: _controller.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          left: 5.0.w,
                                          top: 3.0.h,
                                          right: 5.0.w),
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.to(() =>
                                                  VendorFaqsQuestionsAndDescription(
                                                    categoryId: _controller
                                                        .faqsCategories
                                                        .value
                                                        .faqCategories?[index]
                                                        .categoryId??0,
                                                  ));
                                            },
                                            child: Directionality(
                                              textDirection: SessionController()
                                                          .getLanguage() ==
                                                      1
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                              child: Container(
                                                width: 90.w,
                                                child: Row(children: [
                                                  Container(
                                                    width: 84.w,
                                                    child: Text(
                                                      SessionController()
                                                                  .getLanguage() ==
                                                              1
                                                          // ? 'It is the world\'s fifth-most populous country, with a population of almost 243 million people, and has the world\'s \nsecond-largest Muslim population just behind Indonesia.[15] Pakistan is the 33rd-largest country in the world by area and the second-largest in South Asia, spanning 881,913 square kilometres (340,509 square miles). It has a 1,046-kilometre (650-mile) coastline along the Arabian Sea and Gulf of Oman in the south, and is bordered by India to the east, Afghanistan to the west, Iran to the southwest, and China to the northeast. It is separated narrowly from Tajikistan by Afghanistan\'s Wakhan Corridor in the north, and also shares a maritime border with Oman. Islamabad is the nations capital, while Karachi is its largest city and financial centre.'
                                                          ? _controller
                                                              .faqsCategories
                                                              .value
                                                              .faqCategories![
                                                                  index]
                                                              .title??""
                                                          : _controller
                                                              .faqsCategories
                                                              .value
                                                              .faqCategories![
                                                                  index]
                                                              .titleAr??"",
                                                      style: AppTextStyle
                                                          .semiBoldBlack13,
                                                      textAlign:
                                                          TextAlign.justify,
                                                      maxLines: null,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    size: 2.0.h,
                                                    color: AppColors.grey1,
                                                  )
                                                ]),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }));
                }),
              ),
            ],
          ),
        ));
  }
}
