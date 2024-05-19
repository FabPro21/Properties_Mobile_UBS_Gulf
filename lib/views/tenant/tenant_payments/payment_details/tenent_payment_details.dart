import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:intl/intl.dart' as intl;
import 'package:sizer/sizer.dart';
import '../../../../../../data/models/tenant_models/contract_payment_model.dart';
import '../../../../data/helpers/session_controller.dart';
import '../tenant_payment_download_receipt/tenant_payment_download_receipt_controller.dart';
import 'tenant_payment_details_controller.dart';

class TenantPaymentDetails extends StatefulWidget {
  final Payment payment;

  const TenantPaymentDetails({Key key, this.payment}) : super(key: key);
  @override
  State<TenantPaymentDetails> createState() => _TenantPaymentDetailsState();
}

class _TenantPaymentDetailsState extends State<TenantPaymentDetails> {
  final paymentDetailsController =
      getx.Get.put(TenantPaymentDetailsController());
  final paymentDownloadReceiptController =
      getx.Get.put(PaymentDownloadReceiptController());

  @override
  void initState() {
    paymentDetailsController.getCheque(widget.payment);
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 4.0.h, left: 2.5.h, right: 2.5.h),
                  child: Row(
                    children: [
                      Text(
                        AppMetaLabels().receiptNo,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.semiBoldBlack16,
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 2.0.h, left: 2.h),
                        child: Text(widget.payment.receiptNo,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.semiBoldBlack16),
                      ),
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
                  padding: EdgeInsets.only(top: 1.0.h, bottom: 1.0.h),
                  child: AppDivider(),
                ),
                Padding(
                  padding: EdgeInsets.all(2.0.h),
                  child: Container(
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
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 100.0.h,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(247, 247, 247, 1),
                                  borderRadius:
                                      widget.payment.paymentType == 'Cheque'
                                          ? BorderRadius.only(
                                              topLeft: Radius.circular(1.0.h),
                                              topRight: Radius.circular(1.0.h))
                                          : BorderRadius.circular(1.0.h),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(2.0.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppMetaLabels().amount,
                                        style: AppTextStyle.normalBlack10,
                                      ),
                                      Text(
                                        AppMetaLabels().aed +
                                            " ${widget.payment.amount.toString()}",
                                        style: AppTextStyle.semiBoldBlack11,
                                      ),
                                      SizedBox(
                                        height: 1.0.h,
                                      ),
                                      Text(
                                        AppMetaLabels().paymentFor,
                                        style: AppTextStyle.normalBlack10,
                                      ),
                                      Text(
                                        SessionController().getLanguage() == 1
                                            ? widget.payment.paymentFor??""
                                            : widget.payment.paymentForAr??"",
                                        style: AppTextStyle.semiBoldBlack11,
                                      ),
                                      SizedBox(
                                        height: 1.0.h,
                                      ),
                                      Text(
                                        AppMetaLabels().date,
                                        style: AppTextStyle.normalBlack10,
                                      ),
                                      Text(
                                        widget.payment.paymentDate.toString(),
                                        style: AppTextStyle.semiBoldBlack11,
                                      ),
                                      SizedBox(
                                        height: 1.0.h,
                                      ),
                                      Text(
                                        AppMetaLabels().paymentType,
                                        style: AppTextStyle.normalBlack10,
                                      ),
                                      Text(
                                        SessionController().getLanguage() == 1
                                            ? widget.payment.paymentType??""
                                            : widget.payment.paymentTypeAr??"",
                                        style: AppTextStyle.semiBoldBlack11,
                                      ),
                                      SizedBox(
                                        height: 1.0.h,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              widget.payment.paymentType == 'Cheque'
                                  ? Wrap(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 2.0.h,
                                              top: 1.0.h,
                                              right: 2.h),
                                          child: Text(
                                            AppMetaLabels().chequeDetails,
                                            style: AppTextStyle.semiBoldBlack12,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2.h, horizontal: 4.w),
                                          child: getx.Obx(() {
                                            return paymentDetailsController
                                                        .loadingData.value ==
                                                    true
                                                ? LoadingIndicatorBlue()
                                                : paymentDetailsController
                                                            .error.value !=
                                                        ''
                                                    ? AppErrorWidget(
                                                        errorText:
                                                            paymentDetailsController
                                                                .error.value,
                                                      )
                                                    : SingleChildScrollView(
                                                        child: ListView.builder(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            shrinkWrap: true,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            itemCount:
                                                                paymentDetailsController
                                                                    .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              final paidFormatter =
                                                                  intl.NumberFormat(
                                                                      '#,##0.00',
                                                                      'AR');
                                                              String amount = paidFormatter.format(
                                                                  paymentDetailsController
                                                                      .getcheque
                                                                      .value
                                                                      .transactionCheque[
                                                                          index]
                                                                      .chequeAmount);
                                                              return Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  // color: Colors.grey[200],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              1.0.h),
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          AppMetaLabels()
                                                                              .amount,
                                                                          style:
                                                                              AppTextStyle.semiBoldBlack11,
                                                                        ),
                                                                        Spacer(),
                                                                        Text(
                                                                          "${AppMetaLabels().aed} $amount",
                                                                          style:
                                                                              AppTextStyle.semiBoldBlack11,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    rowList(
                                                                        AppMetaLabels()
                                                                            .chequeNo,
                                                                        paymentDetailsController.getcheque.value.transactionCheque[index].chequeNo.toString() ??
                                                                            ""),
                                                                    rowList(
                                                                        AppMetaLabels()
                                                                            .date,
                                                                        paymentDetailsController.getcheque.value.transactionCheque[index].chequeDate.toString() ??
                                                                            ""),
                                                                    rowList(
                                                                        AppMetaLabels()
                                                                            .chqIssuerBank,
                                                                        SessionController().getLanguage() == 1
                                                                            ? paymentDetailsController.getcheque.value.transactionCheque[index].bankName ??
                                                                                ""
                                                                            : paymentDetailsController.getcheque.value.transactionCheque[index].bankNameAr),
                                                                    rowList(
                                                                        AppMetaLabels()
                                                                            .chqStatus,
                                                                        SessionController().getLanguage() == 1
                                                                            ? paymentDetailsController.getcheque.value.transactionCheque[index].chequeStatus ??
                                                                                ""
                                                                            : paymentDetailsController.getcheque.value.transactionCheque[index].chequeStatus ??
                                                                                ""),
                                                                    SizedBox(
                                                                        height:
                                                                            1.0.h),
                                                                    index ==
                                                                            paymentDetailsController.length -
                                                                                1
                                                                        ? Container()
                                                                        : AppDivider(),
                                                                    SizedBox(
                                                                        height:
                                                                            1.0.h),
                                                                  ],
                                                                ),
                                                              );
                                                            }),
                                                      );
                                          }),
                                        ),
                                      ],
                                    )
                                  : SizedBox()
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                getx.Obx(() {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.0.h),
                    child: Container(
                      width: 100.0.w,
                      height: 15.0.h,
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
                      child: Padding(
                        padding: EdgeInsets.all(2.0.h),
                        child: widget.payment.downloadingReceipt.value == true
                            ? LoadingIndicatorBlue()
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppMetaLabels().documents,
                                    style: AppTextStyle.semiBoldBlack12,
                                  ),
                                  SizedBox(
                                    height: 2.0.h,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      paymentDownloadReceiptController
                                          .downloadReceipt(widget.payment);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                ],
                              ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
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
