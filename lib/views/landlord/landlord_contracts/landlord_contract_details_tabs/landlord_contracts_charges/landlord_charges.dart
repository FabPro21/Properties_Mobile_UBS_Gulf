import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/landlord/landlord_contracts/landlord_contract_details_tabs/landlord_contracts_charges/charges_receipts/landlord_charges_receipts.dart';
import 'package:fap_properties/views/landlord/landlord_contracts/landlord_contract_details_tabs/landlord_contracts_charges/landlord_contract_charges_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/bottom_shadow.dart';
import 'package:fap_properties/views/widgets/srno_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../data/models/chart_data.dart';

class LandlordChargesScreen extends StatefulWidget {
  const LandlordChargesScreen({Key key}) : super(key: key);

  @override
  _LandlordChargesScreenState createState() => _LandlordChargesScreenState();
}

class _LandlordChargesScreenState extends State<LandlordChargesScreen> {
  final getCCController = Get.put(GetLandlordChargesController());

  String amount = "";
  String vAmount = "";
  String tAmount = "";

  @override
  Widget build(BuildContext context) {
    getCCController.getData();
    return Stack(
      children: [
        Obx(() {
          // double outStandingAmount = 110;
          // double paidCharges = 120;
          double outStandingAmount = getCCController.outstandingCharges.value;
          double paidCharges = getCCController.paidCharges.value;
          if (outStandingAmount == 0 && paidCharges == 0) {
            outStandingAmount = 1;
            paidCharges = 1;
          }
          List<ChartData> chartData = [
            ChartData(AppMetaLabels().outstanding, outStandingAmount,
                AppColors.amber.withOpacity(0.2)),
            ChartData(AppMetaLabels().paidCharges, paidCharges,
                AppColors.chartlightBlueColorCharges),
          ];
          // List<ChartData> chartData = [
          //   ChartData(AppMetaLabels().outstanding, outStandingAmount,
          //       AppColors.chartDarkBlueColor),
          //   ChartData(AppMetaLabels().paidCharges, paidCharges,
          //       AppColors.chartlightBlueColor),
          // ];
          return getCCController.loadingData.value == true
              ? LoadingIndicatorBlue()
              : getCCController.error.value != ''
                  ? AppErrorWidget(
                      errorText: getCCController.error.value,
                    )
                  : Scaffold(
                      backgroundColor: Colors.grey[50],
                      body: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.0.h, horizontal: 4.w),
                            child: SizedBox(
                              width: 100.0.w,
                              height: 16.0.h,
                              child: SfCircularChart(series: <CircularSeries>[
                                DoughnutSeries<ChartData, String>(
                                  innerRadius: '85%',
                                  radius: "100%",
                                  explode: true,
                                  dataSource: chartData,
                                  pointColorMapper: (ChartData data, _) =>
                                      data.color,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y,
                                ),
                              ]),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              columnList(
                                AppColors.chartlightBlueColorCharges,
                                AppMetaLabels().paidCharges,
                                getCCController.paidChargesCurrency
                                        .toString() ??
                                    "",
                              ),
                              columnList(
                                  AppColors.amber.withOpacity(0.5),
                                  AppMetaLabels().outstanding,
                                  getCCController.outstandingChargesCurrency
                                          .toString() ??
                                      ""),
                              // columnList(
                              //     AppColors.chartlightBlueColor,
                              //     AppMetaLabels().paidCharges,
                              //     getCCController.paidChargesCurrency
                              //             .toString() ??
                              //         ""),
                              // columnList(
                              //     AppColors.chartDarkBlueColor,
                              //     AppMetaLabels().outstanding,
                              //     getCCController.outstandingChargesCurrency
                              //             .toString() ??
                              //         ""),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(2.0.h),
                              child: Container(
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
                                    padding: EdgeInsets.zero,
                                    itemCount: getCCController.length,
                                    itemBuilder: (context, index) {
                                      double am = double.parse(getCCController
                                          .getCharges
                                          .value
                                          .contractCharges[index]
                                          .amount
                                          .toString());

                                      final paidFormatter =
                                          NumberFormat('#,##0.00', 'AR');
                                      amount = paidFormatter.format(am);
                                      double va = double.parse(getCCController
                                          .getCharges
                                          .value
                                          .contractCharges[index]
                                          .vatAmount
                                          .toString());
                                      final vaFormatter =
                                          NumberFormat('#,##0.00', 'AR');
                                      vAmount = vaFormatter.format(va);
                                      double ta = double.parse(getCCController
                                          .getCharges
                                          .value
                                          .contractCharges[index]
                                          .totalAmount
                                          .toString());
                                      final tFormatter =
                                          NumberFormat('#,##0.00', 'AR');
                                      tAmount = tFormatter.format(ta);
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
                                                      rowList(
                                                          AppMetaLabels().date,
                                                          "${getCCController.getCharges.value.contractCharges[index].createdOn ?? ""}"),
                                                      SizedBox(
                                                        height: 0.7.h,
                                                      ),
                                                      rowList(
                                                          AppMetaLabels()
                                                              .amount,
                                                          "${AppMetaLabels().aed} ${amount.toString() ?? ""}" ??
                                                              ""),
                                                      SizedBox(
                                                        height: 0.7.h,
                                                      ),
                                                      rowList(
                                                          AppMetaLabels()
                                                              .vatAmount,
                                                          "${AppMetaLabels().aed} ${vAmount.toString() ?? ""}" ??
                                                              ""),
                                                      SizedBox(
                                                        height: 0.7.h,
                                                      ),
                                                      rowList(
                                                        AppMetaLabels()
                                                            .chargeType,
                                                        SessionController()
                                                                    .getLanguage() ==
                                                                1
                                                            ? getCCController
                                                                    .getCharges
                                                                    .value
                                                                    .contractCharges[
                                                                        index]
                                                                    .chargesType ??
                                                                ""
                                                            : getCCController
                                                                    .getCharges
                                                                    .value
                                                                    .contractCharges[
                                                                        index]
                                                                    .chargesTypeAr ??
                                                                '',
                                                      ),
                                                      SizedBox(
                                                        height: 0.7.h,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            AppMetaLabels()
                                                                .totalAmount,
                                                            style: AppTextStyle
                                                                .semiBoldBlack10,
                                                          ),
                                                          Spacer(),
                                                          Text(
                                                            "${AppMetaLabels().aed} ${tAmount.toString() ?? ""}" ??
                                                                "",
                                                            style: AppTextStyle
                                                                .semiBoldBlack10,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 0.7.h,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 8.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            print(getCCController
                                                                .getCharges
                                                                .value
                                                                .contractCharges[
                                                                    index]
                                                                .chargesTypeId);
                                                            Get.to(() => LandlordChargesReceipts(
                                                                chargesTypeId: getCCController
                                                                    .getCharges
                                                                    .value
                                                                    .contractCharges[
                                                                        index]
                                                                    .chargesTypeId));
                                                          },
                                                          child: Text(
                                                              AppMetaLabels()
                                                                  .showReceipts,
                                                              style: AppTextStyle
                                                                  .normalBlue11
                                                              // .semiBoldBlue11ul,
                                                              // style: AppTextStyle
                                                              //     .semiBoldBlue11ul,
                                                              ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          index == getCCController.length - 1
                                              ? Container()
                                              : AppDivider(),
                                        ],
                                      );
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
        }),
        BottomShadow(),
      ],
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
        Expanded(
          child: Align(
            alignment: SessionController().getLanguage() == 1
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Text(
              t2,
              style: AppTextStyle.normalBlack10,
            ),
          ),
        ),
      ],
    );
  }
}
