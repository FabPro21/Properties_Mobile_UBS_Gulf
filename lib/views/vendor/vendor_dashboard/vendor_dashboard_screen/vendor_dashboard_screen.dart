import 'package:badges/badges.dart' as badge;
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/vendor/vendor_services/vendor_request_list/vendor_request_list.dart';
import 'package:fap_properties/views/widgets/common_widgets/app_logo_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/vendor/vendor_dashboard/vendor_dashboard_screen/vendor_dashboard_controller.dart';
import 'package:fap_properties/views/vendor/vendor_dashboard/widgets/lpos_widget.dart';
import 'package:fap_properties/views/vendor/vendor_notifications/vendor_notifications.dart';
import 'package:fap_properties/views/vendor/vendor_profile/vendor_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../data/models/chart_data.dart';

class VendorDashboard extends StatefulWidget {
  final Function(int)? manageLpos;
  final BuildContext? parentContext;
  const VendorDashboard({Key? key, this.manageLpos, this.parentContext})
      : super(key: key);

  @override
  State<VendorDashboard> createState() => _VendorDashboardState();
}

class _VendorDashboardState extends State<VendorDashboard> {
  final VendorDashboardController controller = Get.find();
  String name = "";
  _getName() {
    String mystring = SessionController().getUserName() ?? "";

    var a = mystring.trim();

    if (a.isEmpty == false) {
      name = a[0];
    } else {
      name = '-';
    }
  }

  @override
  void initState() {
    _getName();
    getData();
    super.initState();
  }

  void getData() {
    controller.getData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 3.0.h),
      child: Obx(() {
        return Directionality(
          textDirection: SessionController().getLanguage() == 1
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.0.h),
                child: Row(
                  children: [
                    SizedBox(width: 45.0.w, child: AppLogoCollier()),
                    const Spacer(),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(72, 88, 106, 1),
                        shape: BoxShape.circle,
                      ),
                      child: TextButton(
                        onPressed: () {
                          Get.to(() => VendorProfile());
                          //showNotificationPopup();
                        },
                        child: Text(
                          name,
                          style: AppTextStyle.semiBoldWhite14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0.w, vertical: 0.0.h),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => VendorNotification());
                        },
                        child: badge.Badge(
                          showBadge: controller.getDataModel.value
                                          .unreadNotification ==
                                      null ||
                                  controller.getDataModel.value
                                          .unreadNotification ==
                                      0
                              ? false
                              : true,
                          badgeStyle: badge.BadgeStyle(
                            padding: EdgeInsets.all(0.8.h),
                          ),
                          position: badge.BadgePosition.topEnd(
                              top: -1.0.h, end: 0.0.h),
                          badgeAnimation: badge.BadgeAnimation.rotation(
                            animationDuration: Duration(seconds: 300),
                            colorChangeAnimationDuration: Duration(seconds: 1),
                            loopAnimation: false,
                            curve: Curves.fastOutSlowIn,
                            colorChangeAnimationCurve: Curves.easeInCubic,
                          ),
                          badgeContent: Text(
                            '${controller.getDataModel.value.unreadNotification}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Icon(
                            Icons.notifications_outlined,
                            color: Colors.white,
                            size: 5.0.h,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // mangae contract 's Container
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 0.0.w, vertical: 2.0.h),
                child: Container(
                  width: 94.0.w,
                  height: 29.0.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(1.0.h),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 0.4.h,
                        spreadRadius: 0.1.h,
                        offset: Offset(0.1.h, 1.0.h),
                      )
                    ],
                  ),
                  child: controller.loadingData.value
                      ? LoadingIndicatorBlue()
                      : controller.error.value != ''
                          ? AppErrorWidget(
                              errorText: AppMetaLabels().noDatafound,
                            )
                          : Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2.0.h, vertical: 1.0.h),
                                  child: Text(
                                    SessionController().getLanguage() == 1
                                        ? controller.company.value
                                        : controller.companyAr.value,
                                    style: AppTextStyle.semiBoldBlack13,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                AppDivider(),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 1.0.h, vertical: 0.0.h),
                                  child: InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: widget.parentContext!,
                                        builder: (BuildContext context) {
                                          return SingleChildScrollView(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(2.0.h),
                                                  topRight:
                                                      Radius.circular(2.0.h),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(2.0.h),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              AppMetaLabels()
                                                                  .invoiceSubmittedCapital,
                                                              style: AppTextStyle
                                                                  .normalBlack10,
                                                            ),
                                                            SizedBox(
                                                              height: 0.7.h,
                                                            ),
                                                            Text(
                                                              AppMetaLabels()
                                                                  .aed,
                                                              style: AppTextStyle
                                                                  .semiBoldBlack12,
                                                            ),
                                                          ],
                                                        ),
                                                        const Spacer(),
                                                        InkWell(
                                                          onTap: () {
                                                            // Navigator.pop(context);
                                                            Get.back();
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      118,
                                                                      118,
                                                                      128,
                                                                      0.12),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(0.5
                                                                          .h),
                                                              child: Icon(
                                                                  Icons.close,
                                                                  size: 2.0.h,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          158,
                                                                          158,
                                                                          158,
                                                                          1)),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 0.7.h,
                                                    ),
                                                    AppDivider(),
                                                    SizedBox(
                                                      height: 1.0.h,
                                                    ),
                                                    AppErrorWidget(
                                                      errorText: AppMetaLabels()
                                                          .noDatafound,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 22.0.w,
                                          height: 12.0.h,
                                          child: SfCircularChart(
                                              series: <CircularSeries>[
                                                DoughnutSeries<ChartData,
                                                    String>(
                                                  onPointTap: (value) {},
                                                  innerRadius: '85%',
                                                  radius: "100%",
                                                  explode: true,
                                                  dataSource:
                                                      controller.chartData,
                                                  pointColorMapper:
                                                      (ChartData data, _) =>
                                                          data.color,
                                                  xValueMapper:
                                                      (ChartData data, _) =>
                                                          data.x,
                                                  yValueMapper:
                                                      (ChartData data, _) =>
                                                          data.y,
                                                ),
                                              ]),
                                        ),
                                        Container(
                                          width: 66.0.w,
                                          height: 7.0.h,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 2.0.w,
                                                    height: 1.0.h,
                                                    decoration: BoxDecoration(
                                                      // color:
                                                      // AppColors.greenColor,
                                                      color: AppColors
                                                          .chartBlueColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        100,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 1.0.h,
                                                            vertical: 0.0.h),
                                                    child: Text(
                                                      AppMetaLabels()
                                                          .totalContractValues,
                                                      style: AppTextStyle
                                                          .semiBoldBlack9,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    "${AppMetaLabels().aed} ${controller.totalContractValues.value}",
                                                    style: AppTextStyle
                                                        .semiBoldBlack10,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 2.0.w,
                                                    height: 1.0.h,
                                                    decoration: BoxDecoration(
                                                      color: AppColors.amber
                                                          .withOpacity(0.65),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        100,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 1.0.h,
                                                            vertical: 0.0.h),
                                                    child: Text(
                                                      AppMetaLabels()
                                                          .activeLpos,
                                                      style: AppTextStyle
                                                          .semiBoldBlack8,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    controller
                                                            .getDataModel
                                                            .value
                                                            .dashboard
                                                            ?.lpoInProcess
                                                            .toString() ??
                                                        "",
                                                    style: AppTextStyle
                                                        .semiBoldBlack10,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 2.0.w,
                                                    height: 1.0.h,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppColors.greenColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        100,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 1.0.h,
                                                            vertical: 0.0.h),
                                                    child: Text(
                                                      AppMetaLabels()
                                                          .invoiceSubmitted,
                                                      style: AppTextStyle
                                                          .semiBoldBlack8,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    controller
                                                            .getDataModel
                                                            .value
                                                            .dashboard
                                                            ?.invoiceSubmitted
                                                            .toString() ??
                                                        "",
                                                    style: AppTextStyle
                                                        .semiBoldBlack10,
                                                  ),
                                                ],
                                              ),
                                              // Row(
                                              //   children: [
                                              //     Container(
                                              //       width: 2.0.w,
                                              //       height: 1.0.h,
                                              //       decoration: BoxDecoration(
                                              //         color: AppColors
                                              //             .chartBlueColor,
                                              //         borderRadius:
                                              //             BorderRadius.circular(
                                              //           100,
                                              //         ),
                                              //       ),
                                              //     ),
                                              //     Padding(
                                              //       padding:
                                              //           EdgeInsets.symmetric(
                                              //               horizontal: 1.0.h,
                                              //               vertical: 0.0.h),
                                              //       child: Text(
                                              //         AppMetaLabels()
                                              //             .openServiceRequests,
                                              //         style: AppTextStyle
                                              //             .semiBoldBlack8,
                                              //         overflow:
                                              //             TextOverflow.ellipsis,
                                              //       ),
                                              //     ),
                                              //     const Spacer(),
                                              //     Text(
                                              //       controller
                                              //           .getDataModel
                                              //           .value
                                              //           .dashboard
                                              //           .totalOpenServiceRequests
                                              //           .toString(),
                                              //       style: AppTextStyle
                                              //           .semiBoldBlack10,
                                              //     ),
                                              //   ],
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                AppDivider(),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    minimumSize: Size.zero,
                                    padding: EdgeInsets.all(2.0.h),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  onPressed: () {
                                    // widget.manageLpos(1);
                                    Get.to(() => VendorRequestList());
                                  },
                                  child: Text(
                                    AppMetaLabels()
                                            .openServiceRequests
                                            .toUpperCase() +
                                        '  (${controller.getDataModel.value.dashboard?.totalOpenServiceRequests.toString()})',
                                    // AppMetaLabels().managePayments,
                                    style: AppTextStyle.semiBoldBlue10,
                                  ),
                                ),
                              ],
                            ),
                ),
              ),
              ///////////////////////////////////////////
              ////   Your Contracts Widget
              ///////////////////////////////////////////
              //const YourContracts(),

              Expanded(
                child: SingleChildScrollView(
                  child: LposWidget(
                    manageLpos: widget.manageLpos,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
