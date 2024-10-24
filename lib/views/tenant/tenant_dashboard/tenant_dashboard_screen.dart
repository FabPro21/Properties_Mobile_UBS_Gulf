// ignore_for_file: implementation_imports, unnecessary_null_comparison, deprecated_member_use

import 'package:badges/badges.dart' as badge;
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/fonts.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/tenant/contract_flows/contract_flow.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_filter/filter_property/filter_property_controller.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_filter/tenant_contracts_filter_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/app_logo_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/common_widgets/status_widget.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_tabs.dart/tenant_contracts_details.dart/tenant_contract_details.dart';
import 'package:fap_properties/views/tenant/tenant_dashboard/tenant_dashboard_get_data_controller.dart';
import 'package:fap_properties/views/tenant/tenant_dashboard/your_contracts_widget.dart';
import 'package:fap_properties/views/tenant/tenant_notifications/tenant_notifications.dart';
import 'package:fap_properties/views/tenant/tenant_notifications/tenant_notifications_controller.dart';
import 'package:fap_properties/views/tenant/tenant_profile/tenant_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../data/models/chart_data.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/due_action_List_button.dart';
import '../../widgets/step_no_widget.dart';
import '../tenant_contracts/contract_extension/contract_extend.dart';
import '../tenant_contracts/contract_renewel/contract_renewel.dart';
import '../tenant_contracts/contract_termination/contract_terminate.dart';
import '../tenant_contracts/make_payment/outstanding_payments/outstanding_payments.dart';
import '../tenant_contracts/tenant_contracts_tabs.dart/tenant_contracts_details.dart/authenticate_contract/authenticate_contract.dart';
import '../tenant_contracts/tenant_contracts_tabs.dart/tenant_contracts_details.dart/municipal_approval/municipal_approval.dart';
import '../tenant_contracts/tenant_contracts_tabs.dart/tenant_contracts_details.dart/tenant_contract_download/tenant_contract_download_controller.dart';
import '../tenant_services_request/tenant_request_details/tenant_service_request_tab/tenant_service_request_tab.dart';
import 'dart:ui' as ui;

class TenantDashboard extends StatefulWidget {
  final BuildContext? parentContext;
  final Function(int)? managePayments;
  final Function(int)? manageContracts;
  const TenantDashboard(
      {Key? key, this.managePayments, this.manageContracts, this.parentContext})
      : super(key: key);

  @override
  State<TenantDashboard> createState() => _TenantDashboardState();
}

class _TenantDashboardState extends State<TenantDashboard>
    with TickerProviderStateMixin {
  final TenantDashboardGetDataController tDGDController = Get.find();
  final GetTenantNotificationsController getTNController = Get.find();
  final contractDownloadController = Get.put(ContractDownloadController());
  AnimationController? animateController;
  Animation<double>? animate;
  String status = "Unread";
  List<ChartData> chartData = [];

  void setData() {
    double val1 = tDGDController.rentalVal.value;
    double val2 = tDGDController.rentOutstanding.value;
    if (val1 == 0 && val2 == 0) {
      val1 = 1;
      val2 = 1;
    }
    // changing color
    chartData = [
      ChartData(
          AppMetaLabels().rentalVal, val1 - val2, AppColors.chartDarkBlueColor),
      ChartData(AppMetaLabels().rentOutstanding, val2,
          AppColors.amber.withOpacity(0.2)),
    ];
    // chartData = [
    //   ChartData(AppMetaLabels().rentalVal, val1, AppColors.chartDarkBlueColor),
    //   ChartData(AppMetaLabels().rentOutstanding, val2,
    //       AppColors.amber.withOpacity(0.2)),
    // ];
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    // int userID = SessionController().getUserID();
    // print('User ID ::::: $userID');
    animateController = new AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    this.animate = Tween(begin: 0.8, end: 1.0).animate(CurvedAnimation(
      parent: animateController!,
      curve: Curves.easeIn,
    ));
    animateController!.repeat(reverse: true);
    // tDGDController.getDashboardData();
    getDBData();
    Get.put(TenantContracrsFilterController());
    Get.put(FilterPropertyController());
    print("initState Called");
  }

  getDBData() async {
    await tDGDController.getDashboardData();
    setState(() {});
  }

  @override
  void dispose() {
    animateController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? ui.TextDirection.ltr
          : ui.TextDirection.rtl,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 1.0.h),
            child: Obx(() {
              setData();
              if (!tDGDController.notificationsDialogShown) {
                if (tDGDController.notificationdata.value.notifications !=
                        null &&
                    tDGDController
                            .notificationdata.value.notifications!.length >
                        0) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showNotificationPopup();
                  });
                }
              }
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.0.h),
                    child: Row(
                      children: [
                        AppLogoCollierDashboard(),
                        const Spacer(),
                        Container(
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(72, 88, 106, 1),
                            shape: BoxShape.circle,
                          ),
                          child: TextButton(
                            onPressed: () async {
                              await Get.to(() => TenantProfile());
                              tDGDController.getDashboardData();
                              // showNotificationPopup();
                            },
                            child: Text(
                              tDGDController.name.value,
                              style: AppTextStyle.semiBoldWhite14,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.0.w, vertical: 0.0.h),
                          child: InkWell(
                            onTap: () async {
                              await Get.to(() => TenantNotifications());
                              tDGDController.getDashboardData();
                            },
                            child: badge.Badge(
                              showBadge: tDGDController.dashboardData.value
                                              .unreadNotifications ==
                                          null ||
                                      tDGDController.dashboardData.value
                                              .unreadNotifications ==
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
                                colorChangeAnimationDuration:
                                    Duration(seconds: 1),
                                loopAnimation: false,
                                curve: Curves.fastOutSlowIn,
                                colorChangeAnimationCurve: Curves.easeInCubic,
                              ),
                              badgeContent: Text(
                                  '${tDGDController.lengthNotiification.value}',
                                  style: AppTextStyle.semiBoldWhite10),
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
                  tDGDController.loadingData.value == true
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.0.w, vertical: 1.0.h),
                          child: Container(
                            height: 33.0.h,
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
                            child: LoadingIndicatorBlue(),
                          ),
                        )
                      : tDGDController.error.value != ''
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0.0.w, vertical: 1.0.h),
                              child: Container(
                                height: 33.0.h,
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
                                child: AppErrorWidget(
                                  errorText: tDGDController.error.value,
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0.0.w, vertical: 1.0.h),
                              child: Container(
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
                                      padding: EdgeInsets.fromLTRB(
                                          4.w, 2.h, 4.w, 1.2.h),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          //Outstanding incl. Charges  NEXT 30 DAYS
                                          Row(
                                            children: [
                                              Text(
                                                AppMetaLabels()
                                                    .paymentBalance
                                                    .toUpperCase(),
                                                style:
                                                    AppTextStyle.normalBlack8,
                                              ),
                                              const Spacer(),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 13.0.w, left: 0.w),
                                                child: Text(
                                                  AppMetaLabels().next30days,
                                                  style:
                                                      AppTextStyle.normalBlack8,
                                                ),
                                              ),
                                            ],
                                          ),
                                          // Amount
                                          Padding(
                                            padding:
                                                EdgeInsets.only(top: 0.6.h),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 43.w,
                                                  child: Text(
                                                    AppMetaLabels().aed +
                                                        " ${tDGDController.paymentCurrency}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: AppTextStyle
                                                        .semiBoldBlack14,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        showContractsExpiringSheet();
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "${tDGDController.dashboardData.value.dashboard?.contractExpiringIn30Days.toString() ?? ""} ",
                                                            style: AppTextStyle
                                                                .semiBoldBlack12,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          Text(
                                                            AppMetaLabels()
                                                                .contractsExpiring,
                                                            style: AppTextStyle
                                                                .normalBlack10,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 0.6.h),
                                                      child: InkWell(
                                                        onTap: () {
                                                          // if (kDebugMode)
                                                          //   showNotificationPopup();
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "${tDGDController.dashboardData.value.dashboard?.checkDueIn30Days} ",
                                                              style: AppTextStyle
                                                                  .semiBoldBlack12,
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 0.1
                                                                          .h),
                                                              child: Text(
                                                                AppMetaLabels()
                                                                    .chequesDue,
                                                                style: AppTextStyle
                                                                    .normalBlack10,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    AppDivider(),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.0.h, vertical: 0.0.h),
                                      child: InkWell(
                                        onTap: () async {
                                          _showDuePaymentsSheet();
                                        },
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 24.0.w,
                                              height: 12.0.h,
                                              child: SfCircularChart(
                                                  series: <CircularSeries>[
                                                    DoughnutSeries<ChartData,
                                                        String>(
                                                      innerRadius: '85%',
                                                      radius: "100%",
                                                      explode: true,
                                                      dataSource: chartData,
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
                                              width: 62.0.w,
                                              // height: 10.0.h,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 0.7.h),
                                                    child: SizedBox(
                                                      width: 62.0.w,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 2.0.w,
                                                            height: 1.0.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColors
                                                                  .greenColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                100,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        1.0.h,
                                                                    vertical:
                                                                        0.0.h),
                                                            child: Text(
                                                              AppMetaLabels()
                                                                  .activeContracts,
                                                              style: AppTextStyle
                                                                  .normalBlack8,
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          SizedBox(
                                                            width: 31.0.w,
                                                            child: Text(
                                                              tDGDController
                                                                      .dashboardData
                                                                      .value
                                                                      .dashboard
                                                                      ?.activeContracts
                                                                      .toString() ??
                                                                  "",
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: AppTextStyle
                                                                  .semiBoldBlack10,
                                                              textAlign:
                                                                  TextAlign.end,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 0.7.h),
                                                    child: SizedBox(
                                                      width: 62.0.w,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 2.0.w,
                                                            height: 1.0.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColors
                                                                  .chartDarkBlueColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                100,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        1.0.h,
                                                                    vertical:
                                                                        0.0.h),
                                                            child: Text(
                                                              AppMetaLabels()
                                                                  .rentalVal,
                                                              style: AppTextStyle
                                                                  .normalBlack8,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          const Spacer(),
                                                          SizedBox(
                                                            width: 31.0.w,
                                                            child: FittedBox(
                                                              child: Text(
                                                                AppMetaLabels()
                                                                        .aed +
                                                                    " ${tDGDController.toBePaidCurrency}",
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: AppTextStyle
                                                                    .semiBoldBlack10,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 0.7.h),
                                                    child: SizedBox(
                                                      width: 62.0.w,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 2.w,
                                                            height: 1.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColors
                                                                  .amber
                                                                  .withOpacity(
                                                                      0.75),
                                                              // color: AppColors
                                                              //     .chartBlueColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                100,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        1.0.h,
                                                                    vertical:
                                                                        0.0.h),
                                                            child: FittedBox(
                                                              child: Text(
                                                                AppMetaLabels()
                                                                    .rentOutstanding,
                                                                style: AppTextStyle
                                                                    .normalBlack8,
                                                              ),
                                                            ),
                                                          ),
                                                          const Spacer(),
                                                          SizedBox(
                                                            width: 31.0.w,
                                                            child: FittedBox(
                                                              child: Text(
                                                                AppMetaLabels()
                                                                        .aed +
                                                                    " ${tDGDController.balanceCurrency}",
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: AppTextStyle
                                                                    .semiBoldBlack10,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                  // Due Action Contract for Renewable
                  Obx(() {
                    return tDGDController.loadingData.value == true
                        ? SizedBox()
                        : tDGDController.showRenewalButton.value
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.h, vertical: 1.h),
                                child: InkWell(
                                    onTap: () async {
                                      await Get.to(() => ContractsFLowTabs());
                                      // await Get.to(() => ContractsWithAction());
                                      tDGDController.getDashboardData();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          color: AppColors.blueColor,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          Icon(
                                            Icons.info,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          Expanded(
                                            child: SizedBox(
                                              height: 4.h,
                                              child: Marquee(
                                                  text: AppMetaLabels()
                                                      .dueActionsForContract,
                                                  style: AppTextStyle
                                                      .normalBlue12
                                                      .copyWith(
                                                          color: Colors.white)
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )))
                            : SizedBox();
                  }),
                  // Obx(() {
                  //   // Tooltip Conditions
                  //   // 1- If banner and notifiation popup both are not available the
                  //   //    tooltip will not show
                  //   // 2- If only banner is available means notification popup is not
                  //   //    available then tooltip will show
                  //   // 3- If both notification popup and banner will available then
                  //   //    tooltip will show once notification banner will close
                  //   return tDGDController.loadingData.value != true &&
                  //               tDGDController.showRenewalButton.value &&
                  //               tDGDController.showSimpleToolTip.value &&
                  //               (tDGDController.notificationdata.value
                  //                           .notifications !=
                  //                       null &&
                  //                   tDGDController.notificationdata.value
                  //                           .notifications.length >
                  //                       0 &&
                  //                   tDGDController.notificationsDialogShown) ||
                  //           (!tDGDController.notificationsDialogShown &&
                  //               tDGDController
                  //                       .notificationdata.value.notifications ==
                  //                   null)
                  //       // ? SimpleTooltip(
                  //       //     tooltipTap: () {},
                  //       //     // shadow
                  //       //     customShadows: [
                  //       //       BoxShadow(
                  //       //         color: Colors.black12,
                  //       //         blurRadius: 1.0.h,
                  //       //         spreadRadius: 0.6.h,
                  //       //         offset: Offset(0.0.h, 0.7.h),
                  //       //       ),
                  //       //     ],
                  //       //     // border color and redius
                  //       //     borderColor: AppColors.blueColor,
                  //       //     borderRadius: 8,
                  //       //     animationDuration: Duration(seconds: 0),
                  //       //     show: tDGDController.showSimpleToolTip.value,
                  //       //     tooltipDirection: TooltipDirection.down,
                  //       //     arrowTipDistance: 0.0012,
                  //       //     arrowBaseWidth: 5,
                  //       //     arrowLength: 5,
                  //       //     minimumOutSidePadding: 1.h,
                  //       //     ballonPadding: EdgeInsets.zero,
                  //       //     maxWidth: 60.w,
                  //       //     maxHeight: 10.h,
                  //       //     content: Container(
                  //       //       padding: EdgeInsets.all(1.w),
                  //       //       decoration: BoxDecoration(
                  //       //         color: Colors.white,
                  //       //         borderRadius: BorderRadius.circular(1.0.h),
                  //       //         boxShadow: [
                  //       //           BoxShadow(
                  //       //             color: Colors.black12,
                  //       //             blurRadius: 1.0.h,
                  //       //             spreadRadius: 0.6.h,
                  //       //             offset: Offset(0.0.h, 0.7.h),
                  //       //           ),
                  //       //         ],
                  //       //       ),
                  //       //       child: RichText(
                  //       //         textAlign: TextAlign.center,
                  //       //         text: TextSpan(
                  //       //           children: [
                  //       //             TextSpan(
                  //       //               text: AppMetaLabels().clickHeretooltip,
                  //       //               style: AppTextStyle.normalBlack9
                  //       //                   .copyWith(height: 1.2),
                  //       //             ),
                  //       //             TextSpan(
                  //       //                 text: AppMetaLabels().clickHere,
                  //       //                 style: AppTextStyle.semiBoldBlue9ul
                  //       //                     .copyWith(height: 1.2),
                  //       //                 recognizer: TapGestureRecognizer()
                  //       //                   ..onTap = () async {
                  //       //                     setState(() {
                  //       //                       tDGDController.showSimpleToolTip
                  //       //                           .value = false;
                  //       //                     });
                  //       //                     await Get.to(
                  //       //                         () => ContractsWithAction());
                  //       //                     tDGDController.getDashboardData();
                  //       //                     setState(() {});
                  //       //                   }),
                  //       //           ],
                  //       //         ),
                  //       //       ),
                  //       //     ),
                  //       //     child: SizedBox(),
                  //       //   )
                  //       : SizedBox();
                  // }),

                  Expanded(
                    child: Container(
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            // change column into stack
                            child: Column(
                              children: [
                                ///////////////////////////////////////////
                                ////   Your Contracts Widget
                                ///////////////////////////////////////////
                                YourContracts(
                                  manageContracts: widget.manageContracts,
                                ),
                                ///////////////////////////////////////////
                                ////   Service Request Widget
                                ///////////////////////////////////////////
                                // const ServicesRequestWidget(),
                                ///////////////////////////////////////////
                                ////   Payments Widget
                                ///////////////////////////////////////////
                                // Padding(
                                //   padding: EdgeInsets.only(
                                //       left: 1.8.h,
                                //       right: 1.8.h,
                                //       top: 3.0.h,
                                //       bottom: 2.h),
                                //   child: PaymentsWidget(
                                //     managePayments: widget.managePayments,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          // Remove the Pop up
                          // Align(
                          //   alignment: SessionController().getLanguage() == 1
                          //       ? Alignment.topRight
                          //       : Alignment.topLeft,
                          //   child: Obx(() {
                          //     // Tooltip Conditions
                          //     // 1- If banner and notifiation popup both are not available the
                          //     //    tooltip will not show
                          //     // 2- If only banner is available means notification popup is not
                          //     //    available then tooltip will show
                          //     // 3- If both notification popup and banner will available then
                          //     //    tooltip will show once notification banner will close
                          //     return tDGDController.loadingData.value != true &&
                          //             tDGDController.showRenewalButton.value
                          //         ? Stack(
                          //             children: [
                          //               Transform.translate(
                          //                 offset: Offset(0, -7),
                          //                 child: Container(
                          //                   width: 50.w,
                          //                   height: Get.height * 0.085,
                          //                   margin: EdgeInsets.only(
                          //                     right: SessionController()
                          //                                 .getLanguage() ==
                          //                             1
                          //                         ? 2.h
                          //                         : 0.h,
                          //                     left: SessionController()
                          //                                 .getLanguage() ==
                          //                             1
                          //                         ? 0.h
                          //                         : 2.h,
                          //                   ),
                          //                   decoration: ShapeDecoration(
                          //                     color: Colors.white,
                          //                     shape: MessageBorder(),
                          //                     shadows: [
                          //                       BoxShadow(
                          //                           color: Colors.black,
                          //                           blurRadius: 4.0,
                          //                           offset: Offset(2, 2)),
                          //                     ],
                          //                   ),
                          //                   alignment: Alignment.center,
                          //                   padding: EdgeInsets.only(
                          //                     left: 1.w,
                          //                     right: 1.w,
                          //                     // top: 1.w,
                          //                     // bottom: 1.w,
                          //                   ),
                          //                   child: RichText(
                          //                     textAlign: TextAlign.center,
                          //                     text: TextSpan(
                          //                       children: [
                          //                         TextSpan(
                          //                           text: AppMetaLabels()
                          //                               .clickaboveButton,
                          //                           style: AppTextStyle
                          //                               .normalBlack9
                          //                               .copyWith(height: 1.2),
                          //                         ),
                          //                         TextSpan(
                          //                           text: SessionController()
                          //                                       .getLanguage() ==
                          //                                   1
                          //                               ? AppMetaLabels().renwal
                          //                               : '',
                          //                           style: AppTextStyle
                          //                               .semiBoldBlack9
                          //                               .copyWith(height: 1.2),
                          //                         ),
                          //                         TextSpan(
                          //                           text: SessionController()
                          //                                       .getLanguage() ==
                          //                                   1
                          //                               ? AppMetaLabels()
                          //                                   .processOr
                          //                               : '',
                          //                           style: AppTextStyle
                          //                               .normalBlack9
                          //                               .copyWith(height: 1.2),
                          //                         ),
                          //                         TextSpan(
                          //                             text: SessionController()
                          //                                         .getLanguage() ==
                          //                                     1
                          //                                 ? AppMetaLabels()
                          //                                     .clickHere
                          //                                 : '',
                          //                             style: AppTextStyle
                          //                                 .semiBoldBlue9ul
                          //                                 .copyWith(
                          //                                     height: 1.2),
                          //                             recognizer:
                          //                                 TapGestureRecognizer()
                          //                                   ..onTap = () async {
                          //                                     // await Get.to(() =>
                          //                                     //     ContractsWithAction());
                          //                                     await Get.to(() =>
                          //                                         ContractsFLowTabs());
                          //                                     tDGDController
                          //                                         .getDashboardData();
                          //                                     setState(() {});
                          //                                   }),
                          //                       ],
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),

                          //               // Container(
                          //               //   padding: EdgeInsets.symmetric(
                          //               //       horizontal: 0.5.h,
                          //               //       vertical: 0.4.h),
                          //               //   width: 64.w,
                          //               //   decoration: BoxDecoration(
                          //               //     color: Colors.white70,
                          //               //     boxShadow: [
                          //               //       BoxShadow(
                          //               //         color: Colors.black12,
                          //               //         blurRadius: 1.0.h,
                          //               //         spreadRadius: 0.6.h,
                          //               //         offset: Offset(0.0.h, 0.7.h),
                          //               //       )
                          //               //     ],
                          //               //     borderRadius:
                          //               //         BorderRadius.circular(8),
                          //               //     border: Border.all(
                          //               //         color: AppColors.blueColor,
                          //               //         width: 2),
                          //               //   ),
                          //               //   child: Container(
                          //               //     decoration: BoxDecoration(
                          //               //       color: Colors.white,
                          //               //       borderRadius:
                          //               //           BorderRadius.circular(6),
                          //               //       boxShadow: [
                          //               //         BoxShadow(
                          //               //           color: Colors.black12,
                          //               //           blurRadius: 1.0.h,
                          //               //           spreadRadius: 0.6.h,
                          //               //           offset: Offset(0.0.h, 0.7.h),
                          //               //         ),
                          //               //       ],
                          //               //     ),
                          //               //     child: Padding(
                          //               //       padding:
                          //               //           const EdgeInsets.all(2.0),
                          //               //       child: RichText(
                          //               //         textAlign: TextAlign.center,
                          //               //         text: TextSpan(
                          //               //           children: [
                          //               //             TextSpan(
                          //               //               text: AppMetaLabels()
                          //               //                   .clickaboveButton,
                          //               //               style: AppTextStyle
                          //               //                   .normalBlack9
                          //               //                   .copyWith(
                          //               //                       height: 1.2),
                          //               //             ),
                          //               //             TextSpan(
                          //               //               text: AppMetaLabels()
                          //               //                   .renwalOrVacating,
                          //               //               style: AppTextStyle
                          //               //                   .semiBoldBlack9
                          //               //                   .copyWith(
                          //               //                       height: 1.2),
                          //               //             ),
                          //               //             TextSpan(
                          //               //               text: AppMetaLabels()
                          //               //                   .processOr,
                          //               //               style: AppTextStyle
                          //               //                   .normalBlack9
                          //               //                   .copyWith(
                          //               //                       height: 1.2),
                          //               //             ),
                          //               //             TextSpan(
                          //               //                 text: AppMetaLabels()
                          //               //                     .clickHere,
                          //               //                 style: AppTextStyle
                          //               //                     .semiBoldBlue9ul
                          //               //                     .copyWith(
                          //               //                         height: 1.2),
                          //               //                 recognizer:
                          //               //                     TapGestureRecognizer()
                          //               //                       ..onTap =
                          //               //                           () async {
                          //               //                         setState(() {
                          //               //                           tDGDController
                          //               //                               .showSimpleToolTip
                          //               //                               .value = false;
                          //               //                         });
                          //               //                         await Get.to(() =>
                          //               //                             ContractsWithAction());
                          //               //                         tDGDController
                          //               //                             .getDashboardData();
                          //               //                         setState(() {});
                          //               //                       }),
                          //               //           ],
                          //               //         ),
                          //               //       ),
                          //               //     ),
                          //               //   ),
                          //               // ),
                          //             ],
                          //           )
                          //         : SizedBox();
                          //   }),
                          // ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  void showContractsExpiringSheet() {
    tDGDController.getExpiringContracts();
    showModalBottomSheet(
        backgroundColor: Colors.white,
        isDismissible: false,
        enableDrag: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (BuildContext context) {
          return Directionality(
            textDirection: SessionController().getLanguage() == 1
                ? ui.TextDirection.ltr
                : ui.TextDirection.rtl,
            child: WillPopScope(
              onWillPop: () async => false,
              child: Padding(
                padding: EdgeInsets.all(2.0.h),
                child: Obx(() {
                  return tDGDController.loadingContractsExpiring.value
                      ? LoadingIndicatorBlue()
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppMetaLabels().expiringIn30days,
                                  style: AppTextStyle.normalBlack10,
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          Color.fromRGBO(118, 118, 128, 0.12),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(0.5.h),
                                      child: Icon(Icons.close,
                                          size: 2.0.h,
                                          color:
                                              Color.fromRGBO(158, 158, 158, 1)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 0.7.h,
                            ),
                            AppDivider(),
                            Expanded(
                              child:
                                  tDGDController
                                              .errorLoadingExpiringContracts !=
                                          ''
                                      ? AppErrorWidget(
                                          errorText: tDGDController
                                              .errorLoadingExpiringContracts,
                                        )
                                      : ListView.builder(
                                          itemCount: tDGDController
                                              .contractsExpiring!
                                              .record!
                                              .length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                              onTap: () async {
                                                Get.back();
                                                SessionController()
                                                    .setContractID(
                                                        tDGDController
                                                            .contractsExpiring!
                                                            .record![index]
                                                            .contractId);
                                                SessionController()
                                                    .setContractNo(
                                                        tDGDController
                                                            .contractsExpiring!
                                                            .record![index]
                                                            .contractNo);

                                                print(
                                                    'Heloo ::::]]]]]]]]\\\\\\');
                                                await Get.to(
                                                    () => ContractsDetailsTabs(
                                                          prevContractNo: null,
                                                        ));
                                                // tDGDController.getDashboardData();
                                              },
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 3.5.w,
                                                            vertical: 1.5.h),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          // height: 12.0.h,
                                                          width: 84.0.w,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Container(
                                                                    width:
                                                                        50.0.w,
                                                                    child: Text(
                                                                      SessionController().getLanguage() ==
                                                                              1
                                                                          ? tDGDController.contractsExpiring!.record![index].propertyName ??
                                                                              ""
                                                                          : tDGDController.contractsExpiring!.record![index].propertyNameAr ??
                                                                              "-",
                                                                      style: AppTextStyle
                                                                          .semiBoldBlack12,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                  Spacer(),
                                                                  Text(
                                                                    '${tDGDController.contractsExpiring!.record![index].contractNo}',
                                                                    style: AppTextStyle
                                                                        .semiBoldBlack12,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 1.0.h,
                                                              ),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    tDGDController
                                                                            .contractsExpiring!
                                                                            .record![index]
                                                                            .fromdate ??
                                                                        "",
                                                                    style: AppTextStyle
                                                                        .normalGrey10,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            1.w),
                                                                    child: Icon(
                                                                        Icons
                                                                            .arrow_forward,
                                                                        size: 10
                                                                            .sp,
                                                                        color: AppColors
                                                                            .greyColor),
                                                                  ),
                                                                  Text(
                                                                    tDGDController
                                                                            .contractsExpiring!
                                                                            .record![index]
                                                                            .todate ??
                                                                        "",
                                                                    style: AppTextStyle
                                                                        .normalGrey10,
                                                                  ),
                                                                  Spacer(),
                                                                  StatusWidget(
                                                                    text: SessionController().getLanguage() ==
                                                                            1
                                                                        ? tDGDController
                                                                            .contractsExpiring!
                                                                            .record![
                                                                                index]
                                                                            .status
                                                                        : tDGDController.contractsExpiring!.record![index].statusAr ??
                                                                            "-",
                                                                    valueToCompare: tDGDController
                                                                            .contractsExpiring!
                                                                            .record![index]
                                                                            .statusAr ??
                                                                        "-",
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  if (index <
                                                      tDGDController
                                                              .contractsExpiring!
                                                              .record!
                                                              .length -
                                                          1)
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 1.0.h,
                                                          right: 1.0.h),
                                                      child: AppDivider(),
                                                    ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                            ),
                          ],
                        );
                }),
              ),
            ),
          );
        },
        context: widget.parentContext!);
  }

  void _showDuePaymentsSheet() {
    tDGDController.getBottomSheetData();
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isDismissible: false,
      enableDrag: false,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: widget.parentContext!,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Directionality(
            textDirection: SessionController().getLanguage() == 1
                ? ui.TextDirection.ltr
                : ui.TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.all(2.0.h),
              child: Obx(() {
                return tDGDController.loadingBottomSheetData.value
                    ? LoadingIndicatorBlue()
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppMetaLabels().toBePaidCapital,
                                    style: AppTextStyle.normalBlack10,
                                  ),
                                  SizedBox(
                                    height: 0.7.h,
                                  ),
                                  Text(
                                    "${AppMetaLabels().aed} ${tDGDController.bottomSheetData.value.totalAmount ?? 0.00}",
                                    style: AppTextStyle.semiBoldBlack12,
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
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(118, 118, 128, 0.12),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(0.5.h),
                                    child: Icon(Icons.close,
                                        size: 2.0.h,
                                        color:
                                            Color.fromRGBO(158, 158, 158, 1)),
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
                          Expanded(
                            child: tDGDController.errorSheet.value != ''
                                ? AppErrorWidget(
                                    errorText: tDGDController.errorSheet.value,
                                  )
                                : ListView.builder(
                                    itemCount:
                                        tDGDController.toBePaidIn30DaysLength,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          bottomSheetListItem(
                                              AppMetaLabels().contractNo,
                                              '${tDGDController.bottomSheetData.value.data![index].contractId}'),
                                          SizedBox(
                                            height: 0.5.h,
                                          ),
                                          bottomSheetListItem(
                                              AppMetaLabels().chequeNo,
                                              '${tDGDController.bottomSheetData.value.data![index].transactionNo}'),
                                          SizedBox(
                                            height: 0.5.h,
                                          ),
                                          bottomSheetListItem(
                                              AppMetaLabels().chequeDate,
                                              '${tDGDController.bottomSheetData.value.data![index].transactionDate}'),
                                          SizedBox(
                                            height: 0.5.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                AppMetaLabels().amount,
                                                style:
                                                    AppTextStyle.semiBoldGrey12,
                                              ),
                                              Spacer(),
                                              Text(
                                                  '${AppMetaLabels().aed} ${tDGDController.bottomSheetData.value.data![index].amount}',
                                                  style: AppTextStyle
                                                      .semiBoldGrey12)
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 1.h),
                                            child: AppDivider(),
                                          )
                                        ],
                                      );
                                    }),
                          ),
                        ],
                      );
              }),
            ),
          ),
        );
      },
    );
  }

  Row bottomSheetListItem(String text1, String text2) {
    return Row(
      children: [
        Text(
          text1,
          style: AppTextStyle.normalGrey12,
        ),
        Spacer(),
        Text(text2, style: AppTextStyle.normalGrey12)
      ],
    );
  }

  void showNotificationPopup() async {
    // 123*
    tDGDController.notificationsDialogShown = true;
    if (tDGDController.notificationdata.value.notifications != null &&
        tDGDController.notificationdata.value.notifications!.isNotEmpty) {
      SessionController().setNotificationId(tDGDController
          .notificationdata.value.notifications![0].notificationId
          .toString());
      getTNController.readNotifications(0, '');
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () async => false,
              child: Container(
                width: 100.w,
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0.h),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(2.h),
                      child: Obx(() {
                        return Swiper(
                            itemCount: tDGDController
                                .notificationdata.value.notifications!.length,
                            layout: SwiperLayout.DEFAULT,
                            viewportFraction: 0.99,
                            scale: 0.9,
                            curve: Curves.easeInCubic,
                            loop: false,
                            pagination: SwiperPagination(
                                alignment:
                                    SessionController().getLanguage() != 1
                                        ? Alignment.topRight
                                        : Alignment.topLeft,
                                builder: SwiperPagination.fraction),
                            // pagination: SwiperPagination.fraction,
                            control: SwiperControl(
                              padding: EdgeInsets.only(left: 0.h, right: 0.h),
                            ),
                            onIndexChanged: (index) {
                              SessionController().setNotificationId(
                                  tDGDController.notificationdata.value
                                      .notifications![index].notificationId
                                      .toString());
                              getTNController.readNotifications(index, '');
                            },
                            itemBuilder: (BuildContext context, int index) {
                              // 112233 popUp dashboard
                              return Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                      onTap: () {},
                                      child: Column(
                                          mainAxisAlignment: SessionController()
                                                      .getLanguage() ==
                                                  1
                                              ? MainAxisAlignment.start
                                              : MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Align(
                                              alignment: SessionController()
                                                          .getLanguage() ==
                                                      1
                                                  ? Alignment.topRight
                                                  : Alignment.topLeft,
                                              child: Padding(
                                                padding: EdgeInsets.all(2.5.h),
                                                child: InkWell(
                                                  onTap: () {
                                                    Get.back();
                                                    Get.back();
                                                    tDGDController
                                                            .notificationsDialogShown =
                                                        true;
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Color.fromRGBO(
                                                          118, 118, 128, 0.12),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(0.5.h),
                                                      child: Icon(Icons.close,
                                                          size: 2.5.h,
                                                          color: Color.fromRGBO(
                                                              158,
                                                              158,
                                                              158,
                                                              1)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 4.h,
                                            ),
                                            // removing Icons.refresh_rounded because there
                                            // is no functionality on this
                                            // Center(
                                            //   child: Container(
                                            //     decoration: BoxDecoration(
                                            //       shape: BoxShape.circle,
                                            //       color: Colors.green[50],
                                            //     ),
                                            //     child: Padding(
                                            //       padding: EdgeInsets.all(1.h),
                                            //       child: Icon(
                                            //           Icons.refresh_rounded,
                                            //           size: 4.5.h,
                                            //           color: Colors.green[500]),
                                            //     ),
                                            //   ),
                                            // ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 2.5.h),
                                              child: Text(
                                                SessionController()
                                                            .getLanguage() ==
                                                        1
                                                    ? tDGDController
                                                            .notificationdata
                                                            .value
                                                            .notifications![
                                                                index]
                                                            .title ??
                                                        ""
                                                    : tDGDController
                                                            .notificationdata
                                                            .value
                                                            .notifications![
                                                                index]
                                                            .titleAr ??
                                                        // .titleAR ??
                                                        "",
                                                style: AppTextStyle
                                                    .semiBoldBlack13
                                                    .copyWith(
                                                        color: AppColors
                                                            .renewelgreyclr1),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3.h,
                                            ),
                                            Expanded(
                                              child: SingleChildScrollView(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 4.5.w,
                                                      right: 4.5.w,
                                                      top: 0.0.h),
                                                  child: Html(
                                                    style: {
                                                      'html': Style(
                                                        textAlign:
                                                            SessionController()
                                                                        .getLanguage() ==
                                                                    1
                                                                ? TextAlign.left
                                                                : TextAlign
                                                                    .right,
                                                        color: Colors.black,
                                                        fontFamily: AppFonts
                                                            .graphikRegular,
                                                        fontSize:
                                                            FontSize(10.0),
                                                      ),
                                                    },
                                                    data: SessionController()
                                                                .getLanguage() ==
                                                            1
                                                        ? tDGDController
                                                                .notificationdata
                                                                .value
                                                                .notifications![
                                                                    index]
                                                                .description ??
                                                            ""
                                                        : tDGDController
                                                                .notificationdata
                                                                .value
                                                                .notifications![
                                                                    index]
                                                                .descriptionAr ??
                                                            "-",
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // showActions(index)
                                          ])));
                            });
                      }),
                    )),
              ),
            );
          });
    }
  }

  Widget showActions(int index) {
    int stageId =
        tDGDController.notificationdata.value.notifications![index].stageId!;
    switch (stageId) {
      case 1:
        return expiringContractActions(index);

      default:
        return renewalActions(index);
    }
  }

  Widget expiringContractActions(int index) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      if (tDGDController
          .notificationdata.value.notifications![index].showExtend!)
        Expanded(
          child: Padding(
              padding: EdgeInsets.all(0.5.h),
              child: CustomButton(
                text: AppMetaLabels().extend,
                onPressed: () {
                  Get.off(() => ContractExtend(
                        contractNo: tDGDController.notificationdata.value
                            .notifications![index].contractno,
                        contractId: tDGDController.notificationdata.value
                            .notifications![index].recordId,
                        dueActionId: tDGDController.notificationdata.value
                            .notifications![index].dueActionid,
                      ));
                },
              )),
        ),
      Expanded(
        child: Padding(
          padding: EdgeInsets.all(0.5.h),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0.sp),
                      side: BorderSide(
                        color: AppColors.blueColor,
                        width: 1.0,
                      )),
                  backgroundColor: AppColors.whiteColor,
                  shadowColor: Colors.transparent),
              onPressed: () {
                Get.to(() => ContractRenewel(
                      contractNo: tDGDController.notificationdata.value
                          .notifications![index].contractno,
                      contractId: tDGDController.notificationdata.value
                          .notifications![index].recordId,
                    ));
              },
              child: Text(AppMetaLabels().renew,
                  style: AppTextStyle.normalBlue11)),
        ),
      ),
      Expanded(
        child: Padding(
            padding: EdgeInsets.all(0.5.h),
            child: CustomButton(
              text: AppMetaLabels().terminate,
              onPressed: () {
                Get.to(() => ContractTerminate(
                      contractNo: tDGDController.notificationdata.value
                          .notifications![index].contractno,
                      contractId: tDGDController.notificationdata.value
                          .notifications![index].recordId,
                    ));
              },
            )),
      ),
    ]);
  }

  Widget renewalActions(int index) {
    if (tDGDController.notificationdata.value.notifications![index].stageId ==
            null ||
        tDGDController.notificationdata.value.notifications![index].stageId! <
            2 ||
        tDGDController.notificationdata.value.notifications![index].stageId! >
            9) return SizedBox();
    final ItemScrollController itemScrollController = ItemScrollController();
    int dueActionIndex = 0;
    switch (
        tDGDController.notificationdata.value.notifications![index].stageId) {
      case 2:
        dueActionIndex = 0;
        break;
      case 3:
        dueActionIndex = 1;
        break;
      case 4:
        dueActionIndex = 2;
        break;
      case 5:
        dueActionIndex = 3;
        break;
      case 6:
        dueActionIndex = 4;
        break;
      case 7:
        dueActionIndex = 5;
        break;
      case 8:
        dueActionIndex = 6;
        break;
      case 9:
        dueActionIndex = 7;
        break;
    }

    final actionList = [
      Padding(
          padding: EdgeInsets.all(0.5.h),
          child: tDGDController
                      .notificationdata.value.notifications![index].stageId ==
                  2
              ? DueActionListButton(
                  text: AppMetaLabels().uploadDocs,
                  srNo: '1',
                  onPressed: () {
                    SessionController().setCaseNo(
                      tDGDController
                          .notificationdata.value.notifications![index].caseId
                          .toString(),
                    );
                    Get.to(() => TenantServiceRequestTabs(
                          requestNo: tDGDController.notificationdata.value
                              .notifications![index].caseId
                              .toString(),
                          caller: 'contracts_with_actions',
                          title: AppMetaLabels().renewalReq,
                          initialIndex: 1,
                        ));
                  })
              : StepNoWidget(label: '1', tooltip: AppMetaLabels().uploadDocs)),
      Padding(
          padding: EdgeInsets.all(0.5.h),
          child: tDGDController
                      .notificationdata.value.notifications![index].stageId ==
                  3
              ? DueActionListButton(
                  text: AppMetaLabels().docsSubmitted,
                  srNo: '2',
                  onPressed: () {
                    SessionController().setCaseNo(
                      tDGDController
                          .notificationdata.value.notifications![index].caseId
                          .toString(),
                    );
                    Get.to(() => TenantServiceRequestTabs(
                          requestNo: tDGDController.notificationdata.value
                              .notifications![index].caseId
                              .toString(),
                          caller: 'contracts_with_actions',
                          title: AppMetaLabels().renewalReq,
                          initialIndex: 1,
                        ));
                  })
              : StepNoWidget(
                  label: '2', tooltip: AppMetaLabels().docsSubmitted)),
      Padding(
          padding: EdgeInsets.all(0.5.h),
          child: tDGDController
                      .notificationdata.value.notifications![index].stageId ==
                  4
              ? DueActionListButton(
                  text: AppMetaLabels().docsApproved,
                  srNo: '3',
                  onPressed: () {
                    SessionController().setCaseNo(
                      tDGDController
                          .notificationdata.value.notifications![index].caseId
                          .toString(),
                    );
                    Get.to(() => TenantServiceRequestTabs(
                          requestNo: tDGDController.notificationdata.value
                              .notifications![index].caseId
                              .toString(),
                          caller: 'contracts_with_actions',
                          title: AppMetaLabels().renewalReq,
                          initialIndex: 1,
                        ));
                  })
              : StepNoWidget(
                  label: '3', tooltip: AppMetaLabels().docsApproved)),
      Padding(
          padding: EdgeInsets.all(0.5.h),
          child: tDGDController
                      .notificationdata.value.notifications![index].stageId ==
                  5
              ? DueActionListButton(
                  text: AppMetaLabels().makePayment,
                  srNo: '4',
                  onPressed: () {
                    SessionController().setContractID(tDGDController
                        .notificationdata.value.notifications![index].recordId);
                    SessionController().setContractNo(tDGDController
                        .notificationdata
                        .value
                        .notifications![index]
                        .contractno);
                    Get.to(() => OutstandingPayments(
                          contractNo: tDGDController.notificationdata.value
                              .notifications![index].contractno,
                          contractId: tDGDController.notificationdata.value
                              .notifications![index].recordId,
                        ));
                  })
              : StepNoWidget(label: '4', tooltip: AppMetaLabels().makePayment)),
      Padding(
          padding: EdgeInsets.all(0.5.h),
          child: tDGDController
                      .notificationdata.value.notifications![index].stageId ==
                  6
              ? Obx(() {
                  return DueActionListButton(
                      text: AppMetaLabels().signContract2,
                      srNo: '5',
                      loading: contractDownloadController.downloading.value,
                      onPressed: () async {
                        SessionController().setContractID(tDGDController
                            .notificationdata
                            .value
                            .notifications![index]
                            .recordId);
                        SessionController().setContractNo(tDGDController
                            .notificationdata
                            .value
                            .notifications![index]
                            .contractno);
                        String path =
                            await contractDownloadController.downloadContract(
                                tDGDController.notificationdata.value
                                        .notifications![index].contractno ??
                                    '',
                                false);
                        if (path != null)
                          Get.to(() => AuthenticateContract(
                              contractNo: tDGDController.notificationdata.value
                                  .notifications![index].contractno,
                              contractId: tDGDController.notificationdata.value
                                  .notifications![index].recordId,
                              filePath: path,
                              dueActionId: tDGDController.notificationdata.value
                                  .notifications![index].dueActionid,
                              stageId: tDGDController.notificationdata.value
                                  .notifications![index].stageId,
                              caller: 'contracts_with_actions',
                              caseId: tDGDController.notificationdata.value
                                  .notifications![index].caseId));
                      });
                })
              : StepNoWidget(
                  label: '5', tooltip: AppMetaLabels().signContract2)),
      Padding(
          padding: EdgeInsets.all(0.5.h),
          child: tDGDController
                      .notificationdata.value.notifications![index].stageId ==
                  7
              ? DueActionListButton(
                  text: AppMetaLabels().contractSigned,
                  srNo: '6',
                  onPressed: () {})
              : StepNoWidget(
                  label: '6', tooltip: AppMetaLabels().contractSigned)),
      Padding(
          padding: EdgeInsets.all(0.5.h),
          child: tDGDController
                      .notificationdata.value.notifications![index].stageId ==
                  8
              ? DueActionListButton(
                  text: AppMetaLabels().approveMunicipal,
                  srNo: '7',
                  onPressed: () {
                    Get.to(() => MunicipalApproval(
                          caller: 'contracts_with_actions',
                          dueActionId: tDGDController.notificationdata.value
                              .notifications![index].dueActionid,
                          contractId: tDGDController.notificationdata.value
                              .notifications![index].recordId,
                        ));
                  })
              : StepNoWidget(
                  label: '7', tooltip: AppMetaLabels().approveMunicipal)),
      Padding(
          padding: EdgeInsets.all(0.5.h),
          child: tDGDController
                      .notificationdata.value.notifications![index].stageId ==
                  9
              ? DueActionListButton(
                  text: AppMetaLabels().downloadContract,
                  srNo: '8',
                  onPressed: () {
                    SessionController().setContractID(tDGDController
                        .notificationdata.value.notifications![index].recordId);
                    Get.to(() => ContractsDetailsTabs());
                  })
              : StepNoWidget(
                  label: '8', tooltip: AppMetaLabels().downloadContract)),
    ];
    return SizedBox(
      width: 80.w,
      height: 8.h,
      child: ScrollablePositionedList.builder(
        itemScrollController: itemScrollController,
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        itemBuilder: (context, index2) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            if (itemScrollController.isAttached)
              itemScrollController.scrollTo(
                  index: dueActionIndex,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn);
          });
          return actionList[index2];
        },
      ),
    );
  }
}
