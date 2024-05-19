import 'dart:io';

import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/fonts.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/backbround_concave.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts.dart';
import 'package:fap_properties/views/tenant/tenant_dashboard/tenant_dashboard_screen.dart';
import 'package:fap_properties/views/tenant/tenant_dashboard/tenant_dashboard_tabs/tenant_dashboard_tabs_controller.dart';
import 'package:fap_properties/views/tenant/tenant_more/tenant_more.dart';
import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request/tenant_request_list/tenant_request_list.dart';
import 'package:fap_properties/views/widgets/custom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../data/helpers/session_controller.dart';
import '../../tenant_payments/tenant_payments_screen.dart';

class TenantDashboardTabs extends StatefulWidget {
  final int initialIndex;
  const TenantDashboardTabs({
    Key key,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  _TenantDashboardTabsState createState() => _TenantDashboardTabsState();
}

class _TenantDashboardTabsState extends State<TenantDashboardTabs> {
  // ignore: unused_field
  TenantDashboardTabsController _dashboardTabsController =
      Get.put(TenantDashboardTabsController());

  int _selectedIndex;
  GlobalKey _toolTipKey = GlobalKey();

  @override
  void initState() {
    _selectedIndex = widget.initialIndex;
    super.initState();
  }

  List<Widget> _buildScreens;

  @override
  Widget build(BuildContext context) {
    _buildScreens = [
      TenantDashboard(
        parentContext: context,
        managePayments: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        manageContracts: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      TenantContractsScreen(),
      TenantRequestList(),
      TenantPaymentsScreen(),
    ];

    return WillPopScope(
        onWillPop: () {
          settingModalBottomSheet(context);
          return;
        },
        child: Directionality(
          textDirection: SessionController().getLanguage() == 1
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                AppBackgroundConcave(),
                SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: _buildScreens[_selectedIndex],
                      ),
                      CustomNavBar(
                        items: [
                          NavBarItem(
                            icon: _selectedIndex == 0
                                ? AppImagesPath.home2
                                : AppImagesPath.home,
                            title: AppMetaLabels().dashboard,
                            onTap: (pos) {
                              setState(() {
                                _selectedIndex = pos;
                              });
                            },
                            position: 0,
                          ),
                          NavBarItem(
                            icon: _selectedIndex == 1
                                ? AppImagesPath.contracts2
                                : AppImagesPath.contracts,
                            title: AppMetaLabels().contracts,
                            onTap: (pos) {
                              setState(() {
                                _selectedIndex = pos;
                              });
                            },
                            position: 1,
                          ),
                          Tooltip(
                            key: _toolTipKey,
                            message: AppMetaLabels().serviceRequests,
                            showDuration: Duration(seconds: 3),
                            verticalOffset: 4.h,
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                                color: AppColors.chartBlueColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: NavBarItem(
                              icon: _selectedIndex == 2
                                  ? AppImagesPath.services2
                                  : AppImagesPath.services,
                              title: AppMetaLabels().services,
                              onTap: (pos) {
                                final dynamic _toolTip =
                                    _toolTipKey.currentState;
                                _toolTip.ensureTooltipVisible();
                                setState(() {
                                  _selectedIndex = pos;
                                });
                              },
                              position: 2,
                            ),
                          ),
                          NavBarItem(
                            icon: _selectedIndex == 3
                                ? AppImagesPath.payments2
                                : AppImagesPath.payments,
                            title: AppMetaLabels().payments,
                            onTap: (pos) {
                              setState(() {
                                _selectedIndex = pos;
                              });
                            },
                            position: 3,
                          ),
                          NavBarItem(
                            icon: AppImagesPath.menu,
                            title: AppMetaLabels().more,
                            onTap: (pos) async {
                              int _res = await Get.to(() => TenantMoreScreen());
                              if (_res != null)
                                setState(() {
                                  _selectedIndex = _res;
                                });
                            },
                            position: 4,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: AppColors.whiteColor,
            child: new Wrap(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 2.0.h, bottom: 0.0.h),
                  child: SizedBox(
                      child: Center(
                          child: Text(
                    AppMetaLabels().areYouSureCloseAPP,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontFamily: AppFonts.graphikSemibold,
                      fontSize: 12.0.sp,
                    ),
                  ))),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.0.h, bottom: 4.0.h),
                  child: Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 4.0.h,
                            width: 35.0.w,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  elevation:
                                      MaterialStateProperty.all<double>(0.0.h),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          AppColors.whiteColor),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(2.0.w),
                                        side: BorderSide(
                                          color: AppColors.blueColor,
                                          width: 1.0,
                                        )),
                                  )),
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                AppMetaLabels().cancel,
                                style: AppTextStyle.semiBoldWhite11
                                    .copyWith(color: Colors.blue),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 4.0.w,
                          ),
                          SizedBox(
                            height: 4.0.h,
                            width: 35.0.w,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  elevation:
                                      MaterialStateProperty.all<double>(0.0.h),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          AppColors.blueColor),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(2.0.w),
                                        side: BorderSide(
                                          color: AppColors.blueColor,
                                          width: 1.0,
                                        )),
                                  )),
                              onPressed: () {
                                exit(0);
                              },
                              child: Text(
                                AppMetaLabels().exit,
                                style: AppTextStyle.semiBoldWhite11
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
