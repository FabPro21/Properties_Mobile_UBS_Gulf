import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/tenant/tenant_more/tenant_offers/tanant_offers_controller.dart';
import 'package:fap_properties/views/tenant/tenant_more/tenant_offers/tenant_offers_detail.dart';
import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../data/helpers/session_controller.dart';

class TenantOffers extends StatefulWidget {
  const TenantOffers({Key? key}) : super(key: key);

  @override
  _TenantOffersState createState() => _TenantOffersState();
}

TenantOffersController _controller = Get.put(TenantOffersController());

class _TenantOffersState extends State<TenantOffers> {
  @override
  void initState() {
    _controller.getOffers(_controller.pagaNo);
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
            CustomAppBar2(
              title: AppMetaLabels().offers,
              onBackPressed: () {
                setState(() {
                  _controller.pagaNo = '1';
                });
                Get.back();
              },
            ),
            Expanded(
              child: Obx(() {
                return _controller.loadingOffers.value
                    ? LoadingIndicatorBlue()
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
                                        left: 5.0.w, top: 3.0.h, right: 5.0.w),
                                    child: Directionality(
                                      textDirection:
                                          SessionController().getLanguage() == 1
                                              ? TextDirection.ltr
                                              : TextDirection.rtl,
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.to(() => TenantOffersDetails(
                                                  offerId: _controller
                                                      .offers
                                                      .value
                                                      .record![index]
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
                                                              .record![index]
                                                              .title ??
                                                          ""
                                                      : _controller
                                                              .offers
                                                              .value
                                                              .record![index]
                                                              .titleAr  ??
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
                                    ),
                                  );
                                }));
              }),
            ),
            SizedBox(
              height: 1.0.h,
            ),
            _controller.length < 20
                ? SizedBox()
                : Center(
                    child: Obx(() {
                      return _controller.errorDetailsMore.value != ''
                          ? Text(
                              AppMetaLabels().noMoreData,
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            )
                          : _controller.length < 20
                              ? SizedBox()
                              : _controller.loadingDetailsMore.value
                                  ? SizedBox(
                                      width: 75.w,
                                      height: 5.h,
                                      child: Center(
                                        child: LoadingIndicatorBlue(),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () async {
                                        int pageSize =
                                            int.parse(_controller.pagaNo);
                                        int newPageNo = pageSize + 1;
                                        _controller.pagaNo =
                                            newPageNo.toString();
                                        _controller
                                            .getOffers(_controller.pagaNo);
                                        setState(() {});
                                      },
                                      child: SizedBox(
                                          width: 75.w,
                                          height: 3.h,
                                          child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: AppMetaLabels()
                                                      .loadMoreData,
                                                  style: TextStyle(
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: 15,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    );
                    }),
                  ),
            _controller.length == 0
                ? SizedBox()
                : SizedBox(
                    height: 2.0.h,
                  ),
          ]),
        ));
  }
}
