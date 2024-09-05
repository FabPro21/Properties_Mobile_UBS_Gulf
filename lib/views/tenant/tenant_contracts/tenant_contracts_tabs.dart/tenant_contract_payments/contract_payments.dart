import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/bottom_shadow.dart';
import 'package:fap_properties/views/widgets/srno_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:sizer/sizer.dart';
import '../../../../../utils/styles/colors.dart';
import '../../../../widgets/common_widgets/error_text_widget.dart';
import '../../../tenant_payments/tenant_payment_download_receipt/tenant_payment_download_receipt_controller.dart';
import '../tenant_contracts_details.dart/tenant_contracts_detail_controller.dart';
import 'contract_payments_controller.dart';

// unverified
class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _PaymentsScreenState createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  final paymentsController = Get.put(ContractPaymentsController());
  final paymentDownloadReceiptController =
      Get.put(PaymentDownloadReceiptController());
  final TextEditingController searchControler = TextEditingController();

  final getCDController = Get.find<GetContractsDetailsController>();
  int tabIndex = 0;

  // @override
  // void initState() {
  //   paymentsController.getData();
  //   paymentsController.getUnverifiedPayments();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Obx(() {
            return Container(
                width: 100.w,
                height: 100.h,
                padding: EdgeInsets.only(bottom: 2.h),
                margin: EdgeInsets.fromLTRB(4.w, 2.0.h, 4.w, 2.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3.0.h),
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
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              TextButton(
                                child: Text(AppMetaLabels().verifiedPayments,
                                    style: tabIndex == 0
                                        ? AppTextStyle.semiBoldBlue10
                                        : AppTextStyle.semiBoldBlack10),
                                onPressed: () {
                                  setState(() {
                                    tabIndex = 0;
                                  });
                                  if (tabIndex == 0) {
                                    paymentsController.getData();
                                  }
                                  if (tabIndex == 1) {
                                    paymentsController.getUnverifiedPayments();
                                  }
                                },
                              ),
                              Container(
                                width: double.infinity,
                                height: 1.5,
                                color: tabIndex == 0
                                    ? AppColors.blueColor
                                    : Colors.transparent,
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              TextButton(
                                child: Text(AppMetaLabels().unverifiedPayments,
                                    style: tabIndex == 1
                                        ? AppTextStyle.semiBoldBlue10
                                        : AppTextStyle.semiBoldBlack10),
                                onPressed: () {
                                  setState(() {
                                    tabIndex = 1;
                                  });

                                  if (tabIndex == 0) {
                                    paymentsController.getData();
                                  }
                                  if (tabIndex == 1) {
                                    paymentsController.getUnverifiedPayments();
                                  }
                                },
                              ),
                              Container(
                                width: double.infinity,
                                height: 1.5,
                                color: tabIndex == 1
                                    ? AppColors.blueColor
                                    : Colors.transparent,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: tabIndex == 0
                          ? verifiedPayments()
                          : unverifiedPayments(),
                    )
                  ],
                ));
          }),
          BottomShadow(),
        ],
      ),
    );
  }

  Widget verifiedPayments() {
    return Column(
      children: [
        if (paymentsController.error.value == '')
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 249, 235, 1),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.amber[400],
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: SizedBox(
                    height: 4.h,
                    child: Marquee(
                      text: AppMetaLabels().chqDetailsUpdatedWithin,
                      style: AppTextStyle.normalBlack12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        Expanded(
          child: paymentsController.loadingData.value == true
              ? LoadingIndicatorBlue()
              : paymentsController.error.value != ''
                  ? CustomErrorWidget(
                      errorText: paymentsController.error.value,
                      errorImage: AppImagesPath.noPaymentsFound,
                      onRetry: () {
                        paymentsController.getData();
                      },
                    )
                  : ListView.builder(
                      // shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: paymentsController.length,
                      itemBuilder: (context, index) {
                        return verifiedPayment(index);
                      }),
        ),
      ],
    );
  }

  InkWell verifiedPayment(int index) {
    final paidFormatter = NumberFormat('#,##0.00', 'AR');
    String amount = paidFormatter
        .format(paymentsController.payments.payments![index].amount);

    print(
        'Cheque Api Condition ::: ${paymentsController.payments.payments![index].paymentType!.trim().toLowerCase()}');
    if (paymentsController.payments.payments![index].paymentType!
            .trim()
            .toLowerCase() ==
        'cheque') {
      paymentsController.getCheque(index);
    }
    return InkWell(
      onTap: () {
        // Get.to(
        //   () => TenantPaymentDetails(
        //       payment: paymentsController.payments.payments![index]),
        // );
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(3.w, 2.0.h, 3.w, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    SrNoWidget(text: index + 1, size: 4.h),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      AppMetaLabels().amount,
                      style: AppTextStyle.semiBoldGrey11,
                    ),
                    Spacer(),
                    Text(
                      "${AppMetaLabels().aed} $amount",
                      style: AppTextStyle.semiBoldGrey11,
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                rowList(
                    AppMetaLabels().paymentType,
                    SessionController().getLanguage() == 1
                        ? paymentsController
                                .payments.payments![index].paymentType ??
                            ""
                        : paymentsController
                                .payments.payments![index].paymentTypeAr ??
                            ""),
                if (paymentsController.payments.payments![index].paymentType ==
                    'Cheque')
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 2.0.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(247, 247, 247, 1),
                      borderRadius: BorderRadius.circular(1.0.h),
                    ),
                    child: Column(
                      children: [
                        Obx(() {
                          return paymentsController.payments.payments![index]
                                      .loadingCheque!.value ==
                                  true
                              ? Padding(
                                  padding: EdgeInsets.all(2.h),
                                  child: LoadingIndicatorBlue(),
                                )
                              : paymentsController.payments.payments![index]
                                          .errorLoadingCheque !=
                                      ''
                                  ? Padding(
                                      padding: EdgeInsets.all(2.h),
                                      child: AppErrorWidget(
                                        errorText: paymentsController.payments
                                            .payments![index].errorLoadingCheque??"error",
                                      ),
                                    )
                                  : paymentsController.payments.payments![index]
                                              .cheque !=
                                          null
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          itemCount: paymentsController
                                              .payments
                                              .payments![index]
                                              .cheque!
                                              .transactionCheque!
                                              .length,
                                          itemBuilder: (context, index2) {
                                            return Column(
                                              children: [
                                                rowList(
                                                    AppMetaLabels().chequeNo,
                                                    paymentsController
                                                            .payments
                                                            .payments![index]
                                                            .cheque!
                                                            .transactionCheque![
                                                                index2]
                                                            .chequeNo
                                                            .toString() ),
                                                rowList(
                                                    AppMetaLabels().chequeDate,
                                                    paymentsController
                                                            .payments
                                                            .payments![index]
                                                            .cheque!
                                                            .transactionCheque![
                                                                index2]
                                                            .chequeDate ??
                                                        ""),
                                                rowList(
                                                    AppMetaLabels()
                                                        .chqIssuerBank,
                                                    SessionController()
                                                                .getLanguage() ==
                                                            1
                                                        ? paymentsController
                                                                .payments
                                                                .payments![index]
                                                                .cheque!
                                                                .transactionCheque![
                                                                    index2]
                                                                .bankName ??
                                                            ""
                                                        : paymentsController
                                                                .payments
                                                                .payments![index]
                                                                .cheque!
                                                                .transactionCheque![
                                                                    index2]
                                                                .bankNameAr ??
                                                            ""),
                                                // removing paymentsController
                                                //         .payments
                                                //         .payments[index]
                                                //         .cheque
                                                //         .transactionCheque[
                                                //             index2]
                                                //         .chequeStatus ==
                                                //     'Bounced' condition because we want to show the status every time
                                                rowList(
                                                    AppMetaLabels().chqStatus,
                                                    SessionController()
                                                                .getLanguage() ==
                                                            1
                                                        ? paymentsController
                                                                .payments
                                                                .payments![index]
                                                                .cheque!
                                                                .transactionCheque![
                                                                    index2]
                                                                .chequeStatus ??
                                                            ""
                                                        : paymentsController
                                                                .payments
                                                                .payments![index]
                                                                .cheque!
                                                                .transactionCheque![
                                                                    index2]
                                                                .chequeStatusAR ??
                                                            ""),
                                                // if (paymentsController
                                                //         .payments
                                                //         .payments[index]
                                                //         .cheque
                                                //         .transactionCheque[
                                                //             index2]
                                                //         .chequeStatus ==
                                                //     'Bounced')
                                                //   rowList(
                                                //       AppMetaLabels().chqStatus,
                                                //       paymentsController
                                                //               .payments
                                                //               .payments[index]
                                                //               .cheque
                                                //               .transactionCheque[
                                                //                   index2]
                                                //               .chequeStatus ??
                                                //           ""),
                                                index2 ==
                                                        paymentsController
                                                                .payments
                                                                .payments![index]
                                                                .cheque!
                                                                .transactionCheque!
                                                                .length -
                                                            1
                                                    ? SizedBox()
                                                    : AppDivider(),
                                              ],
                                            );
                                          })
                                      : SizedBox();
                        }),
                      ],
                    ),
                  ),
                rowList(
                    AppMetaLabels().receiptNum,
                    paymentsController.payments.payments![index].receiptNo ??
                        ""),
                rowList(
                    AppMetaLabels().receiptDate,
                    paymentsController.payments.payments![index].paymentDate ??
                        ""),
                rowList(
                    AppMetaLabels().paymentFor,
                    SessionController().getLanguage() == 1
                        ? paymentsController.payments.payments![index].paymentFor??""
                        : paymentsController
                            .payments.payments![index].paymentForAr??""),
                if (!getCDController
                        .getContractsDetails.value.contract!.contractStatus!
                        .toLowerCase()
                        .contains('draft') &&
                    !getCDController
                        .getContractsDetails.value.contract!.contractStatus!
                        .toLowerCase()
                        .contains('under approval'))
                  Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: Obx(() {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.0.h, vertical: 2.h),
                        child: paymentsController.payments.payments![index]
                                    .downloadingReceipt!.value ==
                                true
                            ? LoadingIndicatorBlue()
                            : InkWell(
                                onTap: () async {
                                  paymentDownloadReceiptController
                                      .downloadReceipt(paymentsController
                                          .payments.payments![index]);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AppImagesPath.document,
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 2.0.h),
                                      child: Text(
                                        AppMetaLabels().downloadReceipt,
                                        style: AppTextStyle.normalBlue12,
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
                      );
                    }),
                  ),
              ],
            ),
          ),
          index == paymentsController.length - 1 ? Container() : AppDivider(),
        ],
      ),
    );
  }

  Widget unverifiedPayments() {
    return paymentsController.loadingUnverified.value == true
        ? LoadingIndicatorBlue()
        : paymentsController.errorLoadingUnverified != ''
            ? CustomErrorWidget(
                errorText: paymentsController.errorLoadingUnverified,
                errorImage: AppImagesPath.noPaymentsFound,
                onRetry: () {
                  paymentsController.getUnverifiedPayments();
                },
              )
            : ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: paymentsController
                    .unverifiedPayments.contractPayments!.length,
                itemBuilder: (context, index) {
                  return unverifiedPayment(index);
                });
  }

  InkWell unverifiedPayment(int index) {
    final paidFormatter = NumberFormat('#,##0.00', 'AR');
    String amount = paidFormatter.format(
        paymentsController.unverifiedPayments.contractPayments![index].amount);

    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(3.w, 3.0.h, 3.w, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    SrNoWidget(text: index + 1, size: 4.h),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      AppMetaLabels().refNo,
                      style: AppTextStyle.semiBoldGrey11,
                    ),
                    Spacer(),
                    Text(
                      paymentsController.unverifiedPayments
                              .contractPayments![index].referenceNo ??
                          "",
                      style: AppTextStyle.semiBoldGrey11,
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                rowList(
                  AppMetaLabels().reasonOfPayment,
                  SessionController().getLanguage() == 1
                      ? paymentsController.unverifiedPayments
                              .contractPayments![index].title ??
                          ""
                      : paymentsController.unverifiedPayments
                              .contractPayments![index].titleAR ??
                          "",
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                rowList(
                    AppMetaLabels().date,
                    paymentsController
                        .unverifiedPayments.contractPayments![index].createdOn!
                        .split(' ')
                        .first),
                SizedBox(
                  height: 2.0.h,
                ),
                rowList(
                  AppMetaLabels().paymentType,
                  SessionController().getLanguage() == 1
                      ? paymentsController.unverifiedPayments
                              .contractPayments![index].paymentType ??
                          ''
                      : paymentsController.unverifiedPayments
                              .contractPayments![index].paymentTypeAR ??
                          '',
                ),
                SizedBox(
                  height: 2.0.h,
                ),
                if (paymentsController.unverifiedPayments
                            .contractPayments![index].paymentType !=
                        null &&
                    paymentsController
                        .unverifiedPayments.contractPayments![index].paymentType!
                        .toLowerCase()
                        .contains('cheque'))
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                    child: rowList(
                        AppMetaLabels().chequeNo,
                        paymentsController.unverifiedPayments
                            .contractPayments![index].chequeNo??""),
                  ),
                Row(
                  children: [
                    Text(
                      AppMetaLabels().amount,
                      style: AppTextStyle.semiBoldGrey11,
                    ),
                    Spacer(),
                    Text(
                      "${AppMetaLabels().aed} $amount",
                      style: AppTextStyle.semiBoldGrey11,
                    ),
                  ],
                ),
              ],
            ),
          ),
          index == paymentsController.length - 1 ? Container() : AppDivider(),
        ],
      ),
    );
  }

  Row rowList(String t1, String t2) {
    return Row(
      children: [
        Expanded(
          child: Text(
            t1,
            style: AppTextStyle.normalGrey11,
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: Align(
            alignment: SessionController().getLanguage() == 1
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Text(t2,
                style: AppTextStyle.normalGrey11, textAlign: TextAlign.end),
          ),
        ),
      ],
    );
  }
}
