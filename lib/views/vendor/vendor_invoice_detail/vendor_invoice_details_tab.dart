// ignore_for_file: must_be_immutable

import 'package:contained_tab_bar_view_with_custom_page_navigator/contained_tab_bar_view_with_custom_page_navigator.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/vendor/vendor_invoice_detail/comunication/coumnication_invoice_details.dart';
import 'package:fap_properties/views/vendor/vendor_invoice_detail/document/document_invoice_details.dart';
import 'package:fap_properties/views/vendor/vendor_invoice_detail/main/main_invoice_details.dart';
import 'package:fap_properties/views/vendor/vendor_invoice_detail/vendor_invoice_details_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class VendorInvoiceRequestTabs extends StatefulWidget {
  final String requestNo;
  final String caller;
  final int initialIndex;
  String title;
  VendorInvoiceRequestTabs({
    Key key,
    this.requestNo,
    this.caller,
    this.title,
    this.initialIndex = 0,
  }) : super(key: key) {
    this.title = title;
  }

  @override
  State<VendorInvoiceRequestTabs> createState() =>
      _VendorInvoiceRequestTabsState();
}

class _VendorInvoiceRequestTabsState extends State<VendorInvoiceRequestTabs> {
  final controller = Get.put(VendorInvoiceDetailsController());
  @override
  void initState() {
    controller.tabIndex.value = widget.initialIndex;
    if (widget.caller == 'Add New Invoice') {
      controller.isEnableInvoiceNo.value = false;
    } else {
      controller.caseNoInvoice = int.parse(widget.requestNo);
      controller.isEnableInvoiceNo.value = true;
    }
    print('downloading ::::: ${widget.requestNo}');
    print(
        'Invoice Value ::: ${controller.isServiceRqTypeRadioButtonVal.value}');
    super.initState();
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  Widget build(BuildContext context) {
    // rebuildAllChildren(context);
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Obx(() {
        return Scaffold(
            backgroundColor: !controller.isEnableBackButton.value
                ? Colors.white.withOpacity(0.7)
                : Colors.white,
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                CustomAppBar2(
                  title: widget.title,
                  onBackPressed: !controller.isEnableBackButton.value
                      ? () {}
                      : () {
                          Get.back();
                        },
                ),
                !controller.isEnableInvoiceNo.value
                    ? SizedBox()
                    : Padding(
                        padding: EdgeInsets.all(2.0.h),
                        child: Row(
                          children: [
                            Text(
                              AppMetaLabels().sRNO,
                              style: AppTextStyle.semiBoldBlack12,
                            ),
                            const Spacer(),
                            Text(
                              controller.caseNoInvoice.toString(),
                              style: AppTextStyle.semiBoldBlack12,
                            ),
                          ],
                        ),
                      ),
                const AppDivider(),
                Expanded(
                  child: Obx(() {
                    return
                        // tenantRDController.loadingData.value == true
                        //     ? LoadingIndicatorBlue()
                        //     :
                        controller.error.value != ''
                            ? AppErrorWidget(
                                errorText: controller.error.value,
                              )
                            : ContainedTabBarView(
                                key: controller.key,
                                tabBarViewProperties: TabBarViewProperties(
                                    physics: NeverScrollableScrollPhysics()),
                                initialIndex: controller.tabIndex.value,
                                //widget.initialIndex,
                                onChange: (index) {
                                  controller
                                      .isServiceRqTypeRadioButtonVal.value = -1;
                                  FocusScope.of(context).unfocus();
                                },
                                // MAIN INFO
                                // DOCUMENTS
                                // COMMUNICATION
                                tabs: [
                                  Tab(text: AppMetaLabels().maininfo),
                                  Tab(text: AppMetaLabels().documentsCapital),
                                  Tab(text: AppMetaLabels().updatesCapital),
                                ],
                                tabBarProperties: TabBarProperties(
                                  height: 6.5.h,
                                  indicatorColor: AppColors.blueColor,
                                  indicatorWeight: 0.2.h,
                                  labelColor: AppColors.blueColor,
                                  unselectedLabelColor: AppColors.blackColor,
                                  labelStyle: AppTextStyle.semiBoldBlack10,
                                ),
                                views: [
                                  VendorInvoiceMainDetails(
                                    caller: widget.caller,
                                    caseNo: widget.requestNo != ''
                                        ? widget.requestNo
                                        : null,
                                  ),
                                  // if (tenantRDController.tenantRequestDetails
                                  //     .value.statusInfo.canUploadDocs)
                                  !controller.isEnableInvoiceNo.value
                                      ? DocumentDumnyWidget()
                                      : VendorInvoiceDocumentsDetails(
                                          caseNo: widget.requestNo,
                                          caller: widget.caller,
                                        ),
                                  !controller.isEnableInvoiceNo.value
                                      ? CommunicationDumnyWidget()
                                      : VendorInvoiceCommunication(
                                          canCommunicate:
                                              controller.isEnableInvoiceNo.value
                                                  ? true
                                                  : false,
                                          reqNo: widget.requestNo),
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

class DocumentDumnyWidget extends StatefulWidget {
  const DocumentDumnyWidget({
    Key key,
  }) : super(key: key);

  @override
  State<DocumentDumnyWidget> createState() => _DocumentDumnyWidgetState();
}

class _DocumentDumnyWidgetState extends State<DocumentDumnyWidget> {
  @override
  void initState() {
    callingDumnyFunc();
    super.initState();
  }

  final controller = Get.find<VendorInvoiceDetailsController>();
  callingDumnyFunc() async {
    await Future.delayed(Duration(seconds: 2));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.tabIndex.value = 0;
    });
    if (controller.callerInvoice == 'Add New Invoice') {
      controller.key.currentState?.animateTo(controller.tabIndex.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: InkWell(
          onTap: () {
            setState(() {
              controller.tabIndex.value = 0;
              controller.isServiceRqTypeRadioButtonVal.value = -1;
            });
            controller.key.currentState?.animateTo(controller.tabIndex.value);
          },
          child: Container(
            height: 100,
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 10, right: 10, bottom: 10),
            margin:
                EdgeInsets.only(top: 2.h, bottom: 3.5.h, left: 20, right: 20),
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 249, 235, 1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(20),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.info,
                  color: Colors.amber[300],
                  size: 22,
                ),
                SizedBox(
                  width: Get.width * 0.03,
                ),
                Container(
                  width: Get.width * 0.66,
                  child: Text(
                    AppMetaLabels().pleaseFillDataInMainInfoFirst,
                    textAlign: TextAlign.justify,
                    style: AppTextStyle.semiBoldGrey12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CommunicationDumnyWidget extends StatefulWidget {
  const CommunicationDumnyWidget({
    Key key,
  }) : super(key: key);

  @override
  State<CommunicationDumnyWidget> createState() =>
      _CommunicationDumnyWidgetState();
}

class _CommunicationDumnyWidgetState extends State<CommunicationDumnyWidget> {
  @override
  void initState() {
    callingDumnyFunc();
    super.initState();
  }

  final controller = Get.find<VendorInvoiceDetailsController>();
  callingDumnyFunc() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.tabIndex.value = 0;
    });
    if (controller.callerInvoice == 'Add New Invoice') {
      controller.key.currentState?.animateTo(controller.tabIndex.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: InkWell(
          onTap: () {
            setState(() {
              controller.tabIndex.value = 0;
              controller.isServiceRqTypeRadioButtonVal.value = -1;
            });
            controller.key.currentState?.animateTo(controller.tabIndex.value);
          },
          child: Container(
            height: 100,
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 10, right: 10, bottom: 10),
            margin:
                EdgeInsets.only(top: 2.h, bottom: 3.5.h, left: 20, right: 20),
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 249, 235, 1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(20),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.info,
                  color: Colors.amber[300],
                  size: 22,
                ),
                SizedBox(
                  width: Get.width * 0.03,
                ),
                Container(
                  width: Get.width * 0.66,
                  child: Text(
                    AppMetaLabels().pleaseFillDataInMainInfoFirst,
                    textAlign: TextAlign.justify,
                    style: AppTextStyle.semiBoldGrey12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
