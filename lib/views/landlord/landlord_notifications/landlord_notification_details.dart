// ignore_for_file: unnecessary_null_comparison

import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/fonts.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/landlord/landlord_notifications/landlord_notifications_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;

class LandlordNotificationDetails extends StatefulWidget {
  const LandlordNotificationDetails({Key? key}) : super(key: key);

  @override
  State<LandlordNotificationDetails> createState() =>
      _LandlordNotificationDetailsState();
}

class _LandlordNotificationDetailsState
    extends State<LandlordNotificationDetails> {
  var getLandLController = Get.put(LandlordNotificationsController());
  _getData() async {
    await getLandLController.notificationsDetails();
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Directionality(
              textDirection: SessionController().getLanguage() == 1
                  ? ui.TextDirection.ltr
                  : ui.TextDirection.rtl,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(2.0.h),
                  child: Obx(() {
                    return getLandLController
                                .loadingnotificationsDetail.value ==
                            true
                        ? Padding(
                            padding: EdgeInsets.only(top: 40.0.h),
                            child: LoadingIndicatorBlue(),
                          )
                        : getLandLController.error.value != ''
                            ? Padding(
                                padding: EdgeInsets.only(top: 40.0.h),
                                child: AppErrorWidget(
                                  errorText: getLandLController.error.value,
                                ),
                              )
                            : Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(1.0.h),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(1.5.h),
                                          child: Text(
                                            SessionController().getLanguage() ==
                                                    1
                                                ? getLandLController
                                                    .notificationsDetailModel
                                                    .value
                                                    .notification!
                                                    .title
                                                    .toString()
                                                : getLandLController
                                                    .notificationsDetailModel
                                                    .value
                                                    .notification!
                                                    .titleAR
                                                    .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
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
                                            getLandLController
                                                    .notificationsDetailModel
                                                    .value
                                                    .notification!
                                                    .createdOn
                                                    .toString() ,
                                            style: AppTextStyle.normalBlack10,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 2.0.w,
                                              right: 2.0.w,
                                              top: 1.0.h,
                                              bottom: 1.0.h),
                                          child: Html(
                                            data: SessionController()
                                                        .getLanguage() ==
                                                    1
                                                ? getLandLController
                                                    .notificationsDetailModel
                                                    .value
                                                    .notification!
                                                    .description
                                                    .toString()
                                                : getLandLController
                                                    .notificationsDetailModel
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
                                                fontFamily:
                                                    AppFonts.graphikRegular,
                                                fontSize: FontSize(10.0),
                                              ),
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (!getLandLController.loadingFiles.value &&
                                      getLandLController.files != null &&
                                      getLandLController
                                          .files!.record!.isNotEmpty)
                                    Container(
                                      margin: EdgeInsets.only(top: 3.h),
                                      padding: EdgeInsets.all(2.h),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(1.0.h),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppMetaLabels().files,
                                            style: AppTextStyle.semiBoldBlack12,
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: getLandLController
                                                  .files!.record!.length,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          getLandLController
                                                                  .files!
                                                                  .record![index]
                                                                  .fileName ??
                                                              '',
                                                          style: AppTextStyle
                                                              .semiBoldBlue12,
                                                        ),
                                                        SizedBox(
                                                          height: 50,
                                                          width: 50,
                                                          child: Obx(() {
                                                            return getLandLController
                                                                    .files!
                                                                    .record![
                                                                        index]
                                                                    .downloading!
                                                                    .value
                                                                ? LoadingIndicatorBlue(
                                                                    strokeWidth:
                                                                        2,
                                                                    size: 24,
                                                                  )
                                                                : Center(
                                                                    child:
                                                                        IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        getLandLController
                                                                            .downloadFile(index);
                                                                      },
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .download,
                                                                        color: Colors
                                                                            .black87,
                                                                      ),
                                                                    ),
                                                                  );
                                                          }),
                                                        )
                                                      ],
                                                    ),
                                                    if (index <
                                                        getLandLController.files!
                                                                .record!.length -
                                                            1)
                                                      AppDivider()
                                                  ],
                                                );
                                              })
                                        ],
                                      ),
                                    )
                                ],
                              );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
