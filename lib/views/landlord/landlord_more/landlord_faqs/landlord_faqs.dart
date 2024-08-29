import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/landlord/landlord_more/landlord_faqs/landlord_faqs_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'landlord_faqs_details.dart';

class LandLordFaqs extends StatefulWidget {
  const LandLordFaqs({Key? key}) : super(key: key);

  @override
  _LandLordFaqsState createState() => _LandLordFaqsState();
}

class _LandLordFaqsState extends State<LandLordFaqs> {
  LandLordFaqsController _controller = Get.put(LandLordFaqsController());
  @override
  void initState() {
    _controller.getfaqsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(children: [
            CustomAppBar2(
              title: AppMetaLabels().faq,
            ),
            Obx(() {
              return _controller.loadingFaqsCatg.value
                  ? Expanded(
                      child: Center(
                        child: LoadingIndicatorBlue(),
                      ),
                    )
                  : _controller.length == 0
                      ? Expanded(
                          child: CustomErrorWidget(
                            errorImage: AppImagesPath.noServicesFound,
                            errorText: _controller.errorFaqsCatg.value,
                          ),
                        )
                      : Expanded(
                          child: Container(
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
                                              Get.to(() => LandLordFaqsDetails(
                                                    categoryId: int.parse(
                                                        _controller
                                                                .faqsCategories
                                                                .value
                                                                .data![index]
                                                                .categoryId ??
                                                            ''),
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
                                                          ? _controller
                                                                  .faqsCategories
                                                                  .value
                                                                  .data![index]
                                                                  .title ??
                                                              ""
                                                          : _controller
                                                                  .faqsCategories
                                                                  .value
                                                                  .data![index]
                                                                  .titleAR ??
                                                              "",
                                                      style: AppTextStyle
                                                          .semiBoldBlack13,
                                                      maxLines: null,
                                                      textAlign:
                                                          TextAlign.justify,
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
                                  })),
                        );
            })
          ])),
    );
  }
}
