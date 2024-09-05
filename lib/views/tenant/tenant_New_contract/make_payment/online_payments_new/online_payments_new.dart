// ignore_for_file: unrelated_type_equality_checks, unnecessary_null_comparison
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_tabs.dart/tenant_contracts_details.dart/tenant_contract_details.dart';
import 'package:fap_properties/views/tenant/tenant_New_contract/make_payment/online_payments_new/online_payments_new_controller.dart';
import 'package:fap_properties/views/tenant/tenant_New_contract/make_payment/terms/terms_and_conditions_new.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../data/helpers/session_controller.dart';
import '../../../../../data/models/tenant_models/contract_payable/outstanding_payments_model.dart';

class OnlinePaymentsNewContract extends StatefulWidget {
  final String? contractNo;
  const OnlinePaymentsNewContract({Key? key, this.contractNo}) : super(key: key);

  @override
  _OnlinePaymentsNewContractState createState() =>
      _OnlinePaymentsNewContractState();
}

class _OnlinePaymentsNewContractState extends State<OnlinePaymentsNewContract> {
  var _controller = Get.put(OnlinePaymentsNewContractController());
  bool value = false;

  @override
  void initState() {
    _controller.registeringPayment.value = false;
    _controller.getOnlinePayable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Obx(() {
            return Stack(children: [
              // appbar
              Padding(
                padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppMetaLabels().onlinePayments,
                      style: AppTextStyle.semiBoldBlack15,
                    ),
                    InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(118, 118, 128, 0.12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(0.5.h),
                          child: Icon(Icons.close,
                              size: 2.5.h,
                              color: Color.fromRGBO(158, 158, 158, 1)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Divider
              Padding(
                padding: EdgeInsets.only(top: 4.0.h, bottom: 2.0.w),
                child: AppDivider(),
              ),
              // Payments
              Padding(
                  padding: EdgeInsets.only(top: 7.0.h, bottom: 4.0.h),
                  child: _controller.loadingPayable.value
                      ? LoadingIndicatorBlue()
                      : _controller.errorPayable.value != ''
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomErrorWidget(
                                  errorImage: AppImagesPath.noPaymentsFound,
                                  errorText:
                                      AppMetaLabels().noPendingPaymentFound,
                                  // 'No pending payments were found against this contract',
                                  onRetry: () {
                                    _controller.getOnlinePayable();
                                  },
                                ),
                                TextButton(
                                  child: Text(AppMetaLabels().viewContract
                                      // 'View Contract'
                                      ),
                                  onPressed: () {
                                    Get.off(() => ContractsDetailsTabs());
                                  },
                                )
                              ],
                            )
                          // CustomErrorWidget(
                          //     errorImage: AppImagesPath.noPaymentsFound,
                          //     // errorText: _controller.errorPayable.value,
                          //     errorText: 'kk',
                          //     onRetry: () {
                          //       _controller.getOnlinePayable();
                          //     },
                          //   )
                          : _controller.contractPayableData.record! == null
                              ? SizedBox()
                              : Center(
                                  child: Container(
                                      width: 92.0.w,
                                      height: 90.h,
                                      padding: EdgeInsets.only(
                                          left: 3.w, right: 3.w, top: 2.5.h),
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
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  AppMetaLabels().contractNo,
                                                  style: AppTextStyle
                                                      .semiBoldBlack12,
                                                ),
                                                Text(
                                                  widget.contractNo??"",
                                                  style: AppTextStyle
                                                      .semiBoldBlack12,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Text(
                                              AppMetaLabels().payments,
                                              style:
                                                  AppTextStyle.semiBoldBlack12,
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            AppDivider(),
                                            SizedBox(
                                              height: 1.w,
                                            ),
                                            // Card Payment && Bank Transfer
                                            _controller.isRadioButtonShow.value
                                                ? Obx(() {
                                                    // New work with Tab
                                                    return Row(
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            children: [
                                                              TextButton(
                                                                child: Text(
                                                                    AppMetaLabels()
                                                                        .cardPayment,
                                                                    style: _controller.isPayemntValue.value ==
                                                                            1
                                                                        ? AppTextStyle
                                                                            .semiBoldBlue10
                                                                        : AppTextStyle
                                                                            .semiBoldBlack10),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    _controller
                                                                        .isPayemntValue
                                                                        .value = 1;
                                                                  });
                                                                },
                                                              ),
                                                              Container(
                                                                width: double
                                                                    .infinity,
                                                                height: 1.5,
                                                                color: _controller
                                                                            .isPayemntValue
                                                                            .value ==
                                                                        1
                                                                    ? AppColors
                                                                        .blueColor
                                                                    : Colors
                                                                        .transparent,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        // we commented the bank transfer because bank transfer is not ready yet
                                                        // Expanded(
                                                        //   child: Column(
                                                        //     children: [
                                                        //       TextButton(
                                                        //         child: Text(
                                                        //             AppMetaLabels()
                                                        //                 .bankTransfer,
                                                        //             style: _controller.isPayemntValue.value ==
                                                        //                     3
                                                        //                 ? AppTextStyle
                                                        //                     .semiBoldBlue10
                                                        //                 : AppTextStyle
                                                        //                     .semiBoldBlack10),
                                                        //         onPressed: () {
                                                        //           setState(() {
                                                        //             _controller
                                                        //                 .isPayemntValue
                                                        //                 .value = 3;
                                                        //           });
                                                        //         },
                                                        //       ),
                                                        //       Container(
                                                        //         width: double
                                                        //             .infinity,
                                                        //         height: 1.5,
                                                        //         color: _controller
                                                        //                     .isPayemntValue
                                                        //                     .value ==
                                                        //                 3
                                                        //             ? AppColors
                                                        //                 .blueColor
                                                        //             : Colors
                                                        //                 .transparent,
                                                        //       )
                                                        //     ],
                                                        //   ),
                                                        // )
                                                      ],
                                                    );
                                                    // old work with Radio Button
                                                    //  Row(
                                                    //   children: [
                                                    //     // Card Payment
                                                    //     Container(
                                                    //       child: Row(
                                                    //         children: [
                                                    //           Radio(
                                                    //             toggleable:
                                                    //                 true,
                                                    //             // payable.cheque == null || payable.cheque.isEmpty,
                                                    //             groupValue: _controller
                                                    //                 .isPayemntValue
                                                    //                 .value, //payable.paymentMethodId.value,
                                                    //             onChanged:
                                                    //                 (value) async {
                                                    //               _controller
                                                    //                   .isPayemntValue
                                                    //                   .value = value;
                                                    //               print(_controller
                                                    //                   .isPayemntValue
                                                    //                   .value);
                                                    //             },
                                                    //             value: 1,
                                                    //           ),
                                                    //           Text(
                                                    //             AppMetaLabels()
                                                    //                 .cardPayment,
                                                    //             style: AppTextStyle
                                                    //                 .normalBlack10,
                                                    //           ),
                                                    //         ],
                                                    //       ),
                                                    //     ),
                                                    //     // Bank Transfer
                                                    //     Container(
                                                    //       child: Row(
                                                    //         children: [
                                                    //           Radio(
                                                    //             toggleable:
                                                    //                 true,
                                                    //             // payable.cheque == null || payable.cheque.isEmpty,
                                                    //             groupValue: _controller
                                                    //                 .isPayemntValue
                                                    //                 .value, //payable.paymentMethodId.value,
                                                    //             onChanged:
                                                    //                 (value) async {
                                                    //               _controller
                                                    //                   .isPayemntValue
                                                    //                   .value = value;
                                                    //               print(_controller
                                                    //                   .isPayemntValue
                                                    //                   .value);
                                                    //             },
                                                    //             value: 3,
                                                    //           ),
                                                    //           Text(
                                                    //             AppMetaLabels()
                                                    //                 .bankTransfer,
                                                    //             style: AppTextStyle
                                                    //                 .normalBlack10,
                                                    //           ),
                                                    //         ],
                                                    //       ),
                                                    //     ),
                                                    //   ],
                                                    // );
                                                  })
                                                : SizedBox(
                                                    height: 1.5.h,
                                                  ),

                                            Expanded(
                                                child: Scrollbar(
                                              thumbVisibility: true,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // OLD
                                                    // if (_controller.rentalSum !=
                                                    //     0)
                                                    //   Padding(
                                                    //     padding:
                                                    //         EdgeInsets.only(
                                                    //             top: 2.0.h,
                                                    //             bottom: 1.h,
                                                    //             left: 4.0.w,
                                                    //             right: 4.0.w),
                                                    //     child: Text(
                                                    //       "${AppMetaLabels().renatalpayments}",
                                                    //       style: AppTextStyle
                                                    //           .semiBoldBlack11,
                                                    //     ),
                                                    //   ),
                                                    // if (_controller.rentalSum !=
                                                    //     0)
                                                    //   ListView.builder(
                                                    //     padding:
                                                    //         EdgeInsets.zero,
                                                    //     shrinkWrap: true,
                                                    //     physics:
                                                    //         NeverScrollableScrollPhysics(),
                                                    //     itemCount: _controller
                                                    //         .contractPayableData
                                                    //         .record!
                                                    //         .length,
                                                    //     itemBuilder:
                                                    //         (BuildContext
                                                    //                 context,
                                                    //             int index) {
                                                    //       if (_controller
                                                    //               .contractPayableData
                                                    //               .record![index]
                                                    //               .type ==
                                                    //           'Contract Payable')
                                                    //         return paymentsListItem(
                                                    //             _controller
                                                    //                 .contractPayableData
                                                    //                 .record![index]);
                                                    //       else
                                                    //         return SizedBox();
                                                    //     },
                                                    //   ),
                                                    // if (_controller
                                                    //         .additionalSum !=
                                                    //     0)
                                                    //   Padding(
                                                    //     padding:
                                                    //         EdgeInsets.only(
                                                    //             top: 1.5.h,
                                                    //             bottom: 1.h,
                                                    //             left: 4.0.w,
                                                    //             right: 4.0.w),
                                                    //     child: Text(
                                                    //       AppMetaLabels()
                                                    //           .additionalCharges,
                                                    //       style: AppTextStyle
                                                    //           .semiBoldBlack11,
                                                    //     ),
                                                    //   ),
                                                    // if (_controller
                                                    //         .additionalSum !=
                                                    //     0)
                                                    //   ListView.builder(
                                                    //     padding:
                                                    //         EdgeInsets.zero,
                                                    //     shrinkWrap: true,
                                                    //     physics:
                                                    //         NeverScrollableScrollPhysics(),
                                                    //     itemCount: _controller
                                                    //         .contractPayableData
                                                    //         .record!
                                                    //         .length,
                                                    //     itemBuilder:
                                                    //         (BuildContext
                                                    //                 context,
                                                    //             int index) {
                                                    //       if (_controller
                                                    //               .contractPayableData
                                                    //               .record![index]
                                                    //               .type ==
                                                    //           'Additional Charges')
                                                    //         return paymentsListItem(
                                                    //             _controller
                                                    //                 .contractPayableData
                                                    //                 .record![index]);
                                                    //       else
                                                    //         return SizedBox();
                                                    //     },
                                                    //   ),
                                                    // if (_controller
                                                    //         .vatRentSum !=
                                                    //     0)
                                                    //   Padding(
                                                    //     padding:
                                                    //         EdgeInsets.only(
                                                    //             top: 1.5.h,
                                                    //             bottom: 1.h,
                                                    //             left: 4.0.w,
                                                    //             right: 4.0.w),
                                                    //     child: Text(
                                                    //       AppMetaLabels()
                                                    //           .vatOnRent,
                                                    //       style: AppTextStyle
                                                    //           .semiBoldBlack11,
                                                    //     ),
                                                    //   ),
                                                    // if (_controller
                                                    //         .vatRentSum !=
                                                    //     0)
                                                    //   ListView.builder(
                                                    //     padding:
                                                    //         EdgeInsets.zero,
                                                    //     shrinkWrap: true,
                                                    //     physics:
                                                    //         NeverScrollableScrollPhysics(),
                                                    //     itemCount: _controller
                                                    //         .contractPayableData
                                                    //         .record!
                                                    //         .length,
                                                    //     itemBuilder:
                                                    //         (BuildContext
                                                    //                 context,
                                                    //             int index) {
                                                    //       if (_controller
                                                    //               .contractPayableData
                                                    //               .record![index]
                                                    //               .type
                                                    //               .toLowerCase() ==
                                                    //           'VAT On Rent'
                                                    //               .toLowerCase())
                                                    //         return paymentsListItem(
                                                    //             _controller
                                                    //                 .contractPayableData
                                                    //                 .record![index]);
                                                    //       else
                                                    //         return SizedBox();
                                                    //     },
                                                    //   ),
                                                    // if (_controller
                                                    //         .vatChargesSum !=
                                                    //     0)
                                                    //   Padding(
                                                    //     padding:
                                                    //         EdgeInsets.only(
                                                    //             top: 1.5.h,
                                                    //             bottom: 1.h,
                                                    //             left: 4.0.w,
                                                    //             right: 4.0.w),
                                                    //     child: Text(
                                                    //       AppMetaLabels()
                                                    //           .vatOnCharges,
                                                    //       style: AppTextStyle
                                                    //           .semiBoldBlack11,
                                                    //     ),
                                                    //   ),
                                                    // if (_controller
                                                    //         .vatChargesSum !=
                                                    //     0)
                                                    //   ListView.builder(
                                                    //     padding:
                                                    //         EdgeInsets.zero,
                                                    //     shrinkWrap: true,
                                                    //     physics:
                                                    //         NeverScrollableScrollPhysics(),
                                                    //     itemCount: _controller
                                                    //         .contractPayableData
                                                    //         .record!
                                                    //         .length,
                                                    //     itemBuilder:
                                                    //         (BuildContext
                                                    //                 context,
                                                    //             int index) {
                                                    //       if (_controller
                                                    //               .contractPayableData
                                                    //               .record![index]
                                                    //               .type
                                                    //               .toLowerCase() ==
                                                    //           'Vat On Charges'
                                                    //               .toLowerCase())
                                                    //         return paymentsListItem(
                                                    //             _controller
                                                    //                 .contractPayableData
                                                    //                 .record![index]);
                                                    //       else
                                                    //         return SizedBox();
                                                    //     },
                                                    //   ),

                                                    // New
                                                    // This Condition for "paymentsListItem" ListViewBuilder
                                                    // _controller.isPayemntValue.value == 1
                                                    // the above condition is for to show separate button for both tabs
                                                    // _controller.cardPaymentListLength.length == 0
                                                    // the above condition for to show SizedBox when there is no installment
                                                    _controller.isPayemntValue
                                                                .value ==
                                                            1
                                                        ? _controller
                                                                    .cardPaymentListLength
                                                                    .length ==
                                                                0
                                                            ? Container(
                                                                height: 50.h,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Image.asset(
                                                                      AppImagesPath
                                                                          .noPaymentsFound,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      width:
                                                                          12.0.h,
                                                                      height:
                                                                          12.0.h,
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.only(top: 1.h),
                                                                        child:
                                                                            Text(
                                                                          AppMetaLabels()
                                                                              .noPendingPF,
                                                                          style:
                                                                              AppTextStyle.semiBoldGrey14,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            : Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  if (_controller
                                                                          .rentalSum !=
                                                                      0)
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          top: 2.0
                                                                              .h,
                                                                          bottom: 1
                                                                              .h,
                                                                          left: 4.0
                                                                              .w,
                                                                          right:
                                                                              4.0.w),
                                                                      child:
                                                                          Text(
                                                                        "${AppMetaLabels().renatalpayments}",
                                                                        style: AppTextStyle
                                                                            .semiBoldBlack11,
                                                                      ),
                                                                    ),
                                                                  if (_controller
                                                                          .rentalSum !=
                                                                      0)
                                                                    ListView
                                                                        .builder(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          NeverScrollableScrollPhysics(),
                                                                      itemCount: _controller
                                                                          .contractPayableData
                                                                          .record!
                                                                          .length,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index) {
                                                                        if (_controller.contractPayableData.record![index].type ==
                                                                            'Contract Payable')
                                                                          return paymentsListItem(_controller
                                                                              .contractPayableData
                                                                              .record![index]);
                                                                        else
                                                                          return SizedBox();
                                                                      },
                                                                    ),
                                                                  if (_controller
                                                                          .additionalSum !=
                                                                      0)
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          top: 1.5
                                                                              .h,
                                                                          bottom: 1
                                                                              .h,
                                                                          left: 4.0
                                                                              .w,
                                                                          right:
                                                                              4.0.w),
                                                                      child:
                                                                          Text(
                                                                        AppMetaLabels()
                                                                            .additionalCharges,
                                                                        style: AppTextStyle
                                                                            .semiBoldBlack11,
                                                                      ),
                                                                    ),
                                                                  if (_controller
                                                                          .additionalSum !=
                                                                      0)
                                                                    ListView
                                                                        .builder(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          NeverScrollableScrollPhysics(),
                                                                      itemCount: _controller
                                                                          .contractPayableData
                                                                          .record!
                                                                          .length,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index) {
                                                                        if (_controller.contractPayableData.record![index].type ==
                                                                            'Additional Charges')
                                                                          return paymentsListItem(_controller
                                                                              .contractPayableData
                                                                              .record![index]);
                                                                        else
                                                                          return SizedBox();
                                                                      },
                                                                    ),
                                                                  if (_controller
                                                                          .vatRentSum !=
                                                                      0)
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          top: 1.5
                                                                              .h,
                                                                          bottom: 1
                                                                              .h,
                                                                          left: 4.0
                                                                              .w,
                                                                          right:
                                                                              4.0.w),
                                                                      child:
                                                                          Text(
                                                                        AppMetaLabels()
                                                                            .vatOnRent,
                                                                        style: AppTextStyle
                                                                            .semiBoldBlack11,
                                                                      ),
                                                                    ),
                                                                  if (_controller
                                                                          .vatRentSum !=
                                                                      0)
                                                                    ListView
                                                                        .builder(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          NeverScrollableScrollPhysics(),
                                                                      itemCount: _controller
                                                                          .contractPayableData
                                                                          .record!
                                                                          .length,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index) {
                                                                        if (_controller.contractPayableData.record![index].type!.toLowerCase() ==
                                                                            'VAT On Rent'.toLowerCase())
                                                                          return paymentsListItem(_controller
                                                                              .contractPayableData
                                                                              .record![index]);
                                                                        else
                                                                          return SizedBox();
                                                                      },
                                                                    ),
                                                                  if (_controller
                                                                          .vatChargesSum !=
                                                                      0)
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          top: 1.5
                                                                              .h,
                                                                          bottom: 1
                                                                              .h,
                                                                          left: 4.0
                                                                              .w,
                                                                          right:
                                                                              4.0.w),
                                                                      child:
                                                                          Text(
                                                                        AppMetaLabels()
                                                                            .vatOnCharges,
                                                                        style: AppTextStyle
                                                                            .semiBoldBlack11,
                                                                      ),
                                                                    ),
                                                                  if (_controller
                                                                          .vatChargesSum !=
                                                                      0)
                                                                    ListView
                                                                        .builder(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          NeverScrollableScrollPhysics(),
                                                                      itemCount: _controller
                                                                          .contractPayableData
                                                                          .record!
                                                                          .length,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index) {
                                                                        if (_controller.contractPayableData.record![index].type!.toLowerCase() ==
                                                                            'Vat On Charges'.toLowerCase())
                                                                          return paymentsListItem(_controller
                                                                              .contractPayableData
                                                                              .record![index]);
                                                                        else
                                                                          return SizedBox();
                                                                      },
                                                                    ),
                                                                ],
                                                              )
                                                        : SizedBox(),

                                                    // This Condition for "paymentsListItem" ListViewBuilder
                                                    // _controller.isPayemntValue.value == 3
                                                    // the above condition is for to show separate button for both tabs
                                                    // _controller.bankTransferListLength.length == 0
                                                    // the above condition for to show SizedBox when there is no installment
                                                    _controller.isPayemntValue
                                                                .value ==
                                                            3
                                                        ? _controller
                                                                    .bankTransferListLength
                                                                    .length ==
                                                                0
                                                            ? Container(
                                                                height: 50.h,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Image.asset(
                                                                      AppImagesPath
                                                                          .noPaymentsFound,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      width:
                                                                          12.0.h,
                                                                      height:
                                                                          12.0.h,
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.only(top: 1.h),
                                                                        child:
                                                                            Text(
                                                                          AppMetaLabels()
                                                                              .noPendingPF,
                                                                          style:
                                                                              AppTextStyle.semiBoldGrey14,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            : Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  if (_controller
                                                                          .rentalSum !=
                                                                      0)
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          top: 2.0
                                                                              .h,
                                                                          bottom: 1
                                                                              .h,
                                                                          left: 4.0
                                                                              .w,
                                                                          right:
                                                                              4.0.w),
                                                                      child:
                                                                          Text(
                                                                        "${AppMetaLabels().renatalpayments}",
                                                                        style: AppTextStyle
                                                                            .semiBoldBlack11,
                                                                      ),
                                                                    ),
                                                                  if (_controller
                                                                          .rentalSum !=
                                                                      0)
                                                                    ListView
                                                                        .builder(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          NeverScrollableScrollPhysics(),
                                                                      itemCount: _controller
                                                                          .contractPayableData
                                                                          .record!
                                                                          .length,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index) {
                                                                        if (_controller.contractPayableData.record![index].type ==
                                                                            'Contract Payable')
                                                                          return paymentsListItem(_controller
                                                                              .contractPayableData
                                                                              .record![index]);
                                                                        else
                                                                          return SizedBox();
                                                                      },
                                                                    ),
                                                                  if (_controller
                                                                          .additionalSum !=
                                                                      0)
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          top: 1.5
                                                                              .h,
                                                                          bottom: 1
                                                                              .h,
                                                                          left: 4.0
                                                                              .w,
                                                                          right:
                                                                              4.0.w),
                                                                      child:
                                                                          Text(
                                                                        AppMetaLabels()
                                                                            .additionalCharges,
                                                                        style: AppTextStyle
                                                                            .semiBoldBlack11,
                                                                      ),
                                                                    ),
                                                                  if (_controller
                                                                          .additionalSum !=
                                                                      0)
                                                                    ListView
                                                                        .builder(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          NeverScrollableScrollPhysics(),
                                                                      itemCount: _controller
                                                                          .contractPayableData
                                                                          .record!
                                                                          .length,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index) {
                                                                        if (_controller.contractPayableData.record![index].type ==
                                                                            'Additional Charges')
                                                                          return paymentsListItem(_controller
                                                                              .contractPayableData
                                                                              .record![index]);
                                                                        else
                                                                          return SizedBox();
                                                                      },
                                                                    ),
                                                                  if (_controller
                                                                          .vatRentSum !=
                                                                      0)
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          top: 1.5
                                                                              .h,
                                                                          bottom: 1
                                                                              .h,
                                                                          left: 4.0
                                                                              .w,
                                                                          right:
                                                                              4.0.w),
                                                                      child:
                                                                          Text(
                                                                        AppMetaLabels()
                                                                            .vatOnRent,
                                                                        style: AppTextStyle
                                                                            .semiBoldBlack11,
                                                                      ),
                                                                    ),
                                                                  if (_controller
                                                                          .vatRentSum !=
                                                                      0)
                                                                    ListView
                                                                        .builder(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          NeverScrollableScrollPhysics(),
                                                                      itemCount: _controller
                                                                          .contractPayableData
                                                                          .record!
                                                                          .length,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index) {
                                                                        if (_controller.contractPayableData.record![index].type!.toLowerCase() ==
                                                                            'VAT On Rent'.toLowerCase())
                                                                          return paymentsListItem(_controller
                                                                              .contractPayableData
                                                                              .record![index]);
                                                                        else
                                                                          return SizedBox();
                                                                      },
                                                                    ),
                                                                  if (_controller
                                                                          .vatChargesSum !=
                                                                      0)
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          top: 1.5
                                                                              .h,
                                                                          bottom: 1
                                                                              .h,
                                                                          left: 4.0
                                                                              .w,
                                                                          right:
                                                                              4.0.w),
                                                                      child:
                                                                          Text(
                                                                        AppMetaLabels()
                                                                            .vatOnCharges,
                                                                        style: AppTextStyle
                                                                            .semiBoldBlack11,
                                                                      ),
                                                                    ),
                                                                  if (_controller
                                                                          .vatChargesSum !=
                                                                      0)
                                                                    ListView
                                                                        .builder(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          NeverScrollableScrollPhysics(),
                                                                      itemCount: _controller
                                                                          .contractPayableData
                                                                          .record!
                                                                          .length,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index) {
                                                                        if (_controller.contractPayableData.record![index].type!.toLowerCase() ==
                                                                            'Vat On Charges'.toLowerCase())
                                                                          return paymentsListItem(_controller
                                                                              .contractPayableData
                                                                              .record![index]);
                                                                        else
                                                                          return SizedBox();
                                                                      },
                                                                    ),
                                                                ],
                                                              )
                                                        : SizedBox(),

                                                    // This Condition for "Procced Button" and  Amount etc
                                                    // _controller.isPayemntValue.value == 1
                                                    // the above condition is for to show separate button for both tabs
                                                    // _controller.cardPaymentListLength.length == 0
                                                    // the above condition for to show SizedBox when there is no installment
                                                    _controller.isPayemntValue
                                                                .value ==
                                                            1
                                                        ? _controller
                                                                    .cardPaymentListLength
                                                                    .length ==
                                                                0
                                                            ? SizedBox()
                                                            : Column(
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: 4.0
                                                                            .h,
                                                                        left: 4.0
                                                                            .w,
                                                                        right: 4.0
                                                                            .w),
                                                                    child: Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            AppMetaLabels().amount,
                                                                            style:
                                                                                AppTextStyle.semiBoldBlack11,
                                                                          ),
                                                                          Spacer(),
                                                                          Obx(() {
                                                                            return Text(
                                                                              '${AppMetaLabels().aed} ${_controller.sumOfSelectedPayments.value}',
                                                                              style: AppTextStyle.semiBoldBlack11,
                                                                            );
                                                                          }),
                                                                        ]),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 2.h,
                                                                  ),
                                                                  Image.asset(
                                                                      AppImagesPath
                                                                          .paymentMethods,
                                                                      fit: BoxFit
                                                                          .fitHeight),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            1.h,
                                                                        horizontal:
                                                                            4.w),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Get.to(() =>
                                                                            TermsAndConditionsNewContract(
                                                                              title: AppMetaLabels().termsConditions,
                                                                            ));
                                                                      },
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.circle,
                                                                            size:
                                                                                2.w,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                2.w,
                                                                          ),
                                                                          Text(
                                                                            AppMetaLabels().termsConditions,
                                                                            style:
                                                                                AppTextStyle.normalBlue10,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            4.w),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Get.to(() =>
                                                                            TermsAndConditionsNewContract(
                                                                              title: AppMetaLabels().refundPolicy,
                                                                            ));
                                                                      },
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.circle,
                                                                            size:
                                                                                2.w,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                2.w,
                                                                          ),
                                                                          Text(
                                                                            AppMetaLabels().refundPolicy,
                                                                            style:
                                                                                AppTextStyle.normalBlue10,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Center(
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          5.0.h,
                                                                      width:
                                                                          69.0.w,
                                                                      margin: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              4.0.h),
                                                                      child: Obx(
                                                                          () {
                                                                        return _controller.registeringPayment.value
                                                                            ? LoadingIndicatorBlue()
                                                                            : ElevatedButton(
                                                                                onPressed: () {
                                                                                  if (_controller.sumOfSelectedPayments.value == '0.00') {
                                                                                    SnakBarWidget.getSnackBarErrorBlue(AppMetaLabels().alert, AppMetaLabels().pleaseSelectPayment);
                                                                                  } else {
                                                                                    _controller.registerPayment(widget.contractNo??"");
                                                                                  }
                                                                                },
                                                                                child: Text(
                                                                                  AppMetaLabels().proceedTopayL,
                                                                                  style: AppTextStyle.semiBoldBlack11.copyWith(color: Colors.white),
                                                                                ),
                                                                                style: ButtonStyle(
                                                                                    elevation: WidgetStateProperty.all<double>(0.0),
                                                                                    backgroundColor: WidgetStateProperty.all<Color>(AppColors.blueColor),
                                                                                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                                                                      RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(2.0.w),
                                                                                      ),
                                                                                    )),
                                                                              );
                                                                      }),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )

                                                        // This Condition for "Procced Button" and  Amount etc
                                                        // _controller.isPayemntValue.value ==3
                                                        // the above condition is for to show separate button for both tabs
                                                        // _controller.bankTransferListLength.length == 0
                                                        // the above condition for to show SizedBox when there is no installment
                                                        : _controller
                                                                    .isPayemntValue
                                                                    .value ==
                                                                3
                                                            ? _controller
                                                                        .bankTransferListLength
                                                                        .length ==
                                                                    0
                                                                ? SizedBox()
                                                                : Column(
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsets.only(
                                                                            top:
                                                                                4.0.h,
                                                                            left: 4.0.w,
                                                                            right: 4.0.w),
                                                                        child: Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                AppMetaLabels().amount,
                                                                                style: AppTextStyle.semiBoldBlack11,
                                                                              ),
                                                                              Spacer(),
                                                                              Obx(() {
                                                                                return Text(
                                                                                  '${AppMetaLabels().aed} ${_controller.sumOfSelectedPayments1.value}',
                                                                                  style: AppTextStyle.semiBoldBlack11,
                                                                                );
                                                                              }),
                                                                            ]),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            2.h,
                                                                      ),
                                                                      Image.asset(
                                                                          AppImagesPath
                                                                              .paymentMethods,
                                                                          fit: BoxFit
                                                                              .fitHeight),
                                                                      Padding(
                                                                        padding: EdgeInsets.symmetric(
                                                                            vertical:
                                                                                1.h,
                                                                            horizontal: 4.w),
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Get.to(() =>
                                                                                TermsAndConditionsNewContract(
                                                                                  title: AppMetaLabels().termsConditions,
                                                                                ));
                                                                          },
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Icon(
                                                                                Icons.circle,
                                                                                size: 2.w,
                                                                              ),
                                                                              SizedBox(
                                                                                width: 2.w,
                                                                              ),
                                                                              Text(
                                                                                AppMetaLabels().termsConditions,
                                                                                style: AppTextStyle.normalBlue10,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: 4.w),
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Get.to(() =>
                                                                                TermsAndConditionsNewContract(
                                                                                  title: AppMetaLabels().refundPolicy,
                                                                                ));
                                                                          },
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Icon(
                                                                                Icons.circle,
                                                                                size: 2.w,
                                                                              ),
                                                                              SizedBox(
                                                                                width: 2.w,
                                                                              ),
                                                                              Text(
                                                                                AppMetaLabels().refundPolicy,
                                                                                style: AppTextStyle.normalBlue10,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Center(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              5.0.h,
                                                                          width:
                                                                              69.0.w,
                                                                          margin:
                                                                              EdgeInsets.symmetric(vertical: 4.0.h),
                                                                          child:
                                                                              Obx(() {
                                                                            return _controller.registeringPayment.value
                                                                                ? LoadingIndicatorBlue()
                                                                                : ElevatedButton(
                                                                                    onPressed: () {
                                                                                      if (_controller.sumOfSelectedPayments1.value == '0.00') {
                                                                                        SnakBarWidget.getSnackBarErrorBlue(AppMetaLabels().alert, AppMetaLabels().pleaseSelectPayment);
                                                                                      } else {
                                                                                        _controller.registerPayment(widget.contractNo??"");
                                                                                      }
                                                                                    },
                                                                                    child: Text(
                                                                                      AppMetaLabels().proceedTopayL,
                                                                                      style: AppTextStyle.semiBoldBlack11.copyWith(color: Colors.white),
                                                                                    ),
                                                                                    style: ButtonStyle(
                                                                                        elevation: WidgetStateProperty.all<double>(0.0),
                                                                                        backgroundColor: WidgetStateProperty.all<Color>(AppColors.blueColor),
                                                                                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                                                                          RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(2.0.w),
                                                                                          ),
                                                                                        )),
                                                                                  );
                                                                          }),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                            : SizedBox(),
                                                    // Padding(
                                                    //   padding: EdgeInsets.only(
                                                    //       top: 4.0.h,
                                                    //       left: 4.0.w,
                                                    //       right: 4.0.w),
                                                    //   child: Row(
                                                    //       mainAxisAlignment:
                                                    //           MainAxisAlignment
                                                    //               .start,
                                                    //       children: [
                                                    //         Text(
                                                    //           AppMetaLabels()
                                                    //               .amount,
                                                    //           style: AppTextStyle
                                                    //               .semiBoldBlack11,
                                                    //         ),
                                                    //         Spacer(),
                                                    //         Obx(() {
                                                    //           return Text(
                                                    //             '${AppMetaLabels().aed} ${_controller.sumOfSelectedPayments.value}',
                                                    //             style: AppTextStyle
                                                    //                 .semiBoldBlack11,
                                                    //           );
                                                    //         }),
                                                    //       ]),
                                                    // ),
                                                    // SizedBox(
                                                    //   height: 2.h,
                                                    // ),
                                                    // Image.asset(
                                                    //     AppImagesPath
                                                    //         .paymentMethods,
                                                    //     fit: BoxFit.fitHeight),
                                                    // Padding(
                                                    //   padding:
                                                    //       EdgeInsets.symmetric(
                                                    //           vertical: 1.h,
                                                    //           horizontal: 4.w),
                                                    //   child: InkWell(
                                                    //     onTap: () {
                                                    //       Get.to(() =>
                                                    //           TermsAndConditions(
                                                    //             title: AppMetaLabels()
                                                    //                 .termsConditions,
                                                    //           ));
                                                    //     },
                                                    //     child: Row(
                                                    //       children: [
                                                    //         Icon(
                                                    //           Icons.circle,
                                                    //           size: 2.w,
                                                    //         ),
                                                    //         SizedBox(
                                                    //           width: 2.w,
                                                    //         ),
                                                    //         Text(
                                                    //           AppMetaLabels()
                                                    //               .termsConditions,
                                                    //           style: AppTextStyle
                                                    //               .normalBlue10,
                                                    //         ),
                                                    //       ],
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    // Padding(
                                                    //   padding:
                                                    //       EdgeInsets.symmetric(
                                                    //           horizontal: 4.w),
                                                    //   child: InkWell(
                                                    //     onTap: () {
                                                    //       Get.to(() =>
                                                    //           TermsAndConditions(
                                                    //             title: AppMetaLabels()
                                                    //                 .refundPolicy,
                                                    //           ));
                                                    //     },
                                                    //     child: Row(
                                                    //       children: [
                                                    //         Icon(
                                                    //           Icons.circle,
                                                    //           size: 2.w,
                                                    //         ),
                                                    //         SizedBox(
                                                    //           width: 2.w,
                                                    //         ),
                                                    //         Text(
                                                    //           AppMetaLabels()
                                                    //               .refundPolicy,
                                                    //           style: AppTextStyle
                                                    //               .normalBlue10,
                                                    //         ),
                                                    //       ],
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    // Center(
                                                    //   child: Container(
                                                    //     height: 5.0.h,
                                                    //     width: 69.0.w,
                                                    //     margin: EdgeInsets
                                                    //         .symmetric(
                                                    //             vertical:
                                                    //                 4.0.h),
                                                    //     child: Obx(() {
                                                    //       return _controller
                                                    //               .registeringPayment
                                                    //               .value
                                                    //           ? LoadingIndicatorBlue()
                                                    //           : ElevatedButton(
                                                    //               onPressed:
                                                    //                   () {
                                                    //                 print(_controller
                                                    //                     .isPayemntValue
                                                    //                     .value);
                                                    //                 _controller
                                                    //                     .registerPayment(
                                                    //                         widget.contractNo);
                                                    //               },
                                                    //               child: Text(
                                                    //                 AppMetaLabels()
                                                    //                     .proceedTopayL,
                                                    //                 style: AppTextStyle
                                                    //                     .semiBoldBlack11
                                                    //                     .copyWith(
                                                    //                         color:
                                                    //                             Colors.white),
                                                    //               ),
                                                    //               style: ButtonStyle(
                                                    //                   elevation: MaterialStateProperty.all<double>(0.0),
                                                    //                   backgroundColor: MaterialStateProperty.all<Color>(AppColors.blueColor),
                                                    //                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    //                     RoundedRectangleBorder(
                                                    //                       borderRadius:
                                                    //                           BorderRadius.circular(2.0.w),
                                                    //                     ),
                                                    //                   )),
                                                    //             );
                                                    //     }),
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ))
                                          ]))))
            ]);
          }),
        ),
      ),
    );
  }

  Column paymentsListItem(Record payable) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_controller.cardPaymentListLength.length == 0 &&
            _controller.isPayemntValue.value == 1)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImagesPath.noPaymentsFound,
                fit: BoxFit.cover,
                width: 12.0.h,
                height: 12.0.h,
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Text(
                    AppMetaLabels().noPendingPF,
                    style: AppTextStyle.semiBoldGrey14,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        if (_controller.bankTransferListLength.length == 0 &&
            _controller.isPayemntValue.value == 3)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImagesPath.noPaymentsFound,
                fit: BoxFit.cover,
                width: 12.0.h,
                height: 12.0.h,
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Text(
                    AppMetaLabels().noPendingPF,
                    style: AppTextStyle.semiBoldGrey14,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        Obx(() {
          return payable.defaultpaymentmethodtype!.value ==
                  _controller.isPayemntValue.value
              ? Container(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          if (payable.type!.toLowerCase() ==
                              'contract payable') {
                            payable.isChecked.value = !payable.isChecked.value;
                            _controller.sumSelectedPayments();
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Obx(() {
                              return Checkbox(
                                activeColor: AppColors.blueColor,
                                value: payable.isChecked.value,
                                onChanged: (bool? value) {
                                  if (payable.type!.toLowerCase() ==
                                      'contract payable') {
                                    payable.isChecked.value = value!;
                                    _controller.sumSelectedPayments();
                                  }
                                },
                              );
                            }), //Check
                            Expanded(
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? payable.title??""
                                    : payable.titleAr ?? '',
                                style: AppTextStyle.normalBlack10,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 4.0.w),
                                child: Text(
                                  '${AppMetaLabels().aed} ${payable.amountFormatted}',
                                  style: AppTextStyle.normalBlack10,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 4.w, right: 4.w, bottom: 1.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppMetaLabels().dueDate,
                              style: AppTextStyle.normalBlack10,
                            ),
                            Text(
                              payable.paymentDate??"",
                              style: AppTextStyle.normalBlue10,
                            ),
                          ],
                        ),
                      ),
                      // Text(
                      //   'Payment Method ID : ${payable.paymentMethodId.value}',
                      // ),
                    ],
                  ),
                )
              : SizedBox();
        }),
        payable.defaultpaymentmethodtype!.value ==
                _controller.isPayemntValue.value
            ? AppDivider()
            : SizedBox(),
      ],
    );
  }
}
