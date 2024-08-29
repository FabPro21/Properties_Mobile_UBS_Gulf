import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/fonts.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'public_notification_controller.dart';
import 'dart:ui' as ui;

class PublicNotificationDetails extends StatefulWidget {
  const PublicNotificationDetails({Key? key}) : super(key: key);

  @override
  _PublicNotificationDetailsState createState() =>
      _PublicNotificationDetailsState();
}

class _PublicNotificationDetailsState extends State<PublicNotificationDetails> {
  var _controller = Get.put(PublicNotificationsController());

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
                                child: CustomErrorWidget(
                                  errorText: _controller.error.value,
                                  errorImage: AppImagesPath.noServicesFound,
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
                                                    .notification!
                                                    .title ??
                                                ""
                                            : _controller
                                                    .notificationsDetaildata
                                                    .value
                                                    .notification!
                                                    .titleAR ??
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
                                        _controller
                                                .notificationsDetaildata
                                                .value
                                                .notification!
                                                .createdOn ??
                                            "",
                                        style: AppTextStyle.normalBlack10,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 3.w),
                                      child: Html(
                                        data:
                                            SessionController().getLanguage() ==
                                                    1
                                                ? _controller
                                                    .notificationsDetaildata
                                                    .value
                                                    .notification!
                                                    .description
                                                    .toString()
                                                : _controller
                                                    .notificationsDetaildata
                                                    .value
                                                    .notification!
                                                    .descriptionAR
                                                    .toString(),
                                        style: {
                                          'html': Style(
                                            textAlign: SessionController()
                                                        .getLanguage() ==
                                                    1
                                                ? TextAlign.left
                                                : TextAlign.right,
                                            color: Colors.black,
                                            fontFamily: AppFonts.graphikRegular,
                                            fontSize: FontSize(10.0),
                                          ),
                                        },
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
