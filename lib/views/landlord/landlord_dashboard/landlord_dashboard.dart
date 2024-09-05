import 'package:badges/badges.dart' as badge;
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/chart_data.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/landlord/landlord_dashboard/widgets/properties/landlord_properties_widget.dart';
import 'package:fap_properties/views/landlord/landlord_dashboard/widgets/properties/properties_widget_controller.dart';
import 'package:fap_properties/views/landlord/landlord_more/landlord_profile/landlord_profile.dart';
import 'package:fap_properties/views/landlord/landlord_notifications/landlord_notifications.dart';
import 'package:fap_properties/views/widgets/common_widgets/app_logo_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:ui' as ui;

class LandlordDashboard extends StatefulWidget {
  final BuildContext? parentContext;
  final Function(int)? manageProperties;
  final Function(int)? manageContracts;
  const LandlordDashboard(
      {Key? key,
      this.manageProperties,
      this.manageContracts,
      this.parentContext})
      : super(key: key);

  @override
  State<LandlordDashboard> createState() => _LandlordDashboardState();
}

class _LandlordDashboardState extends State<LandlordDashboard> {
  final landLordPropertiesController = Get.put(LandlordPropsWidgetController());
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDBData();
    });

    super.initState();
  }

  getDBData() async {
    await landLordPropertiesController.getDashboardData();
    if (landLordPropertiesController.dashboardData.value.dashboard != null) {
      landLordPropertiesController.setData();
    }
  }

  @override
  Widget build(BuildContext context) {
    _getName();
    if (landLordPropertiesController.dashboardData.value.dashboard != null) {
      landLordPropertiesController.setData();
    }
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? ui.TextDirection.ltr
          : ui.TextDirection.rtl,
      child: Stack(
        children: [
          Obx((() => Padding(
                padding: EdgeInsets.only(top: 1.0.h),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0.h),
                      child: Row(
                        children: [
                          SizedBox(width: 45.0.w, child: AppLogo()),
                          const Spacer(),
                          Container(
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(72, 88, 106, 1),
                              shape: BoxShape.circle,
                            ),
                            child: TextButton(
                              onPressed: () async {
                                await Get.to(() => LandLordProfile());
                                landLordPropertiesController.getDashboardData();
                              },
                              child: Text(
                                landLordPropertiesController.name.value,
                                style: AppTextStyle.semiBoldWhite14,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.0.w, vertical: 0.0.h),
                            child: InkWell(
                              onTap: () async {
                                await Get.to(() => LandlordNotifications());
                                landLordPropertiesController.getProperties();
                              },
                              child: badge.Badge(
                                position: badge.BadgePosition.topEnd(
                                    top: -1.0.h, end: 0.0.h),
                                showBadge: landLordPropertiesController
                                                .dashboardData
                                                .value
                                                .unreadNotifications ==
                                            null ||
                                        landLordPropertiesController
                                                .dashboardData
                                                .value
                                                .unreadNotifications ==
                                            '0'
                                    ? false
                                    : true,
                                badgeStyle: badge.BadgeStyle(
                                  padding: EdgeInsets.all(0.8.h),
                                ),
                                badgeAnimation: badge.BadgeAnimation.rotation(
                                  animationDuration: Duration(seconds: 300),
                                  colorChangeAnimationDuration:
                                      Duration(seconds: 1),
                                  loopAnimation: false,
                                  curve: Curves.fastOutSlowIn,
                                  colorChangeAnimationCurve: Curves.easeInCubic,
                                ),
                                badgeContent: Text(
                                  '${landLordPropertiesController.lengthNotiification.value}',
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
                    landLordPropertiesController.loadingData.value == true &&
                            landLordPropertiesController
                                    .dashboardData.value.dashboard ==
                                null
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
                        : landLordPropertiesController.error.value != ''
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
                                    errorText: landLordPropertiesController
                                        .error.value,
                                  ),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0.0.w, vertical: 0.5.h),
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
                                        padding: EdgeInsets.only(
                                            top: 2.h, left: 2.h, right: 2.h),
                                        child: Text(
                                          landLordPropertiesController
                                                      .dashboardData
                                                      .value
                                                      .dashboard ==
                                                  null
                                              ? ''
                                              : SessionController()
                                                          .getLanguage() ==
                                                      1
                                                  ? landLordPropertiesController
                                                          .dashboardData
                                                          .value
                                                          .dashboard?.first
                                                          .landlordName ??
                                                      ""
                                                  : landLordPropertiesController
                                                          .dashboardData
                                                          .value
                                                          .dashboard?.first
                                                          .landlordNameAR ??
                                                      "_",
                                          style: AppTextStyle.semiBoldBlack13,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                        ),
                                      ),

                                      // No of units and Legal Cases
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            4.w, 0.h, 4.w, 1.h),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 1.2.h, left: 4.w),
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    AppMetaLabels()
                                                        .noofUnits
                                                        .toUpperCase(),
                                                    style: AppTextStyle
                                                        .normalBlack8,
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.005,
                                                  ),
                                                  Text(
                                                      landLordPropertiesController
                                                          .totalUnits.value,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: AppTextStyle
                                                          .semiBoldBlack14),
                                                ],
                                              ),
                                              const Spacer(),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 8.0.w,
                                                        left: 0.w),
                                                    child: Text(
                                                      AppMetaLabels()
                                                          .legalCases,
                                                      style: AppTextStyle
                                                          .normalBlack8,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.005,
                                                  ),
                                                  InkWell(
                                                    onTap: () {},
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width:
                                                              Get.width * 0.08,
                                                          child: Text(
                                                            landLordPropertiesController
                                                                        .openCases
                                                                        .value ==
                                                                    ''
                                                                ? ''
                                                                : "${landLordPropertiesController.openCases.value.toString()} ",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 10.0.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          AppMetaLabels()
                                                              .openCases,
                                                          style: AppTextStyle
                                                              .normalBlack10,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 0.3.h),
                                                    child: InkWell(
                                                      onTap: () {},
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: Get.width *
                                                                0.08,
                                                            child: Text(
                                                              landLordPropertiesController
                                                                          .closeCases
                                                                          .value ==
                                                                      ''
                                                                  ? ''
                                                                  : "${landLordPropertiesController.closeCases.value.toString()}",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    10.0.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 0.1.h),
                                                            child: Text(
                                                              AppMetaLabels()
                                                                  .closeCases,
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
                                      ),
                                      AppDivider(),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 1.0.h,
                                        ),
                                        child: InkWell(
                                          onTap: () async {},
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 28.0.w,
                                                height: 12.0.h,
                                                child: SfCircularChart(
                                                    series: <CircularSeries>[
                                                      DoughnutSeries<ChartData,
                                                          String>(
                                                        innerRadius: '85%',
                                                        radius: "100%",
                                                        explode: true,
                                                        dataSource:
                                                            landLordPropertiesController
                                                                .chartData,
                                                        pointColorMapper:
                                                            (ChartData data,
                                                                    _) =>
                                                                data.color,
                                                        xValueMapper:
                                                            (ChartData data,
                                                                    _) =>
                                                                data.x,
                                                        yValueMapper:
                                                            (ChartData data,
                                                                    _) =>
                                                                data.y,
                                                      ),
                                                    ]),
                                              ),
                                              SizedBox(
                                                width: 59.0.w,
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
                                                            Text(
                                                                " ${landLordPropertiesController.activeContract.value.toInt()}",
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: AppTextStyle
                                                                    .semiBoldBlack10),
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
                                                                    .occupiedUnits,
                                                                style: AppTextStyle
                                                                    .normalBlack8,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                            const Spacer(),
                                                            FittedBox(
                                                              child: Text(
                                                                " ${landLordPropertiesController.occupiedUnits.value.toInt()}",
                                                                style: AppTextStyle
                                                                    .semiBoldBlack10,
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
                                                                    .amber
                                                                    .withOpacity(
                                                                        0.75),
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
                                                                      .vacantUnits,
                                                                  style: AppTextStyle
                                                                      .normalBlack8,
                                                                ),
                                                              ),
                                                            ),
                                                            const Spacer(),
                                                            FittedBox(
                                                              child: Container(
                                                                child: Text(
                                                                  "${landLordPropertiesController.vacantUnit.value.toInt()}",
                                                                  style: AppTextStyle
                                                                      .semiBoldBlack10,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
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
                                      AppDivider(),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 2.0.h, bottom: 2.0.h),
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              minimumSize: Size.zero,
                                              padding: EdgeInsets.zero,
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                            onPressed: () {
                                              widget.manageProperties!(2);
                                              setState(() {});
                                            },
                                            child: Text(
                                              AppMetaLabels().manageContracts,
                                              style: AppTextStyle.semiBoldBlue9,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            PropertiesWidget(
                              manageProperties: widget.manageProperties!,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ))),
        ],
      ),
    );
  }
}
