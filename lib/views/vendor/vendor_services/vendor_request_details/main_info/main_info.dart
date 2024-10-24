import 'dart:typed_data';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/bottom_shadow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

import '../../../../widgets/common_widgets/status_widget.dart';
import 'main_info_controller.dart';

class SvcReqMainInfo extends StatelessWidget {
  SvcReqMainInfo({Key? key}) : super(key: key);
  final controller = Get.find<SvcReqMainInfoController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BottomShadow(),
          Obx(() {
            return controller.loadingData.value == true
                ? Padding(
                    padding: EdgeInsets.only(top: 10.0.h),
                    child: LoadingIndicatorBlue(),
                  )
                : controller.error.value != ''
                    ? Padding(
                        padding: EdgeInsets.only(top: 10.0.h),
                        child: AppErrorWidget(
                          errorText: controller.error.value,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.all(2.0.h),
                        child: Column(
                          children: [
                            Container(
                              width: 100.0.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2.0.h),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 0.5.h,
                                    spreadRadius: 0.1.h,
                                    offset: Offset(0.1.h, 0.1.h),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(2.0.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppMetaLabels().requestDetails,
                                      style: AppTextStyle.semiBoldBlack12,
                                    ),
                                    SizedBox(
                                      height: 1.0.h,
                                    ),
                                    Text(
                                      SessionController().getLanguage() == 1
                                          ? controller.vendorRequestDetails
                                                  .value.detail?.category ??
                                              ""
                                          : controller.vendorRequestDetails
                                                  .value.detail?.categoryAR ??
                                              "",
                                      style: AppTextStyle.normalGrey10,
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Text(
                                      SessionController().getLanguage() == 1
                                          ? controller.vendorRequestDetails
                                                  .value.detail?.subCategory ??
                                              ""
                                          : controller
                                                  .vendorRequestDetails
                                                  .value
                                                  .detail
                                                  ?.subcategoryAR ??
                                              "",
                                      style: AppTextStyle.normalGrey10,
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Text(
                                      SessionController().getLanguage() == 1
                                          ? controller.vendorRequestDetails
                                                  .value.detail?.propertyName ??
                                              ""
                                          : controller
                                                  .vendorRequestDetails
                                                  .value
                                                  .detail
                                                  ?.propertyNameAr ??
                                              "",
                                      style: AppTextStyle.normalGrey10,
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Text(
                                      controller.vendorRequestDetails.value
                                              .detail?.unitRefNo ??
                                          "",
                                      style: AppTextStyle.semiBoldGrey10,
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '',
                                          // controller.vendorRequestDetails.value
                                          //         .detail?.time ??
                                          //     "",
                                          style: AppTextStyle.normalGrey10,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 2.0.w),
                                          child: Text(
                                            '${controller.vendorRequestDetails.value.detail?.date ?? ""} ${controller.vendorRequestDetails.value.detail?.time ?? ""}',
                                            style: AppTextStyle.normalGrey10,
                                          ),
                                        ),
                                        Spacer(),
                                        ConstrainedBox(
                                            constraints:
                                                BoxConstraints(maxWidth: 35.w),
                                            child: controller
                                                            .vendorRequestDetails
                                                            .value
                                                            .detail
                                                            ?.status
                                                            ?.trim() ==
                                                        'Received' &&
                                                    controller
                                                            .vendorRequestDetails
                                                            .value
                                                            .detail
                                                            ?.subCategory ==
                                                        'Supplier Invoice'
                                                ? ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                        maxWidth: 35.w),
                                                    child: StatusWidgetVendor(
                                                      text: AppMetaLabels()
                                                          .submitted,
                                                      valueToCompare: controller
                                                              .vendorRequestDetails
                                                              .value
                                                              .detail
                                                              ?.status ??
                                                          "",
                                                    ))
                                                : ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                        maxWidth: 35.w),
                                                    child: StatusWidgetVendor(
                                                      text: SessionController()
                                                                  .getLanguage() ==
                                                              1
                                                          ? controller
                                                                  .vendorRequestDetails
                                                                  .value
                                                                  .detail
                                                                  ?.status ??
                                                              ""
                                                          : controller
                                                                  .vendorRequestDetails
                                                                  .value
                                                                  .detail
                                                                  ?.statusAR ??
                                                              "",
                                                      valueToCompare: controller
                                                              .vendorRequestDetails
                                                              .value
                                                              .detail
                                                              ?.status ??
                                                          "",
                                                    ))),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                                width: 100.0.w,
                                margin: EdgeInsets.only(top: 2.h),
                                padding: EdgeInsets.all(2.0.h),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(2.0.h),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 0.5.h,
                                      spreadRadius: 0.1.h,
                                      offset: Offset(0.1.h, 0.1.h),
                                    ),
                                  ],
                                ),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppMetaLabels().contactPersonDetails,
                                        style: AppTextStyle.semiBoldBlack12,
                                      ),
                                      SizedBox(
                                        height: 2.0.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${AppMetaLabels().name}: ',
                                            style: AppTextStyle.normalGrey10,
                                          ),
                                          Spacer(),
                                          SizedBox(
                                            width: Get.width * 0.6,
                                            child: Text(
                                              controller
                                                      .vendorRequestDetails
                                                      .value
                                                      .detail
                                                      ?.otherContactName ??
                                                  controller
                                                      .vendorRequestDetails
                                                      .value
                                                      .detail
                                                      ?.contactName ??
                                                  '',
                                              style: AppTextStyle.normalGrey10,
                                              textAlign: SessionController()
                                                          .getLanguage() ==
                                                      1
                                                  ? TextAlign.end
                                                  : TextAlign.start,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${AppMetaLabels().phoneNumber}: ',
                                            style: AppTextStyle.normalGrey10,
                                          ),
                                          Spacer(),
                                          Text(
                                            controller
                                                    .vendorRequestDetails
                                                    .value
                                                    .detail
                                                    ?.otherContactPhone ??
                                                controller
                                                    .vendorRequestDetails
                                                    .value
                                                    .detail
                                                    ?.contactPhone ??
                                                '',
                                            style: AppTextStyle.normalGrey10,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${AppMetaLabels().contactTime}: ',
                                            style: AppTextStyle.normalGrey10,
                                          ),
                                          Spacer(),
                                          Text(
                                            controller
                                                    .vendorRequestDetails
                                                    .value
                                                    .detail
                                                    ?.contactTiming ??
                                                '-',
                                            style: AppTextStyle.normalGrey10,
                                          )
                                        ],
                                      )
                                    ])),
                            Container(
                              width: 100.0.w,
                              margin: EdgeInsets.only(top: 2.h),
                              padding: EdgeInsets.all(2.0.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2.0.h),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 0.5.h,
                                    spreadRadius: 0.1.h,
                                    offset: Offset(0.1.h, 0.1.h),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppMetaLabels().description,
                                    style: AppTextStyle.semiBoldBlack12,
                                  ),
                                  SizedBox(
                                    height: 1.0.h,
                                  ),
                                  Text(
                                    controller.vendorRequestDetails.value.detail
                                            ?.description ??
                                        '',
                                    style: AppTextStyle.normalGrey10,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 100.0.w,
                              margin: EdgeInsets.only(bottom: 1.h, top: 2.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2.0.h),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 0.5.h,
                                    spreadRadius: 0.1.h,
                                    offset: Offset(0.1.h, 0.1.h),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(2.0.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppMetaLabels().photos,
                                      style: AppTextStyle.semiBoldBlack12,
                                    ),
                                    Obx(() {
                                      return controller.gettingPhotos.value
                                          ? Container(
                                              height: 9.h,
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.all(0.5.h),
                                              child: LoadingIndicatorBlue(),
                                            )
                                          : controller.errorGettingPhotos != ''
                                              ? Center(
                                                  child: SizedBox(
                                                    height: 10.h,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          controller
                                                              .errorGettingPhotos,
                                                          style: AppTextStyle
                                                              .semiBoldGrey10,
                                                        ),
                                                        IconButton(
                                                            onPressed: () {
                                                              controller
                                                                  .getPhotos();
                                                            },
                                                            icon: Icon(
                                                                Icons.refresh))
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : GridView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  padding:
                                                      EdgeInsets.only(top: 1.h),
                                                  gridDelegate:
                                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                                          maxCrossAxisExtent:
                                                              25.w,
                                                          childAspectRatio:
                                                              3 / 2,
                                                          crossAxisSpacing: 1.w,
                                                          mainAxisSpacing: 1.w),
                                                  itemCount:
                                                      controller.photos.length,
                                                  itemBuilder:
                                                      (BuildContext ctx,
                                                          index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        showBigImage(
                                                            context,
                                                            controller
                                                                .photos[index]
                                                                .file!);
                                                      },
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(1.h),
                                                        child: Image.memory(
                                                          controller
                                                              .photos[index]
                                                              .file!,
                                                          width: 20.0.w,
                                                          height: 9.0.h,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    );
                                                  });
                                    }),
                                  ],
                                ),
                              ),
                            ),
                            controller.vendorRequestDetails.value.detail
                                            ?.contractorAcknowledged !=
                                        true &&
                                    controller.vendorRequestDetails.value.detail
                                            ?.contractorRejected !=
                                        true &&
                                    controller.vendorRequestDetails.value.detail
                                            ?.status
                                            ?.trim() ==
                                        'Assigned to Contractor'
                                ? Container(
                                    width: 100.0.w,
                                    margin:
                                        EdgeInsets.only(bottom: 1.h, top: 2.h),
                                    padding: EdgeInsets.all(2.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(2.0.h),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 0.5.h,
                                          spreadRadius: 0.1.h,
                                          offset: Offset(0.1.h, 0.1.h),
                                        ),
                                      ],
                                    ),
                                    child: Obx(() {
                                      return controller.updatingStatus.value
                                          ? LoadingIndicatorBlue()
                                          : Row(
                                              children: [
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Expanded(
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      controller
                                                          .acknowledgeCase();
                                                    },
                                                    child: Text(
                                                        AppMetaLabels().ack),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Expanded(
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                AppColors
                                                                    .redColor),
                                                    onPressed: () {
                                                      controller.rejectCase();
                                                    },
                                                    child: Text(
                                                      AppMetaLabels()
                                                          .notInScope,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                              ],
                                            );
                                    }))
                                : controller.vendorRequestDetails.value.detail
                                                ?.contractorAcknowledged ==
                                            true ||
                                        controller.vendorRequestDetails.value
                                                .detail?.contractorRejected ==
                                            true
                                    ? Container(
                                        width: 100.0.w,
                                        margin: EdgeInsets.only(
                                            bottom: 1.h, top: 2.h),
                                        padding: EdgeInsets.all(2.h),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(2.0.h),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 0.5.h,
                                              spreadRadius: 0.1.h,
                                              offset: Offset(0.1.h, 0.1.h),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                              controller
                                                          .vendorRequestDetails
                                                          .value
                                                          .detail
                                                          ?.contractorAcknowledged ==
                                                      true
                                                  ? AppMetaLabels().acknowledged
                                                  : controller
                                                              .vendorRequestDetails
                                                              .value
                                                              .detail
                                                              ?.contractorRejected ==
                                                          true
                                                      ? AppMetaLabels().rejected
                                                      : '',
                                              style:
                                                  AppTextStyle.semiBoldBlue12),
                                        ),
                                      )
                                    : SizedBox()
                          ],
                        ),
                      );
          }),
        ],
      ),
    );
  }

  showBigImage(BuildContext context, Uint8List image) {
    showDialog(
        context: context,
        builder: (context) {
          return Material(
            child: Center(
              child: Stack(
                children: [
                  ZoomOverlay(
                      minScale: 0.5, // Optional
                      maxScale: 3.0, // Optional
                      twoTouchOnly: true, // Defaults to false
                      child: Image.memory(image)),
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.cancel))
                ],
              ),
            ),
          );
        });
  }
}
