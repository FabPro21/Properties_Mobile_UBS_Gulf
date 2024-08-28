import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/landlord/landlord_contracts/landlord_contract_details_tabs/landlord_contract_main_info/landlord_contract_main_info_controller.dart';
import 'package:fap_properties/views/widgets/bottom_shadow.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/common_widgets/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LandlordContractMainInfo extends StatefulWidget {
  final int? contractId;
  final String? previousContactNo;
  const LandlordContractMainInfo(
      {Key? key, @required this.contractId, this.previousContactNo})
      : super(key: key);

  @override
  _LandlordContractMainInfoState createState() =>
      _LandlordContractMainInfoState();
}

class _LandlordContractMainInfoState extends State<LandlordContractMainInfo> {
  final controller = Get.put(LandlordContractMainInfoController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getContractDetails(widget.contractId ?? 0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Obx(() {
              return controller.loadingContractDetails.value
                  ? LoadingIndicatorBlue()
                  : controller.errorLoadingContractDetails != '' &&
                          controller.contractDetails!.contract == null &&
                          controller.loadingContractDetails.value
                      ? LoadingIndicatorBlue()
                      : controller.errorLoadingContractDetails != ''
                          ? CustomErrorWidget(
                              errorText: controller.errorLoadingContractDetails,
                            )
                          : Padding(
                              padding: EdgeInsets.only(top: 1.h),
                              child: Obx(
                                () {
                                  return controller.obxError.value == '0'
                                      ? LoadingIndicatorBlue()
                                      : controller.loadingContractDetails
                                                  .value ==
                                              true
                                          ? LoadingIndicatorBlue()
                                          : controller.errorLoadingContractDetails !=
                                                  ''
                                              ? AppErrorWidget(
                                                  errorText: controller
                                                      .errorLoadingContractDetails,
                                                )
                                              : Padding(
                                                  padding:
                                                      EdgeInsets.all(2.0.h),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        width: 94.0.w,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      2.0.h),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black12,
                                                              blurRadius: 0.5.h,
                                                              spreadRadius:
                                                                  0.3.h,
                                                              offset: Offset(
                                                                  0.1.h, 0.1.h),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  2.5.h),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                AppMetaLabels()
                                                                    .contractLength,
                                                                style: AppTextStyle
                                                                    .semiBoldBlack12,
                                                              ),
                                                              Align(
                                                                alignment: Alignment
                                                                    .bottomRight,
                                                                child: Text(
                                                                  (controller.daysPassed)
                                                                          .toString() +
                                                                      '/' +
                                                                      controller
                                                                          .contractDetails!
                                                                          .contract!
                                                                          .noOfDays
                                                                          .toString(),
                                                                  style: AppTextStyle
                                                                      .normalBlack10,
                                                                ),
                                                              ),
                                                              LinearProgressIndicator(
                                                                value:
                                                                    controller
                                                                        .comPtg,
                                                                backgroundColor:
                                                                    AppColors
                                                                        .chartlightBlueColor,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 2.0
                                                                            .h,
                                                                        bottom:
                                                                            2.0.h),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          AppMetaLabels()
                                                                              .contractDate,
                                                                          style:
                                                                              AppTextStyle.normalBlack10,
                                                                        ),
                                                                        Text(
                                                                          controller.contractDetails!.contract!.contractDate ??
                                                                              "",
                                                                          style:
                                                                              AppTextStyle.semiBoldBlack10,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          AppMetaLabels()
                                                                              .startDate,
                                                                          style:
                                                                              AppTextStyle.normalBlack10,
                                                                        ),
                                                                        Text(
                                                                          controller.contractDetails!.contract!.contractStartDate ??
                                                                              "",
                                                                          style:
                                                                              AppTextStyle.semiBoldBlack10,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          AppMetaLabels()
                                                                              .endDate,
                                                                          style:
                                                                              AppTextStyle.normalBlack10,
                                                                        ),
                                                                        Text(
                                                                          controller.contractDetails!.contract!.contractEndDate ??
                                                                              "",
                                                                          style:
                                                                              AppTextStyle.semiBoldBlack10,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        AppMetaLabels()
                                                                            .contractAmount,
                                                                        style: AppTextStyle
                                                                            .normalBlack11,
                                                                      ),
                                                                      Text(
                                                                        "${AppMetaLabels().aed} ${controller.amount}",
                                                                        style: AppTextStyle
                                                                            .semiBoldBlack11,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Spacer(),
                                                                  Column(
                                                                    crossAxisAlignment: SessionController().getLanguage() ==
                                                                            1
                                                                        ? CrossAxisAlignment
                                                                            .end
                                                                        : CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        AppMetaLabels()
                                                                            .status,
                                                                        style: AppTextStyle
                                                                            .normalBlack11,
                                                                      ),
                                                                      ConstrainedBox(
                                                                        constraints:
                                                                            BoxConstraints(maxWidth: 27.w),
                                                                        child:
                                                                            FittedBox(
                                                                          child:
                                                                              StatusWidget(
                                                                            text: SessionController().getLanguage() == 1
                                                                                ? controller.contractDetails!.contract!.contractStatus ?? "-"
                                                                                : controller.contractDetails!.contract!.contractStatusAr ?? '-',
                                                                            valueToCompare:
                                                                                controller.contractDetails!.contract!.contractStatus ?? "",
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 2.h,
                                                              ),
                                                              if (widget.previousContactNo !=
                                                                      null &&
                                                                  controller
                                                                          .contractDetails!
                                                                          .contract!
                                                                          .contractno !=
                                                                      widget
                                                                          .previousContactNo)
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      AppMetaLabels()
                                                                          .prevContractNo,
                                                                      style: AppTextStyle
                                                                          .normalBlack11,
                                                                    ),
                                                                    Text(
                                                                      widget.previousContactNo ??
                                                                          "",
                                                                      style: AppTextStyle
                                                                          .semiBoldBlack11,
                                                                    ),
                                                                  ],
                                                                )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 3.0.h),
                                                        child: Container(
                                                          width: 94.0.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2.0.h),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black12,
                                                                blurRadius:
                                                                    0.5.h,
                                                                spreadRadius:
                                                                    0.3.h,
                                                                offset: Offset(
                                                                    0.1.h,
                                                                    0.1.h),
                                                              ),
                                                            ],
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2.5.h),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      AppMetaLabels()
                                                                          .property,
                                                                      style: AppTextStyle
                                                                          .semiBoldBlack11,
                                                                    ),
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          top: 2.0
                                                                              .h),
                                                                  child: Text(
                                                                    SessionController().getLanguage() ==
                                                                            1
                                                                        ? controller
                                                                            .contractDetails!
                                                                            .contract!
                                                                            .unitName
                                                                            .toString()
                                                                        : controller
                                                                            .contractDetails!
                                                                            .contract!
                                                                            .unitNameAr
                                                                            .toString(),
                                                                    style: AppTextStyle
                                                                        .normalBlack10,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          top: 1.5
                                                                              .h),
                                                                  child:
                                                                      Container(
                                                                    child: Text(
                                                                      SessionController().getLanguage() == 1
                                                                          ? controller
                                                                              .contractDetails!
                                                                              .contract!
                                                                              .address
                                                                              .toString()
                                                                          : controller
                                                                              .contractDetails!
                                                                              .contract!
                                                                              .addressAr
                                                                              .toString(),
                                                                      style: AppTextStyle
                                                                          .semiBoldBlack10,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                },
                              ),
                            );
            }),
            BottomShadow(),
          ],
        ));
  }
}
// import 'package:fap_properties/data/helpers/session_controller.dart';
// import 'package:fap_properties/utils/constants/meta_labels.dart';
// import 'package:fap_properties/utils/styles/colors.dart';
// import 'package:fap_properties/utils/styles/text_styles.dart';
// import 'package:fap_properties/views/landlord/landlord_contracts/landlord_contract_details_tabs/landlord_main_info/londlord_contract_main_info_controller.dart';
// import 'package:fap_properties/views/widgets/bottom_shadow.dart';
// import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
// import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';

// class LandlordContractMainInfo extends StatefulWidget {
//   final int contractId;
//   const LandlordContractMainInfo({Key key, @required this.contractId})
//       : super(key: key);

//   @override
//   _LandlordContractMainInfoState createState() =>
//       _LandlordContractMainInfoState();
// }

// class _LandlordContractMainInfoState extends State<LandlordContractMainInfo> {
//   final controller = Get.put(LandlordContractMainInfoController());

//   @override
//   void initState() {
//     controller.getContractDetails(widget.contractId);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isEng = SessionController().getLanguage() == 1;
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: Stack(
//           children: [
//             Obx(() {
//               return controller.loadingContractDetails.value
//                   ? LoadingIndicatorBlue()
//                   : controller.errorLoadingContractDetails != ''
//                       ? CustomErrorWidget(
//                           errorText: controller.errorLoadingContractDetails,
//                         )
//                       : Padding(
//                           padding: EdgeInsets.only(top: 2.h),
//                           child: SingleChildScrollView(
//                             child: Padding(
//                               padding: EdgeInsets.all(2.0.h),
//                               child: Column(
//                                 children: [
//                                   Container(
//                                     width: 94.0.w,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius:
//                                           BorderRadius.circular(2.0.h),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.black12,
//                                           blurRadius: 0.5.h,
//                                           spreadRadius: 0.3.h,
//                                           offset: Offset(0.1.h, 0.1.h),
//                                         ),
//                                       ],
//                                     ),
//                                     child: Padding(
//                                       padding: EdgeInsets.all(2.5.h),
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             AppMetaLabels().contractLength,
//                                             style: AppTextStyle.semiBoldBlack12,
//                                           ),
//                                           Align(
//                                             alignment: Alignment.bottomRight,
//                                             child: Text(
//                                               '${controller.contractDetails.contract.noOfDaysPassed}/${controller.contractDetails.contract.noOfDays}',
//                                               style: AppTextStyle.normalBlack10,
//                                             ),
//                                           ),
//                                           LinearProgressIndicator(
//                                             value: controller.contractDetails
//                                                 .contract.complete,
//                                             backgroundColor:
//                                                 AppColors.chartlightBlueColor,
//                                           ),
//                                           Padding(
//                                             padding: EdgeInsets.only(
//                                                 top: 2.0.h, bottom: 2.0.h),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Column(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.start,
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                       AppMetaLabels()
//                                                           .issueDateLand,
//                                                       style: AppTextStyle
//                                                           .normalBlack10,
//                                                     ),
//                                                     Text(
//                                                       controller
//                                                           .contractDetails
//                                                           .contract
//                                                           .contractDate,
//                                                       style: AppTextStyle
//                                                           .semiBoldBlack10,
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 Column(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.start,
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                       AppMetaLabels()
//                                                           .startDateLand,
//                                                       style: AppTextStyle
//                                                           .normalBlack10,
//                                                     ),
//                                                     Text(
//                                                       controller
//                                                           .contractDetails
//                                                           .contract
//                                                           .contractStartDate,
//                                                       style: AppTextStyle
//                                                           .semiBoldBlack10,
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 Column(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.start,
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                       AppMetaLabels()
//                                                           .endDateLand,
//                                                       style: AppTextStyle
//                                                           .normalBlack10,
//                                                     ),
//                                                     Text(
//                                                       controller
//                                                           .contractDetails
//                                                           .contract
//                                                           .contractEndDate,
//                                                       style: AppTextStyle
//                                                           .semiBoldBlack10,
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 AppMetaLabels().contractAmount,
//                                                 style:
//                                                     AppTextStyle.normalBlack11,
//                                               ),
//                                               const Spacer(),
//                                               Text(
//                                                 controller.contractDetails
//                                                     .contract.amountFormatted,
//                                                 style: AppTextStyle
//                                                     .semiBoldBlack11,
//                                               ),
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.only(top: 3.0.h),
//                                     child: Container(
//                                       width: 94.0.w,
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius:
//                                             BorderRadius.circular(2.0.h),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.black12,
//                                             blurRadius: 0.5.h,
//                                             spreadRadius: 0.3.h,
//                                             offset: Offset(0.1.h, 0.1.h),
//                                           ),
//                                         ],
//                                       ),
//                                       child: Padding(
//                                         padding: EdgeInsets.all(2.5.h),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 Text(
//                                                   AppMetaLabels().propertyLand,
//                                                   style: AppTextStyle
//                                                       .semiBoldBlack11,
//                                                 ),
//                                               ],
//                                             ),
//                                             Padding(
//                                               padding:
//                                                   EdgeInsets.only(top: 2.0.h),
//                                               child: Text(
//                                                 controller
//                                                         .contractDetails
//                                                         .contract
//                                                         .propertyName ??
//                                                     '',
//                                                 style:
//                                                     AppTextStyle.normalBlack10,
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding:
//                                                   EdgeInsets.only(top: 1.5.h),
//                                               child: Container(
//                                                 child: Text(
//                                                   isEng
//                                                       ? controller
//                                                               .contractDetails
//                                                               .contract
//                                                               .address ??
//                                                           ''
//                                                       : controller
//                                                               .contractDetails
//                                                               .contract
//                                                               .addressAr ??
//                                                           '',
//                                                   style: AppTextStyle
//                                                       .semiBoldBlack10,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//             }),
//             BottomShadow(),
//           ],
//         ));
//   }
// }
