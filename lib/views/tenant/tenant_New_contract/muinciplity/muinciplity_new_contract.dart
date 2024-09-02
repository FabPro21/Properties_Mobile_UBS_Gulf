// ignore_for_file: deprecated_member_use

import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/tenant/tenant_dashboard/tenant_dashboard_tabs/tenant_dashboard_tabs.dart';
import 'package:fap_properties/views/tenant/tenant_New_contract/muinciplity/municiplity_new_contract_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;
import '../../../../../../utils/styles/colors.dart';

class MunicipalApprovalNewContract extends StatefulWidget {
  final String? caller;
  final int? dueActionId;
  final int? contractId;

  MunicipalApprovalNewContract(
      {Key? key, this.caller, this.dueActionId, @required this.contractId})
      : super(key: key);

  @override
  State<MunicipalApprovalNewContract> createState() => _MunicipalApprovalNewContractState();
}

class _MunicipalApprovalNewContractState extends State<MunicipalApprovalNewContract> {
  final MunicipalApprovalNewContractController controller =
      Get.put(MunicipalApprovalNewContractController());

  @override
  void initState() {
    controller.getInstructions(widget.contractId??0);
    controller.isShowpopUp.value = false;
    super.initState();
  }

  Future<bool> _onWillPop() async {
    if (controller.isShowpopUp.value != true) {
      Get.back();
    } else {
      Get.off(() => TenantDashboardTabs(
            initialIndex: 0,
          ));
    }
    return false; //<-- SEE HERE
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Directionality(
        textDirection: SessionController().getLanguage() == 1
            ? ui.TextDirection.ltr
            : ui.TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 4.0.h, left: 2.5.h, right: 2.5.h),
                      child: Row(
                        children: [
                          Text(
                            AppMetaLabels().instructions,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.semiBoldBlack16,
                          ),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(241, 241, 245, 1),
                                shape: BoxShape.circle),
                            child: Padding(
                              padding: EdgeInsets.all(0.7.h),
                              child: InkWell(
                                onTap: () {
                                  getx.Get.back();
                                },
                                child: Icon(Icons.close,
                                    size: 2.5.h,
                                    color: Color.fromRGBO(70, 82, 95, 1)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 1.0.h,
                      ),
                      child: AppDivider(),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.0.w, vertical: 2.h),
                        child: Container(
                          padding: EdgeInsets.all(2.0.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(1.0.h),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 1.0.h,
                                spreadRadius: 0.6.h,
                                offset: Offset(0.0.h, 0.7.h),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppMetaLabels().municipalApproval,
                                style: AppTextStyle.semiBoldBlack12,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              AppDivider(),
                              Expanded(
                                child: Column(
                                  children: [
                                    Obx(() {
                                      return controller
                                              .loadingInstructions.value
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  top: Get.height * 0.1,
                                                  left: 0),
                                              child: Center(
                                                child: LoadingIndicatorBlue(),
                                              ),
                                            )
                                          : controller.errorLoadingData != ''
                                              ? CustomErrorWidget(
                                                  errorText: controller
                                                      .errorLoadingData,
                                                  onRetry: () {
                                                    controller.getInstructions(
                                                        widget.contractId??0);
                                                  })
                                              : InkWell(
                                                  onTap: () {
                                                    print(
                                                        'URL ::::::: ${controller.municipalInstructions.record}');
                                                    // 7 feb 2023 we are now using the link that we are getting from api
                                                    launchUrl(
                                                        Uri.parse(controller
                                                                .municipalInstructions
                                                                .record ??
                                                            ''),
                                                        mode: LaunchMode
                                                            .externalApplication);
                                                    // launchUrl(
                                                    //     Uri.parse(
                                                    //         'https://mservices.dma.abudhabi.ae/mservices/account/login'),
                                                    //     mode: LaunchMode
                                                    //         .externalApplication);
                                                  },
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: Container(
                                                      height: Get.height * 0.05,
                                                      width: Get.width * 0.6,
                                                      margin: EdgeInsets.only(
                                                          top: Get.height * 0.1,
                                                          left: 0),
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .blue.shade600,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10),
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                          )),
                                                      child: Center(
                                                          child: Text(
                                                              AppMetaLabels()
                                                                  .loginToTawtheeq,
                                                              textAlign:
                                                                  TextAlign
                                                                      .justify,
                                                              style: TextStyle(
                                                                  color: AppColors
                                                                      .whiteColor,
                                                                  fontSize:
                                                                      11.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))),
                                                    ),
                                                  ),
                                                );
                                      //   child: Html(
                                      //     data: controller
                                      //         .municipalInstructions.record,
                                      //     onLinkTap: (url) {
                                      //       launchUrl(Uri.parse(url),
                                      //           mode: LaunchMode
                                      //               .externalApplication);
                                      //     },

                                      //     // onLinkTap: (url, context, data, element) {
                                      //     //   launchUrl(Uri.parse(url),
                                      //     //       mode:
                                      //     //           LaunchMode.externalApplication);
                                      //     // },
                                      //   ),
                                      // );
                                    }),
                                    Obx(() {
                                      return controller
                                              .loadingInstructions.value
                                          ? SizedBox()
                                          : Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.only(
                                                  top: 10,
                                                  right: 10,
                                                  bottom: 10),
                                              margin: EdgeInsets.only(
                                                  top: 4.h,
                                                  bottom: 3.5.h,
                                                  left: 20,
                                                  right: 20),
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      255, 249, 235, 1),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(0),
                                                    topLeft: Radius.circular(0),
                                                    topRight:
                                                        Radius.circular(20),
                                                  )),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.info,
                                                        color:
                                                            Colors.amber[300],
                                                        size: 22,
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * 0.03,
                                                      ),
                                                      Container(
                                                        width: Get.width * 0.6,
                                                        child: Text(
                                                          AppMetaLabels()
                                                              .stage8_1,
                                                          textAlign:
                                                              TextAlign.justify,
                                                          style: AppTextStyle
                                                              .normalBlack12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                    }),
                                  ],
                                ),
                              ),
                              Obx(() {
                                return controller.isHideSubmitButton.value
                                    ? SizedBox()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Obx(() {
                                            return Checkbox(
                                              activeColor: AppColors.blueColor,
                                              value: controller.approved.value,
                                              onChanged: (bool? value) {
                                                controller.approved.value =
                                                    value!;
                                              },
                                            );
                                          }), //Check
                                          Expanded(
                                            child: Text(
                                              AppMetaLabels()
                                                  .confirmMunicipality,
                                              style: AppTextStyle.normalBlack10,
                                            ),
                                          ),
                                        ],
                                      );
                              }),
                              Center(
                                child: Obx(() {
                                  return controller.isHideSubmitButton.value
                                      ? SizedBox()
                                      : controller.updatingStage.value
                                          ? LoadingIndicatorBlue()
                                          : ElevatedButton(
                                              onPressed: !controller
                                                      .approved.value
                                                  ? null
                                                  : () async {
                                                      print(controller
                                                          .approved.value);
                                                      if (controller
                                                          .approved.value) {
                                                        await controller
                                                            .updateContractStage(
                                                                widget
                                                                    .dueActionId??-1,
                                                                9,
                                                                widget.caller??"");
                                                        controller.isShowpopUp
                                                            .value = true;
                                                      
                                                      } else {
                                                        Get.snackbar(
                                                            AppMetaLabels()
                                                                .error,
                                                            AppMetaLabels()
                                                                .pleaseConfirm,
                                                            backgroundColor:
                                                                AppColors
                                                                    .white54);
                                                      }
                                                    },
                                              child: SizedBox(
                                                width: 40.w,
                                                child: Center(
                                                  child: Text(
                                                    SessionController()
                                                                .getLanguage() ==
                                                            1
                                                        ? AppMetaLabels().submit
                                                        : AppMetaLabels().apply,
                                                    style: AppTextStyle
                                                        .semiBoldBlack11
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ),
                                              ),
                                              style: ButtonStyle(
                                                  elevation:
                                                      WidgetStateProperty.all<
                                                          double>(0.0),
                                                  backgroundColor: !controller
                                                          .approved.value
                                                      ? WidgetStateProperty.all<
                                                              Color>(
                                                          Colors.grey.shade400)
                                                      : WidgetStateProperty
                                                          .all<Color>(AppColors
                                                              .blueColor),
                                                  shape:
                                                      WidgetStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2.0.w),
                                                    ),
                                                  )),
                                            );
                                }),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Obx(() {
                return controller.isShowpopUp.value != true
                    ? SizedBox()
                    : Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: Colors.black.withOpacity(0.3),
                        child: Center(
                          child: Container(
                              padding: EdgeInsets.all(3.0.w),
                              margin: EdgeInsets.all(3.0.h),
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
                                      AppMetaLabels().municipalityConfirmation,
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.semiBoldBlack11,
                                    ),
                                    SizedBox(
                                      height: 3.0.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: Get.width * 0.03),
                                      child: Text(
                                        AppMetaLabels().stage9,
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle.normalBlack10
                                            .copyWith(
                                                color:
                                                    AppColors.renewelgreyclr1,
                                                height: 1.3),
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 5.0.h, bottom: 2.0.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: SizedBox(
                                                height: 4.8.h,
                                                width: 30.0.w,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                      elevation:
                                                          WidgetStateProperty
                                                              .all<double>(
                                                                  0.0.h),
                                                      backgroundColor:
                                                          WidgetStateProperty
                                                              .all<Color>(AppColors
                                                                  .whiteColor),
                                                      shape: WidgetStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2.0.w),
                                                            side: BorderSide(
                                                              color: AppColors
                                                                  .blueColor,
                                                              width: 1.0,
                                                            )),
                                                      )),
                                                  onPressed: () {
                                                    setState(() {
                                                      controller.isShowpopUp
                                                          .value = false;
                                                    });
                                                  },
                                                  child: Text(
                                                    AppMetaLabels().stayOnPage,
                                                    textAlign: TextAlign.center,
                                                    style: AppTextStyle
                                                        .semiBoldWhite10
                                                        .copyWith(
                                                            color: Colors.blue),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: SizedBox(
                                                height: 5.0.h,
                                                width: 30.0.w,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              1.3.h),
                                                    ),
                                                    backgroundColor:
                                                        Color.fromRGBO(
                                                            0, 61, 166, 1),
                                                  ),
                                                  onPressed: () {
                                                    Get.back();
                                                    Get.off(() =>
                                                        TenantDashboardTabs(
                                                          initialIndex: 0,
                                                        ));
                                                  },
                                                  child: Text(
                                                    AppMetaLabels()
                                                        .goToDashoboard,
                                                    textAlign: TextAlign.center,
                                                    style: AppTextStyle
                                                        .semiBoldWhite10,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ])),
                        ),
                      );
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget showDialogData() {
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
                AppMetaLabels().stageUpdated,
                style: AppTextStyle.semiBoldBlack13,
              ),
              SizedBox(
                height: 3.0.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: Get.width * 0.03),
                child: Text(
                  'Here will  add message',
                  style: AppTextStyle.normalBlack10
                      .copyWith(color: AppColors.renewelgreyclr1, height: 1.3),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 5.0.h, bottom: 4.0.h),
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 6.0.h,
                      width: 65.0.w,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1.3.h),
                          ),
                          backgroundColor: Color.fromRGBO(0, 61, 166, 1),
                        ),
                        onPressed: () {
                          Get.back();
                          Get.off(() => TenantDashboardTabs(
                                initialIndex: 0,
                              ));
                        },
                        child: Text(
                          AppMetaLabels().goToDashoboard,
                          style: AppTextStyle.semiBoldWhite10,
                        ),
                      ),
                    ),
                  )),
              // Padding(
              //   padding: EdgeInsets.only(top: 0.0.h, bottom: 4.0.h),
              //   child: Align(
              //     alignment: Alignment.center,
              //     child: SizedBox(
              //       height: 6.0.h,
              //       width: 65.0.w,
              //       child: ElevatedButton(
              //         style: ButtonStyle(
              //             elevation: MaterialStateProperty.all<double>(0.0.h),
              //             backgroundColor: MaterialStateProperty.all<Color>(
              //                 AppColors.whiteColor),
              //             shape:
              //                 MaterialStateProperty.all<RoundedRectangleBorder>(
              //               RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(2.0.w),
              //                   side: BorderSide(
              //                     color: AppColors.blueColor,
              //                     width: 1.0,
              //                   )),
              //             )),
              //         onPressed: () {
              //           Get.back();
              //         },
              //         child: Text(
              //           AppMetaLabels().stayOnPage,
              //           style: AppTextStyle.semiBoldWhite11
              //               .copyWith(color: Colors.blue),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ]));
  }

  Row rowList(String t1, String t2) {
    return Row(
      children: [
        Text(
          t1,
          style: AppTextStyle.normalBlack10,
        ),
        Spacer(),
        Text(
          t2,
          style: AppTextStyle.normalBlack10,
        ),
      ],
    );
  }
}
