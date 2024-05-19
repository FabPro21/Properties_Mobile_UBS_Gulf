import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/tenant/tenant_more/tenant_offers/tanant_offers_controller.dart';
import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../data/helpers/session_controller.dart';

class TenantOffersDetails extends StatefulWidget {
  final String offerId;
  const TenantOffersDetails({Key key, this.offerId}) : super(key: key);

  @override
  _TenantOffersDetailsState createState() => _TenantOffersDetailsState();
}

class _TenantOffersDetailsState extends State<TenantOffersDetails> {
  TenantOffersController _controller = Get.put(TenantOffersController());

  @override
  void initState() {
    _getdata();
    super.initState();
  }

  _getdata() async {
    await _controller.getOffersDetails(widget.offerId);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomAppBar2(
                title: AppMetaLabels().offers,
              ),
              Expanded(child: SingleChildScrollView(
                child: Obx(() {
                  return _controller.loadingDetails.value
                      ? SizedBox(
                          height: 90.h,
                          child: Center(
                            child: LoadingIndicatorBlue(),
                          ),
                        )
                      : _controller.errorDetails.value != ""
                          ? CustomErrorWidget(
                              errorImage: AppImagesPath.noServicesFound,
                              errorText: _controller.errorDetails.value)
                          : _controller.offersDetails.value.record == null
                              ? SizedBox()
                              : Directionality(
                                  textDirection:
                                      SessionController().getLanguage() == 1
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 4.0.w,
                                              right: 4.0.w,
                                              top: 3.0.h),
                                          child: Align(
                                            alignment: SessionController()
                                                        .getLanguage() ==
                                                    1
                                                ? Alignment.centerLeft
                                                : Alignment.centerRight,
                                            child: Text(
                                              SessionController()
                                                          .getLanguage() ==
                                                      1
                                                  ? _controller.offersDetails
                                                          .value.record.title ??
                                                      ""
                                                  : _controller
                                                          .offersDetails
                                                          .value
                                                          .record
                                                          .titleAr ??
                                                      "",
                                              style:
                                                  AppTextStyle.semiBoldBlack14,
                                            ),
                                          )),
                                      SizedBox(
                                        height: 1.0.h,
                                      ),
                                      Align(
                                        alignment:
                                            SessionController().getLanguage() ==
                                                    1
                                                ? Alignment.centerLeft
                                                : Alignment.centerRight,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              right: 4.0.w,
                                              left: 4.0.w,
                                              bottom: 2.0.h),
                                          child: Html(
                                            data: SessionController()
                                                        .getLanguage() ==
                                                    1
                                                ? _controller
                                                        .offersDetails
                                                        .value
                                                        .record
                                                        .description.trim() ??
                                                    "-"
                                                : _controller
                                                        .offersDetails
                                                        .value
                                                        .record
                                                        .desriptionAr.trim() ??
                                                    "_",
                                            padding: EdgeInsets.zero,
                                          ),
                                          // child: Text(
                                          //   SessionController().getLanguage() ==
                                          //           1
                                          //       ? _controller
                                          //               .offersDetails
                                          //               .value
                                          //               .record
                                          //               .description ??
                                          //           ""
                                          //       : _controller
                                          //               .offersDetails
                                          //               .value
                                          //               .record
                                          //               .desriptionAr ??
                                          //           "_",
                                          //   style: AppTextStyle.normalBlack12,
                                          // ),
                                        ),
                                      ),
                                      _controller.offersDetails.value
                                                  .offerProperties.length ==
                                              0
                                          ? SizedBox()
                                          : Padding(
                                              padding: EdgeInsets.only(
                                                  right: 4.0.w,
                                                  top: 4.0.h,
                                                  left: 4.0.w),
                                              child: Align(
                                                  alignment: SessionController()
                                                              .getLanguage() ==
                                                          1
                                                      ? Alignment.centerLeft
                                                      : Alignment.centerRight,
                                                  child: Text(
                                                    AppMetaLabels()
                                                        .offerProperties,
                                                    style: AppTextStyle
                                                        .semiBoldBlack14,
                                                  )),
                                            ),
                                      Container(
                                          child: ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              padding:
                                                  EdgeInsets.only(top: 0.5.h),
                                              shrinkWrap: true,
                                              itemCount: _controller
                                                  .offersDetails
                                                  .value
                                                  .offerProperties
                                                  .length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5.0.w,
                                                      top: 3.0.h,
                                                      right: 5.0.w),
                                                  child: Column(
                                                    children: [
                                                      Row(children: [
                                                        Image.asset(
                                                          AppImagesPath.home3,
                                                          width: 6.0.w,
                                                        ),
                                                        SizedBox(
                                                          width: 2.0.w,
                                                        ),
                                                        SizedBox(
                                                          width: 80.0.w,
                                                          child: Text(
                                                            SessionController()
                                                                        .getLanguage() ==
                                                                    1
                                                                ? _controller
                                                                        .offersDetails
                                                                        .value
                                                                        .offerProperties[
                                                                            index]
                                                                        .propertyName.trim() ??
                                                                    ""
                                                                : _controller
                                                                        .offersDetails
                                                                        .value
                                                                        .offerProperties[
                                                                            index]
                                                                        .propertyNameAr.trim() ??
                                                                    "",
                                                            style: AppTextStyle
                                                                .normalBlack12,
                                                            maxLines: null,
                                                          ),
                                                        ),
                                                      ]),
                                                    ],
                                                  ),
                                                );
                                              }))
                                    ],
                                  ),
                                );
                }),
              ))
            ],
          )),
    );
  }
}
