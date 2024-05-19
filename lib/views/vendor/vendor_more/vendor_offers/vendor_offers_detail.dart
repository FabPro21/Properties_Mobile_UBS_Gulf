import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/vendor/vendor_more/vendor_offers/vendor_offers_controller.dart';
import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../data/helpers/session_controller.dart';

class VendorOffersDetails extends StatefulWidget {
  final String offerId;
  const VendorOffersDetails({Key key, this.offerId}) : super(key: key);

  @override
  _VendorOffersDetailsState createState() => _VendorOffersDetailsState();
}

class _VendorOffersDetailsState extends State<VendorOffersDetails> {
  var _controller = Get.put(VendorOffersController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getOffersDetails(widget.offerId);
    });
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
                title: AppMetaLabels().offers,
              ),
              Expanded(
                child: Obx(() {
                  return _controller.loadingDetails.value
                      ? Center(
                          child: LoadingIndicatorBlue(),
                        )
                      : _controller.errorDetails.value != ""
                          ? CustomErrorWidget(
                              errorImage: AppImagesPath.noServicesFound,
                              errorText: _controller.errorDetails.value,
                            )
                          : _controller.offersDetails.value == null
                              ? ''
                              : Column(
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
                                            SessionController().getLanguage() ==
                                                    1
                                                ? _controller.offersDetails
                                                        .value.record?.title ??
                                                    ""
                                                : _controller
                                                        .offersDetails
                                                        .value
                                                        .record
                                                        ?.titleAr ??
                                                    "",
                                            style: AppTextStyle.semiBoldBlack14,
                                          ),
                                        )),
                                    SizedBox(
                                      height: 1.0.h,
                                    ),
                                    Align(
                                      alignment:
                                          SessionController().getLanguage() == 1
                                              ? Alignment.centerLeft
                                              : Alignment.centerRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.0.w,
                                            bottom: 2.0.h,
                                            right: 4.0.h),
                                        child: Html(
                                          data: SessionController()
                                                      .getLanguage() ==
                                                  1
                                              ? _controller.offersDetails.value
                                                      .record?.description ??
                                                  ""
                                              : _controller.offersDetails.value
                                                      .record?.desriptionAr ??
                                                  "",
                                          padding: EdgeInsets.zero,
                                        ),
                                      ),
                                    ),
                                    _controller.offersDetails.value
                                                .offerProperties ==
                                            null
                                        ? SizedBox()
                                        : Padding(
                                            padding: EdgeInsets.only(
                                                top: 4.0.h,
                                                left: 4.0.w,
                                                right: 4.0.w),
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
                                    _controller.offersDetails.value
                                                .offerProperties ==
                                            null
                                        ? SizedBox()
                                        : Expanded(
                                            child: ListView.builder(
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
                                                          Expanded(
                                                            child: Text(
                                                              SessionController()
                                                                          .getLanguage() ==
                                                                      1
                                                                  ? _controller
                                                                          .offersDetails
                                                                          .value
                                                                          .offerProperties[
                                                                              index]
                                                                          .propertyName
                                                                          .trim() ??
                                                                      ""
                                                                  : _controller
                                                                          .offersDetails
                                                                          .value
                                                                          .offerProperties[
                                                                              index]
                                                                          .propertyNameAr ??
                                                                      "",
                                                              style: AppTextStyle
                                                                  .normalBlack12,
                                                              maxLines: 2,
                                                            ),
                                                          ),
                                                        ]),
                                                      ],
                                                    ),
                                                  );
                                                }))
                                  ],
                                );
                }),
              )
            ],
          ),
        ));
  }
}
