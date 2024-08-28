import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/bottom_shadow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'vendor_contracts_detail_controller.dart';

class VendorInfo extends StatefulWidget {
  const VendorInfo({Key? key}) : super(key: key);

  @override
  _VendorInfoState createState() => _VendorInfoState();
}

class _VendorInfoState extends State<VendorInfo> {
  final getCDController = Get.put(VendorContractsDetailsController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              BottomShadow(),
              Padding(
                padding: EdgeInsets.only(top: 2.0.h),
                child: Obx(() {
                  return getCDController.loadingData.value == true
                      ? Padding(
                          padding: EdgeInsets.only(top: 25.0.h),
                          child: LoadingIndicatorBlue(),
                        )
                      : getCDController.error.value != ''
                          ? Padding(
                              padding: EdgeInsets.only(top: 25.0.h),
                              child: AppErrorWidget(
                                errorText: getCDController.error.value,
                              ),
                            )
                          : Column(
                              children: [
                                Container(
                                  width: 94.0.w,
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
                                    padding: EdgeInsets.all(2.5.h),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  AppMetaLabels().contractDate,
                                                  style:
                                                      AppTextStyle.normalGrey10,
                                                ),
                                                SizedBox(
                                                  height: 1.0.h,
                                                ),
                                                Text(
                                                  getCDController
                                                          .getContractsDetails
                                                          .value
                                                          .contractDetail!
                                                          .contractDate
                                                          .toString(),
                                                  style: AppTextStyle
                                                      .semiBoldBlack10,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  AppMetaLabels().startDate,
                                                  style:
                                                      AppTextStyle.normalGrey10,
                                                ),
                                                SizedBox(
                                                  height: 1.0.h,
                                                ),
                                                Text(
                                                  getCDController
                                                          .getContractsDetails
                                                          .value
                                                          .contractDetail!
                                                          .startDate
                                                          .toString() ,
                                                  style: AppTextStyle
                                                      .semiBoldBlack10,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  AppMetaLabels().endDate,
                                                  style:
                                                      AppTextStyle.normalGrey10,
                                                ),
                                                SizedBox(
                                                  height: 1.0.h,
                                                ),
                                                Text(
                                                  getCDController
                                                          .getContractsDetails
                                                          .value
                                                          .contractDetail!
                                                          .endDate
                                                          .toString() ,
                                                  style: AppTextStyle
                                                      .semiBoldBlack10,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 2.0.h, bottom: 2.0.h),
                                          child: AppDivider(),
                                        ),
                                        rowList(AppMetaLabels().contractLength,
                                            "${getCDController.daysPassed} / ${getCDController.getContractsDetails.value.contractDetail!.contractLength.toString() }"),
                                        SizedBox(
                                          height: 1.0.h,
                                        ),
                                        LinearProgressIndicator(
                                          value: getCDController.comPtg,
                                          backgroundColor:
                                              AppColors.chartlightBlueColor,
                                        ),
                                        SizedBox(
                                          height: 1.0.h,
                                        ),
                                        rowList(
                                          AppMetaLabels().noofStaffwithAcc,
                                          getCDController
                                                  .getContractsDetails
                                                  .value
                                                  .contractDetail!
                                                  .noofStaffswithAccount
                                                  .toString(),
                                        ),
                                        rowList(
                                          AppMetaLabels().noofStaffwithoutAcc,
                                          getCDController
                                                  .getContractsDetails
                                                  .value
                                                  .contractDetail!
                                                  .noofStaffswithoutAccount
                                                  .toString() ,
                                        ),
                                        rowList(
                                          AppMetaLabels()
                                              .noOfPaymentInstallments,
                                          getCDController
                                                  .getContractsDetails
                                                  .value
                                                  .contractDetail!
                                                  .paymentInstallments
                                                  .toString() ,
                                        ),
                                        rowList(
                                          AppMetaLabels().paymentType,
                                          getCDController
                                                  .getContractsDetails
                                                  .value
                                                  .contractDetail!
                                                  .paymentTermType
                                                  .toString(),
                                        ),
                                        rowList(
                                          AppMetaLabels().amount,
                                          "${AppMetaLabels().aed}" +
                                              " ${getCDController.amountCurrency.toString() }",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                }),
              ),
            ],
          ),
        ));
  }

  Row rowList(String text1, String text2) {
    return Row(
      children: [
        Text(
          text1,
          style: AppTextStyle.normalBlack10,
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(top: 1.8.h),
          child: Text(
            text2,
            style: AppTextStyle.semiBoldBlack10,
          ),
        ),
      ],
    );
  }
}
