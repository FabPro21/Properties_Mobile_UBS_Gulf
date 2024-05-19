import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/vendor/vendor_notifications/vendor_notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;

class VendorNotificationDetails extends StatefulWidget {
  const VendorNotificationDetails({Key key}) : super(key: key);

  @override
  _VendorNotificationDetailsState createState() =>
      _VendorNotificationDetailsState();
}

class _VendorNotificationDetailsState extends State<VendorNotificationDetails> {
  var _controller = Get.put(VendorNotificationsController());

  _getData() async {
    await _controller.notificationsDetails();
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? ui.TextDirection.ltr
          : ui.TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
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
                        // _controller.getData();
                        // _controller.unReadNotifications();
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
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(2.0.h),
                  child: Obx(() {
                    return _controller.loadingnotificationsDetail.value == true
                        ? Padding(
                            padding: EdgeInsets.only(top: 40.0.h),
                            child: LoadingIndicatorBlue(),
                          )
                        : _controller.error.value != ''
                            ? Padding(
                                padding: EdgeInsets.only(top: 40.0.h),
                                child: AppErrorWidget(
                                  errorText: _controller.error.value,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(1.0.h),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 0.5.h,
                                      spreadRadius: 0.3.h,
                                      offset: Offset(0.1.h, 0.1.h),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(1.0.h),
                                      child: Text(
                                        SessionController().getLanguage() == 1
                                            ? _controller
                                                    .notificationsDetaildata
                                                    .value
                                                    .notification
                                                    .title ??
                                                ""
                                            : _controller
                                                    .notificationsDetaildata
                                                    .value
                                                    .notification
                                                    .titleAr ??
                                                "",
                                        style: AppTextStyle.semiBoldBlack13,
                                      ),
                                    ),
                                    AppDivider(),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 2.0.h,
                                          right: 2.0.h,
                                          top: 1.0.h),
                                      child: Text(
                                        _controller.notificationsDetaildata
                                                .value.notification.createdOn ??
                                            "",
                                        style: AppTextStyle.normalBlack10,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2.w),
                                      child: Html(
                                             customTextAlign: (_) =>
                                            SessionController().getLanguage() ==
                                                    1
                                                ? TextAlign.left
                                                : TextAlign.right,
                                        data:
                                            SessionController().getLanguage() ==
                                                    1
                                                ? _controller
                                                        .notificationsDetaildata
                                                        .value
                                                        .notification
                                                        .description ??
                                                    ""
                                                : _controller
                                                        .notificationsDetaildata
                                                        .value
                                                        .notification
                                                        .descriptionAr ??
                                                    "",
                                        defaultTextStyle:
                                            AppTextStyle.normalBlack10,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
