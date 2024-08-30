import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/landlord/landlord_dashboard/widgets/properties/properties_widget_controller.dart';
import 'package:fap_properties/views/landlord/landlord_properties/landlord_property_details_tab/landlord_property_details_tabs.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PropertiesWidget extends StatefulWidget {
  final Function(int)? manageProperties;
  const PropertiesWidget({Key? key, this.manageProperties}) : super(key: key);

  @override
  _PropertiesWidgetState createState() => _PropertiesWidgetState();
}

class _PropertiesWidgetState extends State<PropertiesWidget> {
  @override
  void initState() {
    super.initState();
  }

  final controller = Get.find<LandlordPropsWidgetController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 2.0.h,
        right: 2.0.h,
        top: 2.0.h,
      ),
      child: Container(
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.5.w),
              child: Text(
                AppMetaLabels().propertiessLand +
                    "  (${controller.propsModel?.serviceRequests?.length})",
                style: AppTextStyle.semiBoldBlack13,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 2.h),
              child: AppDivider(),
            ),
            Container(
              child: Obx(() {
                return controller.loadingProperties.value == true
                    ? LoadingIndicatorBlue()
                    : controller.errorLoadingProperties != ''
                        ? AppErrorWidget(
                            errorImage: AppImagesPath.noContractsFound,
                            errorText: controller.errorLoadingProperties,
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.length,
                            itemBuilder: (context, index) {
                              final property = controller
                                  .propsModel?.serviceRequests?[index];
                              return InkWell(
                                onTap: () {
                                  Get.to(() => LandlordPropertDetailsTabs(
                                        propertyId: controller.propsModel
                                            ?.serviceRequests?[index].propertyID
                                            .toString(),
                                        propertyNo: controller.propsModel
                                                    ?.serviceRequests ==
                                                null
                                            ? ''
                                            : SessionController()
                                                        .getLanguage() ==
                                                    1
                                                ? controller
                                                        .propsModel
                                                        ?.serviceRequests![
                                                            index]
                                                        .emirateName
                                                        .toString() ??
                                                    ""
                                                : controller
                                                        .propsModel
                                                        ?.serviceRequests?[
                                                            index]
                                                        .emirateNameAR
                                                        .toString() ??
                                                    "",
                                      ));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 1.0.h,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 1.0.h,
                                              bottom: 1.h,
                                              right: 1.0.h),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 78.0.w,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      alignment: SessionController()
                                                                  .getLanguage() ==
                                                              1
                                                          ? Alignment.topLeft
                                                          : Alignment.topRight,
                                                      width: 58.w,
                                                      child: Text(
                                                        SessionController()
                                                                    .getLanguage() ==
                                                                1
                                                            ? property
                                                                    ?.propertyName ??
                                                                ""
                                                            : property
                                                                    ?.propertyNameAR ??
                                                                "",
                                                        maxLines: 1,
                                                        style: AppTextStyle
                                                            .semiBoldBlack12,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 1.0.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          AppMetaLabels()
                                                              .emirate,
                                                          style: AppTextStyle
                                                              .normalGrey11,
                                                        ),
                                                        Spacer(),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          width: 58.w,
                                                          child: Text(
                                                            SessionController()
                                                                        .getLanguage() ==
                                                                    1
                                                                ? property
                                                                        ?.emirateName ??
                                                                    ""
                                                                : property
                                                                        ?.emirateNameAR ??
                                                                    "",
                                                            style: AppTextStyle
                                                                .semiBoldBlack11,
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    // SizedBox(
                                                    //   height: 1.0.h,
                                                    // ),
                                                    // Row(
                                                    //   children: [
                                                    //     Text(
                                                    //       AppMetaLabels()
                                                    //           .sector,
                                                    //       style: AppTextStyle
                                                    //           .semiBoldBlack11,
                                                    //     ),
                                                    //     Spacer(),
                                                    //     Container(
                                                    //       alignment: Alignment
                                                    //           .centerRight,
                                                    //       width: 58.w,
                                                    //       child: Text(
                                                    //         SessionController()
                                                    //                     .getLanguage() ==
                                                    //                 1
                                                    //             ? property
                                                    //                     .sector ??
                                                    //                 ""
                                                    //             : property
                                                    //                     .sectorAR ??
                                                    //                 "",
                                                    //         style: AppTextStyle
                                                    //             .normalGrey10,
                                                    //         maxLines: 1,
                                                    //       ),
                                                    //     ),
                                                    //   ],
                                                    // ),
                                                    SizedBox(
                                                      height: 1.0.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          AppMetaLabels().type,
                                                          style: AppTextStyle
                                                              .normalGrey11,
                                                        ),
                                                        Spacer(),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          width: 58.w,
                                                          child: Text(
                                                            SessionController()
                                                                        .getLanguage() ==
                                                                    1
                                                                ? property
                                                                        ?.propertyType ??
                                                                    ""
                                                                : property
                                                                        ?.propertyTypeAR ??
                                                                    "",
                                                            style: AppTextStyle
                                                                .normalGrey10,
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 1.2.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          AppMetaLabels()
                                                              .category,
                                                          style: AppTextStyle
                                                              .normalGrey11,
                                                        ),
                                                        Spacer(),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          width: 58.w,
                                                          child: Text(
                                                            SessionController()
                                                                        .getLanguage() ==
                                                                    1
                                                                ? property
                                                                        ?.propertyCategory ??
                                                                    ""
                                                                : property
                                                                        ?.propertyCategoryAR ??
                                                                    "".trim(),
                                                            style: AppTextStyle
                                                                .normalGrey10,
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: SessionController()
                                                            .getLanguage() ==
                                                        1
                                                    ? EdgeInsets.only(
                                                        right: 1.0.h,
                                                        left: 0.5.h)
                                                    : EdgeInsets.only(
                                                        right: 0.5.h,
                                                        left: 1.0.h),
                                                child: SizedBox(
                                                  width: 0.15.w,
                                                  child: Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    color: AppColors.grey1,
                                                    size: 20,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    index == controller.length - 1
                                        ? SizedBox()
                                        : AppDivider(),
                                  ],
                                ),
                              );
                            },
                          );
              }),
            ),
            controller.errorLoadingProperties != ''
                ? SizedBox(
                    height: Get.height * 0.1,
                  )
                : Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: 2.0.h, bottom: 2.0.h),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          widget.manageProperties!(1);
                          setState(() {});
                        },
                        child: Text(
                          AppMetaLabels().viewAllPropertiesLand,
                          style: AppTextStyle.semiBoldBlue9,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
