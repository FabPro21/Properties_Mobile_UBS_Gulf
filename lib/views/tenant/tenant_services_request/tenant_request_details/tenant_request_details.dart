// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/utils/text_validator.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/contracts_with_action/contracts_with_actions_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/common_widgets/status_widget.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_tabs.dart/tenant_contracts_details.dart/tenant_contract_details.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_tabs.dart/tenant_contracts_details.dart/tenant_contracts_detail_controller.dart';
import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request_details/tenant_request_details_controller.dart';
import 'package:fap_properties/views/widgets/bottom_shadow.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';
import 'dart:ui' as ui;
import 'tenant_service_request_tab/take_survey/take_survey.dart';

class TenantRequestDetails extends StatefulWidget {
  final String? caller;
  // here adding for the VACATING AND FROM CONTACT DETAIL
  final String? caseNo;
  TenantRequestDetails({
    Key? key,
    this.caller,
    this.caseNo,
  }) : super(key: key) {
    Get.put(TenantRequestDetailsController());
  }

  @override
  _TenantRequestDetailsState createState() => _TenantRequestDetailsState();
}

class _TenantRequestDetailsState extends State<TenantRequestDetails> {
  final tenantRDController = Get.find<TenantRequestDetailsController>();
  TextEditingController feedbackDescController = TextEditingController();
  ScrollController controller = ScrollController();

  @override
  void initState() {
    tenantRDController.caseNo = int.parse(widget.caseNo!);
    print('**************** In main ${widget.caller}');
    checkIsRenewed();
    print(tenantRDController.caseNo);
    // tenantRDController.getData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      autoScroll();
      print(
          '====> isRenwed Case Main Class ::::::: ${tenantRDController.isContractRenewed}=====>');
    });
    super.initState();
  }

  void checkIsRenewed() {
    if (widget.caller == 'contractRenewed') {
      setState(() {
        tenantRDController.isContractRenewed.value = true;
      });
    }
    //   getDataMain();
    // }else{
    //   getDataMain();
    // }
  }

  getDataMain() async {
    await tenantRDController.getData();
    tenantRDController.getFiles();
  }

  Future<void> autoScroll() async {
    if (tenantRDController
                .tenantRequestDetails.value.statusInfo!.canTakeSurvey! &&
            tenantRDController.showSurveyButton ||
        tenantRDController
            .tenantRequestDetails.value.statusInfo!.canAddFeedback!) {
      await Future.delayed(const Duration(milliseconds: 200));
      controller.jumpTo(controller.position.maxScrollExtent);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    print('**************** In Main Caller build: ${widget.caller}');
    print(
        '**************** In Main Feedback:  ${tenantRDController.feedback.value.feedback}');
    print(
        '**************** In Main Rating:  ${tenantRDController.feedback.value.feedback?.rating}');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: controller,
            child: Obx(() {
              return tenantRDController.loadingData.value == true
                  ? Padding(
                      padding: EdgeInsets.only(top: 10.0.h),
                      child: LoadingIndicatorBlue(),
                    )
                  : tenantRDController.error.value != ''
                      ? AppErrorWidget(
                          errorText: tenantRDController.error.value,
                        )
                      : Container(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 2.0.w,
                                  top: 2.0.h,
                                  right: 2.0.w,
                                  bottom: 2.h),
                              child: Column(children: [
                                // Request Detail Container
                                Container(
                                  width: 100.0.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2.0.h),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 0.5.h,
                                        spreadRadius: 0.1.h,
                                        offset: Offset(0.1.h, 0.1.h),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(2.0.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppMetaLabels().requestDetails,
                                          style: AppTextStyle.semiBoldBlack12,
                                        ),
                                        SizedBox(
                                          height: 1.0.h,
                                        ),
                                        Text(
                                          SessionController().getLanguage() == 1
                                              ? tenantRDController
                                                      .tenantRequestDetails
                                                      .value
                                                      .detail!
                                                      .category ??
                                                  ""
                                              : tenantRDController
                                                      .tenantRequestDetails
                                                      .value
                                                      .detail!
                                                      .categoryAR ??
                                                  "",
                                          style: AppTextStyle.normalGrey10,
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Text(
                                          SessionController().getLanguage() == 1
                                              ? tenantRDController
                                                      .tenantRequestDetails
                                                      .value
                                                      .detail!
                                                      .subCategory ??
                                                  ""
                                              : tenantRDController
                                                      .tenantRequestDetails
                                                      .value
                                                      .detail!
                                                      .subCategoryAR ??
                                                  " ",
                                          style: AppTextStyle.normalGrey10,
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Text(
                                          SessionController().getLanguage() == 1
                                              ? tenantRDController
                                                      .tenantRequestDetails
                                                      .value
                                                      .detail!
                                                      .propertyName ??
                                                  ""
                                              : tenantRDController
                                                      .tenantRequestDetails
                                                      .value
                                                      .detail!
                                                      .propertyNameAr ??
                                                  "",
                                          style: AppTextStyle.normalGrey10,
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Text(
                                          tenantRDController
                                                  .tenantRequestDetails
                                                  .value
                                                  .detail!
                                                  .unitRefNo ??
                                              "",
                                          style: AppTextStyle.semiBoldGrey10,
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              tenantRDController
                                                  .tenantRequestDetails
                                                  .value
                                                  .detail!
                                                  .date!
                                                  .trimLeft()
                                                  .trimRight()
                                                  .replaceAll(' ', '-'),
                                              style: AppTextStyle.normalGrey10,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 2.0.w, right: 2.w),
                                              child: Text(
                                                tenantRDController
                                                        .tenantRequestDetails
                                                        .value
                                                        .detail!
                                                        .time ??
                                                    "",
                                                style:
                                                    AppTextStyle.normalGrey10,
                                              ),
                                            ),
                                            Spacer(),
                                            ConstrainedBox(
                                                constraints: BoxConstraints(
                                                    maxWidth: 55.w),
                                                child: StatusWidget(
                                                  text: SessionController()
                                                              .getLanguage() ==
                                                          1
                                                      ? tenantRDController
                                                              .tenantRequestDetails
                                                              .value
                                                              .detail!
                                                              .status ??
                                                          ""
                                                      : tenantRDController
                                                              .tenantRequestDetails
                                                              .value
                                                              .detail!
                                                              .statusAR ??
                                                          "",
                                                  valueToCompare:
                                                      tenantRDController
                                                              .tenantRequestDetails
                                                              .value
                                                              .detail!
                                                              .status ??
                                                          "",
                                                )),
                                          ],
                                        ),
                                        if (tenantRDController
                                                .tenantRequestDetails
                                                .value
                                                .contractInfo!
                                                .contractno !=
                                            null)
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 1.0.h,
                                              ),
                                              AppDivider(),
                                              SizedBox(
                                                height: 1.0.h,
                                              ),
                                              Text(
                                                AppMetaLabels().contractInfo,
                                                style: AppTextStyle
                                                    .semiBoldBlack12,
                                              ),
                                              SizedBox(
                                                height: 2.0.h,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  SessionController()
                                                      .setContractID(
                                                          tenantRDController
                                                              .tenantRequestDetails
                                                              .value
                                                              .contractInfo!
                                                              .contractId);
                                                  SessionController()
                                                      .setContractNo(
                                                          tenantRDController
                                                              .tenantRequestDetails
                                                              .value
                                                              .contractInfo!
                                                              .contractno);
                                                  Get.to(() =>
                                                      ContractsDetailsTabs(
                                                          prevContractNo:
                                                              null));
                                                },
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      width: 47.0.w,
                                                      child: Text(
                                                        SessionController()
                                                                    .getLanguage() ==
                                                                1
                                                            ? tenantRDController
                                                                    .tenantRequestDetails
                                                                    .value
                                                                    .contractInfo!
                                                                    .propertyName ??
                                                                ''
                                                            : tenantRDController
                                                                    .tenantRequestDetails
                                                                    .value
                                                                    .contractInfo!
                                                                    .propertyNameAr ??
                                                                '',
                                                        style: AppTextStyle
                                                            .semiBoldBlack9,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      "${tenantRDController.tenantRequestDetails.value.contractInfo!.contractno}",
                                                      style: AppTextStyle
                                                          .semiBoldBlack9,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Contact Person Detail
                                Container(
                                    width: 100.0.w,
                                    padding: EdgeInsets.all(2.0.h),
                                    margin: EdgeInsets.only(top: 3.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(2.0.h),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 0.5.h,
                                          spreadRadius: 0.1.h,
                                          offset: Offset(0.1.h, 0.1.h),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppMetaLabels()
                                                .contactPersonDetails,
                                            style: AppTextStyle.semiBoldBlack12,
                                          ),
                                          SizedBox(
                                            height: 2.0.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${AppMetaLabels().name}: ',
                                                style:
                                                    AppTextStyle.normalGrey10,
                                              ),
                                              Spacer(),
                                              Text(
                                                tenantRDController
                                                        .tenantRequestDetails
                                                        .value
                                                        .detail!
                                                        .contactName ??
                                                    '-',
                                                style:
                                                    AppTextStyle.normalGrey10,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${AppMetaLabels().phoneNumber}: ',
                                                style:
                                                    AppTextStyle.normalGrey10,
                                              ),
                                              Spacer(),
                                              Directionality(
                                                textDirection:
                                                    ui.TextDirection.ltr,
                                                child: Text(
                                                  tenantRDController
                                                          .tenantRequestDetails
                                                          .value
                                                          .detail!
                                                          .contactPhone ??
                                                      '-',
                                                  style:
                                                      AppTextStyle.normalGrey10,
                                                ),
                                              )
                                            ],
                                          ),
                                          if (tenantRDController
                                                  .tenantRequestDetails
                                                  .value
                                                  .detail!
                                                  .requestType ==
                                              'FM')
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 1.h),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    '${AppMetaLabels().contactTime}: ',
                                                    style: AppTextStyle
                                                        .normalGrey10,
                                                  ),
                                                  Spacer(),
                                                  Directionality(
                                                    textDirection:
                                                        ui.TextDirection.ltr,
                                                    child: Text(
                                                      tenantRDController
                                                              .tenantRequestDetails
                                                              .value
                                                              .detail!
                                                              .contactTiming ??
                                                          '-',
                                                      style: AppTextStyle
                                                          .normalGrey10,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                        ])),
                                SizedBox(
                                  height:
                                      tenantRDController.report.value.id == null
                                          ? 1.h
                                          : 3.0.h,
                                ),
                                // 112233 showing upload document in tenant
                                // upload service request
                                tenantRDController.report.value.id == null
                                    ? SizedBox()
                                    : Container(
                                        padding: EdgeInsets.all(2.0.h),
                                        width: 100.0.w,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(2.0.h),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 0.5.h,
                                              spreadRadius: 0.1.h,
                                              offset: Offset(0.1.h, 0.1.h),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: 1.0.h,
                                                bottom: 2.0.h,
                                              ),
                                              child: Text(
                                                AppMetaLabels()
                                                    .serviceCompletionReport,
                                                style: AppTextStyle
                                                    .semiBoldBlack12,
                                              ),
                                            ),
                                            Obx(() {
                                              return tenantRDController
                                                      .loadingReport.value
                                                  ? Container(
                                                      height: 9.h,
                                                      alignment:
                                                          Alignment.center,
                                                      margin:
                                                          EdgeInsets.all(0.5.h),
                                                      child:
                                                          LoadingIndicatorBlue(),
                                                    )
                                                  : tenantRDController.report
                                                              .value.id ==
                                                          null
                                                      ? Text(
                                                          AppMetaLabels()
                                                              .noReports,
                                                          style: AppTextStyle
                                                              .normalBlack10,
                                                        )
                                                      : tenantRDController
                                                                  .errorLoadingReport !=
                                                              ''
                                                          ? Center(
                                                              child: SizedBox(
                                                                height: 12.h,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Text(
                                                                      tenantRDController
                                                                          .errorLoadingReport,
                                                                      style: AppTextStyle
                                                                          .semiBoldGrey10,
                                                                    ),
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          tenantRDController
                                                                              .getFiles();
                                                                        },
                                                                        icon: Icon(
                                                                            Icons.refresh))
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          : showReport();
                                            }),
                                          ],
                                        )),
                                SizedBox(height: 2.h),
                                // Description
                                Container(
                                  width: 100.0.w,
                                  margin: EdgeInsets.only(bottom: 1.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2.0.h),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 0.5.h,
                                        spreadRadius: 0.1.h,
                                        offset: Offset(0.1.h, 0.1.h),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(2.0.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppMetaLabels().description,
                                          style: AppTextStyle.semiBoldBlack12,
                                        ),
                                        SizedBox(
                                          height: 1.0.h,
                                        ),
                                        Text(
                                          tenantRDController
                                                  .tenantRequestDetails
                                                  .value
                                                  .detail!
                                                  .description ??
                                              '',
                                          // ' {canTakeSurvey:=> ' +
                                          // tenantRDController
                                          //     .tenantRequestDetails
                                          //     .value
                                          //     .statusInfo
                                          //     .canTakeSurvey
                                          //     .toString() +
                                          // '} showSurveyButton:=> ' +
                                          // tenantRDController
                                          //     .showSurveyButton
                                          //     .toString(),
                                          style: AppTextStyle.normalGrey10,
                                        ),
                                        if (tenantRDController
                                                .tenantRequestDetails
                                                .value
                                                .detail!
                                                .vacatingReason !=
                                            null)
                                          Padding(
                                            padding:
                                                EdgeInsets.only(top: 1.0.h),
                                            child: Text(
                                              AppMetaLabels().vacatingReason +
                                                  tenantRDController
                                                      .tenantRequestDetails
                                                      .value
                                                      .detail!
                                                      .vacatingReason
                                                      .toString(),
                                              style: AppTextStyle.normalGrey10,
                                            ),
                                          ),
                                        if (tenantRDController
                                                .tenantRequestDetails
                                                .value
                                                .detail!
                                                .vacatingDate !=
                                            null)
                                          Padding(
                                            padding:
                                                EdgeInsets.only(top: 1.0.h),
                                            child: Text(
                                              AppMetaLabels().vacatingDate +
                                                  tenantRDController
                                                      .tenantRequestDetails
                                                      .value
                                                      .detail!
                                                      .vacatingDate
                                                      .toString(),
                                              style: AppTextStyle.normalGrey10,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (tenantRDController.tenantRequestDetails
                                        .value.detail!.requestType ==
                                    'FM')
                                  Container(
                                    width: 100.0.w,
                                    margin:
                                        EdgeInsets.only(bottom: 1.h, top: 2.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(2.0.h),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 0.5.h,
                                          spreadRadius: 0.1.h,
                                          offset: Offset(0.1.h, 0.1.h),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(2.0.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppMetaLabels().photos,
                                            style: AppTextStyle.semiBoldBlack12,
                                          ),
                                          Obx(() {
                                            return tenantRDController
                                                    .gettingPhotos.value
                                                ? Container(
                                                    height: 9.h,
                                                    alignment: Alignment.center,
                                                    margin:
                                                        EdgeInsets.all(0.5.h),
                                                    child:
                                                        LoadingIndicatorBlue(),
                                                  )
                                                : tenantRDController
                                                            .errorGettingPhotos !=
                                                        ''
                                                    ? Center(
                                                        child: SizedBox(
                                                          height: 12.h,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                tenantRDController
                                                                    .errorGettingPhotos,
                                                                style: AppTextStyle
                                                                    .semiBoldGrey10,
                                                              ),
                                                              IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    tenantRDController
                                                                        .getPhotos();
                                                                  },
                                                                  icon: Icon(Icons
                                                                      .refresh))
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : GridView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        padding:
                                                            EdgeInsets
                                                                .only(top: 1.h),
                                                        gridDelegate:
                                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                                                maxCrossAxisExtent:
                                                                    25.w,
                                                                childAspectRatio:
                                                                    3 / 2,
                                                                crossAxisSpacing:
                                                                    1.w,
                                                                mainAxisSpacing:
                                                                    1.w),
                                                        itemCount:
                                                            tenantRDController
                                                                .photos.length,
                                                        itemBuilder:
                                                            (BuildContext ctx,
                                                                index) {
                                                          return showImage(
                                                              context, index);
                                                        });
                                          }),
                                        ],
                                      ),
                                    ),
                                  ),

                                Obx(() {
                                  return tenantRDController
                                          .gettingFeedback.value
                                      ? SizedBox()
                                      : tenantRDController
                                                  .errorGettingFeedback !=
                                              ''
                                          ? Center(
                                              child: SizedBox(
                                                height: 12.h,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      tenantRDController
                                                          .errorGettingFeedback,
                                                      style: AppTextStyle
                                                          .semiBoldGrey10,
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          tenantRDController
                                                              .getFeedback();
                                                        },
                                                        icon:
                                                            Icon(Icons.refresh))
                                                  ],
                                                ),
                                              ),
                                            )
                                          : tenantRDController.feedback.value
                                                          .feedback !=
                                                      null &&
                                                  tenantRDController
                                                          .feedback
                                                          .value
                                                          .feedback!
                                                          .rating !=
                                                      0.0
                                              ? Container(
                                                  width: 100.0.w,
                                                  padding:
                                                      EdgeInsets.all(2.0.h),
                                                  margin:
                                                      EdgeInsets.only(top: 2.h),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.0.h),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black12,
                                                        blurRadius: 0.5.h,
                                                        spreadRadius: 0.1.h,
                                                        offset: Offset(
                                                            0.1.h, 0.1.h),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          AppMetaLabels()
                                                              .feedback,
                                                          style: AppTextStyle
                                                              .semiBoldBlack12,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 2.0.h),
                                                          child:
                                                              SmoothStarRating(
                                                            color: AppColors
                                                                .blueColor,
                                                            borderColor:
                                                                AppColors
                                                                    .blueColor,
                                                            rating: tenantRDController
                                                                    .feedback
                                                                    .value
                                                                    .feedback!
                                                                    .rating ??
                                                                0,
                                                            // isReadOnly: true,
                                                            size: 4.0.h,
                                                            filledIconData:
                                                                Icons.star,
                                                            halfFilledIconData:
                                                                Icons.star_half,
                                                            defaultIconData:
                                                                Icons
                                                                    .star_border,
                                                            starCount: 5,
                                                            allowHalfRating:
                                                                true,
                                                            spacing: 2.0.w,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 2.0.h,
                                                        ),
                                                        Text(
                                                          tenantRDController
                                                                  .feedback
                                                                  .value
                                                                  .feedback!
                                                                  .description ??
                                                              '',
                                                          style: AppTextStyle
                                                              .normalBlack10,
                                                        ),
                                                      ]),
                                                )
                                              : SizedBox();
                                }),
                                if (tenantRDController.tenantRequestDetails
                                        .value.statusInfo!.canCancel! &&
                                    tenantRDController.tenantRequestDetails
                                            .value.stageInfo!.stageId! <
                                        4)
                                  Padding(
                                      padding: EdgeInsets.only(top: 2.h),
                                      child: SizedBox(
                                        width: 90.0.w,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(1.3.h),
                                            ),
                                            backgroundColor:
                                                Color.fromRGBO(255, 36, 27, 1),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 6.0.h,
                                                vertical: 1.8.h),
                                          ),
                                          onPressed: () {
                                            showCancelSvcReqDialog(context);
                                            // Get.to(() => TenantFeedback());
                                          },
                                          child: Text(
                                            AppMetaLabels().cancelRequest,
                                            style: AppTextStyle.semiBoldWhite12,
                                          ),
                                        ),
                                      )),

                                // IF COMING ON THIS SCREEN FROM contractRenewed (means contract flow)
                                // then we will check feedback and rating
                                if (widget.caller == 'contractRenewed')
                                  if (tenantRDController
                                                  .feedback.value.feedback ==
                                              null &&
                                          tenantRDController.feedback.value
                                                  .feedback?.rating ==
                                              0.0 ||
                                      tenantRDController.feedback.value.feedback
                                              ?.rating ==
                                          null)
                                    Container(
                                      height: 6.5.h,
                                      width: 90.0.w,
                                      margin: EdgeInsets.only(top: 2.h),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          FocusScope.of(context).unfocus();
                                          setState(() {
                                            tenantRDController.rating = 0;
                                            feedbackDescController.text = '';
                                          });
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor:
                                                    Colors.transparent,
                                                content: FeedbackWidget(
                                                  tenantRDController:
                                                      tenantRDController,
                                                  feedbackDescController:
                                                      feedbackDescController,
                                                  context: context,
                                                ),
                                              );
                                            },
                                          );
                                          setState(() {});
                                        },
                                        child: Text(
                                          AppMetaLabels().addFeedback,
                                          style: AppTextStyle.semiBoldWhite12,
                                        ),
                                        style: ButtonStyle(
                                            elevation: MaterialStateProperty
                                                .all<double>(0.0),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(AppColors.blueColor),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.0.w)),
                                            )),
                                      ),
                                    ),

                                // if (widget.caller == 'contractRenewed')
                                //   if (tenantRDController.tenantRequestDetails
                                //           .value.statusInfo.canTakeSurvey &&
                                //       tenantRDController.showSurveyButton)
                                //     Container(
                                //       height: 6.5.h,
                                //       width: 90.0.w,
                                //       margin: EdgeInsets.only(top: 2.h),
                                //       child: ElevatedButton(
                                //         onPressed: () {
                                //           Get.to(() => TakeSurvey(
                                //                 reqNo: tenantRDController
                                //                     .tenantRequestDetails
                                //                     .value
                                //                     .detail!
                                //                     .caseNo,
                                //                 catId: tenantRDController
                                //                     .tenantRequestDetails
                                //                     .value
                                //                     .detail!
                                //                     .caseCategouryId,
                                //               ));
                                //         },
                                //         child: Text(
                                //           AppMetaLabels().takeSurvey,
                                //           style: AppTextStyle.semiBoldWhite12,
                                //         ),
                                //         style: ButtonStyle(
                                //             elevation: MaterialStateProperty
                                //                 .all<double>(0.0),
                                //             backgroundColor:
                                //                 MaterialStateProperty.all<
                                //                     Color>(AppColors.blueColor),
                                //             shape: MaterialStateProperty.all<
                                //                 RoundedRectangleBorder>(
                                //               RoundedRectangleBorder(
                                //                 borderRadius:
                                //                     BorderRadius.circular(
                                //                         2.0.w),
                                //                 // side: BorderSide(
                                //                 //   color: AppColors.blueColor,
                                //                 //   width: 1.0,
                                //                 // )
                                //               ),
                                //             )),
                                //       ),
                                //     ),

                                // IF  NOT COMING ON THIS SCREEN FROM contractRenewed (means contract flow)
                                // then we will check only canAddFeedback
                                if (widget.caller != 'contractRenewed')
                                  if (tenantRDController.tenantRequestDetails
                                      .value.statusInfo!.canAddFeedback!)
                                    Container(
                                      height: 6.5.h,
                                      width: 90.0.w,
                                      margin: EdgeInsets.only(top: 2.h),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          FocusScope.of(context).unfocus();
                                          setState(() {
                                            tenantRDController.rating = 0;
                                            feedbackDescController.text = '';
                                          });
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor:
                                                    Colors.transparent,
                                                content: FeedbackWidget(
                                                  tenantRDController:
                                                      tenantRDController,
                                                  feedbackDescController:
                                                      feedbackDescController,
                                                  context: context,
                                                ),
                                              );
                                            },
                                          );
                                          setState(() {});
                                        },
                                        child: Text(
                                          AppMetaLabels().addFeedback,
                                          style: AppTextStyle.semiBoldWhite12,
                                        ),
                                        style: ButtonStyle(
                                            elevation: MaterialStateProperty
                                                .all<double>(0.0),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(AppColors.blueColor),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.0.w)),
                                            )),
                                      ),
                                    ),

                                // if (widget.caller != 'contractRenewed')
                                //   if (tenantRDController.tenantRequestDetails
                                //           .value.statusInfo.canTakeSurvey &&
                                //       tenantRDController.showSurveyButton)
                                //     Container(
                                //       height: 6.5.h,
                                //       width: 90.0.w,
                                //       margin: EdgeInsets.only(top: 2.h),
                                //       child: ElevatedButton(
                                //         onPressed: () {
                                //           Get.to(() => TakeSurvey(
                                //                 reqNo: tenantRDController
                                //                     .tenantRequestDetails
                                //                     .value
                                //                     .detail!
                                //                     .caseNo,
                                //                 catId: tenantRDController
                                //                     .tenantRequestDetails
                                //                     .value
                                //                     .detail!
                                //                     .caseCategouryId,
                                //               ));
                                //         },
                                //         child: Text(
                                //           AppMetaLabels().takeSurvey,
                                //           style: AppTextStyle.semiBoldWhite12,
                                //         ),
                                //         style: ButtonStyle(
                                //             elevation: MaterialStateProperty
                                //                 .all<double>(0.0),
                                //             backgroundColor:
                                //                 MaterialStateProperty.all<
                                //                     Color>(AppColors.blueColor),
                                //             shape: MaterialStateProperty.all<
                                //                 RoundedRectangleBorder>(
                                //               RoundedRectangleBorder(
                                //                 borderRadius:
                                //                     BorderRadius.circular(
                                //                         2.0.w),
                                //                 // side: BorderSide(
                                //                 //   color: AppColors.blueColor,
                                //                 //   width: 1.0,
                                //                 // )
                                //               ),
                                //             )),
                                //       ),
                                //     ),
                                // old One
                                // if (tenantRDController.tenantRequestDetails
                                //     .value.statusInfo.canAddFeedback)
                                //   Container(
                                //     height: 6.5.h,
                                //     width: 90.0.w,
                                //     margin: EdgeInsets.only(top: 2.h),
                                //     child: ElevatedButton(
                                //       onPressed: () {
                                //         FocusScope.of(context).unfocus();
                                //         showDialog(
                                //             context: context,
                                //             builder: (BuildContext context) {
                                //               return AlertDialog(
                                //                   contentPadding:
                                //                       EdgeInsets.fromLTRB(1.0.w,
                                //                           1.0.h, 1.0.w, 1.0.h),
                                //                   backgroundColor:
                                //                       Colors.transparent,
                                //                   content: showFeedbackField());
                                //             });
                                //       },
                                //       child: Text(
                                //         AppMetaLabels().addFeedback,
                                //         style: AppTextStyle.semiBoldWhite12,
                                //       ),
                                //       style: ButtonStyle(
                                //           elevation:
                                //               MaterialStateProperty.all<double>(
                                //                   0.0),
                                //           backgroundColor:
                                //               MaterialStateProperty.all<Color>(
                                //                   AppColors.blueColor),
                                //           shape: MaterialStateProperty.all<
                                //               RoundedRectangleBorder>(
                                //             RoundedRectangleBorder(
                                //                 borderRadius:
                                //                     BorderRadius.circular(
                                //                         2.0.w)),
                                //           )),
                                //     ),
                                //   ),

                                if (tenantRDController.tenantRequestDetails
                                        .value.statusInfo!.canTakeSurvey! &&
                                    tenantRDController.showSurveyButton)
                                  Container(
                                    height: 6.5.h,
                                    width: 90.0.w,
                                    margin: EdgeInsets.only(top: 2.h),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.to(() => TakeSurvey(
                                              reqNo: tenantRDController
                                                  .tenantRequestDetails
                                                  .value
                                                  .detail!
                                                  .caseNo,
                                              catId: tenantRDController
                                                  .tenantRequestDetails
                                                  .value
                                                  .detail!
                                                  .caseCategouryId,
                                            ));
                                      },
                                      child: Text(
                                        AppMetaLabels().takeSurvey,
                                        style: AppTextStyle.semiBoldWhite12,
                                      ),
                                      style: ButtonStyle(
                                          elevation:
                                              MaterialStateProperty.all<double>(
                                                  0.0),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  AppColors.blueColor),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(2.0.w),
                                              // side: BorderSide(
                                              //   color: AppColors.blueColor,
                                              //   width: 1.0,
                                              // )
                                            ),
                                          )),
                                    ),
                                  ),

                                SizedBox(
                                  height: 2.h,
                                )
                              ]),
                            ),
                          ),
                        );
            }),
          ),
          BottomShadow(),
        ],
      ),
    );
  }

  Widget showReport() {
    return InkWell(
      onTap: () {
        tenantRDController.showReport();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AppImagesPath.pdfimg,
            width: 6.5.h,
            height: 6.5.h,
            fit: BoxFit.contain,
          ),
          Padding(
            padding: EdgeInsets.only(left: 3.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tenantRDController.report.value.name ??
                      AppMetaLabels().report,
                  style: AppTextStyle.semiBoldBlue11,
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Text(
                  tenantRDController.report.value.size ?? '',
                  style: AppTextStyle.normalGrey9,
                ),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  AwesomeDialog showCancelSvcReqDialog(BuildContext context) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.noHeader,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(2.0.h),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 36, 27, 0.1),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(1.7.h),
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.red,
                    size: 3.5.h,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(2.0.h),
              child: Text(
                AppMetaLabels().areYouSure,
                style: AppTextStyle.semiBoldBlack12,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      dialogBorderRadius: BorderRadius.circular(2.0.h),
      btnOk: Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(1.0.h),
              child: Obx(() {
                return tenantRDController.cancellingRequest.value
                    ? LoadingIndicatorBlue()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1.3.h),
                          ),
                          backgroundColor: Color.fromRGBO(255, 36, 27, 1),
                          padding: EdgeInsets.symmetric(
                              horizontal: 11.0.h, vertical: 1.8.h),
                        ),
                        onPressed: () async {
                          bool cancelled =
                              await tenantRDController.cancelRequest();
                          if (cancelled) {
                            Get.back();
                            if (widget.caller == 'contract') {
                              final contractController =
                                  Get.find<GetContractsDetailsController>();
                              contractController.getData();
                            }
                            final contractsWithActionsController =
                                Get.put(ContractsWithActionsController());
                            contractsWithActionsController.getContracts();
                          }
                        },
                        child: Text(
                          AppMetaLabels().yes,
                          style: AppTextStyle.semiBoldWhite11,
                        ),
                      );
              }),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(1.0.h),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    width: 0.2.w,
                    color: Color.fromRGBO(0, 61, 166, 1),
                    style: BorderStyle.solid,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(1.3.h),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 9.0.h, vertical: 1.7.h),
                  child: Text(
                    AppMetaLabels().no,
                    style: AppTextStyle.semiBoldWhite12.copyWith(
                      color: Color.fromRGBO(0, 61, 166, 1),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    )..show();
  }

  Widget showImage(BuildContext context, int index) {
    return InkWell(
      onTap: tenantRDController.photos[index] == null
          ? () {
              _showPicker(context);
            }
          : null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(1.h),
        child: Container(
          color: Color.fromRGBO(246, 248, 249, 1),
          child: tenantRDController.photos[index] != null
              ? Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        showBigPhoto(context, index);
                      },
                      child: tenantRDController.photos[index]!.source != null
                          ? Image.asset(
                              AppImagesPath.thumbnail,
                              width: 22.0.w,
                              height: 10.0.h,
                              fit: BoxFit.cover,
                              errorBuilder: (context, object, stackTrace) {
                                return Container(
                                  width: 22.0.w,
                                  height: 10.0.h,
                                  color: Colors.red[100],
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                );
                              },
                            )
                          // ? Image.network(
                          //     tenantRDController.photos[index].source,
                          //     width: 22.0.w,
                          //     height: 10.0.h,
                          //     fit: BoxFit.cover,
                          //     errorBuilder: (context, object, stackTrace) {
                          //       return Container(
                          //         width: 22.0.w,
                          //         height: 10.0.h,
                          //         color: Colors.red[100],
                          //         alignment: Alignment.center,
                          //         child: Icon(
                          //           Icons.error,
                          //           color: Colors.red,
                          //         ),
                          //       );
                          //     },
                          //   )
                          : Image.memory(
                              tenantRDController.photos[index]!.file!,
                              width: 22.0.w,
                              height: 10.0.h,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Obx(() {
                      return tenantRDController
                                  .photos[index]!.uploading.value ||
                              tenantRDController.photos[index]!.errorUploading
                          ? Container(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              alignment: Alignment.center,
                              child: tenantRDController
                                      .photos[index]!.uploading.value
                                  ? LoadingIndicatorBlue(
                                      size: 20,
                                    )
                                  : tenantRDController
                                          .photos[index]!.errorUploading
                                      ? IconButton(
                                          onPressed: () {
                                            tenantRDController
                                                .uploadPhoto(index);
                                          },
                                          icon: Icon(
                                            Icons.refresh_outlined,
                                            color: Colors.red,
                                          ),
                                        )
                                      : null)
                          : tenantRDController.tenantRequestDetails.value
                                  .statusInfo!.canCancel!
                              ? InkWell(
                                  onTap: () {
                                    _showDeletePhotoOptions(context, index);
                                  },
                                  child: Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromRGBO(255, 255, 255, 0.5),
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                    padding: EdgeInsets.all(2),
                                    child: tenantRDController
                                            .photos[index]!.removing.value
                                        ? LoadingIndicatorBlue(
                                            size: 20,
                                          )
                                        : Icon(
                                            tenantRDController.photos[index]!
                                                    .errorRemoving
                                                ? Icons.refresh_outlined
                                                : Icons.cancel_outlined,
                                            color: Colors.red),
                                  ),
                                )
                              : SizedBox();
                    }),
                  ],
                )
              : Center(
                  child: Text(
                    "+",
                    style: AppTextStyle.semiBoldWhite16
                        .copyWith(color: Color.fromRGBO(180, 180, 180, 1)),
                  ),
                ),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Directionality(
            textDirection: SessionController().getLanguage() == 1
                ? ui.TextDirection.ltr
                : ui.TextDirection.rtl,
            child: SafeArea(
              child: Container(
                color: Colors.white,
                child: new Wrap(
                  children: <Widget>[
                    new ListTile(
                        leading: new Icon(Icons.photo_library),
                        title: new Text(AppMetaLabels().photoLibrary),
                        onTap: () {
                          print(':::::::::::""""""""":::::::::::::::::');
                          tenantRDController.pickPhoto(ImageSource.gallery);
                          Navigator.of(context).pop();
                        }),
                    new ListTile(
                      leading: new Icon(Icons.photo_camera),
                      title: new Text(AppMetaLabels().camera),
                      onTap: () {
                        tenantRDController.pickPhoto(ImageSource.camera);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _showDeletePhotoOptions(context, index) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Directionality(
            textDirection: SessionController().getLanguage() == 1
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: SafeArea(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(12),
                child: Wrap(
                  children: <Widget>[
                    Text(
                      AppMetaLabels().wantremovephoto,
                      style: AppTextStyle.normalBlack12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 3.h, horizontal: 2.5.w),
                          height: 5.h,
                          width: 40.w,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1.3.h),
                              ),
                              backgroundColor: Color.fromRGBO(255, 36, 27, 1),
                            ),
                            onPressed: () {
                              tenantRDController.removePhoto(index);
                              Navigator.pop(context);
                            },
                            child: Text(
                              AppMetaLabels().remove,
                              style: AppTextStyle.semiBoldWhite10,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 3.h, horizontal: 2.5.w),
                          height: 5.h,
                          width: 40.w,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1.3.h),
                              ),
                              backgroundColor: AppColors.blueColor,
                            ),
                            child: Text(
                              AppMetaLabels().cancel,
                              style: AppTextStyle.semiBoldWhite10,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Column uploadReport() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Obx(() {
        return tenantRDController.editingReport.value
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: 5.h, height: 5.h, child: LoadingIndicatorBlue()),
              )
            : tenantRDController.errorEditingReport
                ? IconButton(
                    onPressed: () {
                      tenantRDController.uploadReport();
                    },
                    icon: Icon(
                      Icons.refresh,
                      size: 4.5.h,
                      color: Colors.red,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      tenantRDController.pickReport();
                    },
                    icon: Image.asset(
                      AppImagesPath.downloadimg,
                      width: 4.5.h,
                      height: 4.5.h,
                      fit: BoxFit.contain,
                    ),
                  );
      }),
      Text(
        AppMetaLabels().uploadReport,
        style: AppTextStyle.semiBoldBlack10,
      ),
      SizedBox(
        height: 1.5.h,
      ),
      Text(
        AppMetaLabels().fileMustNot,
        style: AppTextStyle.normalGrey9,
      ),
    ]);
  }

  showBigPhoto(BuildContext context, int index) {
    if (tenantRDController.photos[index]!.file == null)
      tenantRDController.downloadDoc(index);
    showDialog(
        context: context,
        builder: (context) {
          return Material(
            child: Center(
              child: Stack(
                children: [
                  Container(
                    color: Colors.white,
                    width: 100.w,
                    height: 80.h,
                    child: Obx(() {
                      return ZoomOverlay(
                          minScale: 0.5, // Optional
                          maxScale: 3.0, // Optional
                          twoTouchOnly: true, // Defaults to false
                          child: tenantRDController
                                  .photos[index]!.downloading.value
                              ? LoadingIndicatorBlue()
                              : tenantRDController
                                      .photos[index]!.errorDownloading
                                  ? AppErrorWidget(
                                      errorText: tenantRDController
                                              .photos[index]!.errorText ??
                                          "",
                                      onRetry: () {
                                        tenantRDController.downloadDoc(index);
                                      },
                                    )
                                  : Image.memory(
                                      tenantRDController.photos[index]!.file!));
                    }),
                  ),
                  Container(
                    padding: EdgeInsets.all(0.5.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.grey[100]),
                    child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.cancel)),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class FeedbackWidget extends StatefulWidget {
  const FeedbackWidget({
    super.key,
    required this.tenantRDController,
    required this.feedbackDescController,
    required this.context,
  });

  final TenantRequestDetailsController tenantRDController;
  final TextEditingController feedbackDescController;
  final BuildContext context;

  @override
  State<FeedbackWidget> createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.only(
              left: 0.5.w, right: 0.5.w, top: 3.0.w, bottom: 3.0.w),
          height: 60.0.h,
          width: 90.w,
          // width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2.0.h),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 0.5.h,
                spreadRadius: 0.3.h,
                offset: Offset(0.1.h, 0.1.h),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Directionality(
              textDirection: SessionController().getLanguage() == 1
                  ? ui.TextDirection.ltr
                  : ui.TextDirection.rtl,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 0.5.w,
                        right: 0.5.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppMetaLabels().rateExperience,
                            style: AppTextStyle.semiBoldBlack12,
                          ),
                          InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.cancel_outlined,
                                size: 3.0.h,
                                color: AppColors.greyColor,
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 0.5.w,
                        right: 0.5.w,
                      ),
                      child: Align(
                        alignment: SessionController().getLanguage() == 1
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Text(
                          AppMetaLabels().areyouSatisfied,
                          style: AppTextStyle.normalBlack10,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4.0.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 1.0.w, right: 1.0.w),
                      child: SmoothStarRating(
                        color: AppColors.blueColor,
                        borderColor: AppColors.blueColor,
                        rating: widget.tenantRDController.rating,
                        // isReadOnly: false,
                        size: 10.0.w,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        starCount: 5,
                        allowHalfRating: true,
                        spacing: 2.0.w,
                        onRatingChanged: (value) {
                          print('Value ::::***::::::: $value');
                          setState(() {
                            widget.tenantRDController.rating = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 1.5.w,
                        right: 1.5.w,
                      ),
                      child: Align(
                        alignment: SessionController().getLanguage() == 1
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Text(
                          AppMetaLabels().tellUs,
                          style: AppTextStyle.semiBoldBlack10
                              .copyWith(color: AppColors.renewelgreyclr1),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 1.5.w,
                        right: 1.5.w,
                      ),
                      child: SizedBox(
                        height: 12.0.h,
                        width: 99.0.w,
                        child: Form(
                          key: formKey,
                          child: TextFormField(
                            maxLines: 3,
                            textAlign: TextAlign.start,
                            controller: widget.feedbackDescController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8),
                              hintText: AppMetaLabels().enterRemarks,
                              hintStyle: AppTextStyle.normalGrey9,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            validator: (value) {
                              var feedBack = value;
                              feedBack = feedBack!.replaceAll('\n', ' ');
                              print('FeedBack :::: $feedBack');
                              if (feedBack.isEmpty) {
                                return AppMetaLabels().requiredField;
                              } else if (!textValidator
                                  .hasMatch(feedBack.replaceAll('\n', ' '))) {
                                return AppMetaLabels().invalidText;
                              } else if (feedBack.trim().isEmpty == true) {
                                return AppMetaLabels().invalidText;
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 2.0.h,
                        left: 1.5.w,
                        right: 1.5.w,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 6.0.h,
                          width: 65.0.w,
                          child: Obx(() {
                            return widget
                                    .tenantRDController.addingFeedback.value
                                ? LoadingIndicatorBlue()
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(1.3.h),
                                      ),
                                      backgroundColor:
                                          Color.fromRGBO(0, 61, 166, 1),
                                    ),
                                    onPressed: () async {
                                      if (widget.tenantRDController.rating ==
                                          0) {
                                        SnakBarWidget.getSnackBarErrorBlue(
                                            AppMetaLabels().alert,
                                            AppMetaLabels().selectRating);
                                      } else if (formKey.currentState!
                                          .validate()) {
                                        if (await widget.tenantRDController
                                            .addFeedback(widget
                                                .feedbackDescController
                                                .text)) Navigator.pop(context);
                                      }
                                    },
                                    child: Text(
                                      AppMetaLabels().submit,
                                      style: AppTextStyle.semiBoldWhite12,
                                    ),
                                  );
                          }),
                        ),
                      ),
                    ),
                  ]),
            ),
          )),
    );
  }
}
