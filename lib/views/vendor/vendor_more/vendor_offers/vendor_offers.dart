import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/vendor/vendor_more/vendor_offers/vendor_offers_controller.dart';
import 'package:fap_properties/views/vendor/vendor_more/vendor_offers/vendor_offers_detail.dart';
import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../data/helpers/session_controller.dart';

class VendorOffers extends StatefulWidget {
  const VendorOffers({Key key}) : super(key: key);

  @override
  _VendorOffersState createState() => _VendorOffersState();
}

class _VendorOffersState extends State<VendorOffers> {
  var _controller = Get.put(VendorOffersController());

  @override
  void initState() {
    _controller.getOffers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ************** Note *************** //
    // Must Update for both users Technician and other user
    // based on SessionController().vendorUserType == 'Technician'
    // ************** Note *************** //
    return SessionController().vendorUserType == 'Technician'
        ? Directionality(
            textDirection: SessionController().getLanguage() == 1
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.only(top: 2.0.h),
                  child: Text(AppMetaLabels().offers,
                      style: AppTextStyle.semiBoldWhite14)),
              Expanded(
                child: Obx(() {
                  return _controller.loadingOffers.value
                      ? Center(
                          child: LoadingIndicatorBlue(),
                        )
                      : _controller.length == 0
                          ? CustomErrorWidget(
                              errorText: _controller.errorOffers.value,
                              errorImage: AppImagesPath.noServicesFound,
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(1.0.h),
                              ),
                              margin: EdgeInsets.only(top: 2.h, bottom: 2.h),
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
                                              Get.to(() => VendorOffersDetails(
                                                  offerId: _controller
                                                      .offers
                                                      .value
                                                      .record[index]
                                                      .offerid
                                                      .toString()));
                                            },
                                            child: Row(children: [
                                              Text(
                                                  SessionController()
                                                              .getLanguage() ==
                                                          1
                                                      ? _controller
                                                              .offers
                                                              .value
                                                              .record[index]
                                                              .title ??
                                                          ""
                                                      : _controller
                                                              .offers
                                                              .value
                                                              .record[index]
                                                              .titleAr ??
                                                          "",
                                                  style: AppTextStyle
                                                      .semiBoldBlack13),
                                              Spacer(),
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 2.0.h,
                                                color: AppColors.grey1,
                                              )
                                            ]),
                                          ),
                                        ],
                                      ),
                                    );
                                  }));
                }),
              )
            ]),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            body: Directionality(
              textDirection: SessionController().getLanguage() == 1
                  ? TextDirection.ltr
                  : TextDirection.rtl,
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                CustomAppBar2(
                  title: AppMetaLabels().offers,
                ),
                Expanded(
                  child: Obx(() {
                    return _controller.loadingOffers.value
                        ? Center(
                            child: LoadingIndicatorBlue(),
                          )
                        : _controller.length == 0
                            ? CustomErrorWidget(
                                errorText: _controller.errorOffers.value,
                                errorImage: AppImagesPath.noServicesFound,
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
                                                    VendorOffersDetails(
                                                        offerId: _controller
                                                            .offers
                                                            .value
                                                            .record[index]
                                                            .offerid
                                                            .toString()));
                                              },
                                              child: Row(children: [
                                                Text(
                                                    SessionController()
                                                                .getLanguage() ==
                                                            1
                                                        ? _controller
                                                                .offers
                                                                .value
                                                                .record[index]
                                                                .title ??
                                                            ""
                                                        : _controller
                                                                .offers
                                                                .value
                                                                .record[index]
                                                                .titleAr ??
                                                            "",
                                                    style: AppTextStyle
                                                        .semiBoldBlack13),
                                                Spacer(),
                                                Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  size: 2.0.h,
                                                  color: AppColors.grey1,
                                                )
                                              ]),
                                            ),
                                          ],
                                        ),
                                      );
                                    }));
                  }),
                )
              ]),
            ));
  }
}
