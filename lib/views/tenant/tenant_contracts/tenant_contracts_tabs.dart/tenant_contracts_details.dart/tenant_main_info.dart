// ignore_for_file: unnecessary_null_comparison

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/screen_disable.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/make_payment/outstanding_payments/outstanding_payments.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
// import 'package:fap_properties/views/tenant/tenant_contracts/contract_checkin/contract_checkin.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/contract_extension/contract_extend.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/contract_renewel/contract_renewel.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/contract_termination/contract_terminate.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/legal_settlement/legal_settlement.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_tabs.dart/tenant_contracts_details.dart/authenticate_contract/authenticate_contract.dart';
import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request_details/tenant_service_request_tab/tenant_service_request_tab.dart';
import 'package:fap_properties/views/widgets/bottom_shadow.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sizer/sizer.dart';

import '../../../../widgets/common_widgets/status_widget.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/due_action_List_button.dart';
import '../../../../widgets/step_no_widget.dart';
import 'municipal_approval/municipal_approval.dart';
import 'tenant_contract_download/tenant_contract_download_controller.dart';
import 'tenant_contracts_detail_controller.dart';

class MainInfo extends StatefulWidget {
  final String? prevContractNo;
  const MainInfo({Key? key, @required this.prevContractNo}) : super(key: key);

  @override
  _MainInfoState createState() => _MainInfoState();
}

class _MainInfoState extends State<MainInfo> {
  final getCDController = Get.put(GetContractsDetailsController());
  // final getCDController = Get.find<GetContractsDetailsController>();
  final contractDownloadController = Get.put(ContractDownloadController());

  @override
  void initState() {
    print('****************');
    print(getCDController.getContractsDetails.value.contract!.isCanceled);
    print(getCDController.getContractsDetails.value.contract!.contractno);
    print(getCDController.getContractsDetails.value.caseNo);
    print('****************');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Obx(() {
                return Container(
                  height: getCDController.canDownload.value &&
                          getCDController.getContractsDetails.value.contract!
                                  .contractStatus ==
                              'Legal Case'
                      ? 115.h
                      : getCDController.canDownload.value
                          ? 105.h
                          : getCDController.getContractsDetails.value.contract!
                                      .contractStatus ==
                                  'Legal Case'
                              ? 98.h
                              : SessionController().getLanguage() == 1
                                  ? 88.h
                                  : 95.h,
                  child: Padding(
                    padding: EdgeInsets.only(top: 1.h),
                    child: Obx(
                      () {
                        return getCDController.loadingContract.value == true
                            ? LoadingIndicatorBlue()
                            : getCDController.errorLoadingContract.value != ''
                                ? AppErrorWidget(
                                    errorText: getCDController
                                        .errorLoadingContract.value,
                                  )
                                : Padding(
                                    padding: EdgeInsets.all(2.0.h),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 94.0.w,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(2.0.h),
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
                                            padding: EdgeInsets.all(2.5.h),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppMetaLabels()
                                                      .contractLength,
                                                  style: AppTextStyle
                                                      .semiBoldBlack12,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Text(
                                                    getCDController.daysPassed
                                                                .toString() +
                                                            '/' +
                                                            getCDController
                                                                .getContractsDetails
                                                                .value
                                                                .contract!
                                                                .noOfDays
                                                                .toString(),
                                                    style: AppTextStyle
                                                        .normalBlack10,
                                                  ),
                                                ),
                                                LinearProgressIndicator(
                                                  value: getCDController.comPtg,
                                                  backgroundColor: AppColors
                                                      .chartlightBlueColor,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 2.0.h,
                                                      bottom: 2.0.h),
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
                                                            style: AppTextStyle
                                                                .normalBlack10,
                                                          ),
                                                          Text(
                                                            getCDController
                                                                    .getContractsDetails
                                                                    .value
                                                                    .contract!
                                                                    .contractDate ??
                                                                "",
                                                            style: AppTextStyle
                                                                .semiBoldBlack10,
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
                                                            style: AppTextStyle
                                                                .normalBlack10,
                                                          ),
                                                          Text(
                                                            getCDController
                                                                    .getContractsDetails
                                                                    .value
                                                                    .contract!
                                                                    .contractStartDate ??
                                                                "",
                                                            style: AppTextStyle
                                                                .semiBoldBlack10,
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
                                                            style: AppTextStyle
                                                                .normalBlack10,
                                                          ),
                                                          Text(
                                                            getCDController
                                                                    .getContractsDetails
                                                                    .value
                                                                    .contract!
                                                                    .contractEndDate ??
                                                                "",
                                                            style: AppTextStyle
                                                                .semiBoldBlack10,
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
                                                          "${AppMetaLabels().aed} ${getCDController.amount}",
                                                          style: AppTextStyle
                                                              .semiBoldBlack11,
                                                        ),
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    Column(
                                                      crossAxisAlignment:
                                                          SessionController()
                                                                      .getLanguage() ==
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
                                                              BoxConstraints(
                                                                  maxWidth:
                                                                      27.w),
                                                          child: FittedBox(
                                                            child: StatusWidget(
                                                              text: SessionController()
                                                                          .getLanguage() ==
                                                                      1
                                                                  ? getCDController
                                                                      .getContractsDetails
                                                                      .value
                                                                      .contract!
                                                                      .contractStatus
                                                                  : getCDController
                                                                          .getContractsDetails
                                                                          .value
                                                                          .contract!
                                                                          .contractStatusAR ??
                                                                      '',
                                                              valueToCompare:
                                                                  getCDController
                                                                      .getContractsDetails
                                                                      .value
                                                                      .contract!
                                                                      .contractStatus,
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
                                                if (widget.prevContractNo !=
                                                        null &&
                                                    getCDController
                                                            .getContractsDetails
                                                            .value
                                                            .contract!
                                                            .contractno !=
                                                        widget.prevContractNo)
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
                                                        widget.prevContractNo ??
                                                            '',
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
                                          padding: EdgeInsets.only(top: 3.0.h),
                                          child: Container(
                                            width: 94.0.w,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(2.0.h),
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
                                              padding: EdgeInsets.all(2.5.h),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                    padding: EdgeInsets.only(
                                                        top: 2.0.h),
                                                    child: Text(
                                                      SessionController()
                                                                  .getLanguage() ==
                                                              1
                                                          ? getCDController
                                                              .getContractsDetails
                                                              .value
                                                              .contract!
                                                              .unitName
                                                              .toString()
                                                          : getCDController
                                                              .getContractsDetails
                                                              .value
                                                              .contract!
                                                              .unitNameAr
                                                              .toString(),
                                                      style: AppTextStyle
                                                          .normalBlack10,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 1.5.h),
                                                    child: Container(
                                                      child: Text(
                                                        SessionController()
                                                                    .getLanguage() ==
                                                                1
                                                            ? getCDController
                                                                .getContractsDetails
                                                                .value
                                                                .contract!
                                                                .address
                                                                .toString()
                                                            : getCDController
                                                                .getContractsDetails
                                                                .value
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
                                        if (getCDController
                                                .errorLoadingContractPayables
                                                .value !=
                                            AppMetaLabels().noDatafound)
                                          getCDController
                                                  .loadingContractPayables.value
                                              ? Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 4.0,
                                                    right: 4.0,
                                                    top: 5.h,
                                                  ),
                                                  child: LoadingIndicatorBlue(
                                                    size: 20,
                                                  ),
                                                )
                                              : Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 3.0.h),
                                                  child: Container(
                                                    width: 94.0.w,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2.0.h),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black12,
                                                          blurRadius: 0.5.h,
                                                          spreadRadius: 0.3.h,
                                                          offset: Offset(
                                                              0.1.h, 0.1.h),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(2.5.h),
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
                                                                .outstandingPayment,
                                                            style: AppTextStyle
                                                                .semiBoldBlack11,
                                                          ),
                                                          // getCDController
                                                          //         .loadingContractPayables
                                                          //         .value
                                                          //     ? Padding(
                                                          //         padding:
                                                          //             const EdgeInsets
                                                          //                 .all(4.0),
                                                          //         child:
                                                          //             LoadingIndicatorBlue(
                                                          //           size: 20,
                                                          //         ),
                                                          //       )
                                                          //     :
                                                          getCDController
                                                                      .errorLoadingContractPayables
                                                                      .value !=
                                                                  ''
                                                              ? AppErrorWidget(
                                                                  errorText:
                                                                      getCDController
                                                                          .errorLoadingContractPayables
                                                                          .value,
                                                                )
                                                              : Column(
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          1.5.h,
                                                                    ),
                                                                    if (getCDController
                                                                            .totalRentalPayment
                                                                            .value !=
                                                                        '0.00')
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(top: 1.h),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text(
                                                                              AppMetaLabels().renatalpayments,
                                                                              style: AppTextStyle.normalBlack10,
                                                                            ),
                                                                            Spacer(),
                                                                            Text(
                                                                              '${AppMetaLabels().aed} ${getCDController.totalRentalPayment.value}',
                                                                              style: AppTextStyle.semiBoldBlack11,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    if (getCDController
                                                                            .totalAdditionalCharges
                                                                            .value !=
                                                                        '0.00')
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(top: 1.h),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text(
                                                                              AppMetaLabels().additionalCharges,
                                                                              style: AppTextStyle.normalBlack10,
                                                                            ),
                                                                            Spacer(),
                                                                            Text(
                                                                              '${AppMetaLabels().aed} ${getCDController.totalAdditionalCharges.value}',
                                                                              style: AppTextStyle.semiBoldBlack11,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    if (getCDController
                                                                            .totalVatOnRent
                                                                            .value !=
                                                                        '0.00')
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(top: 1.h),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text(
                                                                              AppMetaLabels().vatOnRent,
                                                                              style: AppTextStyle.normalBlack10,
                                                                            ),
                                                                            Spacer(),
                                                                            Text(
                                                                              '${AppMetaLabels().aed} ${getCDController.totalVatOnRent.value}',
                                                                              style: AppTextStyle.semiBoldBlack11,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    if (getCDController
                                                                            .totalVatOnCharges
                                                                            .value !=
                                                                        '0.00')
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(top: 1.h),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text(
                                                                              AppMetaLabels().vatOnCharges,
                                                                              style: AppTextStyle.normalBlack10,
                                                                            ),
                                                                            Spacer(),
                                                                            Text(
                                                                              '${AppMetaLabels().aed} ${getCDController.totalVatOnCharges.value}',
                                                                              style: AppTextStyle.semiBoldBlack11,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    SizedBox(
                                                                      height:
                                                                          1.0.h,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          AppMetaLabels()
                                                                              .totalpayments,
                                                                          style:
                                                                              AppTextStyle.normalBlack10,
                                                                        ),
                                                                        Spacer(),
                                                                        Text(
                                                                          '${AppMetaLabels().aed} ${getCDController.sumOfAllPayments.value}',
                                                                          style:
                                                                              AppTextStyle.semiBoldBlack11,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    if (getCDController
                                                                            .getContractsDetails
                                                                            .value
                                                                            .canPayment ==
                                                                        1)
                                                                      Column(
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                1.5.h,
                                                                          ),
                                                                          AppDivider(),
                                                                          SizedBox(
                                                                            height:
                                                                                1.5.h,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Material(
                                                                        child:
                                                                            InkWell(
                                                                          onTap: getCDController.getContractsDetails.value.contract!.isCanceled == 1
                                                                              ? () {
                                                                                  SnakBarWidget.getSnackBarErrorBlue(AppMetaLabels().alert, AppMetaLabels().yourRequestCancelled);
                                                                                }
                                                                              : () {
                                                                                  Get.to(() => OutstandingPayments(
                                                                                        contractNo: getCDController.getContractsDetails.value.contract!.contractno,
                                                                                        contractId: getCDController.getContractsDetails.value.contract!.contractId,
                                                                                      ));
                                                                                },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text(
                                                                              // getCDController.outstandingPaymentsController.gotoOnlinePayments.value?
                                                                              AppMetaLabels().proceedTopay,
                                                                              // : AppMetaLabels().chequeDetailsC,
                                                                              style: AppTextStyle.semiBoldBlue10,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        // today
                                        // Obx(() {
                                        //   return getCDController.loadingCanDownload.value ||
                                        //           getCDController
                                        //                   .getContractsDetails
                                        //                   .value
                                        //                   .caseStageInfo
                                        //                   .stageId ==
                                        //               null ||
                                        //           getCDController
                                        //                   .getContractsDetails
                                        //                   .value
                                        //                   .caseStageInfo
                                        //                   .stageId <
                                        //               8
                                        //       ? SizedBox()
                                        //       : getCDController.canDownloadContract
                                        //                   .canDownload ==
                                        //               '1'
                                        //           ? Container(
                                        //               width: 100.0.w,
                                        //               padding:
                                        //                   EdgeInsets.all(2.0.h),
                                        //               margin:
                                        //                   EdgeInsets.only(top: 3.h),
                                        //               decoration: BoxDecoration(
                                        //                 color: Colors.white,
                                        //                 borderRadius:
                                        //                     BorderRadius.circular(
                                        //                         1.0.h),
                                        //                 boxShadow: [
                                        //                   BoxShadow(
                                        //                     color: Colors.black12,
                                        //                     blurRadius: 1.0.h,
                                        //                     spreadRadius: 0.6.h,
                                        //                     offset: Offset(
                                        //                         0.0.h, 0.7.h),
                                        //                   ),
                                        //                 ],
                                        //               ),
                                        //               child: Column(
                                        //                 mainAxisAlignment:
                                        //                     MainAxisAlignment.start,
                                        //                 crossAxisAlignment:
                                        //                     CrossAxisAlignment
                                        //                         .start,
                                        //                 children: [
                                        //                   Text(
                                        //                     AppMetaLabels()
                                        //                         .documents,
                                        //                     style: AppTextStyle
                                        //                         .semiBoldBlack12,
                                        //                   ),
                                        //                   SizedBox(
                                        //                     height: 2.0.h,
                                        //                   ),
                                        //                   contractDownloadController
                                        //                               .downloading
                                        //                               .value ==
                                        //                           true
                                        //                       ? LoadingIndicatorBlue()
                                        //                       : InkWell(
                                        //                           onTap: () {
                                        //                             {
                                        //                               getCDController
                                        //                                   .downloadContract();
                                        //                             }
                                        //                           },
                                        //                           child: Row(
                                        //                             mainAxisAlignment:
                                        //                                 MainAxisAlignment
                                        //                                     .start,
                                        //                             crossAxisAlignment:
                                        //                                 CrossAxisAlignment
                                        //                                     .center,
                                        //                             children: [
                                        //                               Image.asset(
                                        //                                 AppImagesPath
                                        //                                     .document,
                                        //                                 fit: BoxFit
                                        //                                     .cover,
                                        //                               ),
                                        //                               Padding(
                                        //                                 padding: EdgeInsets.symmetric(
                                        //                                     horizontal:
                                        //                                         4.0.w),
                                        //                                 child: Text(
                                        //                                   AppMetaLabels()
                                        //                                       .downloadContract,
                                        //                                   style: AppTextStyle
                                        //                                       .normalBlue12,
                                        //                                 ),
                                        //                               ),
                                        //                               Spacer(),
                                        //                               Icon(
                                        //                                 Icons
                                        //                                     .download,
                                        //                                 size: 3.0.h,
                                        //                               )
                                        //                             ],
                                        //                           ),
                                        //                         ),
                                        //                 ],
                                        //               ),
                                        //             )
                                        //           : getCDController
                                        //                       .canDownloadContract
                                        //                       .canDownload ==
                                        //                   '0'
                                        //               ? Container(
                                        //                   alignment:
                                        //                       Alignment.center,
                                        //                   padding:
                                        //                       EdgeInsets.all(8.0),
                                        //                   margin: EdgeInsets.only(
                                        //                     top: 2.h,
                                        //                   ),
                                        //                   decoration: BoxDecoration(
                                        //                       color: Color.fromRGBO(
                                        //                           255, 249, 235, 1),
                                        //                       borderRadius:
                                        //                           BorderRadius
                                        //                               .circular(8)),
                                        //                   child: Row(
                                        //                     crossAxisAlignment:
                                        //                         CrossAxisAlignment
                                        //                             .center,
                                        //                     children: [
                                        //                       Icon(
                                        //                         Icons.error_outline,
                                        //                         color: Colors
                                        //                             .amber[400],
                                        //                       ),
                                        //                       SizedBox(
                                        //                         width: 8.0,
                                        //                       ),
                                        //                       // 112233 error alert
                                        //                       Expanded(
                                        //                         child: Text(
                                        //                           SessionController()
                                        //                                       .getLanguage() ==
                                        //                                   1
                                        //                               ? getCDController
                                        //                                       .canDownloadContract
                                        //                                       .message ??
                                        //                                   ''
                                        //                               : getCDController
                                        //                                       .canDownloadContract
                                        //                                       .messageAR ??
                                        //                                   "",
                                        //                           style: AppTextStyle
                                        //                               .normalBlack12,
                                        //                         ),
                                        //                       ),
                                        //                     ],
                                        //                   ),
                                        //                 )
                                        //               : SizedBox();
                                        // }),

                                        // today Feed Back
                                        // getCDController.getContractsDetails.value
                                        //                 .caseNo
                                        //                 .toString() ==
                                        //             null ||
                                        //         getCDController.getContractsDetails
                                        //                 .value.caseNo ==
                                        //             0 ||
                                        //         getCDController.getContractsDetails
                                        //                 .value.caseNo ==
                                        //             0.0
                                        //     ? SizedBox()
                                        //     : Obx(() {
                                        //         return getCDController
                                        //                     .loadingCanDownload
                                        //                     .value ||
                                        //                 getCDController
                                        //                         .getContractsDetails
                                        //                         .value
                                        //                         .caseStageInfo
                                        //                         .stageId ==
                                        //                     null ||
                                        //                 getCDController
                                        //                         .getContractsDetails
                                        //                         .value
                                        //                         .caseStageInfo
                                        //                         .stageId <
                                        //                     8
                                        //             ? SizedBox()
                                        //             : getCDController
                                        //                         .canDownloadContract
                                        //                         .canDownload ==
                                        //                     '1'
                                        //                 ? Padding(
                                        //                     padding: EdgeInsets
                                        //                         .symmetric(
                                        //                             horizontal:
                                        //                                 0.3.h,
                                        //                             vertical:
                                        //                                 0.5.h),
                                        //                     child: InkWell(
                                        //                         onTap: () async {
                                        //                           print(
                                        //                               '****************');
                                        //                           print(getCDController
                                        //                               .getContractsDetails
                                        //                               .value
                                        //                               .caseNo);
                                        //                           print(getCDController
                                        //                               .getContractsDetails
                                        //                               .value
                                        //                               .message);
                                        //                           print(getCDController
                                        //                               .getContractsDetails
                                        //                               .value
                                        //                               .status);
                                        //                           print(
                                        //                               '****************');
                                        //                           SessionController()
                                        //                               .setCaseNo(
                                        //                             getCDController
                                        //                                 .getContractsDetails
                                        //                                 .value
                                        //                                 .caseNo
                                        //                                 .toString(),
                                        //                           );
                                        //                           Get.to(() =>
                                        //                               TenantServiceRequestTabs(
                                        //                                 requestNo: getCDController
                                        //                                     .getContractsDetails
                                        //                                     .value
                                        //                                     .caseNo
                                        //                                     .toString(),
                                        //                                 caller:
                                        //                                     'contract!',
                                        //                                 title: AppMetaLabels()
                                        //                                     .renewalReq,
                                        //                                 initialIndex:
                                        //                                     0,
                                        //                               ));
                                        //                         },
                                        //                         child: Container(
                                        //                           alignment:
                                        //                               Alignment
                                        //                                   .center,
                                        //                           padding:
                                        //                               EdgeInsets
                                        //                                   .all(5.0),
                                        //                           margin: EdgeInsets
                                        //                               .only(
                                        //                                   top: 2.h,
                                        //                                   bottom:
                                        //                                       2.h),
                                        //                           decoration: BoxDecoration(
                                        //                               color: AppColors
                                        //                                   .blueColor,
                                        //                               borderRadius:
                                        //                                   BorderRadius
                                        //                                       .circular(
                                        //                                           8)),
                                        //                           child: Row(
                                        //                             crossAxisAlignment:
                                        //                                 CrossAxisAlignment
                                        //                                     .center,
                                        //                             children: [
                                        //                               SizedBox(
                                        //                                 width: 8.0,
                                        //                               ),
                                        //                               Icon(
                                        //                                 Icons.info,
                                        //                                 color: Colors
                                        //                                     .white,
                                        //                               ),
                                        //                               SizedBox(
                                        //                                 width: 8.0,
                                        //                               ),
                                        //                               Expanded(
                                        //                                 child:
                                        //                                     SizedBox(
                                        //                                   height:
                                        //                                       4.h,
                                        //                                   child: Marquee(
                                        //                                       text: AppMetaLabels()
                                        //                                           .clickHereFeedback,
                                        //                                       style: AppTextStyle
                                        //                                           .normalBlue12
                                        //                                           .copyWith(color: Colors.white)
                                        //                                           .copyWith(fontWeight: FontWeight.bold)),
                                        //                                 ),
                                        //                               ),
                                        //                             ],
                                        //                           ),
                                        //                         )))
                                        //                 : SizedBox();
                                        //       }),

                                        if (getCDController
                                                .getContractsDetails
                                                .value
                                                .contract!
                                                .contractStatus ==
                                            'Legal Case')
                                          Container(
                                              width: 100.0.w,
                                              margin: EdgeInsets.only(top: 3.h),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        1.0.h),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 1.0.h,
                                                    spreadRadius: 0.6.h,
                                                    offset:
                                                        Offset(0.0.h, 0.7.h),
                                                  ),
                                                ],
                                              ),
                                              child: getCDController
                                                          .getContractsDetails
                                                          .value
                                                          .legalCaseNo ==
                                                      0
                                                  ? CustomButton2(
                                                      text: AppMetaLabels()
                                                          .reqLegalSettlement,
                                                      onPressed: () {
                                                        Get.to(
                                                            () =>
                                                                LegalSettlement(
                                                                  contractNo: getCDController
                                                                      .getContractsDetails
                                                                      .value
                                                                      .contract!
                                                                      .contractno,
                                                                  contractId: getCDController
                                                                      .getContractsDetails
                                                                      .value
                                                                      .contract!
                                                                      .contractId,
                                                                ));
                                                      },
                                                    )
                                                  : Center(
                                                      child: TextButton(
                                                          onPressed: () {
                                                            SessionController().setCaseNo(
                                                                getCDController
                                                                    .getContractsDetails
                                                                    .value
                                                                    .legalCaseNo
                                                                    .toString());
                                                            Get.to(() =>
                                                                TenantServiceRequestTabs(
                                                                  requestNo: getCDController
                                                                      .getContractsDetails
                                                                      .value
                                                                      .legalCaseNo
                                                                      .toString(),
                                                                  caller:
                                                                      'contract!',
                                                                  title: AppMetaLabels()
                                                                      .legalReq,
                                                                ));
                                                          },
                                                          child: Text(
                                                            AppMetaLabels()
                                                                .reqLegalSettlementSubmitted,
                                                            style: AppTextStyle
                                                                .normalBlue14,
                                                          )),
                                                    )),

                                        // Obx(() {
                                        //   return getCDController
                                        //               .loadingCanCheckin.value ||
                                        //           getCDController
                                        //                   .errorLoadingCanCheckin !=
                                        //               '' ||
                                        //           !getCDController
                                        //               .canCheckinModel.checkIn
                                        //       ? SizedBox()
                                        //       : Container(
                                        //           width: 100.0.w,
                                        //           margin: EdgeInsets.only(top: 3.h),
                                        //           padding: EdgeInsets.all(2.0.h),
                                        //           decoration: BoxDecoration(
                                        //             color: Colors.white,
                                        //             borderRadius:
                                        //                 BorderRadius.circular(
                                        //                     1.0.h),
                                        //             boxShadow: [
                                        //               BoxShadow(
                                        //                 color: Colors.black12,
                                        //                 blurRadius: 1.0.h,
                                        //                 spreadRadius: 0.6.h,
                                        //                 offset:
                                        //                     Offset(0.0.h, 0.7.h),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //           child: getCDController
                                        //                       .canCheckinModel
                                        //                       .caseNo ==
                                        //                   0
                                        //               ? ElevatedButton(
                                        //                   onPressed: () {
                                        //                     Get.to(
                                        //                         () =>
                                        //                             ContractCheckin(
                                        //                               contractNo: getCDController
                                        //                                   .getContractsDetails
                                        //                                   .value
                                        //                                   .contract!
                                        //                                   .contractno,
                                        //                               contractId: getCDController
                                        //                                   .getContractsDetails
                                        //                                   .value
                                        //                                   .contract!
                                        //                                   .contractId,
                                        //                             ));
                                        //                   },
                                        //                   child: Text(
                                        //                     AppMetaLabels().checkin,
                                        //                     style: AppTextStyle
                                        //                         .normalBlue12
                                        //                         .copyWith(
                                        //                             color: Colors
                                        //                                 .white),
                                        //                   ),
                                        //                   style: ButtonStyle(
                                        //                       elevation:
                                        //                           MaterialStateProperty
                                        //                               .all<double>(
                                        //                                   0.0),
                                        //                       backgroundColor:
                                        //                           MaterialStateProperty
                                        //                               .all<Color>(
                                        //                                   AppColors
                                        //                                       .blueColor3),
                                        //                       shape: MaterialStateProperty
                                        //                           .all<
                                        //                               RoundedRectangleBorder>(
                                        //                         RoundedRectangleBorder(
                                        //                           borderRadius:
                                        //                               BorderRadius
                                        //                                   .circular(
                                        //                                       2.0.w),
                                        //                           // side: BorderSide(
                                        //                           //  // color: AppColors.blueColor,
                                        //                           //   width: 1.0,
                                        //                           // )
                                        //                         ),
                                        //                       )),
                                        //                 )
                                        //               : Center(
                                        //                   child: TextButton(
                                        //                       onPressed: () {
                                        //                         SessionController().setCaseNo(
                                        //                             getCDController
                                        //                                 .canCheckinModel
                                        //                                 .caseNo
                                        //                                 .toString());
                                        //                         Get.to(() =>
                                        //                             TenantServiceRequestTabs(
                                        //                               requestNo: getCDController
                                        //                                   .canCheckinModel
                                        //                                   .caseNo
                                        //                                   .toString(),
                                        //                               showDocs:
                                        //                                   true,
                                        //                               showPhotos:
                                        //                                   false,
                                        //                               caller:
                                        //                                   'contract!',
                                        //                               title: AppMetaLabels()
                                        //                                   .checkinReq,
                                        //                             ));
                                        //                       },
                                        //                       child: Text(
                                        //                         AppMetaLabels()
                                        //                             .checkinReqSubmitted,
                                        //                         style: AppTextStyle
                                        //                             .normalBlue14,
                                        //                       )),
                                        //                 ));
                                        // })
                                      ],
                                    ),
                                  );
                      },
                    ),
                  ),
                );
              }),
            ),
            Obx(() {
              return Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: getCDController.canDownload.value == false
                      ? 0.h
                      : getCDController.canDownload.value &&
                              getCDController.canDownloadContract.canDownload ==
                                  '0'
                          ? 13.h
                          : 27.0.h,
// // FEEDBACK NULL AND CANDOWNLOAD FALSE
//                       getCDController.getContractsDetails.value.caseNo.toString() == null ||
//                               getCDController.getContractsDetails.value.caseNo ==
//                                   0 ||
//                               getCDController.getContractsDetails.value.caseNo == 0.0 &&
//                                   getCDController.canDownload.value == false
//                           ? 0.h
//                           :
// // FEEDBACK !NULL AND CANDOWNLOAD TRUE
//                           getCDController.canDownload.value == true &&
//                                       getCDController.getContractsDetails.value.caseNo.toString() !=
//                                           null ||
//                                   getCDController.getContractsDetails.value.caseNo !=
//                                       0 ||
//                                   getCDController.getContractsDetails.value.caseNo !=
//                                       0.0
//                               ? 27.h
//                               :
// // FEEDBACK NULL AND CANDOWNLOAD TRUE
//                               getCDController.canDownload.value == true &&
//                                           getCDController.getContractsDetails
//                                                   .value.caseNo
//                                                   .toString() ==
//                                               null ||
//                                       getCDController.getContractsDetails.value.caseNo ==
//                                           0 ||
//                                       getCDController.getContractsDetails.value.caseNo ==
//                                           0.0
//                                   ? 14.h
//                                   :
// // FEEDBACK !NULL AND CANDOWNLOAD FALSE
//                                   getCDController.canDownload.value == false &&
//                                               getCDController
//                                                       .getContractsDetails
//                                                       .value
//                                                       .caseNo
//                                                       .toString() !=
//                                                   null ||
//                                           getCDController.getContractsDetails.value.caseNo != 0 ||
//                                           getCDController.getContractsDetails.value.caseNo != 0.0
//                                       ? 14.h
//                                       : 0.h,
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 0.5, bottom: 0.5),
                  decoration: getCDController.canDownload.value == false
                      ? null
                      : BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 0.5.h,
                              spreadRadius: 0.5.h,
                              offset: Offset(0.1.h, 0.1.h),
                            ),
                          ],
                        ),
                  child: getCDController.canDownload.value == false
                      ? SizedBox()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(() {
                              return getCDController.loadingCanDownload.value ||
                                      getCDController.getContractsDetails.value
                                              .caseStageInfo!.stageId! ==
                                          null ||
                                      getCDController.getContractsDetails.value
                                              .caseStageInfo!.stageId! <
                                          8
                                  ? SizedBox()
                                  : getCDController.canDownloadContract
                                              .canDownload ==
                                          '1'
                                      ? Container(
                                          width: 100.0.w,
                                          padding: EdgeInsets.all(2.0.h),
                                          margin: EdgeInsets.only(
                                              top: 2.h, left: 5.w, right: 5.w),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(1.0.h),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                AppMetaLabels().documents,
                                                style: AppTextStyle
                                                    .semiBoldBlack12,
                                              ),
                                              SizedBox(
                                                height: 2.0.h,
                                              ),
                                              contractDownloadController
                                                          .downloading.value ==
                                                      true
                                                  ? LoadingIndicatorBlue()
                                                  : InkWell(
                                                      onTap: () {
                                                        {
                                                          getCDController
                                                              .downloadContract();
                                                        }
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Image.asset(
                                                            AppImagesPath
                                                                .document,
                                                            fit: BoxFit.cover,
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        4.0.w),
                                                            child: Text(
                                                              AppMetaLabels()
                                                                  .downloadContract,
                                                              style: AppTextStyle
                                                                  .normalBlue12,
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Icon(
                                                            Icons.download,
                                                            size: 3.0.h,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        )
                                      : getCDController.canDownloadContract
                                                  .canDownload ==
                                              '0'
                                          ? Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(8.0),
                                              margin: EdgeInsets.only(
                                                  top: 2.h,
                                                  left: 3.w,
                                                  right: 3.w),
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      255, 249, 235, 1),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.error_outline,
                                                    color: Colors.amber[400],
                                                  ),
                                                  SizedBox(
                                                    width: 8.0,
                                                  ),
                                                  // 112233 error alert
                                                  Expanded(
                                                    child: Text(
                                                      SessionController()
                                                                  .getLanguage() ==
                                                              1
                                                          ? getCDController
                                                                  .canDownloadContract
                                                                  .message ??
                                                              ''
                                                          : getCDController
                                                                  .canDownloadContract
                                                                  .messageAR ??
                                                              "",
                                                      style: AppTextStyle
                                                          .normalBlack12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : SizedBox();
                            }),
                            // commenting this because we want to show the Feedback button
                            // on the base of of canDownload
                            //
                            // we will pass caseId from the caseStageInfo model instead of caseExist
                            // getCDController.getContractsDetails.value.caseNo
                            //                 .toString() ==
                            //             null ||
                            //         getCDController
                            //                 .getContractsDetails.value.caseNo ==
                            //             0 ||
                            //         getCDController
                            //                 .getContractsDetails.value.caseNo ==
                            //             0.0
                            //     ? SizedBox(
                            //         height: 30,
                            //       )
                            //     :
                            Container(
                              margin: EdgeInsets.only(left: 5.w, right: 5.w),
                              child: Obx(() {
                                return getCDController.loadingCanDownload.value
                                    // ||
                                    //         getCDController.getContractsDetails
                                    //                 .value.caseStageInfo.stageId ==
                                    //             null ||
                                    //         getCDController.getContractsDetails
                                    //                 .value.caseStageInfo.stageId <
                                    //             8
                                    ? SizedBox()
                                    : getCDController.canDownloadContract
                                                .canDownload ==
                                            '1'
                                        ? Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 0.3.h,
                                                vertical: 0.5.h),
                                            child: InkWell(
                                                onTap: () async {
                                                  SessionController().setCaseNo(
                                                    getCDController
                                                        .getContractsDetails
                                                        .value
                                                        .caseStageInfo!
                                                        .caseid
                                                        .toString(),
                                                  );
                                                  print(
                                                      'Case No :::in Production::: ${getCDController.getContractsDetails.value.caseStageInfo!.caseid.toString()}');
                                                  Get.to(() =>
                                                      TenantServiceRequestTabs(
                                                        requestNo: getCDController
                                                            .getContractsDetails
                                                            .value
                                                            .caseStageInfo!
                                                            .caseid
                                                            .toString(),
                                                        caller:
                                                            'contractRenewed',
                                                        title: AppMetaLabels()
                                                            .renewalReq,
                                                        initialIndex: 0,
                                                      ));
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.all(5.0),
                                                  margin: EdgeInsets.only(
                                                      top: 2.h, bottom: 2.h),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          AppColors.blueColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: 8.0,
                                                      ),
                                                      Icon(
                                                        Icons.info,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        width: 8.0,
                                                      ),
                                                      Expanded(
                                                        child: SizedBox(
                                                          height: 4.h,
                                                          child: Marquee(
                                                              text: AppMetaLabels()
                                                                  .clickHereFeedback,
                                                              style: AppTextStyle
                                                                  .normalBlue12
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .white)
                                                                  .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )))
                                        : SizedBox();
                              }),
                            ),
                          ],
                        ),
                ),
              );
            }),
            getCDController.isEnableScreen.value == false
                ? ScreenDisableWidget()
                : SizedBox(),
            BottomShadow(),
          ],
        ),
        bottomNavigationBar: Obx(() {
          print(
              'getCDController.loadingContract.value ******** ****** 1 ***** ***** ${getCDController.loadingContract.value}');
          print(
              'getCDController.errorLoadingContract.value *********  2 ***** ***** ${getCDController.errorLoadingContract.value}');
          print(
              'getContractsDetails.contract!.contractStatus ********* 3 ***** ***** ${getCDController.getContractsDetails.value.contract!.contractStatus}');
          print(
              'getCDController.getContractsDetails.caseStageInfo *** 4 ***** ***** ${getCDController.getContractsDetails.value.caseStageInfo}');
          print(
              'getCDController.caseStageInfo.stageId ******** ****** 5 ***** ***** ${getCDController.getContractsDetails.value.caseStageInfo!.stageId}');

          return getCDController.loadingContract.value ||
                  getCDController.errorLoadingContract.value != '' ||
                  getCDController
                          .getContractsDetails.value.contract!.contractStatus ==
                      'Ended' ||
                  getCDController.getContractsDetails.value.caseStageInfo ==
                      null ||
                  getCDController.getContractsDetails.value.caseStageInfo!.stageId ==
                      null ||
                  getCDController
                          .getContractsDetails.value.caseStageInfo!.stageId! <
                      1 ||
                  getCDController
                          .getContractsDetails.value.caseStageInfo!.stageId! >
                      9
              ? SizedBox()
              : SizedBox();
          // BottomAppBar is commented on 14-03-2023 becaause
          // we faced a conflict on stageID
          // : BottomAppBar(
          //     child: Container(
          //         height: 8.0.h, //set your height here
          //         width: double.maxFinite, //set your width here
          //         decoration:
          //             BoxDecoration(color: Colors.white, boxShadow: [
          //           BoxShadow(
          //             color: Colors.black12,
          //             blurRadius: 0.9.h,
          //             spreadRadius: 0.4.h,
          //             offset: Offset(0.1.h, 0.1.h),
          //           ),
          //         ]),
          //         child: showActions()));
        }));
  }

  Widget showActions() {
    int stageId =
        getCDController.getContractsDetails.value.caseStageInfo!.stageId!;
    switch (stageId) {
      case 1:
        return expiringContractActions();

      default:
        return renewalActions(stageId);
    }
  }

  Widget expiringContractActions() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        if (getCDController.showExtend)
          Expanded(
            child: Padding(
                padding: EdgeInsets.all(0.5.h),
                child: CustomButtonWithoutBackgroud(
                  text: AppMetaLabels().extend,
                  onPressed: () {
                    Get.to(() => ContractExtend(
                          contractNo: getCDController
                              .getContractsDetails.value.contract!.contractno,
                          contractId: getCDController
                              .getContractsDetails.value.contract!.contractId,
                          caller: 'contract!',
                          dueActionId: getCDController.getContractsDetails.value
                              .caseStageInfo!.dueActionid,
                        ));
                  },
                  borderColor: AppColors.blueColor,
                )),
          ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(0.5.h),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.0.sp),
                        side: BorderSide(
                          color: AppColors.blueColor,
                          width: 1.0,
                        )),
                    backgroundColor: AppColors.whiteColor,
                    shadowColor: AppColors.blueColor),
                onPressed: () {
                  Get.to(() => ContractRenewel(
                        contractNo: getCDController
                            .getContractsDetails.value.contract!.contractno,
                        contractId: getCDController
                            .getContractsDetails.value.contract!.contractId,
                        caller: 'contract!',
                        dueActionid: getCDController.getContractsDetails.value
                            .caseStageInfo!.dueActionid,
                      ));
                },
                child: Text(AppMetaLabels().renew,
                    style: AppTextStyle.normalBlue11)),
          ),
        ),
        Expanded(
          child: Padding(
              padding: EdgeInsets.all(0.5.h),
              child: CustomButtonWithoutBackgroud(
                  text: AppMetaLabels().terminate,
                  onPressed: () {
                    Get.to(() => ContractTerminate(
                          contractNo: getCDController
                              .getContractsDetails.value.contract!.contractno,
                          contractId: getCDController
                              .getContractsDetails.value.contract!.contractId,
                          caller: 'contract!',
                          dueActionid: getCDController.getContractsDetails.value
                              .caseStageInfo!.dueActionid,
                        ));
                  },
                  borderColor: AppColors.blueColor)),
        ),
      ]),
    );
  }

  Widget renewalActions(int stageId) {
    final ItemScrollController itemScrollController = ItemScrollController();

    int dueActionIndex = 0;
    switch (stageId) {
      case 2:
        dueActionIndex = 0;
        break;
      case 3:
        dueActionIndex = 1;
        break;
      case 4:
        dueActionIndex = 2;
        break;
      case 5:
        dueActionIndex = 3;
        break;
      case 6:
        dueActionIndex = 4;
        break;
      case 7:
        dueActionIndex = 5;
        break;
      case 8:
        dueActionIndex = 6;
        break;
      case 9:
        dueActionIndex = 7;
        break;
    }

    final actionList = [
      Padding(
          padding: EdgeInsets.all(0.5.h),
          child: stageId == 2
              ? DueActionListButton(
                  text: AppMetaLabels().uploadDocs,
                  srNo: '1',
                  onPressed: getCDController
                              .getContractsDetails.value.contract!.isCanceled ==
                          1
                      ? () {
                          SnakBarWidget.getSnackBarErrorBlue(
                              AppMetaLabels().alert,
                              AppMetaLabels().yourRequestCancelled);
                        }
                      : () {
                          SessionController().setCaseNo(
                            getCDController
                                .getContractsDetails.value.caseStageInfo!.caseid
                                .toString(),
                          );
                          Get.to(() => TenantServiceRequestTabs(
                                requestNo: getCDController.getContractsDetails
                                    .value.caseStageInfo!.caseid
                                    .toString(),
                                caller: 'contract!',
                                title: AppMetaLabels().renewalReq,
                                initialIndex: 1,
                              ));
                        })
              : StepNoWidget(label: '1', tooltip: AppMetaLabels().uploadDocs)),
      Padding(
          padding: EdgeInsets.all(0.5.h),
          child: stageId == 3
              ? DueActionListButton(
                  text: AppMetaLabels().docsSubmitted,
                  srNo: '2',
                  onPressed: getCDController
                              .getContractsDetails.value.contract!.isCanceled ==
                          1
                      ? () {
                          SnakBarWidget.getSnackBarErrorBlue(
                              AppMetaLabels().alert,
                              AppMetaLabels().yourRequestCancelled);
                        }
                      : () {
                          SessionController().setCaseNo(
                            getCDController
                                .getContractsDetails.value.caseStageInfo!.caseid
                                .toString(),
                          );
                          Get.to(() => TenantServiceRequestTabs(
                                requestNo: getCDController.getContractsDetails
                                    .value.caseStageInfo!.caseid
                                    .toString(),
                                caller: 'contract!',
                                title: AppMetaLabels().renewalReq,
                                initialIndex: 1,
                              ));
                        })
              : StepNoWidget(
                  label: '2', tooltip: AppMetaLabels().docsSubmitted)),
      Padding(
          padding: EdgeInsets.all(0.5.h),
          child: stageId == 4
              ? DueActionListButton(
                  text: AppMetaLabels().docsApproved,
                  srNo: '3',
                  onPressed: getCDController
                              .getContractsDetails.value.contract!.isCanceled ==
                          1
                      ? () {
                          SnakBarWidget.getSnackBarErrorBlue(
                              AppMetaLabels().alert,
                              AppMetaLabels().yourRequestCancelled);
                        }
                      : () {
                          SessionController().setCaseNo(
                            getCDController
                                .getContractsDetails.value.caseStageInfo!.caseid
                                .toString(),
                          );
                          Get.to(() => TenantServiceRequestTabs(
                                requestNo: getCDController.getContractsDetails
                                    .value.caseStageInfo!.caseid
                                    .toString(),
                                caller: 'contract!',
                                title: AppMetaLabels().renewalReq,
                                initialIndex: 1,
                              ));
                        })
              : StepNoWidget(
                  label: '3', tooltip: AppMetaLabels().docsApproved)),
      Padding(
          padding: EdgeInsets.all(0.5.h),
          child: stageId == 5
              ? DueActionListButton(
                  text: AppMetaLabels().makePayment,
                  srNo: '4',
                  onPressed: getCDController
                              .getContractsDetails.value.contract!.isCanceled ==
                          1
                      ? () {
                          SnakBarWidget.getSnackBarErrorBlue(
                              AppMetaLabels().alert,
                              AppMetaLabels().yourRequestCancelled);
                        }
                      : () {
                          SessionController().setContractID(getCDController
                              .getContractsDetails.value.contract!.contractId);
                          SessionController().setContractNo(getCDController
                              .getContractsDetails.value.contract!.contractno);
                          Get.to(() => OutstandingPayments(
                                contractNo: getCDController.getContractsDetails
                                    .value.contract!.contractno,
                                contractId: getCDController.getContractsDetails
                                    .value.contract!.contractId,
                              ));
                        })
              : StepNoWidget(label: '4', tooltip: AppMetaLabels().makePayment)),
      Padding(
          padding: EdgeInsets.all(0.5.h),
          child: stageId == 6
              ? Obx(() {
                  return DueActionListButton(
                      text: AppMetaLabels().signContract2,
                      srNo: '5',
                      loading: contractDownloadController.downloading.value,
                      onPressed: getCDController.getContractsDetails.value
                                  .contract!.isCanceled ==
                              1
                          ? () {
                              SnakBarWidget.getSnackBarErrorBlue(
                                  AppMetaLabels().alert,
                                  AppMetaLabels().yourRequestCancelled);
                            }
                          : () async {
                              getCDController.isEnableScreen.value = false;

                              SessionController().setContractID(getCDController
                                  .getContractsDetails
                                  .value
                                  .contract!
                                  .contractId);
                              SessionController().setContractNo(getCDController
                                  .getContractsDetails
                                  .value
                                  .contract!
                                  .contractno);

                              // for loading
                              SnakBarWidget.getLoadingWithColor();
                              await Future.delayed(Duration(seconds: 0));
                              SnakBarWidget.getSnackBarErrorBlue(
                                AppMetaLabels().loading,
                                AppMetaLabels().generatingContractInfo,
                              );

                              String path = await contractDownloadController
                                  .downloadContract(
                                      getCDController.getContractsDetails.value
                                          .contract!.contractno??'',
                                      false);
                              getCDController.isEnableScreen.value = true;
                              if (path != null) {
                                Get.closeAllSnackbars();
                                Get.to(() => AuthenticateContract(
                                    contractNo: getCDController
                                        .getContractsDetails
                                        .value
                                        .contract!
                                        .contractno,
                                    contractId: getCDController
                                        .getContractsDetails
                                        .value
                                        .contract!
                                        .contractId,
                                    filePath: path,
                                    dueActionId: getCDController
                                        .getContractsDetails
                                        .value
                                        .caseStageInfo!
                                        .dueActionid,
                                    stageId: getCDController.getContractsDetails
                                        .value.caseStageInfo!.stageId,
                                    caller: 'contract!',
                                    caseId: getCDController.getContractsDetails
                                        .value.caseStageInfo!.caseid));
                              }
                            });
                })
              : StepNoWidget(
                  label: '5', tooltip: AppMetaLabels().signContract2)),
      Padding(
          padding: EdgeInsets.all(0.5.h),
          child: stageId == 7
              ? DueActionListButton(
                  text: AppMetaLabels().contractSigned,
                  srNo: '6',
                  onPressed: getCDController
                              .getContractsDetails.value.contract!.isCanceled ==
                          1
                      ? () {
                          SnakBarWidget.getSnackBarErrorBlue(
                              AppMetaLabels().alert,
                              AppMetaLabels().yourRequestCancelled);
                        }
                      : () {})
              : StepNoWidget(
                  label: '6', tooltip: AppMetaLabels().contractSigned)),
      Padding(
          padding: EdgeInsets.all(0.5.h),
          child: stageId == 8
              ? DueActionListButton(
                  text: AppMetaLabels().approveMunicipal,
                  srNo: '7',
                  onPressed: getCDController
                              .getContractsDetails.value.contract!.isCanceled ==
                          1
                      ? () {
                          SnakBarWidget.getSnackBarErrorBlue(
                              AppMetaLabels().alert,
                              AppMetaLabels().yourRequestCancelled);
                        }
                      : () {
                          Get.to(() => MunicipalApproval(
                                caller: 'contract!',
                                dueActionId: getCDController.getContractsDetails
                                    .value.caseStageInfo!.dueActionid??0,
                                contractId: getCDController.getContractsDetails
                                    .value.contract!.contractId,
                              ));
                        })
              : StepNoWidget(
                  label: '7', tooltip: AppMetaLabels().approveMunicipal)),
      Padding(
          padding: EdgeInsets.all(0.5.h),
          child: stageId == 9
              ? DueActionListButton(
                  srNo: '8',
                  text: AppMetaLabels().downloadContract,
                  loading: getCDController.downloadingContract.value,
                  onPressed: getCDController
                              .getContractsDetails.value.contract!.isCanceled ==
                          1
                      ? () {
                          SnakBarWidget.getSnackBarErrorBlue(
                              AppMetaLabels().alert,
                              AppMetaLabels().yourRequestCancelled);
                        }
                      : () {
                          if (getCDController.canDownloadContract.canDownload ==
                              '1')
                            getCDController.downloadContract();
                          else if (getCDController
                                  .canDownloadContract.canDownload ==
                              '2')
                            Get.snackbar(AppMetaLabels().error,
                                getCDController.canDownloadContract.message??"",
                                backgroundColor: AppColors.white54);
                        })
              : StepNoWidget(
                  label: '8', tooltip: AppMetaLabels().downloadContract)),
    ];
    return ScrollablePositionedList.builder(
      itemScrollController: itemScrollController,
      scrollDirection: Axis.horizontal,
      itemCount: 8,
      itemBuilder: (context, index2) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (itemScrollController.isAttached)
            itemScrollController.scrollTo(
                index: dueActionIndex,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn);
        });
        return actionList[index2];
      },
    );
  }
}

class CustomButton2 extends StatelessWidget {
  final Function? onPressed;
  final String? text;
  final bool? loading;
  const CustomButton2(
      {Key? key, this.onPressed, this.text, this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
      child: ElevatedButton(
        onPressed: loading!
            ? null
            : () {
                onPressed!();
              },
        child: loading!
            ? AnimatedTextKit(
                isRepeatingAnimation: true,
                repeatForever: true,
                pause: Duration(milliseconds: 10),
                animatedTexts: [
                  ColorizeAnimatedText(text??"",
                      textStyle: AppTextStyle.normalBlue12
                          .copyWith(color: Colors.white),
                      colors: [
                        AppColors.blueColor,
                        AppColors.blueColor2,
                        AppColors.blueColor
                      ],
                      speed: Duration(milliseconds: 200)),
                ],
              )
            : Text(
                text ?? '',
                style: AppTextStyle.normalBlue12.copyWith(color: Colors.white),
              ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0.sp),
            ),
            backgroundColor: AppColors.blueColor3,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 8)),
      ),
    );
  }
}
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:fap_properties/data/helpers/session_controller.dart';
// import 'package:fap_properties/utils/constants/assets_path.dart';
// import 'package:fap_properties/utils/constants/meta_labels.dart';
// import 'package:fap_properties/utils/screen_disable.dart';
// import 'package:fap_properties/utils/styles/colors.dart';
// import 'package:fap_properties/utils/styles/text_styles.dart';
// import 'package:fap_properties/views/tenant/tenant_contracts/make_payment/outstanding_payments/outstanding_payments.dart';
// import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
// import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
// import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
// // import 'package:fap_properties/views/tenant/tenant_contracts/contract_checkin/contract_checkin.dart';
// import 'package:fap_properties/views/tenant/tenant_contracts/contract_extension/contract_extend.dart';
// import 'package:fap_properties/views/tenant/tenant_contracts/contract_renewel/contract_renewel.dart';
// import 'package:fap_properties/views/tenant/tenant_contracts/contract_termination/contract_terminate.dart';
// import 'package:fap_properties/views/tenant/tenant_contracts/legal_settlement/legal_settlement.dart';
// import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_tabs.dart/tenant_contracts_details.dart/authenticate_contract/authenticate_contract.dart';
// import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request_details/tenant_service_request_tab/tenant_service_request_tab.dart';
// import 'package:fap_properties/views/widgets/bottom_shadow.dart';
// import 'package:fap_properties/views/widgets/snackbar_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:marquee/marquee.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
// import 'package:sizer/sizer.dart';

// import '../../../../widgets/common_widgets/status_widget.dart';
// import '../../../../widgets/custom_button.dart';
// import '../../../../widgets/due_action_List_button.dart';
// import '../../../../widgets/step_no_widget.dart';
// import 'municipal_approval/municipal_approval.dart';
// import 'tenant_contract_download/tenant_contract_download_controller.dart';
// import 'tenant_contracts_detail_controller.dart';

// class MainInfo extends StatefulWidget {
//   final String prevContractNo;
//   const MainInfo({Key key, @required this.prevContractNo}) : super(key: key);

//   @override
//   _MainInfoState createState() => _MainInfoState();
// }

// class _MainInfoState extends State<MainInfo> {
//   final getCDController = Get.put(GetContractsDetailsController());
//   // final getCDController = Get.find<GetContractsDetailsController>();
//   final contractDownloadController = Get.put(ContractDownloadController());

//   @override
//   void initState() {
//     print('****************');
//     print(getCDController.getContractsDetails.value.contract!.isCanceled);
//     print(getCDController.getContractsDetails.value.contract!.contractno);
//     print(getCDController.getContractsDetails.value.caseNo);
//     print('****************');
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: Stack(
//           children: [
//             SingleChildScrollView(
//               child: Obx(() {
//                 return Container(
//                   height: getCDController.canDownload.value &&
//                           getCDController.getContractsDetails.value.contract!
//                                   .contractStatus ==
//                               'Legal Case'
//                       ? 115.h
//                       : getCDController.canDownload.value
//                           ? 105.h
//                           : getCDController.getContractsDetails.value.contract!
//                                       .contractStatus ==
//                                   'Legal Case'
//                               ? 95.h
//                               : 85.h,
//                   child: Padding(
//                     padding: EdgeInsets.only(top: 1.h),
//                     child: Obx(
//                       () {
//                         return getCDController.loadingContract.value == true
//                             ? LoadingIndicatorBlue()
//                             : getCDController.errorLoadingContract.value != ''
//                                 ? AppErrorWidget(
//                                     errorText: getCDController
//                                         .errorLoadingContract.value,
//                                   )
//                                 : Padding(
//                                     padding: EdgeInsets.all(2.0.h),
//                                     child: Column(
//                                       children: [
//                                         Container(
//                                           width: 94.0.w,
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius:
//                                                 BorderRadius.circular(2.0.h),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: Colors.black12,
//                                                 blurRadius: 0.5.h,
//                                                 spreadRadius: 0.3.h,
//                                                 offset: Offset(0.1.h, 0.1.h),
//                                               ),
//                                             ],
//                                           ),
//                                           child: Padding(
//                                             padding: EdgeInsets.all(2.5.h),
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   AppMetaLabels()
//                                                       .contractLength,
//                                                   style: AppTextStyle
//                                                       .semiBoldBlack12,
//                                                 ),
//                                                 Align(
//                                                   alignment:
//                                                       Alignment.bottomRight,
//                                                   child: Text(
//                                                     getCDController.daysPassed
//                                                                 .toString() +
//                                                             '/' +
//                                                             getCDController
//                                                                 .getContractsDetails
//                                                                 .value
//                                                                 .contract!
//                                                                 .noOfDays
//                                                                 .toString() ??
//                                                         "",
//                                                     style: AppTextStyle
//                                                         .normalBlack10,
//                                                   ),
//                                                 ),
//                                                 LinearProgressIndicator(
//                                                   value: getCDController.comPtg,
//                                                   backgroundColor: AppColors
//                                                       .chartlightBlueColor,
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(
//                                                       top: 2.0.h,
//                                                       bottom: 2.0.h),
//                                                   child: Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceBetween,
//                                                     children: [
//                                                       Column(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .start,
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           Text(
//                                                             AppMetaLabels()
//                                                                 .contractDate,
//                                                             style: AppTextStyle
//                                                                 .normalBlack10,
//                                                           ),
//                                                           Text(
//                                                             getCDController
//                                                                     .getContractsDetails
//                                                                     .value
//                                                                     .contract!
//                                                                     .contractDate ??
//                                                                 "",
//                                                             style: AppTextStyle
//                                                                 .semiBoldBlack10,
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       Column(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .start,
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           Text(
//                                                             AppMetaLabels()
//                                                                 .startDate,
//                                                             style: AppTextStyle
//                                                                 .normalBlack10,
//                                                           ),
//                                                           Text(
//                                                             getCDController
//                                                                     .getContractsDetails
//                                                                     .value
//                                                                     .contract!
//                                                                     .contractStartDate ??
//                                                                 "",
//                                                             style: AppTextStyle
//                                                                 .semiBoldBlack10,
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       Column(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .start,
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           Text(
//                                                             AppMetaLabels()
//                                                                 .endDate,
//                                                             style: AppTextStyle
//                                                                 .normalBlack10,
//                                                           ),
//                                                           Text(
//                                                             getCDController
//                                                                     .getContractsDetails
//                                                                     .value
//                                                                     .contract!
//                                                                     .contractEndDate ??
//                                                                 "",
//                                                             style: AppTextStyle
//                                                                 .semiBoldBlack10,
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     Column(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         Text(
//                                                           AppMetaLabels()
//                                                               .contractAmount,
//                                                           style: AppTextStyle
//                                                               .normalBlack11,
//                                                         ),
//                                                         Text(
//                                                           "${AppMetaLabels().aed} ${getCDController.amount}",
//                                                           style: AppTextStyle
//                                                               .semiBoldBlack11,
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     Spacer(),
//                                                     Column(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .end,
//                                                       children: [
//                                                         Text(
//                                                           AppMetaLabels()
//                                                               .status,
//                                                           style: AppTextStyle
//                                                               .normalBlack11,
//                                                         ),
//                                                         ConstrainedBox(
//                                                           constraints:
//                                                               BoxConstraints(
//                                                                   maxWidth:
//                                                                       27.w),
//                                                           child: FittedBox(
//                                                             child: StatusWidget(
//                                                               text: SessionController()
//                                                                           .getLanguage() ==
//                                                                       1
//                                                                   ? getCDController
//                                                                       .getContractsDetails
//                                                                       .value
//                                                                       .contract!
//                                                                       .contractStatus
//                                                                   : getCDController
//                                                                           .getContractsDetails
//                                                                           .value
//                                                                           .contract!
//                                                                           .contractStatusAR ??
//                                                                       '',
//                                                               valueToCompare:
//                                                                   getCDController
//                                                                       .getContractsDetails
//                                                                       .value
//                                                                       .contract!
//                                                                       .contractStatus,
//                                                             ),
//                                                           ),
//                                                         )
//                                                       ],
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 SizedBox(
//                                                   height: 2.h,
//                                                 ),
//                                                 if (widget.prevContractNo !=
//                                                         null &&
//                                                     getCDController
//                                                             .getContractsDetails
//                                                             .value
//                                                             .contract!
//                                                             .contractno !=
//                                                         widget.prevContractNo)
//                                                   Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceBetween,
//                                                     children: [
//                                                       Text(
//                                                         AppMetaLabels()
//                                                             .prevContractNo,
//                                                         style: AppTextStyle
//                                                             .normalBlack11,
//                                                       ),
//                                                       Text(
//                                                         widget.prevContractNo,
//                                                         style: AppTextStyle
//                                                             .semiBoldBlack11,
//                                                       ),
//                                                     ],
//                                                   )
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.only(top: 3.0.h),
//                                           child: Container(
//                                             width: 94.0.w,
//                                             decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               borderRadius:
//                                                   BorderRadius.circular(2.0.h),
//                                               boxShadow: [
//                                                 BoxShadow(
//                                                   color: Colors.black12,
//                                                   blurRadius: 0.5.h,
//                                                   spreadRadius: 0.3.h,
//                                                   offset: Offset(0.1.h, 0.1.h),
//                                                 ),
//                                               ],
//                                             ),
//                                             child: Padding(
//                                               padding: EdgeInsets.all(2.5.h),
//                                               child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.start,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Row(
//                                                     children: [
//                                                       Text(
//                                                         AppMetaLabels()
//                                                             .property,
//                                                         style: AppTextStyle
//                                                             .semiBoldBlack11,
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   Padding(
//                                                     padding: EdgeInsets.only(
//                                                         top: 2.0.h),
//                                                     child: Text(
//                                                       SessionController()
//                                                                   .getLanguage() ==
//                                                               1
//                                                           ? getCDController
//                                                                   .getContractsDetails
//                                                                   .value
//                                                                   .contract!
//                                                                   .unitName
//                                                                   .toString() ??
//                                                               ""
//                                                           : getCDController
//                                                                   .getContractsDetails
//                                                                   .value
//                                                                   .contract!
//                                                                   .unitNameAr
//                                                                   .toString() ??
//                                                               "",
//                                                       style: AppTextStyle
//                                                           .normalBlack10,
//                                                     ),
//                                                   ),
//                                                   Padding(
//                                                     padding: EdgeInsets.only(
//                                                         top: 1.5.h),
//                                                     child: Container(
//                                                       child: Text(
//                                                         SessionController()
//                                                                     .getLanguage() ==
//                                                                 1
//                                                             ? getCDController
//                                                                     .getContractsDetails
//                                                                     .value
//                                                                     .contract!
//                                                                     .address
//                                                                     .toString() ??
//                                                                 ''
//                                                             : getCDController
//                                                                     .getContractsDetails
//                                                                     .value
//                                                                     .contract!
//                                                                     .addressAr
//                                                                     .toString() ??
//                                                                 '',
//                                                         style: AppTextStyle
//                                                             .semiBoldBlack10,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         if (getCDController
//                                                 .errorLoadingContractPayables
//                                                 .value !=
//                                             AppMetaLabels().noDatafound)
//                                           getCDController
//                                                   .loadingContractPayables.value
//                                               ? Padding(
//                                                   padding: EdgeInsets.only(
//                                                     left: 4.0,
//                                                     right: 4.0,
//                                                     top: 5.h,
//                                                   ),
//                                                   child: LoadingIndicatorBlue(
//                                                     size: 20,
//                                                   ),
//                                                 )
//                                               : Padding(
//                                                   padding: EdgeInsets.only(
//                                                       top: 3.0.h),
//                                                   child: Container(
//                                                     width: 94.0.w,
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.white,
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               2.0.h),
//                                                       boxShadow: [
//                                                         BoxShadow(
//                                                           color: Colors.black12,
//                                                           blurRadius: 0.5.h,
//                                                           spreadRadius: 0.3.h,
//                                                           offset: Offset(
//                                                               0.1.h, 0.1.h),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     child: Padding(
//                                                       padding:
//                                                           EdgeInsets.all(2.5.h),
//                                                       child: Column(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .start,
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           Text(
//                                                             AppMetaLabels()
//                                                                 .outstandingPayment,
//                                                             style: AppTextStyle
//                                                                 .semiBoldBlack11,
//                                                           ),
//                                                           // getCDController
//                                                           //         .loadingContractPayables
//                                                           //         .value
//                                                           //     ? Padding(
//                                                           //         padding:
//                                                           //             const EdgeInsets
//                                                           //                 .all(4.0),
//                                                           //         child:
//                                                           //             LoadingIndicatorBlue(
//                                                           //           size: 20,
//                                                           //         ),
//                                                           //       )
//                                                           //     :
//                                                           getCDController
//                                                                       .errorLoadingContractPayables
//                                                                       .value !=
//                                                                   ''
//                                                               ? AppErrorWidget(
//                                                                   errorText:
//                                                                       getCDController
//                                                                           .errorLoadingContractPayables
//                                                                           .value,
//                                                                 )
//                                                               : Column(
//                                                                   children: [
//                                                                     SizedBox(
//                                                                       height:
//                                                                           1.5.h,
//                                                                     ),
//                                                                     if (getCDController
//                                                                             .totalRentalPayment
//                                                                             .value !=
//                                                                         '0.00')
//                                                                       Padding(
//                                                                         padding:
//                                                                             EdgeInsets.only(top: 1.h),
//                                                                         child:
//                                                                             Row(
//                                                                           children: [
//                                                                             Text(
//                                                                               AppMetaLabels().renatalpayments,
//                                                                               style: AppTextStyle.normalBlack10,
//                                                                             ),
//                                                                             Spacer(),
//                                                                             Text(
//                                                                               '${AppMetaLabels().aed} ${getCDController.totalRentalPayment.value}',
//                                                                               style: AppTextStyle.semiBoldBlack11,
//                                                                             ),
//                                                                           ],
//                                                                         ),
//                                                                       ),
//                                                                     if (getCDController
//                                                                             .totalAdditionalCharges
//                                                                             .value !=
//                                                                         '0.00')
//                                                                       Padding(
//                                                                         padding:
//                                                                             EdgeInsets.only(top: 1.h),
//                                                                         child:
//                                                                             Row(
//                                                                           children: [
//                                                                             Text(
//                                                                               AppMetaLabels().additionalCharges,
//                                                                               style: AppTextStyle.normalBlack10,
//                                                                             ),
//                                                                             Spacer(),
//                                                                             Text(
//                                                                               '${AppMetaLabels().aed} ${getCDController.totalAdditionalCharges.value}',
//                                                                               style: AppTextStyle.semiBoldBlack11,
//                                                                             ),
//                                                                           ],
//                                                                         ),
//                                                                       ),
//                                                                     if (getCDController
//                                                                             .totalVatOnRent
//                                                                             .value !=
//                                                                         '0.00')
//                                                                       Padding(
//                                                                         padding:
//                                                                             EdgeInsets.only(top: 1.h),
//                                                                         child:
//                                                                             Row(
//                                                                           children: [
//                                                                             Text(
//                                                                               AppMetaLabels().vatOnRent,
//                                                                               style: AppTextStyle.normalBlack10,
//                                                                             ),
//                                                                             Spacer(),
//                                                                             Text(
//                                                                               '${AppMetaLabels().aed} ${getCDController.totalVatOnRent.value}',
//                                                                               style: AppTextStyle.semiBoldBlack11,
//                                                                             ),
//                                                                           ],
//                                                                         ),
//                                                                       ),
//                                                                     if (getCDController
//                                                                             .totalVatOnCharges
//                                                                             .value !=
//                                                                         '0.00')
//                                                                       Padding(
//                                                                         padding:
//                                                                             EdgeInsets.only(top: 1.h),
//                                                                         child:
//                                                                             Row(
//                                                                           children: [
//                                                                             Text(
//                                                                               AppMetaLabels().vatOnCharges,
//                                                                               style: AppTextStyle.normalBlack10,
//                                                                             ),
//                                                                             Spacer(),
//                                                                             Text(
//                                                                               '${AppMetaLabels().aed} ${getCDController.totalVatOnCharges.value}',
//                                                                               style: AppTextStyle.semiBoldBlack11,
//                                                                             ),
//                                                                           ],
//                                                                         ),
//                                                                       ),
//                                                                     SizedBox(
//                                                                       height:
//                                                                           1.0.h,
//                                                                     ),
//                                                                     Row(
//                                                                       children: [
//                                                                         Text(
//                                                                           AppMetaLabels()
//                                                                               .totalpayments,
//                                                                           style:
//                                                                               AppTextStyle.normalBlack10,
//                                                                         ),
//                                                                         Spacer(),
//                                                                         Text(
//                                                                           '${AppMetaLabels().aed} ${getCDController.sumOfAllPayments.value}',
//                                                                           style:
//                                                                               AppTextStyle.semiBoldBlack11,
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                     if (getCDController
//                                                                             .getContractsDetails
//                                                                             .value
//                                                                             .canPayment ==
//                                                                         1)
//                                                                       Column(
//                                                                         children: [
//                                                                           SizedBox(
//                                                                             height:
//                                                                                 1.5.h,
//                                                                           ),
//                                                                           AppDivider(),
//                                                                           SizedBox(
//                                                                             height:
//                                                                                 1.5.h,
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .center,
//                                                                       child:
//                                                                           Material(
//                                                                         child:
//                                                                             InkWell(
//                                                                           onTap: getCDController.getContractsDetails.value.contract!.isCanceled == 1
//                                                                               ? () {
//                                                                                   SnakBarWidget.getSnackBarErrorBlue(AppMetaLabels().alert, AppMetaLabels().yourRequestCancelled);
//                                                                                 }
//                                                                               : () {
//                                                                                   Get.to(() => OutstandingPayments(
//                                                                                         contractNo: getCDController.getContractsDetails.value.contract!.contractno,
//                                                                                         contractId: getCDController.getContractsDetails.value.contract!.contractId,
//                                                                                       ));
//                                                                                 },
//                                                                           child:
//                                                                               Padding(
//                                                                             padding:
//                                                                                 const EdgeInsets.all(8.0),
//                                                                             child:
//                                                                                 Text(
//                                                                               // getCDController.outstandingPaymentsController.gotoOnlinePayments.value?
//                                                                               AppMetaLabels().proceedTopay,
//                                                                               // : AppMetaLabels().chequeDetailsC,
//                                                                               style: AppTextStyle.semiBoldBlue10,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 )
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                         // today
//                                         // Obx(() {
//                                         //   return getCDController.loadingCanDownload.value ||
//                                         //           getCDController
//                                         //                   .getContractsDetails
//                                         //                   .value
//                                         //                   .caseStageInfo
//                                         //                   .stageId ==
//                                         //               null ||
//                                         //           getCDController
//                                         //                   .getContractsDetails
//                                         //                   .value
//                                         //                   .caseStageInfo
//                                         //                   .stageId <
//                                         //               8
//                                         //       ? SizedBox()
//                                         //       : getCDController.canDownloadContract
//                                         //                   .canDownload ==
//                                         //               '1'
//                                         //           ? Container(
//                                         //               width: 100.0.w,
//                                         //               padding:
//                                         //                   EdgeInsets.all(2.0.h),
//                                         //               margin:
//                                         //                   EdgeInsets.only(top: 3.h),
//                                         //               decoration: BoxDecoration(
//                                         //                 color: Colors.white,
//                                         //                 borderRadius:
//                                         //                     BorderRadius.circular(
//                                         //                         1.0.h),
//                                         //                 boxShadow: [
//                                         //                   BoxShadow(
//                                         //                     color: Colors.black12,
//                                         //                     blurRadius: 1.0.h,
//                                         //                     spreadRadius: 0.6.h,
//                                         //                     offset: Offset(
//                                         //                         0.0.h, 0.7.h),
//                                         //                   ),
//                                         //                 ],
//                                         //               ),
//                                         //               child: Column(
//                                         //                 mainAxisAlignment:
//                                         //                     MainAxisAlignment.start,
//                                         //                 crossAxisAlignment:
//                                         //                     CrossAxisAlignment
//                                         //                         .start,
//                                         //                 children: [
//                                         //                   Text(
//                                         //                     AppMetaLabels()
//                                         //                         .documents,
//                                         //                     style: AppTextStyle
//                                         //                         .semiBoldBlack12,
//                                         //                   ),
//                                         //                   SizedBox(
//                                         //                     height: 2.0.h,
//                                         //                   ),
//                                         //                   contractDownloadController
//                                         //                               .downloading
//                                         //                               .value ==
//                                         //                           true
//                                         //                       ? LoadingIndicatorBlue()
//                                         //                       : InkWell(
//                                         //                           onTap: () {
//                                         //                             {
//                                         //                               getCDController
//                                         //                                   .downloadContract();
//                                         //                             }
//                                         //                           },
//                                         //                           child: Row(
//                                         //                             mainAxisAlignment:
//                                         //                                 MainAxisAlignment
//                                         //                                     .start,
//                                         //                             crossAxisAlignment:
//                                         //                                 CrossAxisAlignment
//                                         //                                     .center,
//                                         //                             children: [
//                                         //                               Image.asset(
//                                         //                                 AppImagesPath
//                                         //                                     .document,
//                                         //                                 fit: BoxFit
//                                         //                                     .cover,
//                                         //                               ),
//                                         //                               Padding(
//                                         //                                 padding: EdgeInsets.symmetric(
//                                         //                                     horizontal:
//                                         //                                         4.0.w),
//                                         //                                 child: Text(
//                                         //                                   AppMetaLabels()
//                                         //                                       .downloadContract,
//                                         //                                   style: AppTextStyle
//                                         //                                       .normalBlue12,
//                                         //                                 ),
//                                         //                               ),
//                                         //                               Spacer(),
//                                         //                               Icon(
//                                         //                                 Icons
//                                         //                                     .download,
//                                         //                                 size: 3.0.h,
//                                         //                               )
//                                         //                             ],
//                                         //                           ),
//                                         //                         ),
//                                         //                 ],
//                                         //               ),
//                                         //             )
//                                         //           : getCDController
//                                         //                       .canDownloadContract
//                                         //                       .canDownload ==
//                                         //                   '0'
//                                         //               ? Container(
//                                         //                   alignment:
//                                         //                       Alignment.center,
//                                         //                   padding:
//                                         //                       EdgeInsets.all(8.0),
//                                         //                   margin: EdgeInsets.only(
//                                         //                     top: 2.h,
//                                         //                   ),
//                                         //                   decoration: BoxDecoration(
//                                         //                       color: Color.fromRGBO(
//                                         //                           255, 249, 235, 1),
//                                         //                       borderRadius:
//                                         //                           BorderRadius
//                                         //                               .circular(8)),
//                                         //                   child: Row(
//                                         //                     crossAxisAlignment:
//                                         //                         CrossAxisAlignment
//                                         //                             .center,
//                                         //                     children: [
//                                         //                       Icon(
//                                         //                         Icons.error_outline,
//                                         //                         color: Colors
//                                         //                             .amber[400],
//                                         //                       ),
//                                         //                       SizedBox(
//                                         //                         width: 8.0,
//                                         //                       ),
//                                         //                       // 112233 error alert
//                                         //                       Expanded(
//                                         //                         child: Text(
//                                         //                           SessionController()
//                                         //                                       .getLanguage() ==
//                                         //                                   1
//                                         //                               ? getCDController
//                                         //                                       .canDownloadContract
//                                         //                                       .message ??
//                                         //                                   ''
//                                         //                               : getCDController
//                                         //                                       .canDownloadContract
//                                         //                                       .messageAR ??
//                                         //                                   "",
//                                         //                           style: AppTextStyle
//                                         //                               .normalBlack12,
//                                         //                         ),
//                                         //                       ),
//                                         //                     ],
//                                         //                   ),
//                                         //                 )
//                                         //               : SizedBox();
//                                         // }),

//                                         // today Feed Back
//                                         // getCDController.getContractsDetails.value
//                                         //                 .caseNo
//                                         //                 .toString() ==
//                                         //             null ||
//                                         //         getCDController.getContractsDetails
//                                         //                 .value.caseNo ==
//                                         //             0 ||
//                                         //         getCDController.getContractsDetails
//                                         //                 .value.caseNo ==
//                                         //             0.0
//                                         //     ? SizedBox()
//                                         //     : Obx(() {
//                                         //         return getCDController
//                                         //                     .loadingCanDownload
//                                         //                     .value ||
//                                         //                 getCDController
//                                         //                         .getContractsDetails
//                                         //                         .value
//                                         //                         .caseStageInfo
//                                         //                         .stageId ==
//                                         //                     null ||
//                                         //                 getCDController
//                                         //                         .getContractsDetails
//                                         //                         .value
//                                         //                         .caseStageInfo
//                                         //                         .stageId <
//                                         //                     8
//                                         //             ? SizedBox()
//                                         //             : getCDController
//                                         //                         .canDownloadContract
//                                         //                         .canDownload ==
//                                         //                     '1'
//                                         //                 ? Padding(
//                                         //                     padding: EdgeInsets
//                                         //                         .symmetric(
//                                         //                             horizontal:
//                                         //                                 0.3.h,
//                                         //                             vertical:
//                                         //                                 0.5.h),
//                                         //                     child: InkWell(
//                                         //                         onTap: () async {
//                                         //                           print(
//                                         //                               '****************');
//                                         //                           print(getCDController
//                                         //                               .getContractsDetails
//                                         //                               .value
//                                         //                               .caseNo);
//                                         //                           print(getCDController
//                                         //                               .getContractsDetails
//                                         //                               .value
//                                         //                               .message);
//                                         //                           print(getCDController
//                                         //                               .getContractsDetails
//                                         //                               .value
//                                         //                               .status);
//                                         //                           print(
//                                         //                               '****************');
//                                         //                           SessionController()
//                                         //                               .setCaseNo(
//                                         //                             getCDController
//                                         //                                 .getContractsDetails
//                                         //                                 .value
//                                         //                                 .caseNo
//                                         //                                 .toString(),
//                                         //                           );
//                                         //                           Get.to(() =>
//                                         //                               TenantServiceRequestTabs(
//                                         //                                 requestNo: getCDController
//                                         //                                     .getContractsDetails
//                                         //                                     .value
//                                         //                                     .caseNo
//                                         //                                     .toString(),
//                                         //                                 caller:
//                                         //                                     'contract!',
//                                         //                                 title: AppMetaLabels()
//                                         //                                     .renewalReq,
//                                         //                                 initialIndex:
//                                         //                                     0,
//                                         //                               ));
//                                         //                         },
//                                         //                         child: Container(
//                                         //                           alignment:
//                                         //                               Alignment
//                                         //                                   .center,
//                                         //                           padding:
//                                         //                               EdgeInsets
//                                         //                                   .all(5.0),
//                                         //                           margin: EdgeInsets
//                                         //                               .only(
//                                         //                                   top: 2.h,
//                                         //                                   bottom:
//                                         //                                       2.h),
//                                         //                           decoration: BoxDecoration(
//                                         //                               color: AppColors
//                                         //                                   .blueColor,
//                                         //                               borderRadius:
//                                         //                                   BorderRadius
//                                         //                                       .circular(
//                                         //                                           8)),
//                                         //                           child: Row(
//                                         //                             crossAxisAlignment:
//                                         //                                 CrossAxisAlignment
//                                         //                                     .center,
//                                         //                             children: [
//                                         //                               SizedBox(
//                                         //                                 width: 8.0,
//                                         //                               ),
//                                         //                               Icon(
//                                         //                                 Icons.info,
//                                         //                                 color: Colors
//                                         //                                     .white,
//                                         //                               ),
//                                         //                               SizedBox(
//                                         //                                 width: 8.0,
//                                         //                               ),
//                                         //                               Expanded(
//                                         //                                 child:
//                                         //                                     SizedBox(
//                                         //                                   height:
//                                         //                                       4.h,
//                                         //                                   child: Marquee(
//                                         //                                       text: AppMetaLabels()
//                                         //                                           .clickHereFeedback,
//                                         //                                       style: AppTextStyle
//                                         //                                           .normalBlue12
//                                         //                                           .copyWith(color: Colors.white)
//                                         //                                           .copyWith(fontWeight: FontWeight.bold)),
//                                         //                                 ),
//                                         //                               ),
//                                         //                             ],
//                                         //                           ),
//                                         //                         )))
//                                         //                 : SizedBox();
//                                         //       }),

//                                         if (getCDController
//                                                 .getContractsDetails
//                                                 .value
//                                                 .contract!
//                                                 .contractStatus ==
//                                             'Legal Case')
//                                           Container(
//                                               width: 100.0.w,
//                                               margin: EdgeInsets.only(top: 3.h),
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                         1.0.h),
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                     color: Colors.black12,
//                                                     blurRadius: 1.0.h,
//                                                     spreadRadius: 0.6.h,
//                                                     offset:
//                                                         Offset(0.0.h, 0.7.h),
//                                                   ),
//                                                 ],
//                                               ),
//                                               child: getCDController
//                                                           .getContractsDetails
//                                                           .value
//                                                           .legalCaseNo ==
//                                                       0
//                                                   ? CustomButton2(
//                                                       text: AppMetaLabels()
//                                                           .reqLegalSettlement,
//                                                       onPressed: () {
//                                                         Get.to(
//                                                             () =>
//                                                                 LegalSettlement(
//                                                                   contractNo: getCDController
//                                                                       .getContractsDetails
//                                                                       .value
//                                                                       .contract!
//                                                                       .contractno,
//                                                                   contractId: getCDController
//                                                                       .getContractsDetails
//                                                                       .value
//                                                                       .contract!
//                                                                       .contractId,
//                                                                 ));
//                                                       },
//                                                     )
//                                                   : Center(
//                                                       child: TextButton(
//                                                           onPressed: () {
//                                                             SessionController().setCaseNo(
//                                                                 getCDController
//                                                                     .getContractsDetails
//                                                                     .value
//                                                                     .legalCaseNo
//                                                                     .toString());
//                                                             Get.to(() =>
//                                                                 TenantServiceRequestTabs(
//                                                                   requestNo: getCDController
//                                                                       .getContractsDetails
//                                                                       .value
//                                                                       .legalCaseNo
//                                                                       .toString(),
//                                                                   caller:
//                                                                       'contract!',
//                                                                   title: AppMetaLabels()
//                                                                       .legalReq,
//                                                                 ));
//                                                           },
//                                                           child: Text(
//                                                             AppMetaLabels()
//                                                                 .reqLegalSettlementSubmitted,
//                                                             style: AppTextStyle
//                                                                 .normalBlue14,
//                                                           )),
//                                                     )),

//                                         // Obx(() {
//                                         //   return getCDController
//                                         //               .loadingCanCheckin.value ||
//                                         //           getCDController
//                                         //                   .errorLoadingCanCheckin !=
//                                         //               '' ||
//                                         //           !getCDController
//                                         //               .canCheckinModel.checkIn
//                                         //       ? SizedBox()
//                                         //       : Container(
//                                         //           width: 100.0.w,
//                                         //           margin: EdgeInsets.only(top: 3.h),
//                                         //           padding: EdgeInsets.all(2.0.h),
//                                         //           decoration: BoxDecoration(
//                                         //             color: Colors.white,
//                                         //             borderRadius:
//                                         //                 BorderRadius.circular(
//                                         //                     1.0.h),
//                                         //             boxShadow: [
//                                         //               BoxShadow(
//                                         //                 color: Colors.black12,
//                                         //                 blurRadius: 1.0.h,
//                                         //                 spreadRadius: 0.6.h,
//                                         //                 offset:
//                                         //                     Offset(0.0.h, 0.7.h),
//                                         //               ),
//                                         //             ],
//                                         //           ),
//                                         //           child: getCDController
//                                         //                       .canCheckinModel
//                                         //                       .caseNo ==
//                                         //                   0
//                                         //               ? ElevatedButton(
//                                         //                   onPressed: () {
//                                         //                     Get.to(
//                                         //                         () =>
//                                         //                             ContractCheckin(
//                                         //                               contractNo: getCDController
//                                         //                                   .getContractsDetails
//                                         //                                   .value
//                                         //                                   .contract!
//                                         //                                   .contractno,
//                                         //                               contractId: getCDController
//                                         //                                   .getContractsDetails
//                                         //                                   .value
//                                         //                                   .contract!
//                                         //                                   .contractId,
//                                         //                             ));
//                                         //                   },
//                                         //                   child: Text(
//                                         //                     AppMetaLabels().checkin,
//                                         //                     style: AppTextStyle
//                                         //                         .normalBlue12
//                                         //                         .copyWith(
//                                         //                             color: Colors
//                                         //                                 .white),
//                                         //                   ),
//                                         //                   style: ButtonStyle(
//                                         //                       elevation:
//                                         //                           MaterialStateProperty
//                                         //                               .all<double>(
//                                         //                                   0.0),
//                                         //                       backgroundColor:
//                                         //                           MaterialStateProperty
//                                         //                               .all<Color>(
//                                         //                                   AppColors
//                                         //                                       .blueColor3),
//                                         //                       shape: MaterialStateProperty
//                                         //                           .all<
//                                         //                               RoundedRectangleBorder>(
//                                         //                         RoundedRectangleBorder(
//                                         //                           borderRadius:
//                                         //                               BorderRadius
//                                         //                                   .circular(
//                                         //                                       2.0.w),
//                                         //                           // side: BorderSide(
//                                         //                           //  // color: AppColors.blueColor,
//                                         //                           //   width: 1.0,
//                                         //                           // )
//                                         //                         ),
//                                         //                       )),
//                                         //                 )
//                                         //               : Center(
//                                         //                   child: TextButton(
//                                         //                       onPressed: () {
//                                         //                         SessionController().setCaseNo(
//                                         //                             getCDController
//                                         //                                 .canCheckinModel
//                                         //                                 .caseNo
//                                         //                                 .toString());
//                                         //                         Get.to(() =>
//                                         //                             TenantServiceRequestTabs(
//                                         //                               requestNo: getCDController
//                                         //                                   .canCheckinModel
//                                         //                                   .caseNo
//                                         //                                   .toString(),
//                                         //                               showDocs:
//                                         //                                   true,
//                                         //                               showPhotos:
//                                         //                                   false,
//                                         //                               caller:
//                                         //                                   'contract!',
//                                         //                               title: AppMetaLabels()
//                                         //                                   .checkinReq,
//                                         //                             ));
//                                         //                       },
//                                         //                       child: Text(
//                                         //                         AppMetaLabels()
//                                         //                             .checkinReqSubmitted,
//                                         //                         style: AppTextStyle
//                                         //                             .normalBlue14,
//                                         //                       )),
//                                         //                 ));
//                                         // })
//                                       ],
//                                     ),
//                                   );
//                       },
//                     ),
//                   ),
//                 );
//               }),
//             ),
//             Obx(() {
//               return Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Container(
//                   height:
//                       getCDController.canDownload.value == false ? 0.h : 27.0.h,
// // // FEEDBACK NULL AND CANDOWNLOAD FALSE
// //                       getCDController.getContractsDetails.value.caseNo.toString() == null ||
// //                               getCDController.getContractsDetails.value.caseNo ==
// //                                   0 ||
// //                               getCDController.getContractsDetails.value.caseNo == 0.0 &&
// //                                   getCDController.canDownload.value == false
// //                           ? 0.h
// //                           :
// // // FEEDBACK !NULL AND CANDOWNLOAD TRUE
// //                           getCDController.canDownload.value == true &&
// //                                       getCDController.getContractsDetails.value.caseNo.toString() !=
// //                                           null ||
// //                                   getCDController.getContractsDetails.value.caseNo !=
// //                                       0 ||
// //                                   getCDController.getContractsDetails.value.caseNo !=
// //                                       0.0
// //                               ? 27.h
// //                               :
// // // FEEDBACK NULL AND CANDOWNLOAD TRUE
// //                               getCDController.canDownload.value == true &&
// //                                           getCDController.getContractsDetails
// //                                                   .value.caseNo
// //                                                   .toString() ==
// //                                               null ||
// //                                       getCDController.getContractsDetails.value.caseNo ==
// //                                           0 ||
// //                                       getCDController.getContractsDetails.value.caseNo ==
// //                                           0.0
// //                                   ? 14.h
// //                                   :
// // // FEEDBACK !NULL AND CANDOWNLOAD FALSE
// //                                   getCDController.canDownload.value == false &&
// //                                               getCDController
// //                                                       .getContractsDetails
// //                                                       .value
// //                                                       .caseNo
// //                                                       .toString() !=
// //                                                   null ||
// //                                           getCDController.getContractsDetails.value.caseNo != 0 ||
// //                                           getCDController.getContractsDetails.value.caseNo != 0.0
// //                                       ? 14.h
// //                                       : 0.h,
//                   width: double.infinity,
//                   padding: EdgeInsets.only(top: 0.5, bottom: 0.5),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(15),
//                         topRight: Radius.circular(15)),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 0.5.h,
//                         spreadRadius: 0.5.h,
//                         offset: Offset(0.1.h, 0.1.h),
//                       ),
//                     ],
//                   ),
//                   child: getCDController.canDownload.value == false
//                       ? SizedBox()
//                       : Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Obx(() {
//                               return getCDController.loadingCanDownload.value ||
//                                       getCDController.getContractsDetails.value
//                                               .caseStageInfo.stageId ==
//                                           null ||
//                                       getCDController.getContractsDetails.value
//                                               .caseStageInfo.stageId <
//                                           8
//                                   ? SizedBox()
//                                   : getCDController.canDownloadContract
//                                               .canDownload ==
//                                           '1'
//                                       ? Container(
//                                           width: 100.0.w,
//                                           padding: EdgeInsets.all(2.0.h),
//                                           margin: EdgeInsets.only(
//                                               top: 2.h, left: 5.w, right: 5.w),
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius:
//                                                 BorderRadius.circular(1.0.h),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: Colors.black12,
//                                                 blurRadius: 1.0.h,
//                                                 spreadRadius: 0.6.h,
//                                                 offset: Offset(0.0.h, 0.7.h),
//                                               ),
//                                             ],
//                                           ),
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 AppMetaLabels().documents,
//                                                 style: AppTextStyle
//                                                     .semiBoldBlack12,
//                                               ),
//                                               SizedBox(
//                                                 height: 2.0.h,
//                                               ),
//                                               contractDownloadController
//                                                           .downloading.value ==
//                                                       true
//                                                   ? LoadingIndicatorBlue()
//                                                   : InkWell(
//                                                       onTap: () {
//                                                         {
//                                                           getCDController
//                                                               .downloadContract();
//                                                         }
//                                                       },
//                                                       child: Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .start,
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .center,
//                                                         children: [
//                                                           Image.asset(
//                                                             AppImagesPath
//                                                                 .document,
//                                                             fit: BoxFit.cover,
//                                                           ),
//                                                           Padding(
//                                                             padding: EdgeInsets
//                                                                 .symmetric(
//                                                                     horizontal:
//                                                                         4.0.w),
//                                                             child: Text(
//                                                               AppMetaLabels()
//                                                                   .downloadContract,
//                                                               style: AppTextStyle
//                                                                   .normalBlue12,
//                                                             ),
//                                                           ),
//                                                           Spacer(),
//                                                           Icon(
//                                                             Icons.download,
//                                                             size: 3.0.h,
//                                                           )
//                                                         ],
//                                                       ),
//                                                     ),
//                                             ],
//                                           ),
//                                         )
//                                       : getCDController.canDownloadContract
//                                                   .canDownload ==
//                                               '0'
//                                           ? Container(
//                                               alignment: Alignment.center,
//                                               padding: EdgeInsets.all(8.0),
//                                               margin: EdgeInsets.only(
//                                                 top: 2.h,
//                                               ),
//                                               decoration: BoxDecoration(
//                                                   color: Color.fromRGBO(
//                                                       255, 249, 235, 1),
//                                                   borderRadius:
//                                                       BorderRadius.circular(8)),
//                                               child: Row(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.center,
//                                                 children: [
//                                                   Icon(
//                                                     Icons.error_outline,
//                                                     color: Colors.amber[400],
//                                                   ),
//                                                   SizedBox(
//                                                     width: 8.0,
//                                                   ),
//                                                   // 112233 error alert
//                                                   Expanded(
//                                                     child: Text(
//                                                       SessionController()
//                                                                   .getLanguage() ==
//                                                               1
//                                                           ? getCDController
//                                                                   .canDownloadContract
//                                                                   .message ??
//                                                               ''
//                                                           : getCDController
//                                                                   .canDownloadContract
//                                                                   .messageAR ??
//                                                               "",
//                                                       style: AppTextStyle
//                                                           .normalBlack12,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             )
//                                           : SizedBox();
//                             }),
//                             getCDController.getContractsDetails.value.caseNo
//                                             .toString() ==
//                                         null ||
//                                     getCDController
//                                             .getContractsDetails.value.caseNo ==
//                                         0 ||
//                                     getCDController
//                                             .getContractsDetails.value.caseNo ==
//                                         0.0
//                                 ? SizedBox(
//                                     height: 30,
//                                   )
//                                 : Container(
//                                     margin:
//                                         EdgeInsets.only(left: 5.w, right: 5.w),
//                                     child: Obx(() {
//                                       return getCDController.loadingCanDownload.value ||
//                                               getCDController
//                                                       .getContractsDetails
//                                                       .value
//                                                       .caseStageInfo
//                                                       .stageId ==
//                                                   null ||
//                                               getCDController
//                                                       .getContractsDetails
//                                                       .value
//                                                       .caseStageInfo
//                                                       .stageId <
//                                                   8
//                                           ? SizedBox()
//                                           :
//                                           getCDController.canDownloadContract
//                                                       .canDownload ==
//                                                   '1'
//                                               ? Padding(
//                                                   padding: EdgeInsets.symmetric(
//                                                       horizontal: 0.3.h,
//                                                       vertical: 0.5.h),
//                                                   child: InkWell(
//                                                       onTap: () async {
//                                                         print(
//                                                             '****************');
//                                                         print(getCDController
//                                                             .getContractsDetails
//                                                             .value
//                                                             .caseNo);
//                                                         print(getCDController
//                                                             .getContractsDetails
//                                                             .value
//                                                             .message);
//                                                         print(getCDController
//                                                             .getContractsDetails
//                                                             .value
//                                                             .status);
//                                                         print(
//                                                             '****************');
//                                                         SessionController()
//                                                             .setCaseNo(
//                                                           getCDController
//                                                               .getContractsDetails
//                                                               .value
//                                                               .caseNo
//                                                               .toString(),
//                                                         );
//                                                         Get.to(() =>
//                                                             TenantServiceRequestTabs(
//                                                               requestNo:
//                                                                   getCDController
//                                                                       .getContractsDetails
//                                                                       .value
//                                                                       .caseNo
//                                                                       .toString(),
//                                                               caller:
//                                                                   'contract!',
//                                                               title:
//                                                                   AppMetaLabels()
//                                                                       .renewalReq,
//                                                               initialIndex: 0,
//                                                             ));
//                                                       },
//                                                       child: Container(
//                                                         alignment:
//                                                             Alignment.center,
//                                                         padding:
//                                                             EdgeInsets.all(5.0),
//                                                         margin: EdgeInsets.only(
//                                                             top: 2.h,
//                                                             bottom: 2.h),
//                                                         decoration: BoxDecoration(
//                                                             color: AppColors
//                                                                 .blueColor,
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         8)),
//                                                         child: Row(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .center,
//                                                           children: [
//                                                             SizedBox(
//                                                               width: 8.0,
//                                                             ),
//                                                             Icon(
//                                                               Icons.info,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                             SizedBox(
//                                                               width: 8.0,
//                                                             ),
//                                                             Expanded(
//                                                               child: SizedBox(
//                                                                 height: 4.h,
//                                                                 child: Marquee(
//                                                                     text: AppMetaLabels()
//                                                                         .clickHereFeedback,
//                                                                     style: AppTextStyle
//                                                                         .normalBlue12
//                                                                         .copyWith(
//                                                                             color: Colors
//                                                                                 .white)
//                                                                         .copyWith(
//                                                                             fontWeight:
//                                                                                 FontWeight.bold)),
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       )))
//                                               : SizedBox();
//                                     }),
//                                   ),
//                           ],
//                         ),
//                 ),
//               );
//             }),
//             getCDController.isEnableScreen.value == false
//                 ? ScreenDisableWidget()
//                 : SizedBox(),
//             BottomShadow(),
//           ],
//         ),
//         bottomNavigationBar: Obx(() {
//           print(
//               'getCDController.loadingContract.value ******** ****** 1 ***** ***** ${getCDController.loadingContract.value}');
//           print(
//               'getCDController.errorLoadingContract.value *********  2 ***** ***** ${getCDController.errorLoadingContract.value}');
//           print(
//               'getContractsDetails.contract!.contractStatus ********* 3 ***** ***** ${getCDController.getContractsDetails.value.contract!.contractStatus}');
//           print(
//               'getCDController.getContractsDetails.caseStageInfo *** 4 ***** ***** ${getCDController.getContractsDetails.value.caseStageInfo}');
//           print(
//               'getCDController.caseStageInfo.stageId ******** ****** 5 ***** ***** ${getCDController.getContractsDetails.value.caseStageInfo.stageId}');

//           return getCDController.loadingContract.value ||
//                   getCDController.errorLoadingContract.value != '' ||
//                   getCDController
//                           .getContractsDetails.value.contract!.contractStatus ==
//                       'Ended' ||
//                   getCDController.getContractsDetails.value.caseStageInfo ==
//                       null ||
//                   getCDController
//                           .getContractsDetails.value.caseStageInfo.stageId ==
//                       null ||
//                   getCDController
//                           .getContractsDetails.value.caseStageInfo.stageId <
//                       1 ||
//                   getCDController
//                           .getContractsDetails.value.caseStageInfo.stageId >
//                       9
//               ? SizedBox()
//               : SizedBox();
//               // BottomAppBar is commented on 14-03-2023 becaause
//               // we faced a conflict on stageID
//               // : BottomAppBar(
//               //     child: Container(
//               //         height: 8.0.h, //set your height here
//               //         width: double.maxFinite, //set your width here
//               //         decoration:
//               //             BoxDecoration(color: Colors.white, boxShadow: [
//               //           BoxShadow(
//               //             color: Colors.black12,
//               //             blurRadius: 0.9.h,
//               //             spreadRadius: 0.4.h,
//               //             offset: Offset(0.1.h, 0.1.h),
//               //           ),
//               //         ]),
//               //         child: showActions()));
//         }));
//   }

//   Widget showActions() {
//     int stageId =
//         getCDController.getContractsDetails.value.caseStageInfo.stageId;
//     switch (stageId) {
//       case 1:
//         return expiringContractActions();
//         break;
//       default:
//         return renewalActions(stageId);
//     }
//   }

//   Widget expiringContractActions() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 2.w),
//       child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//         if (getCDController.showExtend)
//           Expanded(
//             child: Padding(
//                 padding: EdgeInsets.all(0.5.h),
//                 child: CustomButtonWithoutBackgroud(
//                   text: AppMetaLabels().extend,
//                   onPressed: () {
//                     Get.to(() => ContractExtend(
//                           contractNo: getCDController
//                               .getContractsDetails.value.contract!.contractno,
//                           contractId: getCDController
//                               .getContractsDetails.value.contract!.contractId,
//                           caller: 'contract!',
//                           dueActionId: getCDController.getContractsDetails.value
//                               .caseStageInfo.dueActionid,
//                         ));
//                   },
//                   borderColor: AppColors.blueColor,
//                 )),
//           ),
//         Expanded(
//           child: Padding(
//             padding: EdgeInsets.all(0.5.h),
//             child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(3.0.sp),
//                         side: BorderSide(
//                           color: AppColors.blueColor,
//                           width: 1.0,
//                         )),
//                     backgroundColor: AppColors.whiteColor,
//                     shadowColor: AppColors.blueColor),
//                 onPressed: () {
//                   Get.to(() => ContractRenewel(
//                         contractNo: getCDController
//                             .getContractsDetails.value.contract!.contractno,
//                         contractId: getCDController
//                             .getContractsDetails.value.contract!.contractId,
//                         caller: 'contract!',
//                         dueActionid: getCDController.getContractsDetails.value
//                             .caseStageInfo.dueActionid,
//                       ));
//                 },
//                 child: Text(AppMetaLabels().renew,
//                     style: AppTextStyle.normalBlue11)),
//           ),
//         ),
//         Expanded(
//           child: Padding(
//               padding: EdgeInsets.all(0.5.h),
//               child: CustomButtonWithoutBackgroud(
//                   text: AppMetaLabels().terminate,
//                   onPressed: () {
//                     Get.to(() => ContractTerminate(
//                           contractNo: getCDController
//                               .getContractsDetails.value.contract!.contractno,
//                           contractId: getCDController
//                               .getContractsDetails.value.contract!.contractId,
//                           caller: 'contract!',
//                           dueActionid: getCDController.getContractsDetails.value
//                               .caseStageInfo.dueActionid,
//                         ));
//                   },
//                   borderColor: AppColors.blueColor)),
//         ),
//       ]),
//     );
//   }

//   Widget renewalActions(int stageId) {
//     final ItemScrollController itemScrollController = ItemScrollController();

//     int dueActionIndex = 0;
//     switch (stageId) {
//       case 2:
//         dueActionIndex = 0;
//         break;
//       case 3:
//         dueActionIndex = 1;
//         break;
//       case 4:
//         dueActionIndex = 2;
//         break;
//       case 5:
//         dueActionIndex = 3;
//         break;
//       case 6:
//         dueActionIndex = 4;
//         break;
//       case 7:
//         dueActionIndex = 5;
//         break;
//       case 8:
//         dueActionIndex = 6;
//         break;
//       case 9:
//         dueActionIndex = 7;
//         break;
//     }

//     final actionList = [
//       Padding(
//           padding: EdgeInsets.all(0.5.h),
//           child: stageId == 2
//               ? DueActionListButton(
//                   text: AppMetaLabels().uploadDocs,
//                   srNo: '1',
//                   onPressed: getCDController
//                               .getContractsDetails.value.contract!.isCanceled ==
//                           1
//                       ? () {
//                           SnakBarWidget.getSnackBarErrorBlue(
//                               AppMetaLabels().alert,
//                               AppMetaLabels().yourRequestCancelled);
//                         }
//                       : () {
//                           SessionController().setCaseNo(
//                             getCDController
//                                 .getContractsDetails.value.caseStageInfo.caseid
//                                 .toString(),
//                           );
//                           Get.to(() => TenantServiceRequestTabs(
//                                 requestNo: getCDController.getContractsDetails
//                                     .value.caseStageInfo.caseid
//                                     .toString(),
//                                 caller: 'contract!',
//                                 title: AppMetaLabels().renewalReq,
//                                 initialIndex: 1,
//                               ));
//                         })
//               : StepNoWidget(label: '1', tooltip: AppMetaLabels().uploadDocs)),
//       Padding(
//           padding: EdgeInsets.all(0.5.h),
//           child: stageId == 3
//               ? DueActionListButton(
//                   text: AppMetaLabels().docsSubmitted,
//                   srNo: '2',
//                   onPressed: getCDController
//                               .getContractsDetails.value.contract!.isCanceled ==
//                           1
//                       ? () {
//                           SnakBarWidget.getSnackBarErrorBlue(
//                               AppMetaLabels().alert,
//                               AppMetaLabels().yourRequestCancelled);
//                         }
//                       : () {
//                           SessionController().setCaseNo(
//                             getCDController
//                                 .getContractsDetails.value.caseStageInfo.caseid
//                                 .toString(),
//                           );
//                           Get.to(() => TenantServiceRequestTabs(
//                                 requestNo: getCDController.getContractsDetails
//                                     .value.caseStageInfo.caseid
//                                     .toString(),
//                                 caller: 'contract!',
//                                 title: AppMetaLabels().renewalReq,
//                                 initialIndex: 1,
//                               ));
//                         })
//               : StepNoWidget(
//                   label: '2', tooltip: AppMetaLabels().docsSubmitted)),
//       Padding(
//           padding: EdgeInsets.all(0.5.h),
//           child: stageId == 4
//               ? DueActionListButton(
//                   text: AppMetaLabels().docsApproved,
//                   srNo: '3',
//                   onPressed: getCDController
//                               .getContractsDetails.value.contract!.isCanceled ==
//                           1
//                       ? () {
//                           SnakBarWidget.getSnackBarErrorBlue(
//                               AppMetaLabels().alert,
//                               AppMetaLabels().yourRequestCancelled);
//                         }
//                       : () {
//                           SessionController().setCaseNo(
//                             getCDController
//                                 .getContractsDetails.value.caseStageInfo.caseid
//                                 .toString(),
//                           );
//                           Get.to(() => TenantServiceRequestTabs(
//                                 requestNo: getCDController.getContractsDetails
//                                     .value.caseStageInfo.caseid
//                                     .toString(),
//                                 caller: 'contract!',
//                                 title: AppMetaLabels().renewalReq,
//                                 initialIndex: 1,
//                               ));
//                         })
//               : StepNoWidget(
//                   label: '3', tooltip: AppMetaLabels().docsApproved)),
//       Padding(
//           padding: EdgeInsets.all(0.5.h),
//           child: stageId == 5
//               ? DueActionListButton(
//                   text: AppMetaLabels().makePayment,
//                   srNo: '4',
//                   onPressed: getCDController
//                               .getContractsDetails.value.contract!.isCanceled ==
//                           1
//                       ? () {
//                           SnakBarWidget.getSnackBarErrorBlue(
//                               AppMetaLabels().alert,
//                               AppMetaLabels().yourRequestCancelled);
//                         }
//                       : () {
//                           SessionController().setContractID(getCDController
//                               .getContractsDetails.value.contract!.contractId);
//                           SessionController().setContractNo(getCDController
//                               .getContractsDetails.value.contract!.contractno);
//                           Get.to(() => OutstandingPayments(
//                                 contractNo: getCDController.getContractsDetails
//                                     .value.contract!.contractno,
//                                 contractId: getCDController.getContractsDetails
//                                     .value.contract!.contractId,
//                               ));
//                         })
//               : StepNoWidget(label: '4', tooltip: AppMetaLabels().makePayment)),
//       Padding(
//           padding: EdgeInsets.all(0.5.h),
//           child: stageId == 6
//               ? Obx(() {
//                   return DueActionListButton(
//                       text: AppMetaLabels().signContract2,
//                       srNo: '5',
//                       loading: contractDownloadController.downloading.value,
//                       onPressed: getCDController.getContractsDetails.value
//                                   .contract!.isCanceled ==
//                               1
//                           ? () {
//                               SnakBarWidget.getSnackBarErrorBlue(
//                                   AppMetaLabels().alert,
//                                   AppMetaLabels().yourRequestCancelled);
//                             }
//                           : () async {
//                               getCDController.isEnableScreen.value = false;

//                               SessionController().setContractID(getCDController
//                                   .getContractsDetails
//                                   .value
//                                   .contract!
//                                   .contractId);
//                               SessionController().setContractNo(getCDController
//                                   .getContractsDetails
//                                   .value
//                                   .contract!
//                                   .contractno);

//                               // for loading
//                               SnakBarWidget.getLoadingWithColor();
//                               await Future.delayed(Duration(seconds: 0));
//                               SnakBarWidget.getSnackBarErrorBlue(
//                                 AppMetaLabels().loading,
//                                 AppMetaLabels().generatingContractInfo,
//                               );

//                               String path = await contractDownloadController
//                                   .downloadContract(
//                                       getCDController.getContractsDetails.value
//                                           .contract!.contractno,
//                                       false);
//                               getCDController.isEnableScreen.value = true;
//                               if (path != null) {
//                                 Get.closeAllSnackbars();
//                                 Get.to(() => AuthenticateContract(
//                                     contractNo: getCDController
//                                         .getContractsDetails
//                                         .value
//                                         .contract!
//                                         .contractno,
//                                     contractId: getCDController
//                                         .getContractsDetails
//                                         .value
//                                         .contract!
//                                         .contractId,
//                                     filePath: path,
//                                     dueActionId: getCDController
//                                         .getContractsDetails
//                                         .value
//                                         .caseStageInfo
//                                         .dueActionid,
//                                     stageId: getCDController.getContractsDetails
//                                         .value.caseStageInfo.stageId,
//                                     caller: 'contract!',
//                                     caseId: getCDController.getContractsDetails
//                                         .value.caseStageInfo.caseid));
//                               }
//                             });
//                 })
//               : StepNoWidget(
//                   label: '5', tooltip: AppMetaLabels().signContract2)),
//       Padding(
//           padding: EdgeInsets.all(0.5.h),
//           child: stageId == 7
//               ? DueActionListButton(
//                   text: AppMetaLabels().contractSigned,
//                   srNo: '6',
//                   onPressed: getCDController
//                               .getContractsDetails.value.contract!.isCanceled ==
//                           1
//                       ? () {
//                           SnakBarWidget.getSnackBarErrorBlue(
//                               AppMetaLabels().alert,
//                               AppMetaLabels().yourRequestCancelled);
//                         }
//                       : () {})
//               : StepNoWidget(
//                   label: '6', tooltip: AppMetaLabels().contractSigned)),
//       Padding(
//           padding: EdgeInsets.all(0.5.h),
//           child: stageId == 8
//               ? DueActionListButton(
//                   text: AppMetaLabels().approveMunicipal,
//                   srNo: '7',
//                   onPressed: getCDController
//                               .getContractsDetails.value.contract!.isCanceled ==
//                           1
//                       ? () {
//                           SnakBarWidget.getSnackBarErrorBlue(
//                               AppMetaLabels().alert,
//                               AppMetaLabels().yourRequestCancelled);
//                         }
//                       : () {
//                           Get.to(() => MunicipalApproval(
//                                 caller: 'contract!',
//                                 dueActionId: getCDController.getContractsDetails
//                                     .value.caseStageInfo.dueActionid,
//                                 contractId: getCDController.getContractsDetails
//                                     .value.contract!.contractId,
//                               ));
//                         })
//               : StepNoWidget(
//                   label: '7', tooltip: AppMetaLabels().approveMunicipal)),
//       Padding(
//           padding: EdgeInsets.all(0.5.h),
//           child: stageId == 9
//               ? DueActionListButton(
//                   srNo: '8',
//                   text: AppMetaLabels().downloadContract,
//                   loading: getCDController.downloadingContract.value,
//                   onPressed: getCDController
//                               .getContractsDetails.value.contract!.isCanceled ==
//                           1
//                       ? () {
//                           SnakBarWidget.getSnackBarErrorBlue(
//                               AppMetaLabels().alert,
//                               AppMetaLabels().yourRequestCancelled);
//                         }
//                       : () {
//                           if (getCDController.canDownloadContract.canDownload ==
//                               '1')
//                             getCDController.downloadContract();
//                           else if (getCDController
//                                   .canDownloadContract.canDownload ==
//                               '2')
//                             Get.snackbar(AppMetaLabels().error,
//                                 getCDController.canDownloadContract.message,
//                                 backgroundColor: AppColors.white54);
//                         })
//               : StepNoWidget(
//                   label: '8', tooltip: AppMetaLabels().downloadContract)),
//     ];
//     return ScrollablePositionedList.builder(
//       itemScrollController: itemScrollController,
//       scrollDirection: Axis.horizontal,
//       itemCount: 8,
//       itemBuilder: (context, index2) {
//         WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//           if (itemScrollController.isAttached)
//             itemScrollController.scrollTo(
//                 index: dueActionIndex,
//                 duration: Duration(milliseconds: 500),
//                 curve: Curves.easeIn);
//         });
//         return actionList[index2];
//       },
//     );
//   }
// }

// class CustomButton2 extends StatelessWidget {
//   final Function onPressed;
//   final String text;
//   final bool loading;
//   const CustomButton2(
//       {Key key, this.onPressed, this.text, this.loading = false})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
//       child: ElevatedButton(
//         onPressed: loading
//             ? null
//             : () {
//                 onPressed();
//               },
//         child: loading
//             ? AnimatedTextKit(
//                 isRepeatingAnimation: true,
//                 repeatForever: true,
//                 pause: Duration(milliseconds: 10),
//                 animatedTexts: [
//                   ColorizeAnimatedText(text ?? '',
//                       textStyle: AppTextStyle.normalBlue12
//                           .copyWith(color: Colors.white),
//                       colors: [
//                         AppColors.blueColor,
//                         AppColors.blueColor2,
//                         AppColors.blueColor
//                       ],
//                       speed: Duration(milliseconds: 200)),
//                 ],
//               )
//             : Text(
//                 text ?? '',
//                 style: AppTextStyle.normalBlue12.copyWith(color: Colors.white),
//               ),
//         style: ElevatedButton.styleFrom(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5.0.sp),
//             ),
//             backgroundColor: AppColors.blueColor3,
//             shadowColor: Colors.transparent,
//             padding: EdgeInsets.symmetric(horizontal: 8)),
//       ),
//     );
//   }
// }
