import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/tenant/tenant_dashboard/tenant_dashboard_get_data_controller.dart';
import 'package:fap_properties/views/tenant/tenant_notifications/tenant_all_notifications.dart';
import 'package:fap_properties/views/tenant/tenant_notifications/tenant_notifications_controller.dart';
import 'package:fap_properties/views/tenant/tenant_notifications/tenant_unread_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../data/helpers/session_controller.dart';

class TenantNotifications extends StatefulWidget {
  TenantNotifications({Key key}) : super(key: key);

  @override
  State<TenantNotifications> createState() => _TenantNotificationsState();
}

class _TenantNotificationsState extends State<TenantNotifications> {
  final getTNController = Get.put(GetTenantNotificationsController());
  TenantDashboardGetDataController _tenantDashboard = Get.find();

  _getData() async {
    await getTNController.getData(getTNController.pagaNoPAll);
  }

  _getUnreadNotifications() async {
    await getTNController.unReadNotifications(getTNController.pagaNoPURead);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getData();
      _getUnreadNotifications();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          _tenantDashboard.getData();
          return true;
        },
        child: Directionality(
          textDirection: SessionController().getLanguage() == 1
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(3.0.h),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 2.w),
                          padding: EdgeInsets.all(0.3.h),
                          child: ToggleSwitch(
                            minWidth: 25.0.w,
                            minHeight: 3.0.h,
                            cornerRadius: 3.0.h,
                            activeBgColors: [
                              [Colors.white],
                              [Colors.white]
                            ],
                            activeFgColor: Colors.white,
                            inactiveBgColor: Colors.grey[200],
                            inactiveFgColor: Colors.white,
                            initialLabelIndex:
                                getTNController.currentIndex.value,
                            totalSwitches: 2,
                            labels: [
                              AppMetaLabels().all,
                              AppMetaLabels().unread
                            ],
                            customTextStyles: [
                              AppTextStyle.semiBoldBlack12,
                              AppTextStyle.semiBoldBlack12,
                            ],
                            radiusStyle: true,
                            onToggle: (index) async {
                              getTNController.currentIndex.value = index;
                              if (index == 0) {
                                await getTNController.getData(
                                    getTNController.pagaNoPAll.toString());
                              } else {
                                await getTNController.unReadNotifications(
                                    getTNController.pagaNoPURead);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2.0.h, right: 2.0.h),
                      child: Row(
                        children: [
                          Text(
                            AppMetaLabels().notifications,
                            style: AppTextStyle.semiBoldBlack16,
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                getTNController.pagaNoPAll = '1';
                                getTNController.pagaNoPURead = '1';
                                getTNController.noMoreDataPageAll.value = '';
                                getTNController.noMoreDataUnRead.value = '';
                              });
                              Get.back();
                              _tenantDashboard.getData();
                            },
                            icon: Icon(
                              Icons.cancel_outlined,
                              color: Colors.grey,
                              size: 3.5.h,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppDivider(),
                    Obx(() {
                      return getTNController.loadingData.value == true
                          ? Padding(
                              padding: EdgeInsets.only(top: 30.0.h),
                              child: LoadingIndicatorBlue(),
                            )
                          : getTNController.currentIndex.value == 0
                              ? Expanded(
                                  child: TenantAllNotifications(),
                                )
                              : Expanded(
                                  child: TenantUnReadNotifications(),
                                );
                    }),
                  ],
                ),
              )),
        ));
  }
}
