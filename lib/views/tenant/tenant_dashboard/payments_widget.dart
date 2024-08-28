import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/tenant/tenant_dashboard/tenant_dashboard_get_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart' as intl;

import '../tenant_payments/payment_details/tenent_payment_details.dart';

class PaymentsWidget extends StatefulWidget {
  final Function(int)? managePayments;
  const PaymentsWidget({Key? key, this.managePayments}) : super(key: key);

  @override
  State<PaymentsWidget> createState() => _PaymentsWidgetState();
}

class _PaymentsWidgetState extends State<PaymentsWidget> {
  final TenantDashboardGetDataController paymentsController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.0.h, vertical: 1.0.h),
      child: Container(
        // height: 31.0.h,
        width: 94.0.w,
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
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0.h, vertical: 2.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    AppMetaLabels().payments,
                    style: AppTextStyle.semiBoldBlack13,
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 2.0.h),
              child: AppDivider(),
            ),
            Container(
              child: Obx(() {
                return paymentsController.loadingPaymentsData.value == true
                    ? LoadingIndicatorBlue()
                    : paymentsController.errorPayments.value != ''
                        ? AppErrorWidget(
                            errorText: paymentsController.errorPayments.value,
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: paymentsController.paymentsLength2,
                            itemBuilder: (context, index) {
                              return inkWell(index);
                            },
                          );
              }),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2.0.h, bottom: 2.0.h),
              child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  widget.managePayments!(3);
                },
                child: Text(
                  AppMetaLabels().viewAllPayments,
                  style: AppTextStyle.semiBoldBlue9,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell inkWell(int index) {
    final amountFormatter = intl.NumberFormat('#,##0.00', 'AR');
    return InkWell(
      onTap: () {
        SessionController().setTransactionId(
          paymentsController.payments.value.payments![index].transactionId
              .toString(),
        );
        Get.to(
          () => TenantPaymentDetails(
              payment: paymentsController.payments.value.payments![index]),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: 2.0.h,
          right: 2.0.h,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  SessionController().getLanguage() == 1
                      ? paymentsController
                          .payments.value.payments![index].paymentFor??""
                      : paymentsController
                          .payments.value.payments![index].paymentForAr??"",

                  // AppMetaLabels().newRequestSmall,
                  style: AppTextStyle.semiBoldGrey11,
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(top: 0.5.h),
                  child: Text(
                    "${paymentsController.payments.value.payments![index].receiptNo}" ,
                    style: AppTextStyle.normalGrey11,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.7.h),
              child: Row(
                children: [
                  Text(
                    "${AppMetaLabels().aed} ${amountFormatter.format(paymentsController.payments.value.payments![index].amount)}",
                    // AppMetaLabels().newRequestSmall,
                    style: AppTextStyle.semiBoldBlack12,
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(top: 0.5.h),
                    child: Text(
                      paymentsController
                              .payments.value.payments![index].paymentDate ??
                          "",
                      style: AppTextStyle.normalGrey11,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.7.h),
              child: Row(
                children: [
                  Text(
                    "${AppMetaLabels().contractNo}",
                    style: AppTextStyle.semiBoldGrey11,
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(top: 0.5.h),
                    child: Text(
                      "${paymentsController.payments.value.payments![index].contractNo}",
                      style: AppTextStyle.normalGrey11,
                    ),
                  ),
                ],
              ),
            ),
            index == paymentsController.paymentsLength - 1
                ? Container()
                : Padding(
                    padding: EdgeInsets.only(top: 2.0.h, bottom: 2.0.h),
                    child: AppDivider(),
                  ),
          ],
        ),
      ),
    );
  }
}
