import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/vendor/vendor_contracts/vendor_contracts_tabs.dart/vendor_financial_terms/vendor_financial_terms_controller.dart';
import 'package:fap_properties/views/widgets/bottom_shadow.dart';
import 'package:fap_properties/views/widgets/srno_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../data/models/chart_data.dart';

class VendorFinancialTerms extends StatefulWidget {
  const VendorFinancialTerms({Key? key}) : super(key: key);

  @override
  _VendorFinancialTermsState createState() => _VendorFinancialTermsState();
}

class _VendorFinancialTermsState extends State<VendorFinancialTerms> {
  final getContractFinancialTermsController =
      Get.put(GetContractFinancialTermsController());

  String amount = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(2.0.h),
              child: Obx(() {
                List<ChartData> chartData = [
                  ChartData(
                      ' ' + AppMetaLabels().balance,
                      getContractFinancialTermsController.totalAmountSum.value,
                      // 120,
                      // AppColors.chartDarkBlueColor,
                      AppColors.amber.withOpacity(0.2)),
                  ChartData(
                      ' ' + AppMetaLabels().paid,
                      // 110,
                      getContractFinancialTermsController.totalPaid.value,
                      // AppColors.chartlightBlueColor
                      AppColors.chartlightBlueColorCharges),
                ];
                return getContractFinancialTermsController.loadingData.value ==
                        true
                    ? Padding(
                        padding: EdgeInsets.only(top: 25.0.h),
                        child: LoadingIndicatorBlue(),
                      )
                    : getContractFinancialTermsController.error.value != ''
                        ? Padding(
                            padding: EdgeInsets.only(top: 25.0.h),
                            child: AppErrorWidget(
                              errorText: getContractFinancialTermsController
                                  .error.value,
                            ),
                          )
                        : Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(1.0.h),
                                child: SizedBox(
                                  width: 100.0.w,
                                  height: 27.0.h,
                                  child: SfCircularChart(
                                      annotations: <CircularChartAnnotation>[
                                        CircularChartAnnotation(
                                          widget: Container(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppMetaLabels().total,
                                                style:
                                                    AppTextStyle.normalBlack10,
                                              ),
                                              SizedBox(
                                                width: 22.w,
                                                child: FittedBox(
                                                  child: Text(
                                                    "${AppMetaLabels().aed} ${getContractFinancialTermsController.totalAmountSumFormat.value.toString() }",
                                                    style: AppTextStyle
                                                        .semiBoldBlack10,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                        )
                                      ],
                                      series: <CircularSeries>[
                                        DoughnutSeries<ChartData, String>(
                                          innerRadius: '85%',
                                          radius: "100%",
                                          explode: true,
                                          dataSource: chartData,
                                          pointColorMapper:
                                              (ChartData data, _) => data.color,
                                          xValueMapper: (ChartData data, _) =>
                                              data.x,
                                          yValueMapper: (ChartData data, _) =>
                                              data.y,
                                        ),
                                      ]),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  columnList(
                                      // AppColors.chartlightBlueColor,
                                      AppColors.chartlightBlueColorCharges,
                                      ' ' + AppMetaLabels().paid,
                                      getContractFinancialTermsController
                                              .totalPaidFormat.value
                                              .toString()),
                                  columnList(
                                      // AppColors.chartDarkBlueColor,
                                      AppColors.amber.withOpacity(0.2),
                                      ' ' + AppMetaLabels().balance,
                                      getContractFinancialTermsController
                                              .balanceFormat.value
                                              .toString()),
                                ],
                              ),
                              SizedBox(
                                height: 2.0.h,
                              ),
                              Container(
                                // height: 92.0.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1.0.h),
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
                                child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount:
                                        getContractFinancialTermsController
                                            .length,
                                    itemBuilder: (context, index) {
                                      ///////////////////////////////
                                      /// amount currency format
                                      ///////////////////////////////
                                      var am =
                                          getContractFinancialTermsController
                                              .getFinalcialTerms
                                              .value
                                              .contractFinancialTerms?[index]
                                              .amount;
                                      final paidFormatter =
                                          NumberFormat('#,##0.00', 'AR');
                                      amount = paidFormatter.format(am);

                                      return Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(2.0.h),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SrNoWidget(
                                                    text: index + 1, size: 4.h),
                                                SizedBox(
                                                  width: 2.w,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 0.5.h,
                                                      ),
                                                      rowList(
                                                          AppMetaLabels()
                                                              .amount,
                                                          "${AppMetaLabels().aed} $amount"),
                                                      SizedBox(
                                                        height: 0.5.h,
                                                      ),
                                                      rowList(
                                                          AppMetaLabels()
                                                              .paymentDate,
                                                          getContractFinancialTermsController
                                                                  .getFinalcialTerms
                                                                  .value
                                                                  .contractFinancialTerms![
                                                                      index]
                                                                  .paymentDate
                                                                  .toString() ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          index ==
                                                  getContractFinancialTermsController
                                                          .length -
                                                      1
                                              ? Container()
                                              : AppDivider(),
                                        ],
                                      );
                                    }),
                              ),
                            ],
                          );
              }),
            ),
          ),
          BottomShadow(),
        ],
      ),
    );
  }

  Column columnList(Color color, String text, String amount) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 3.0.h,
              width: 3.0.w,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.0.h, right: 2.h),
              child: Text(
                text,
                style: AppTextStyle.normalBlack10,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 4.0.h),
          child: Text(
            "${AppMetaLabels().aed} $amount",
            style: AppTextStyle.semiBoldBlack11,
          ),
        ),
      ],
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
