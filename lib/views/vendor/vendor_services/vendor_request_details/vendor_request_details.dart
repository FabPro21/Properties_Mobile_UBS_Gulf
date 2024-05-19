import 'package:contained_tab_bar_view_with_custom_page_navigator/contained_tab_bar_view_with_custom_page_navigator.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/vendor/vendor_services/vendor_request_details/communication/vendor_communication.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/vendor/vendor_services/vendor_request_details/report/report.dart';
import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../data/helpers/session_controller.dart';
import '../../../widgets/common_widgets/error_text_widget.dart';
import '../../../widgets/common_widgets/loading_indicator_blue.dart';
import 'main_info/main_info.dart';
import 'main_info/main_info_controller.dart';

class VendorRequestDetails extends StatefulWidget {
  final int caseNo;
  final bool status;
  const VendorRequestDetails({Key key, this.caseNo, this.status}) : super(key: key);

  @override
  _VendorRequestDetailsState createState() => _VendorRequestDetailsState();
}

class _VendorRequestDetailsState extends State<VendorRequestDetails> {
  final controller = Get.put(SvcReqMainInfoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: SessionController().getLanguage() == 1
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: Column(
          children: [
            CustomAppBar2(
              title: AppMetaLabels().serviceRequest,
            ),
            Expanded(
              child: Obx(() {
                return controller.loadingData.value == true
                    ? Padding(
                        padding: EdgeInsets.only(top: 10.0.h),
                        child: LoadingIndicatorBlue(),
                      )
                    : controller.error.value != ''
                        ? Padding(
                            padding: EdgeInsets.only(top: 10.0.h),
                            child: AppErrorWidget(
                              errorText: controller.error.value,
                            ),
                          )
                        : Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(2.0.h),
                                child: Row(
                                  children: [
                                    Text(
                                      AppMetaLabels().requestno,
                                      style: AppTextStyle.semiBoldBlack12,
                                    ),
                                    const Spacer(),
                                    Text(
                                      "${widget.caseNo}",
                                      style: AppTextStyle.semiBoldBlack12,
                                    ),
                                  ],
                                ),
                              ),
                              AppDivider(),
                              Expanded(
                                child: ContainedTabBarView(
                                  tabs: [
                                    Tab(text: AppMetaLabels().maininfo),
                                    Tab(
                                        text: AppMetaLabels()
                                            .report
                                            .toUpperCase()),
                                    Tab(text: AppMetaLabels().updatesCapital)
                                  ],
                                  tabBarProperties: TabBarProperties(
                                    height: 5.0.h,
                                    indicatorColor: AppColors.blueColor,
                                    indicatorWeight: 0.2.h,
                                    labelColor: AppColors.blueColor,
                                    unselectedLabelColor: AppColors.blackColor,
                                    labelStyle: AppTextStyle.semiBoldBlack10,
                                  ),
                                  views: [
                                    // 1112233 tab Vendor
                                    // MainInfo
                                    // Report
                                    // Communication
                                    SvcReqMainInfo(),
                                    SvcReqReport(
                                      caseNo: widget.caseNo,
                                      status: widget.status,
                                    ),
                                    VendorCommuncation(
                                      reqNo: widget.caseNo.toString(),
                                      canCommunicate: controller.canCommunicate,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
