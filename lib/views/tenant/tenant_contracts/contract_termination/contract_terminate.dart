// ignore_for_file: deprecated_member_use

import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/contract_termination/terminate_contract_controller.dart';
import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request_details/tenant_service_request_tab/tenant_service_request_tab.dart';
import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import '../../../widgets/clear_button.dart';
import 'dart:ui' as ui;

class ContractTerminate extends StatefulWidget {
  final String? contractNo;
  final int? contractId;
  final String? caller;
  final int? dueActionid;
  const ContractTerminate(
      {Key? key,
      this.contractNo,
      this.contractId,
      this.caller,
      this.dueActionid = 0})
      : super(key: key);

  @override
  _ContractTerminateState createState() => _ContractTerminateState();
}

class _ContractTerminateState extends State<ContractTerminate> {
  final controller = Get.put(TerminateContractController());
  final formKey = GlobalKey<FormState>();
  final descTextController = TextEditingController();
  bool? isDialogOpen;

  @override
  void initState() {
    isDialogOpen = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? ui.TextDirection.ltr
          : ui.TextDirection.rtl,
      child: WillPopScope(
        onWillPop: () async {
          if (isDialogOpen!) Get.back();
          return true;
        },
        child: Scaffold(
            backgroundColor: AppColors.greyBG,
            body: Obx(() {
              return Column(children: [
                CustomAppBar2(
                  title: AppMetaLabels().terminate,
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
                  padding: EdgeInsets.only(top: 4.0.h, left: 6.0.w, right: 6.w),
                  child: Align(
                    alignment: SessionController().getLanguage() == 1
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Text(
                      AppMetaLabels().vacateReq,
                      style: AppTextStyle.semiBoldBlack12,
                    ),
                  ),
                ),
                Expanded(
                  child: controller.gettingReasons.value ||
                          controller.gettingPublicToken.value
                      ? LoadingIndicatorBlue()
                      : controller.errorGettingReasons != ''
                          ? AppErrorWidget(
                              errorText: controller.errorGettingReasons,
                            )
                          : controller.reasons != null
                              ? Container(
                                  width: 89.0.w,
                                  margin: EdgeInsets.symmetric(vertical: 3.h),
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
                                          top: 4.5.h,
                                          bottom: 2.5.h,
                                          right: 4.0.w),
                                      child: Scrollbar(
                                        thumbVisibility: true,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                // controller.reasons.note ??
                                                AppMetaLabels().whyTerminate,
                                                textAlign: TextAlign.center,
                                                style:
                                                    AppTextStyle.normalBlack12,
                                              ),
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: controller
                                                    .reasons?.record?.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      controller.selectedReason
                                                          .value = index;
                                                      if (controller
                                                              .reasons
                                                              ?.record?[index]
                                                              .vacatingId ==
                                                          3) {
                                                        controller
                                                            .addDesc.value = 1;
                                                      } else if (controller
                                                              .reasons
                                                              ?.record?[index]
                                                              .vacatingId ==
                                                          7) {
                                                        controller
                                                            .addDesc.value = 2;
                                                      } else
                                                        controller
                                                            .addDesc.value = 0;
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Obx(() {
                                                          return Radio(
                                                            activeColor:
                                                                AppColors
                                                                    .blueColor,
                                                            groupValue: controller
                                                                .selectedReason
                                                                .value,
                                                            onChanged:
                                                                (int? value) {
                                                              controller
                                                                  .selectedReason
                                                                  .value = value!;
                                                              if (controller
                                                                      .reasons
                                                                      ?.record?[
                                                                          index]
                                                                      .vacatingId ==
                                                                  3) {
                                                                controller
                                                                    .addDesc
                                                                    .value = 1;
                                                              } else if (controller
                                                                      .reasons
                                                                      ?.record?[
                                                                          index]
                                                                      .vacatingId ==
                                                                  7) {
                                                                controller
                                                                    .addDesc
                                                                    .value = 2;
                                                              } else
                                                                controller
                                                                    .addDesc
                                                                    .value = 0;
                                                            },
                                                            value: index,
                                                          );
                                                        }),
                                                        Text(
                                                          SessionController()
                                                                      .getLanguage() ==
                                                                  1
                                                              ? controller
                                                                      .reasons
                                                                      ?.record![
                                                                          index]
                                                                      .title ??
                                                                  ""
                                                              : controller
                                                                      .reasons
                                                                      ?.record?[
                                                                          index]
                                                                      .titleAr ??
                                                                  "",
                                                          style: AppTextStyle
                                                              .normalBlack11,
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                              if (controller.addDesc.value != 0)
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 2.0.h),
                                                    child: Form(
                                                      key: formKey,
                                                      child: TextFormField(
                                                        controller:
                                                            descTextController,
                                                        maxLines: 1,
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.length < 3)
                                                            return AppMetaLabels()
                                                                .requiredField;
                                                          else
                                                            return null;
                                                        },
                                                        style: AppTextStyle
                                                            .normalBlack12,
                                                        decoration:
                                                            InputDecoration(
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                            borderSide:
                                                                BorderSide(
                                                              color: AppColors
                                                                  .greyColor,
                                                            ),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                            borderSide:
                                                                BorderSide(
                                                              color: AppColors
                                                                  .greyColor,
                                                            ),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                            borderSide:
                                                                BorderSide(
                                                              color: AppColors
                                                                  .redColor,
                                                            ),
                                                          ),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                            borderSide:
                                                                BorderSide(
                                                              color: AppColors
                                                                  .redColor,
                                                            ),
                                                          ),
                                                          labelText: controller
                                                                      .addDesc
                                                                      .value ==
                                                                  2
                                                              ? AppMetaLabels()
                                                                  .description
                                                              : AppMetaLabels()
                                                                  .otherUnitInfo,
                                                          labelStyle:
                                                              AppTextStyle
                                                                  .normalGrey12,
                                                          contentPadding:
                                                              EdgeInsets.all(
                                                                  4.w),
                                                        ),
                                                      ),
                                                    )),
                                              // Padding(
                                              //   padding:
                                              //       EdgeInsets.only(top: 2.0.h),
                                              //   child: Row(
                                              //     children: [
                                              //       Checkbox(
                                              //         onChanged: (bool value) {
                                              //           controller.earlyTermination
                                              //               .value = value;
                                              //         },
                                              //         value: controller
                                              //             .earlyTermination.value,
                                              //       ),
                                              //       Text(
                                              //         AppMetaLabels()
                                              //             .earlyTermination,
                                              //         style: AppTextStyle
                                              //             .semiBoldBlack10,
                                              //       )
                                              //     ],
                                              //   ),
                                              // ),

                                              if (controller
                                                  .earlyTermination.value)
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 2.0.h),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        AppMetaLabels()
                                                            .terminationDate,
                                                        style: AppTextStyle
                                                            .semiBoldBlack10,
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          var expDate =
                                                              await showRoundedDatePicker(
                                                            theme: ThemeData(
                                                                primaryColor:
                                                                    AppColors
                                                                        .blueColor),
                                                            height: 50.0.h,
                                                            context: context,
                                                            // locale: Locale('en'),
                                                            locale: SessionController()
                                                                        .getLanguage() ==
                                                                    1
                                                                ? Locale(
                                                                    'en', '')
                                                                : Locale(
                                                                    'ar', ''),
                                                            initialDate:
                                                                DateTime.now(),
                                                            borderRadius: 2.0.h,
                                                            styleDatePicker:
                                                                MaterialRoundedDatePickerStyle(
                                                              decorationDateSelected: BoxDecoration(
                                                                  color: AppColors
                                                                      .blueColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100)),
                                                              textStyleButtonPositive:
                                                                  TextStyle(
                                                                color: AppColors
                                                                    .blueColor,
                                                              ),
                                                              textStyleButtonNegative:
                                                                  TextStyle(
                                                                color: AppColors
                                                                    .blueColor,
                                                              ),
                                                              backgroundHeader:
                                                                  Colors.grey
                                                                      .shade300,
                                                              // Appbar year like '2023' button
                                                              textStyleYearButton:
                                                                  TextStyle(
                                                                fontSize: 30.sp,
                                                                color:
                                                                    Colors.blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                backgroundColor:
                                                                    Colors.grey
                                                                        .shade100,
                                                                leadingDistribution:
                                                                    TextLeadingDistribution
                                                                        .even,
                                                              ),
                                                              // Appbar day like 'Thu, Mar 16' button
                                                              textStyleDayButton:
                                                                  TextStyle(
                                                                fontSize: 18.sp,
                                                                color: Colors
                                                                    .white,
                                                              ),

                                                              // Heading year like 'S M T W TH FR SA ' button
                                                              // textStyleDayHeader: TextStyle(
                                                              //   fontSize: 30.sp,
                                                              //   color: Colors.white,
                                                              //   backgroundColor: Colors.red,
                                                              //   decoration: TextDecoration.overline,
                                                              //   decorationColor: Colors.pink,
                                                              // ),
                                                            ),
                                                          );

                                                          if (expDate != null) {
                                                            if (expDate.isBefore(
                                                                    DateTime
                                                                        .now()) ||
                                                                expDate.isAtSameMomentAs(
                                                                    DateTime
                                                                        .now())) {
                                                              Get.snackbar(
                                                                  AppMetaLabels()
                                                                      .error,
                                                                  AppMetaLabels()
                                                                      .selectFuturedate,
                                                                  backgroundColor:
                                                                      AppColors
                                                                          .white54);
                                                            } else {
                                                              DateFormat
                                                                  dateFormat =
                                                                  new DateFormat(
                                                                      AppMetaLabels()
                                                                          .dateFormatForShowRoundedDatePicker);
                                                              // DateFormat
                                                              //     dateFormat =
                                                              //     new DateFormat(
                                                              //         AppMetaLabels()
                                                              //             .dateFormat);
                                                              controller
                                                                      .vacationDate
                                                                      .value =
                                                                  dateFormat
                                                                      .format(
                                                                          expDate);
                                                            }
                                                          }
                                                        },
                                                        child: Container(
                                                          width: 40.0.w,
                                                          height: 5.5.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Color.fromRGBO(
                                                                    246,
                                                                    248,
                                                                    249,
                                                                    1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        1.0.h),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            1.0.h),
                                                                child: Obx(() {
                                                                  return Text(
                                                                    controller
                                                                        .vacationDate
                                                                        .value,
                                                                    style: AppTextStyle
                                                                        .normalBlack12,
                                                                  );
                                                                }),
                                                              ),
                                                              Spacer(),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            1.0.h),
                                                                child:
                                                                    ClearButton(
                                                                  clear: () {
                                                                    controller
                                                                        .vacationDate
                                                                        .value = '';
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              Container(
                                                  margin:
                                                      EdgeInsets.only(top: 4.h),
                                                  height: 6.5.h,
                                                  width: 79.0.w,
                                                  child: controller
                                                          .terminating.value
                                                      ? LoadingIndicatorBlue()
                                                      : Obx(() {
                                                          return ElevatedButton(
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
                                                            onPressed: controller
                                                                            .selectedReason
                                                                            .value ==
                                                                        -1 ||
                                                                    (controller
                                                                            .earlyTermination
                                                                            .value &&
                                                                        controller.vacationDate.value ==
                                                                            '')
                                                                ? null
                                                                : () async {
                                                                    var resp =
                                                                        '';
                                                                    if (controller
                                                                            .addDesc
                                                                            .value !=
                                                                        0) {
                                                                      if (formKey
                                                                          .currentState!
                                                                          .validate()) {
                                                                        String
                                                                            desc =
                                                                            descTextController.text;
                                                                        if (controller.addDesc.value ==
                                                                            1)
                                                                          desc =
                                                                              AppMetaLabels().otherUnitInfo + desc;
                                                                        resp = await controller.terminateContract(
                                                                            widget.contractId ??
                                                                                0,
                                                                            desc,
                                                                            widget.caller ??
                                                                                '',
                                                                            widget.dueActionid ??
                                                                                0);
                                                                      }
                                                                    } else
                                                                      resp = await controller.terminateContract(
                                                                          widget.contractId ??
                                                                              0,
                                                                          '',
                                                                          widget.caller ??
                                                                              '',
                                                                          widget.dueActionid ??
                                                                              0);
                                                                    if (resp ==
                                                                        'ok') {
                                                                      if (controller
                                                                              .reasons
                                                                              ?.record?[controller.selectedReason.value]
                                                                              .vacatingId ==
                                                                          3) {
                                                                        controller
                                                                            .selectNewUnit();
                                                                      } else
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            barrierDismissible:
                                                                                false,
                                                                            builder:
                                                                                (BuildContext context) {
                                                                              return AlertDialog(contentPadding: EdgeInsets.zero, backgroundColor: Colors.transparent, content: showDialogData());
                                                                            });
                                                                    }
                                                                  },
                                                            child: Text(
                                                              AppMetaLabels()
                                                                  .terminate,
                                                              style: AppTextStyle
                                                                  .semiBoldWhite12,
                                                            ),
                                                          );
                                                        })),
                                            ],
                                          ),
                                        ),
                                      )))
                              : SizedBox(),
                ),
              ]);
            })),
      ),
    );
  }

  Widget showDialogData() {
    isDialogOpen = true;
    return Container(
        padding: EdgeInsets.all(3.0.w),
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
              Text(
                '${AppMetaLabels().yourterminationAgainst}${widget.contractNo}${AppMetaLabels().yourReqNoIs}${controller.caseNo}',
                style: AppTextStyle.normalBlack10
                    .copyWith(color: AppColors.renewelgreyclr1),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
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
                              caller: widget.caller ?? "",
                              title: AppMetaLabels().vacateReq,
                            ));
                      },
                      child: Text(
                        AppMetaLabels().viewDetails,
                        style: AppTextStyle.semiBoldWhite12,
                      ),
                    ),
                  ),
                ),
              ),
            ]));
  }
}
// import 'package:fap_properties/data/helpers/session_controller.dart';
// import 'package:fap_properties/utils/constants/meta_labels.dart';
// import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// import 'package:fap_properties/utils/constants/assets_path.dart';
// import 'package:fap_properties/utils/styles/colors.dart';
// import 'package:fap_properties/utils/styles/text_styles.dart';
// import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
// import 'package:fap_properties/views/tenant/tenant_contracts/contract_termination/terminate_contract_controller.dart';
// import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request_details/tenant_service_request_tab/tenant_service_request_tab.dart';
// import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
// import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
// import 'package:intl/intl.dart';
// import '../../../widgets/clear_button.dart';

// class ContractTerminate extends StatefulWidget {
//   final String contractNo;
//   final int contractId;
//   final String caller;
//   final int dueActionid;
//   const ContractTerminate(
//       {Key key,
//       this.contractNo,
//       this.contractId,
//       this.caller,
//       this.dueActionid = 0})
//       : super(key: key);

//   @override
//   _ContractTerminateState createState() => _ContractTerminateState();
// }

// class _ContractTerminateState extends State<ContractTerminate> {
//   final controller = Get.put(TerminateContractController());
//   final formKey = GlobalKey<FormState>();
//   final descTextController = TextEditingController();
//   bool isDialogOpen;

//   @override
//   void initState() {
//     isDialogOpen = false;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: SessionController().getLanguage() == 1
//           ? TextDirection.ltr
//           : TextDirection.rtl,
//       child: WillPopScope(
//         onWillPop: () async {
//           if (isDialogOpen) Get.back();
//           return true;
//         },
//         child: Scaffold(
//             backgroundColor: AppColors.greyBG,
//             body: Obx(() {
//               return Column(children: [
//                 CustomAppBar2(
//                   title: AppMetaLabels().terminate,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 0.5.h,
//                         spreadRadius: 0.3.h,
//                         offset: Offset(0.1.h, 0.1.h),
//                       ),
//                     ],
//                   ),
//                   height: 8.0.h,
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 6.0.w, right: 6.0.w),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           AppMetaLabels().contractNo,
//                           style: AppTextStyle.semiBoldBlack12,
//                         ),
//                         Text(
//                           widget.contractNo,
//                           style: AppTextStyle.semiBoldBlack12,
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 4.0.h, left: 6.0.w, right: 6.w),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       AppMetaLabels().vacateReq,
//                       style: AppTextStyle.semiBoldBlack12,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: controller.gettingReasons.value ||
//                           controller.gettingPublicToken.value
//                       ? LoadingIndicatorBlue()
//                       : controller.errorGettingReasons != ''
//                           ? AppErrorWidget(
//                               errorText: controller.errorGettingReasons,
//                             )
//                           : controller.reasons != null
//                               ? Container(
//                                   width: 89.0.w,
//                                   margin: EdgeInsets.symmetric(vertical: 3.h),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(2.0.h),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black12,
//                                         blurRadius: 0.5.h,
//                                         spreadRadius: 0.3.h,
//                                         offset: Offset(0.1.h, 0.1.h),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Padding(
//                                       padding: EdgeInsets.only(
//                                           left: 4.0.w,
//                                           top: 4.5.h,
//                                           bottom: 2.5.h,
//                                           right: 4.0.w),
//                                       child: Scrollbar(
//                                         thumbVisibility: true,
//                                         child: SingleChildScrollView(
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 controller.reasons.note ??
//                                                     AppMetaLabels()
//                                                         .whyTerminate,
//                                                 textAlign: TextAlign.center,
//                                                 style:
//                                                     AppTextStyle.normalBlack12,
//                                               ),
//                                               ListView.builder(
//                                                 shrinkWrap: true,
//                                                 physics:
//                                                     NeverScrollableScrollPhysics(),
//                                                 itemCount: controller
//                                                     .reasons.record.length,
//                                                 itemBuilder:
//                                                     (BuildContext context,
//                                                         int index) {
//                                                   return InkWell(
//                                                     onTap: () {
//                                                       controller.selectedReason
//                                                           .value = index;
//                                                       if (controller
//                                                               .reasons
//                                                               .record[index]
//                                                               .vacatingId ==
//                                                           3) {
//                                                         controller
//                                                             .addDesc.value = 1;
//                                                       } else if (controller
//                                                               .reasons
//                                                               .record[index]
//                                                               .vacatingId ==
//                                                           7) {
//                                                         controller
//                                                             .addDesc.value = 2;
//                                                       } else
//                                                         controller
//                                                             .addDesc.value = 0;
//                                                     },
//                                                     child: Row(
//                                                       children: [
//                                                         Obx(() {
//                                                           return Radio(
//                                                             groupValue: controller
//                                                                 .selectedReason
//                                                                 .value,
//                                                             onChanged: (value) {
//                                                               controller
//                                                                   .selectedReason
//                                                                   .value = value;
//                                                               if (controller
//                                                                       .reasons
//                                                                       .record[
//                                                                           index]
//                                                                       .vacatingId ==
//                                                                   3) {
//                                                                 controller
//                                                                     .addDesc
//                                                                     .value = 1;
//                                                               } else if (controller
//                                                                       .reasons
//                                                                       .record[
//                                                                           index]
//                                                                       .vacatingId ==
//                                                                   7) {
//                                                                 controller
//                                                                     .addDesc
//                                                                     .value = 2;
//                                                               } else
//                                                                 controller
//                                                                     .addDesc
//                                                                     .value = 0;
//                                                             },
//                                                             value: index,
//                                                           );
//                                                         }),
//                                                         Text(
//                                                           controller
//                                                                   .reasons
//                                                                   .record[index]
//                                                                   .title +
//                                                               '12',
//                                                           style: AppTextStyle
//                                                               .normalBlack11,
//                                                         )
//                                                       ],
//                                                     ),
//                                                   );
//                                                 },
//                                               ),
//                                               if (controller.addDesc.value != 0)
//                                                 Padding(
//                                                     padding: EdgeInsets.only(
//                                                         top: 2.0.h),
//                                                     child: Form(
//                                                       key: formKey,
//                                                       child: TextFormField(
//                                                         controller:
//                                                             descTextController,
//                                                         maxLines: 1,
//                                                         validator: (value) {
//                                                           if (value == null ||
//                                                               value.length < 3)
//                                                             return AppMetaLabels()
//                                                                 .requiredField;
//                                                           else
//                                                             return null;
//                                                         },
//                                                         style: AppTextStyle
//                                                             .normalBlack12,
//                                                         decoration:
//                                                             InputDecoration(
//                                                           focusedBorder:
//                                                               OutlineInputBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         5.0),
//                                                             borderSide:
//                                                                 BorderSide(
//                                                               color: AppColors
//                                                                   .greyColor,
//                                                             ),
//                                                           ),
//                                                           enabledBorder:
//                                                               OutlineInputBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         5.0),
//                                                             borderSide:
//                                                                 BorderSide(
//                                                               color: AppColors
//                                                                   .greyColor,
//                                                             ),
//                                                           ),
//                                                           errorBorder:
//                                                               OutlineInputBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         5.0),
//                                                             borderSide:
//                                                                 BorderSide(
//                                                               color: AppColors
//                                                                   .redColor,
//                                                             ),
//                                                           ),
//                                                           focusedErrorBorder:
//                                                               OutlineInputBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         5.0),
//                                                             borderSide:
//                                                                 BorderSide(
//                                                               color: AppColors
//                                                                   .redColor,
//                                                             ),
//                                                           ),
//                                                           labelText: controller
//                                                                       .addDesc
//                                                                       .value ==
//                                                                   2
//                                                               ? AppMetaLabels()
//                                                                   .description
//                                                               : AppMetaLabels()
//                                                                   .otherUnitInfo,
//                                                           labelStyle:
//                                                               AppTextStyle
//                                                                   .normalGrey12,
//                                                           contentPadding:
//                                                               EdgeInsets.all(
//                                                                   4.w),
//                                                         ),
//                                                       ),
//                                                     )),
//                                               // Padding(
//                                               //   padding:
//                                               //       EdgeInsets.only(top: 2.0.h),
//                                               //   child: Row(
//                                               //     children: [
//                                               //       Checkbox(
//                                               //         onChanged: (bool value) {
//                                               //           controller.earlyTermination
//                                               //               .value = value;
//                                               //         },
//                                               //         value: controller
//                                               //             .earlyTermination.value,
//                                               //       ),
//                                               //       Text(
//                                               //         AppMetaLabels()
//                                               //             .earlyTermination,
//                                               //         style: AppTextStyle
//                                               //             .semiBoldBlack10,
//                                               //       )
//                                               //     ],
//                                               //   ),
//                                               // ),

//                                               if (controller
//                                                   .earlyTermination.value)
//                                                 Padding(
//                                                   padding: EdgeInsets.only(
//                                                       top: 2.0.h),
//                                                   child: Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceBetween,
//                                                     children: [
//                                                       Text(
//                                                         AppMetaLabels()
//                                                             .terminationDate,
//                                                         style: AppTextStyle
//                                                             .semiBoldBlack10,
//                                                       ),
//                                                       InkWell(
//                                                         onTap: () async {
//                                                           var expDate =
//                                                               await showRoundedDatePicker(
//                                                             height: 50.0.h,
//                                                             context: context,
  // locale: Locale('en'),
                              // locale: SessionController().getLanguage() == 1
                              //     ? Locale('en', '')
                              //     : Locale('ar', ''),
//                                                             initialDate:
//                                                                 DateTime.now(),
//                                                             borderRadius: 2.0.h,
//                                                           );

//                                                           if (expDate != null) {
//                                                             if (expDate.isBefore(
//                                                                     DateTime
//                                                                         .now()) ||
//                                                                 expDate.isAtSameMomentAs(
//                                                                     DateTime
//                                                                         .now())) {
//                                                               Get.snackbar(
//                                                                   AppMetaLabels()
//                                                                       .error,
//                                                                   AppMetaLabels()
//                                                                       .selectFuturedate,
//                                                                   backgroundColor:
//                                                                       AppColors
//                                                                           .white54);
//                                                             } else {
//                                                               DateFormat
//                                                                   dateFormat =
//                                                                   new DateFormat(
//                                                                       AppMetaLabels()
//                                                                           .dateFormatForShowRoundedDatePicker);
//                                                               // DateFormat
//                                                               //     dateFormat =
//                                                               //     new DateFormat(
//                                                               //         AppMetaLabels()
//                                                               //             .dateFormat);
//                                                               controller
//                                                                       .vacationDate
//                                                                       .value =
//                                                                   dateFormat
//                                                                       .format(
//                                                                           expDate);
//                                                             }
//                                                           }
//                                                         },
//                                                         child: Container(
//                                                           width: 40.0.w,
//                                                           height: 5.5.h,
//                                                           decoration:
//                                                               BoxDecoration(
//                                                             color:
//                                                                 Color.fromRGBO(
//                                                                     246,
//                                                                     248,
//                                                                     249,
//                                                                     1),
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         1.0.h),
//                                                           ),
//                                                           child: Row(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .spaceAround,
//                                                             children: [
//                                                               Padding(
//                                                                 padding: EdgeInsets
//                                                                     .symmetric(
//                                                                         horizontal:
//                                                                             1.0.h),
//                                                                 child: Obx(() {
//                                                                   return Text(
//                                                                     controller
//                                                                         .vacationDate
//                                                                         .value,
//                                                                     style: AppTextStyle
//                                                                         .normalBlack12,
//                                                                   );
//                                                                 }),
//                                                               ),
//                                                               Spacer(),
//                                                               Padding(
//                                                                 padding: EdgeInsets
//                                                                     .symmetric(
//                                                                         horizontal:
//                                                                             1.0.h),
//                                                                 child:
//                                                                     ClearButton(
//                                                                   clear: () {
//                                                                     controller
//                                                                         .vacationDate
//                                                                         .value = '';
//                                                                   },
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               Container(
//                                                   margin:
//                                                       EdgeInsets.only(top: 4.h),
//                                                   height: 6.5.h,
//                                                   width: 79.0.w,
//                                                   child: controller
//                                                           .terminating.value
//                                                       ? LoadingIndicatorBlue()
//                                                       : Obx(() {
//                                                           return ElevatedButton(
//                                                             style:
//                                                                 ElevatedButton
//                                                                     .styleFrom(
//                                                               shape:
//                                                                   RoundedRectangleBorder(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             1.3.h),
//                                                               ),
//                                                               backgroundColor:
//                                                                   Color
//                                                                       .fromRGBO(
//                                                                           0,
//                                                                           61,
//                                                                           166,
//                                                                           1),
//                                                             ),
//                                                             onPressed: controller
//                                                                             .selectedReason
//                                                                             .value ==
//                                                                         -1 ||
//                                                                     (controller
//                                                                             .earlyTermination
//                                                                             .value &&
//                                                                         controller.vacationDate.value ==
//                                                                             '')
//                                                                 ? null
//                                                                 : () async {
//                                                                     var resp =
//                                                                         '';
//                                                                     if (controller
//                                                                             .addDesc
//                                                                             .value !=
//                                                                         0) {
//                                                                       if (formKey
//                                                                           .currentState
//                                                                           .validate()) {
//                                                                         String
//                                                                             desc =
//                                                                             descTextController.text;
//                                                                         if (controller.addDesc.value ==
//                                                                             1)
//                                                                           desc =
//                                                                               AppMetaLabels().otherUnitInfo + desc;
//                                                                         resp = await controller.terminateContract(
//                                                                             widget.contractId,
//                                                                             desc,
//                                                                             widget.caller,
//                                                                             widget.dueActionid);
//                                                                       }
//                                                                     } else
//                                                                       resp = await controller.terminateContract(
//                                                                           widget
//                                                                               .contractId,
//                                                                           '',
//                                                                           widget
//                                                                               .caller,
//                                                                           widget
//                                                                               .dueActionid);
//                                                                     if (resp ==
//                                                                         'ok') {
//                                                                       if (controller
//                                                                               .reasons
//                                                                               .record[controller.selectedReason.value]
//                                                                               .vacatingId ==
//                                                                           3) {
//                                                                         controller
//                                                                             .selectNewUnit();
//                                                                       } else
//                                                                         showDialog(
//                                                                             context:
//                                                                                 context,
//                                                                             barrierDismissible:
//                                                                                 false,
//                                                                             builder:
//                                                                                 (BuildContext context) {
//                                                                               return AlertDialog(contentPadding: EdgeInsets.zero, backgroundColor: Colors.transparent, content: showDialogData());
//                                                                             });
//                                                                     }
//                                                                   },
//                                                             child: Text(
//                                                               AppMetaLabels()
//                                                                   .terminate,
//                                                               style: AppTextStyle
//                                                                   .semiBoldWhite12,
//                                                             ),
//                                                           );
//                                                         })),
//                                             ],
//                                           ),
//                                         ),
//                                       )))
//                               : SizedBox(),
//                 ),
//               ]);
//             })),
//       ),
//     );
//   }

//   Widget showDialogData() {
//     isDialogOpen = true;
//     return Container(
//         padding: EdgeInsets.all(3.0.w),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(2.0.h),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 0.5.h,
//               spreadRadius: 0.3.h,
//               offset: Offset(0.1.h, 0.1.h),
//             ),
//           ],
//         ),
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(
//                 height: 4.0.h,
//               ),
//               Image.asset(
//                 AppImagesPath.bluttickimg,
//                 height: 9.0.h,
//                 fit: BoxFit.contain,
//               ),
//               SizedBox(
//                 height: 3.0.h,
//               ),
//               Text(
//                 AppMetaLabels().reqScuccesful,
//                 style: AppTextStyle.semiBoldBlack13,
//               ),
//               SizedBox(
//                 height: 3.0.h,
//               ),
//               Text(
//                 '${AppMetaLabels().yourterminationAgainst}${widget.contractNo}${AppMetaLabels().yourReqNoIs}${controller.caseNo}',
//                 style: AppTextStyle.normalBlack10
//                     .copyWith(color: AppColors.renewelgreyclr1),
//                 maxLines: 3,
//                 overflow: TextOverflow.ellipsis,
//                 textAlign: TextAlign.center,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 5.0.h, bottom: 2.0.h),
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: SizedBox(
//                     height: 7.0.h,
//                     width: 65.0.w,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(1.3.h),
//                         ),
//                         backgroundColor: Color.fromRGBO(0, 61, 166, 1),
//                       ),
//                       onPressed: () {
//                         SessionController()
//                             .setCaseNo(controller.caseNo.toString());
//                         Get.back();
//                         Get.off(() => TenantServiceRequestTabs(
//                               requestNo: controller.caseNo.toString(),
//                               caller: widget.caller,
//                               title: AppMetaLabels().vacateReq,
//                             ));
//                       },
//                       child: Text(
//                         AppMetaLabels().viewDetails,
//                         style: AppTextStyle.semiBoldWhite12,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ]));
//   }
// }
