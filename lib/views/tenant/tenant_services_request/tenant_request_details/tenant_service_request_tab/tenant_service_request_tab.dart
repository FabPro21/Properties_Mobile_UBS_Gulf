import 'package:contained_tab_bar_view_with_custom_page_navigator/contained_tab_bar_view_with_custom_page_navigator.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request/tenant_request_list/tenant_request_list_controller.dart';
import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request_details/tenant_request_details.dart';
import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request_details/tenant_service_request_tab/tenant_service_documents.dart';
import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request_details/tenant_service_request_tab/tenent_service_updates.dart';
import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../tenant_request_details_controller.dart';

// 1122 workin in this class
// ignore: must_be_immutable
class TenantServiceRequestTabs extends StatefulWidget {
  final String? requestNo;
  final String? caller;
  final int? initialIndex;
  String? title;
  TenantServiceRequestTabs({
    Key? key,
    this.requestNo,
    this.caller,
    this.title,
    this.initialIndex = 0,
  }) : super(key: key) {
    this.title = AppMetaLabels().serviceRequest;
  }

  @override
  State<TenantServiceRequestTabs> createState() =>
      _TenantServiceRequestTabsState();
}

class _TenantServiceRequestTabsState extends State<TenantServiceRequestTabs> {
  final tenantRDController = Get.put(TenantRequestDetailsController());
  @override
  void initState() {
    tenantRDController.caseNo = int.parse(widget.requestNo??"");
    print('********initState******** ${widget.caller}');
    print(tenantRDController.caseNo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('********build******** ${widget.caller}');
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Obx(() {
        return Scaffold(
            backgroundColor: !tenantRDController.isEnableBackButton.value
                ? Colors.white.withOpacity(0.7)
                : Colors.white,
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                CustomAppBar2(
                  title: widget.title,
                  onBackPressed: !tenantRDController.isEnableBackButton.value
                      ? () {}
                      : () async {
                          if (widget.caller == 'newReq' ||
                              tenantRDController.updatedReq) {
                            var reqListController =
                                Get.find<GetTenantServiceRequestsController>();
                            reqListController.getData();
                          }
                          Get.back();
                        },
                ),
                // Service Request for upload document 112233
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
                        widget.requestNo??"",
                        style: AppTextStyle.semiBoldBlack12,
                      ),
                    ],
                  ),
                ),
                const AppDivider(),
                Expanded(
                  child: Obx(() {
                    return tenantRDController.loadingData.value == true
                        ? LoadingIndicatorBlue()
                        : tenantRDController.error.value != ''
                            ? AppErrorWidget(
                                errorText: tenantRDController.error.value,
                              )
                            : Stack(
                                children: [
                                  ContainedTabBarView(
                                    tabBarViewProperties: TabBarViewProperties(
                                      physics: NeverScrollableScrollPhysics(),
                                    ),
                                    initialIndex: widget.initialIndex??0,
                                    onChange: (index) {
                                      FocusScope.of(context).unfocus();
                                    },
                                    // 112233 Tabs for service request MainInfo,Document,Communiction
                                    // MAIN INFO
                                    // DOCUMENTS
                                    // COMMUNICATION
                                    tabs: [
                                      Tab(text: AppMetaLabels().maininfo),
                                      if (tenantRDController
                                          .tenantRequestDetails
                                          .value
                                          .statusInfo!
                                          .canUploadDocs!)
                                        Tab(
                                            text: AppMetaLabels()
                                                .documentsCapital),
                                      Tab(text: AppMetaLabels().updatesCapital),
                                    ],
                                    tabBarProperties: TabBarProperties(
                                      height: 6.5.h,
                                      indicatorColor: AppColors.blueColor,
                                      indicatorWeight: 0.2.h,
                                      labelColor: AppColors.blueColor,
                                      unselectedLabelColor:
                                          AppColors.blackColor,
                                      labelStyle: AppTextStyle.semiBoldBlack10,
                                    ),
                                    views: [
                                      TenantRequestDetails(
                                        caller: widget.caller??"",
                                        caseNo: widget.requestNo??"0",
                                      ),
                                      if (tenantRDController
                                          .tenantRequestDetails
                                          .value
                                          .statusInfo!
                                          .canUploadDocs!)
                                        TenantServiceDocuments(
                                          caseNo: widget.requestNo??'0',
                                          caller: widget.caller??"",
                                        ),
                                      TenantServiceRequestUpdates(
                                          canCommunicate:
                                              tenantRDController.canCommunicate,
                                          reqNo: widget.requestNo??'0'),
                                    ],
                                  ),
                                  !tenantRDController.isEnableBackButton.value
                                      ? Container(
                                          height: 10.h,
                                          color: Colors.white.withOpacity(0.1),
                                        )
                                      : SizedBox()
                                ],
                              );
                  }),
                ),
              ],
            ));
      }),
    );
  }
}
