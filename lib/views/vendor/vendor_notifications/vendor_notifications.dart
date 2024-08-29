import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/vendor/vendor_dashboard/vendor_dashboard_screen/vendor_dashboard_controller.dart';
import 'package:fap_properties/views/vendor/vendor_notifications/vendor_all_notification.dart';
import 'package:fap_properties/views/vendor/vendor_notifications/vendor_notification_controller.dart';
import 'package:fap_properties/views/vendor/vendor_notifications/vendor_unread_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'dart:ui' as ui;

class VendorNotification extends StatefulWidget {
  VendorNotification({Key? key}) : super(key: key);

  @override
  State<VendorNotification> createState() => _VendorNotificationState();
}

class _VendorNotificationState extends State<VendorNotification> {
  var _controller = Get.put(VendorNotificationsController());

  final VendorDashboardController controller = Get.find();

  _getData() async {
    await _controller.getData(_controller.pagaNoPAll);
  }

  _getUnreadNotifications() async {
    await _controller.unReadNotifications(_controller.pagaNoPURead);
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
        controller.getData();
        return true;
      },
      child: Directionality(
        textDirection: SessionController().getLanguage() == 1
            ? ui.TextDirection.ltr
            : ui.TextDirection.rtl,
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: 0.0.h),
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
                          child: Padding(
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
                              initialLabelIndex: _controller.currentIndex.value,
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
                                _controller.currentIndex.value = index!;
                                if (index == 0) {
                                  await _getData();
                                  setState(() {});
                                } else {
                                  await _controller.unReadNotifications(
                                      _controller.pagaNoPURead.toString());
                                  setState(() {});
                                }
                              },
                            ),
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
                              setState(() {
                                _controller.pagaNoPAll = '1';
                                _controller.pagaNoPURead = '1';
                                _controller.noMoreDataPageAll.value = '';
                                _controller.noMoreDataUnRead.value = '';
                              });
                              controller.getData();
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
                      return _controller.currentIndex.value == 0
                          ? Expanded(
                              child: VendorAllNotification(),
                            )
                          : Expanded(
                              child: VendorUnreadNotification(),
                            );
                    }),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
