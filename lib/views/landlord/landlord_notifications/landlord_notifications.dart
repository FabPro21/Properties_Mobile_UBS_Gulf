// ignore_for_file: deprecated_member_use

import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/landlord/landlord_dashboard/landlord_dashboard_controller.dart';
import 'package:fap_properties/views/landlord/landlord_notifications/landlord_all_notifications.dart';
import 'package:fap_properties/views/landlord/landlord_notifications/landlord_notifications_controller.dart';
import 'package:fap_properties/views/landlord/landlord_notifications/landlord_unread_notifications.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:toggle_switch/toggle_switch.dart';


class LandlordNotifications extends StatefulWidget {
  LandlordNotifications({Key? key}) : super(key: key);

  @override
  State<LandlordNotifications> createState() => _LandlordNotificationsState();
}

class _LandlordNotificationsState extends State<LandlordNotifications> {
  final getLandLController = Get.put(LandlordNotificationsController());
  final landLordDashBoardController = Get.put(LandlordDashboardController());

 _getData() async {
    await getLandLController.getData(getLandLController.pagaNoPAll);
  }

  _getUnreadNotifications() async {
    await getLandLController.unReadNotifications(getLandLController.pagaNoPURead);
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
          // call this api for reload the data of top container of DashBoard
          // landLordDashBoardController.getData();
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
                                getLandLController.currentIndex.value,
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
                            onToggle: (index) {
                              getLandLController.currentIndex.value = index!;
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
                              Get.back();
                              // call this api for reload the data of top container of DashBoard
                              // landLordDashBoardController.getData();
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
                      return getLandLController.loadingData.value == true
                          ? Padding(
                              padding: EdgeInsets.only(top: 30.0.h),
                              child: LoadingIndicatorBlue(),
                            )
                          : getLandLController.currentIndex.value == 0
                              ? Expanded(
                                  child: LandLordAllNotifications(),
                                )
                              : Expanded(
                                  child: LandLordUnReadNotifications(),
                                );
                    }),
                  ],
                ),
              )),
        ));
  }
}
