// ignore_for_file: deprecated_member_use

import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/contract_renewel/renew_contract_controller.dart';
import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request_details/tenant_service_request_tab/tenant_service_request_tab.dart';
import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ContractRenewel extends StatefulWidget {
  final String? contractNo;
  final int? contractId;
  final String? caller;
  final int? dueActionid;
  const ContractRenewel(
      {Key? key,
      this.contractId,
      this.contractNo,
      this.caller,
      this.dueActionid = 0})
      : super(key: key);

  @override
  _ContractRenewelState createState() => _ContractRenewelState();
}

class _ContractRenewelState extends State<ContractRenewel> {
  final controller = Get.put(RenewContractController());

  bool? isDialogOpen;
  bool isEnableSubmitButton = true;

  @override
  void initState() {
    isDialogOpen = false;
    controller.getContractRenewalInfo(widget.contractId ?? 0);
    super.initState();
  }

  double? amount;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: WillPopScope(
        onWillPop: () async {
          if (isDialogOpen!) Get.back();
          return true;
        },
        child: Scaffold(
            backgroundColor: AppColors.greyBG,
            body: SingleChildScrollView(
              child: Container(
                height: 100.h,
                child: Column(children: [
                  CustomAppBar2(
                    title: AppMetaLabels().renew,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 0.5.h,
                          spreadRadius: 0.3.h,
                          offset: Offset(0.1.h, 0.1.h),
                        ),
                      ],
                    ),
                    height: 8.0.h,
                    child: Padding(
                      padding: EdgeInsets.only(left: 6.0.w, right: 6.0.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppMetaLabels().contractNo,
                            style: AppTextStyle.semiBoldBlack12,
                          ),
                          Text(
                            widget.contractNo ?? '0',
                            style: AppTextStyle.semiBoldBlack12,
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 2.5.h, left: 6.0.w, right: 6.0.w),
                    child: Align(
                      alignment: SessionController().getLanguage() == 1
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Text(
                        AppMetaLabels().renewalReq,
                        style: AppTextStyle.semiBoldBlack12,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.5.h,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                          width: 89.0.w,
                          height: 72.h,
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
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: 4.0.w,
                                  top: 2.5.h,
                                  bottom: 2.5.h,
                                  right: 4.0.w),
                              child: Obx(() {
                                return controller.loadingRenewalInfo.value
                                    ? LoadingIndicatorBlue()
                                    : controller.errorLoadingInfo != ''
                                        ? AppErrorWidget(
                                            errorText:
                                                controller.errorLoadingInfo,
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      AppMetaLabels().startDate,
                                                      style: AppTextStyle
                                                          .normalBlack10
                                                          .copyWith(
                                                              color: AppColors
                                                                  .renewelgreyclr)),
                                                  Text(
                                                      controller
                                                              .renewalInfo
                                                              ?.record
                                                              ?.addNewDate ??
                                                          '',
                                                      style: AppTextStyle
                                                          .semiBoldGrey9
                                                          .copyWith(
                                                              color: AppColors
                                                                  .renewelgreyclr))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 1.0.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(AppMetaLabels().endDate,
                                                      style: AppTextStyle
                                                          .normalBlack10
                                                          .copyWith(
                                                              color: AppColors
                                                                  .renewelgreyclr)),
                                                  Text(
                                                      controller
                                                              .renewalInfo
                                                              ?.record
                                                              ?.endNewDate ??
                                                          '',
                                                      style: AppTextStyle
                                                          .semiBoldGrey9
                                                          .copyWith(
                                                              color: AppColors
                                                                  .renewelgreyclr))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 1.0.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      AppMetaLabels()
                                                          .noofInstalments,
                                                      style: AppTextStyle
                                                          .normalBlack10
                                                          .copyWith(
                                                              color: AppColors
                                                                  .renewelgreyclr)),
                                                  Text(
                                                      controller
                                                              .renewalInfo
                                                              ?.record
                                                              ?.installments
                                                              .toString() ??
                                                          '',
                                                      style: AppTextStyle
                                                          .semiBoldGrey9
                                                          .copyWith(
                                                              color: AppColors
                                                                  .renewelgreyclr))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              controller.renewalInfo?.record
                                                          ?.emirateName
                                                          ?.toLowerCase()
                                                          .trim() ==
                                                      'dubai'
                                                  ? SizedBox()
                                                  : controller
                                                                  .renewalInfo
                                                                  ?.record
                                                                  ?.amount ==
                                                              '0' ||
                                                          controller
                                                                  .renewalInfo
                                                                  ?.record
                                                                  ?.amount ==
                                                              '0.00' ||
                                                          controller
                                                                  .renewalInfo
                                                                  ?.record
                                                                  ?.amount ==
                                                              null
                                                      ? SizedBox()
                                                      : Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 2.5.h),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                AppMetaLabels()
                                                                    .contractAmount,
                                                                style: AppTextStyle
                                                                    .semiBoldBlack10,
                                                              ),
                                                              Text(
                                                                '${AppMetaLabels().aed} ${controller.renewalInfo?.record?.amount}',
                                                                style: AppTextStyle
                                                                    .semiBoldBlack10,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 3.h),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.only(
                                                      top: 10,
                                                      right: 10,
                                                      bottom: 10,
                                                      left: 5),
                                                  margin: EdgeInsets.only(
                                                      top: 0.5.h,
                                                      left: 5,
                                                      right: 5),
                                                  decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          255, 249, 235, 1),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(20),
                                                        bottomRight:
                                                            Radius.circular(0),
                                                        topLeft:
                                                            Radius.circular(0),
                                                        topRight:
                                                            Radius.circular(20),
                                                      )),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.info,
                                                        color:
                                                            Colors.amber[300],
                                                        size: 22,
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * 0.02,
                                                      ),
                                                      Container(
                                                        width: Get.width * 0.63,
                                                        child: Text(
                                                          AppMetaLabels()
                                                              .succesfullSubmissionRenewalRequest,
                                                          textAlign:
                                                              TextAlign.justify,
                                                          style: AppTextStyle
                                                              .normalBlack12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 3.h),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.only(
                                                      top: 10,
                                                      right: 10,
                                                      bottom: 10,
                                                      left: 5),
                                                  margin: EdgeInsets.only(
                                                      top: 0.5.h,
                                                      left: 5,
                                                      right: 5),
                                                  decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 210, 229, 244),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(20),
                                                        bottomRight:
                                                            Radius.circular(0),
                                                        topLeft:
                                                            Radius.circular(0),
                                                        topRight:
                                                            Radius.circular(20),
                                                      )),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.info,
                                                        color: Colors.blue[300],
                                                        size: 22,
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * 0.02,
                                                      ),
                                                      Container(
                                                        width: Get.width * 0.63,
                                                        child: Text(
                                                          AppMetaLabels()
                                                              .collierPersonalDocUploadInfo,
                                                          textAlign:
                                                              TextAlign.justify,
                                                          style: AppTextStyle
                                                              .normalBlack12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              // if (controller
                                              //         .renewalInfo?.record!.emirateName ==
                                              //     'Abu Dhabi')
                                              //   Spacer(),
                                              // if (controller
                                              //         .renewalInfo?.record!.emirateName ==
                                              //     'Abu Dhabi')
                                              //   InkWell(
                                              //     onTap: () {
                                              //       launchUrl(Uri.parse(
                                              //           controller.renewalInfo?.link));
                                              //     },
                                              //     child: Text(
                                              //       controller.renewalInfo?.link ?? '',
                                              //       style: AppTextStyle.normalBlue10,
                                              //     ),
                                              //   ),

                                              Spacer(),

                                              Align(
                                                alignment: Alignment.center,
                                                child: SizedBox(
                                                  height: 5.5.h,
                                                  width: 79.0.w,
                                                  child: Obx(() {
                                                    return controller
                                                            .submitting.value
                                                        ? LoadingIndicatorBlue()
                                                        : ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            1.3.h),
                                                              ),
                                                              backgroundColor:
                                                                  Color
                                                                      .fromRGBO(
                                                                          0,
                                                                          61,
                                                                          166,
                                                                          1),
                                                            ),
                                                            onPressed:
                                                                isEnableSubmitButton ==
                                                                        false
                                                                    ? null
                                                                    : () async {
                                                                        // set the value of submitting = true because we want to start the loader
                                                                        // as soon as button is clicked by the user
                                                                        // purpose: avoid the duplication of SR generation
                                                                        controller
                                                                            .submitting
                                                                            .value = true;
                                                                        setState(
                                                                            () {
                                                                          isEnableSubmitButton =
                                                                              false;
                                                                        });
                                                                        var resp = await controller.renewContract(
                                                                            widget.contractId ??
                                                                                0,
                                                                            widget.caller ??
                                                                                "",
                                                                            widget.dueActionid ??
                                                                                0);
                                                                        if (resp ==
                                                                            'ok') {
                                                                          controller
                                                                              .submitting
                                                                              .value = false;
                                                                          showDialog(
                                                                              context: context,
                                                                              barrierDismissible: false,
                                                                              builder: (BuildContext context) {
                                                                                return AlertDialog(contentPadding: EdgeInsets.zero, backgroundColor: Colors.transparent, content: showDialogData());
                                                                              });
                                                                        } else {
                                                                          SnakBarWidget
                                                                              .getSnackBarErrorBlue(
                                                                            AppMetaLabels().error,
                                                                            AppMetaLabels().someThingWentWrong,
                                                                          );
                                                                          setState(
                                                                              () {
                                                                            isEnableSubmitButton =
                                                                                true;
                                                                          });
                                                                        }
                                                                      },
                                                            child: Text(
                                                              AppMetaLabels()
                                                                  .submit,
                                                              textScaleFactor:
                                                                  1.0,
                                                              style: AppTextStyle
                                                                  .semiBoldWhite12,
                                                            ),
                                                          );
                                                  }),
                                                ),
                                              ),
                                            ],
                                          );
                              }))),
                    ),
                  ),
                  SizedBox(
                    height: 2.5.h,
                  ),
                ]),
              ),
            )),
      ),
    );
  }

  Widget showDialogData() {
    isDialogOpen = true;
    return Container(
        padding: EdgeInsets.all(3.0.w),
        // height: 45.0.h,
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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 4.0.h,
              ),
              Image.asset(
                AppImagesPath.bluttickimg,
                height: 9.0.h,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: 3.0.h,
              ),
              Text(
                AppMetaLabels().reqScuccesful,
                style: AppTextStyle.semiBoldBlack13,
              ),
              SizedBox(
                height: 3.0.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: Get.width * 0.03),
                child: Text(
                  '${AppMetaLabels().yourRenewalAgainst}${controller.caseNo}${AppMetaLabels().yourReqNoIsNew1}',
                  // '${AppMetaLabels().yourRenewalAgainst}${widget.contractNo}${AppMetaLabels().yourReqNoIsNew1}${controller.caseNo}${AppMetaLabels().yourReqNoIsNew2}',
                  style: AppTextStyle.normalBlack10
                      .copyWith(color: AppColors.renewelgreyclr1, height: 1.3),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0.h, bottom: 2.0.h),
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 7.0.h,
                    width: 65.0.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1.3.h),
                        ),
                        backgroundColor: Color.fromRGBO(0, 61, 166, 1),
                      ),
                      onPressed: () {
                        SessionController()
                            .setCaseNo(controller.caseNo.toString());
                        Get.back();
                        Get.off(() => TenantServiceRequestTabs(
                              requestNo: controller.caseNo.toString(),
                              caller: widget.caller ?? "!",
                              title: AppMetaLabels().renewalReq,
                              initialIndex: 1,
                            ));
                      },
                      child: Text(
                        AppMetaLabels().uploadDocs,
                        style: AppTextStyle.semiBoldWhite12,
                      ),
                    ),
                  ),
                ),
              ),
            ]));
  }
}
