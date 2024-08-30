import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/bottom_shadow.dart';
import 'package:fap_properties/views/widgets/srno_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import 'lpo_services_controller.dart';

class LpoServices extends StatefulWidget {
  const LpoServices({Key? key}) : super(key: key);

  @override
  _LpoServicesState createState() => _LpoServicesState();
}

class _LpoServicesState extends State<LpoServices> {
  final getLpoServicesController = Get.put(GetLpoServicesController());
  // _getData() async {
  //   await getLpoServicesController.getData();
  // }

  String gAmount = "";
  String dAmount = "";
  String nAmount = "";
  String discountPercentage = "0.00";

  @override
  void initState() {
    // _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BottomShadow(),
        Obx(() {
          return getLpoServicesController.loadingData.value
              ? LoadingIndicatorBlue()
              : getLpoServicesController.error.value != ''
                  ? AppErrorWidget(
                      errorText: getLpoServicesController.error.value,
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 2.0.w,
                            right: 2.0.w,
                            top: 3.0.h,
                            bottom: 5.0.h,
                          ),
                          child: Container(
                            width: 100.0.w,
                            // height: 100.0.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2.0.h),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[200] ?? Colors.grey,
                                  blurRadius: 0.4.h,
                                  spreadRadius: 0.8.h,
                                  offset: Offset(0.1.h, 0.1.h),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount: getLpoServicesController.length,
                                    itemBuilder: (BuildContext context, index) {
                                      var d = getLpoServicesController
                                          .lpoServices
                                          .value
                                          .lpoServices?[index]
                                          .discountPercentage;
                                      discountPercentage = d.toStringAsFixed(2);
                                      //////////////////////////
                                      /// Gross Amount
                                      //////////////////////////
                                      var ga = getLpoServicesController
                                          .lpoServices
                                          .value
                                          .lpoServices?[index]
                                          .netAmount;
                                      final gFormatter =
                                          NumberFormat('#,##0.00', 'AR');
                                      gAmount = gFormatter.format(ga);
                                      //////////////////////////
                                      /// Discount Amount
                                      //////////////////////////
                                      var da = getLpoServicesController
                                          .lpoServices
                                          .value
                                          .lpoServices?[index]
                                          .discountAmount;
                                      final dFormatter =
                                          NumberFormat('#,##0.00', 'AR');
                                      dAmount = dFormatter.format(da);
                                      //////////////////////////
                                      /// Gross Amount
                                      //////////////////////////
                                      var na = getLpoServicesController
                                          .lpoServices
                                          .value
                                          .lpoServices?[index]
                                          .totalAmount;

                                      final nFormatter =
                                          NumberFormat('#,##0.00', 'AR');
                                      nAmount = nFormatter.format(na);
                                      //////////////////////////
                                      /// Total Amount sum
                                      //////////////////////////

                                      return Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            2.0.h, 1.0.h, 2.0.h, 0.0.h),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 1.0.h,
                                                  left: 1.0.h,
                                                  right: 1.0.h),
                                              child: SrNoWidget(
                                                  text: index + 1, size: 4.h),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 2.0.h),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    // Text(
                                                    //   getLpoServicesController
                                                    //       .lpoServices
                                                    //       .value
                                                    //       .lpoServices[index]
                                                    //       .serviceLpoName,
                                                    //   style: AppTextStyle.normalBlack10,
                                                    // ),
                                                    SizedBox(
                                                      height: 1.0.h,
                                                    ),

                                                    Container(
                                                      child: Text(
                                                        SessionController()
                                                                    .getLanguage() ==
                                                                1
                                                            ? getLpoServicesController
                                                                    .lpoServices
                                                                    .value
                                                                    .lpoServices![
                                                                        index]
                                                                    .description ??
                                                                '_'
                                                            : getLpoServicesController
                                                                    .lpoServices
                                                                    .value
                                                                    .lpoServices![
                                                                        index]
                                                                    .descriptionAr ??
                                                                '_',
                                                        style: AppTextStyle
                                                            .normalBlack10,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 1.0.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          AppMetaLabels()
                                                              .completionDate,
                                                          style: AppTextStyle
                                                              .normalBlack10,
                                                        ),
                                                        Text(
                                                          getLpoServicesController
                                                              .lpoServices
                                                              .value
                                                              .lpoServices![
                                                                  index]
                                                              .completionDate??"",
                                                          style: AppTextStyle
                                                              .normalBlack10,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 1.0.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          AppMetaLabels()
                                                              .grossAmount,
                                                          style: AppTextStyle
                                                              .normalBlack10,
                                                        ),
                                                        Text(
                                                          '${AppMetaLabels().aed} $gAmount',
                                                          style: AppTextStyle
                                                              .normalBlack10,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 1.0.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          AppMetaLabels()
                                                              .discountAmount,
                                                          style: AppTextStyle
                                                              .normalBlack10,
                                                        ),
                                                        Text(
                                                          '${AppMetaLabels().aed} $dAmount',
                                                          style: AppTextStyle
                                                              .normalBlack10,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 1.0.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          AppMetaLabels()
                                                              .discountPercentage,
                                                          style: AppTextStyle
                                                              .normalBlack10,
                                                        ),
                                                        Text(
                                                          '${discountPercentage.toString()}%',
                                                          style: AppTextStyle
                                                              .normalBlack10,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 1.0.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          AppMetaLabels()
                                                              .netAmount,
                                                          style: AppTextStyle
                                                              .semiBoldBlack10,
                                                        ),
                                                        Text(
                                                          '${AppMetaLabels().aed} $nAmount',
                                                          style: AppTextStyle
                                                              .semiBoldBlack10,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 1.0.h,
                                                    ),
                                                    index ==
                                                            getLpoServicesController
                                                                    .length -
                                                                1
                                                        ? Container()
                                                        : AppDivider(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                // SizedBox(
                                //   height: 8.0.h,
                                // ),
                                Container(
                                  height: 8.0.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(2.0.h),
                                      bottomRight: Radius.circular(2.0.h),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 0.5.h,
                                        spreadRadius: 0.1.h,
                                        offset: Offset(0.1.h, 0.1.h),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 2.0.h, right: 2.0.h),
                                    child: Row(
                                      children: [
                                        Text(
                                          AppMetaLabels().grandTotal,
                                          style: AppTextStyle.semiBoldBlack11,
                                        ),
                                        Spacer(),
                                        Text(
                                          "${AppMetaLabels().aed} " +
                                              getLpoServicesController
                                                  .totalAmount.value,
                                          style: AppTextStyle.semiBoldBlack11,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
        }),
      ],
    );
  }
}
