import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/tenant/tenant_payments/payment_details/tenent_payment_details.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/srno_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sizer/sizer.dart';
import 'tenant_payments_controller.dart';

class TenantPaymentsScreen extends StatefulWidget {
  const TenantPaymentsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _TenantPaymentsScreenState createState() => _TenantPaymentsScreenState();
}

class _TenantPaymentsScreenState extends State<TenantPaymentsScreen> {
  final TextEditingController searchControler = TextEditingController();

  final TenantPaymentsController paymentsController = Get.find();

  @override
  void initState() {
    paymentsController.getData(paymentsController.pageNo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 3.0.h),
            child: Text(
              AppMetaLabels().payments,
              style: AppTextStyle.semiBoldWhite15,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 2.0.h, right: 2.0.h, top: 6.0.h),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(1.0.h),
              ),
              child: Padding(
                padding: EdgeInsets.all(0.3.h),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchControler,
                        onChanged: (value) async {
                          // paymentsController.searchData(value);
                          if (value.isEmpty) {
                            await paymentsController
                                .getData(paymentsController.pageNo);
                            setState(() {});
                          }
                          if (value.isNotEmpty) {
                            await paymentsController.searchDataByApi(
                                paymentsController.pageNo, value.trim());
                            setState(() {});
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.1),
                          prefixIcon: Icon(
                            Icons.search,
                            size: 2.0.h,
                            color: Colors.grey,
                          ),
                          contentPadding:
                              EdgeInsets.only(left: 5.0.w, right: 5.0.w),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.5.h),
                            borderSide: BorderSide(
                                color: AppColors.whiteColor, width: 0.1.h),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.5.h),
                            borderSide: BorderSide(
                                color: AppColors.whiteColor, width: 0.1.h),
                          ),
                          hintText: AppMetaLabels().searchPayments,
                          hintStyle: AppTextStyle.normalBlack10
                              .copyWith(color: Colors.grey),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        searchControler.clear();
                        paymentsController.getData(paymentsController.pageNo);
                      },
                      icon: Icon(
                        Icons.refresh,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: 4.0.h,
              ),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 50.h),
                  child: Container(
                    width: 92.0.w,
                    margin: EdgeInsets.all(1.5.h),
                    // height: 70.5.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2.0.h),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 0.5.h,
                          spreadRadius: 0.8.h,
                          offset: Offset(0.1.h, 0.1.h),
                        ),
                      ],
                    ),
                    child: Obx(() {
                      return paymentsController.loadingData.value == true
                          ? LoadingIndicatorBlue()
                          : paymentsController.error.value != ''
                              ? CustomErrorWidget(
                                  errorText: AppMetaLabels().noPaymentFound,
                                  errorImage: AppImagesPath.noPaymentsFound,
                                  onRetry: () {
                                    paymentsController
                                        .getData(paymentsController.pageNo);
                                  },
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: paymentsController.payments.length,
                                  itemBuilder: (context, index) {
                                    return inkWell(index);
                                  });
                    }),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InkWell inkWell(int index) {
    final amountFormatter = intl.NumberFormat('#,##0.00', 'AR');
    return InkWell(
      onTap: () {
        SessionController().setTransactionId(
          paymentsController.payments[index].transactionId.toString(),
        );
        Get.to(
          () =>
              TenantPaymentDetails(payment: paymentsController.payments[index]),
        );
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(2.0.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SrNoWidget(text: index + 1, size: 4.h),
                SizedBox(
                  width: 2.w,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            AppMetaLabels().amount,
                            style: AppTextStyle.semiBoldGrey11,
                          ),
                          Spacer(),
                          Text(
                            "${AppMetaLabels().aed} ${amountFormatter.format(paymentsController.payments[index].amount)}",
                            style: AppTextStyle.semiBoldGrey11,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      rowList(
                          AppMetaLabels().paymentType,
                          SessionController().getLanguage() == 1
                              ? paymentsController
                                      .payments[index].paymentType ??
                                  ""
                              : paymentsController
                                      .payments[index].paymentTypeAr ??
                                  ''),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      rowList(AppMetaLabels().receiptNum,
                          '${paymentsController.payments[index].receiptNo}',
                          flex: 2),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      rowList(AppMetaLabels().receiptDate,
                          paymentsController.payments[index].paymentDate ?? ""),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      rowList(
                          AppMetaLabels().paymentFor,
                          SessionController().getLanguage() == 1
                              ? paymentsController.payments[index].paymentFor ??
                                  ""
                              : paymentsController
                                      .payments[index].paymentForAr ??
                                  ""),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      rowList(
                          AppMetaLabels().contractNo,
                          paymentsController.payments[index].contractNo
                              .toString()),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 1.0.h, left: 1.h),
                  child: SizedBox(
                    width: 0.15.w,
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.grey1,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
          index == paymentsController.payments.length - 1
              ? Container()
              : AppDivider(),
          index == paymentsController.payments.length - 1
              ? paymentsController.payments.length < 20
                  ? SizedBox()
                  : paymentsController.isSearch.value
                      ? SizedBox()
                      : Center(
                          child: Obx(() {
                            return paymentsController.errorNoMoreData.value !=
                                    ''
                                ? Text(AppMetaLabels().noMoreData,
                                    style: AppTextStyle.boldBlue)
                                : paymentsController.loadingDataMore.value
                                    ? SizedBox(
                                        width: 75.w,
                                        height: 5.h,
                                        child: Center(
                                          child: LoadingIndicatorBlue(),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () async {
                                          int pageSize = int.parse(
                                              paymentsController.pageNo);
                                          int naePageNo = pageSize + 1;
                                          paymentsController.pageNo =
                                              naePageNo.toString();
                                          await paymentsController.getData1(
                                              paymentsController.pageNo);
                                          setState(() {});
                                        },
                                        child: SizedBox(
                                            width: 75.w,
                                            height: 3.h,
                                            child: RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: AppMetaLabels()
                                                          .loadMoreData,
                                                      style: AppTextStyle
                                                          .boldBlue),
                                                  WidgetSpan(
                                                    child: Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 15,
                                                      color:
                                                          AppColors.blueColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      );
                          }),
                        )
              : SizedBox(),
          SizedBox(
            height: 1.5.h,
          )
        ],
      ),
    );
  }

  Row rowList(String t1, String t2, {int flex = 1}) {
    return Row(
      children: [
        Expanded(
          flex: flex,
          child: Text(
            t1,
            style: AppTextStyle.normalBlack10,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            t2,
            textAlign: SessionController().getLanguage() == 1
                ? TextAlign.right
                : TextAlign.left,
            style: AppTextStyle.semiBoldGrey11,
          ),
        ),
      ],
    );
  }
}
