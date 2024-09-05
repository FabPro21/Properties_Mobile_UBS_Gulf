import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/landlord/landlord_properties/landlord_property_details_tab/landlord_property_detail_tab_controller.dart';
import 'package:fap_properties/views/widgets/bottom_shadow.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'landlord_property_unit_Info_details.dart';

class LandlordPropertyUnitInfo extends StatefulWidget {
  final String? propertID;
  const LandlordPropertyUnitInfo({Key? key, this.propertID}) : super(key: key);

  @override
  _LandlordPropertyUnitInfoState createState() =>
      _LandlordPropertyUnitInfoState();
}

class _LandlordPropertyUnitInfoState extends State<LandlordPropertyUnitInfo> {
  LandlordPropertiesTabDetailController controller =
      Get.put(LandlordPropertiesTabDetailController());
  String propertyName = "";
  String amount = "";

  @override
  void initState() {
    controller.getPropertiesUnitInfo(widget.propertID ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Stack(children: [
        Obx(() {
          return controller.loadingPropertiesInfo.value == true
              ? SizedBox(
                  height: 70.h,
                  child: Center(
                    child: LoadingIndicatorBlue(),
                  ),
                )
              : controller.errorLoadingPropertiesInfo != ''
                  ? SizedBox(
                      height: 60.h,
                      child: Center(
                        child: CustomErrorWidget(
                          errorText: controller.errorLoadingPropertiesInfo,
                          errorImage: AppImagesPath.noContractsFound,
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      itemCount: controller.propertyUnitInfo?.cities?.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            print(controller
                                .propertyUnitInfo?.cities?[index].unitID);
                            Get.to(
                              () => LandlordPropertyUnitInfoDetails(
                                unitID: controller
                                    .propertyUnitInfo?.cities?[index].unitID
                                    .toString(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(1.5.h),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2.5.h),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 0.5.h,
                                    spreadRadius: 0.3.h,
                                    offset: Offset(0.1.h, 0.1.h),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Container(
                                      //   color: Colors.transparent,
                                      //   child: ClipRRect(
                                      //       borderRadius: BorderRadius.only(
                                      //         topLeft: Radius.circular(3.5.h),
                                      //         topRight: Radius.circular(3.5.h),
                                      //       ),
                                      //       child: Container(
                                      //         height: 36.0.h,
                                      //         width: 100.0.w,
                                      //         color: Colors.grey[300],
                                      //         child: StreamBuilder<Uint8List>(
                                      //           stream: controller.getImage(index),
                                      //           builder: (
                                      //             BuildContext context,
                                      //             AsyncSnapshot<Uint8List> snapshot,
                                      //           ) {
                                      //             if (snapshot.connectionState ==
                                      //                 ConnectionState.waiting) {
                                      //               return SizedBox(
                                      //                 height: 36.0.h,
                                      //                 width: 100.0.w,
                                      //                 child: Shimmer.fromColors(
                                      //                   baseColor: Colors.grey
                                      //                       .withOpacity(0.2),
                                      //                   highlightColor: Colors.grey
                                      //                       .withOpacity(0.5),
                                      //                   child: ClipRRect(
                                      //                     borderRadius:
                                      //                         BorderRadius.circular(
                                      //                             2.h),
                                      //                     child: Image.asset(
                                      //                         AppImagesPath
                                      //                             .thumbnail,
                                      //                         fit: BoxFit.cover),
                                      //                   ),
                                      //                 ),
                                      //               );
                                      //             }
                                      //             if (snapshot.hasData) {
                                      //               return Image.memory(
                                      //                   snapshot.data,
                                      //                   fit: BoxFit.cover);
                                      //             } else {
                                      //               return Center(
                                      //                 child: Text(
                                      //                   SessionController()
                                      //                               .getLanguage() ==
                                      //                           1
                                      //                       ? controller
                                      //                                   .propertyUnitInfo
                                      //                                   .cities[index]
                                      //                                   .propertyName[
                                      //                               0] ??
                                      //                           ''
                                      //                       : controller
                                      //                               .propertyUnitInfo
                                      //                               .cities[index]
                                      //                               .propertyNameAR[0] ??
                                      //                           '',
                                      //                   style: AppTextStyle
                                      //                       .semiBoldBlack16
                                      //                       .copyWith(
                                      //                     color: Colors.black,
                                      //                     fontSize: 30.0.sp,
                                      //                   ),
                                      //                 ),
                                      //               );
                                      //             }
                                      //           },
                                      //         ),
                                      //       )),
                                      // ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 2.5.h,
                                          bottom: 2.0.h,
                                          left: 1.5.h,
                                          right: 1.0.h,
                                        ),
                                        child: Container(
                                          width: 81.0.w,
                                          // color: Colors.red,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 90.0.w,
                                                child: Text(
                                                  controller.propertyUnitInfo
                                                              ?.cities ==
                                                          null
                                                      ? ''
                                                      : SessionController()
                                                                  .getLanguage() ==
                                                              1
                                                          ? controller
                                                                  .propertyUnitInfo
                                                                  ?.cities![
                                                                      index]
                                                                  .propertyName ??
                                                              ''
                                                          : controller
                                                                  .propertyUnitInfo
                                                                  ?.cities![
                                                                      index]
                                                                  .propertyNameAR ??
                                                              '',
                                                  style: AppTextStyle
                                                      .semiBoldGrey12,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(height: 1.0.h),
                                              Row(
                                                children: [
                                                  Text(
                                                    AppMetaLabels().unitRefNo,
                                                    style: AppTextStyle
                                                        .normalGrey11,
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    width: 60.w,
                                                    alignment: SessionController()
                                                                .getLanguage() ==
                                                            1
                                                        ? Alignment.centerRight
                                                        : Alignment.centerLeft,
                                                    child: Text(
                                                      controller
                                                              .propertyUnitInfo
                                                              ?.cities?[index]
                                                              .unitRefNo ??
                                                          '',
                                                      style: AppTextStyle
                                                          .normalGrey11,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 1.0.h),
                                              Row(
                                                children: [
                                                  Text(
                                                    AppMetaLabels().unitType,
                                                    style: AppTextStyle
                                                        .normalGrey11,
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    width: 60.w,
                                                    alignment: SessionController()
                                                                .getLanguage() ==
                                                            1
                                                        ? Alignment.centerRight
                                                        : Alignment.centerLeft,
                                                    child: Text(
                                                      controller.propertyUnitInfo
                                                                  ?.cities ==
                                                              null
                                                          ? ''
                                                          : SessionController()
                                                                      .getLanguage() ==
                                                                  1
                                                              ? controller
                                                                      .propertyUnitInfo
                                                                      ?.cities![
                                                                          index]
                                                                      .unitType ??
                                                                  ''
                                                              : controller
                                                                      .propertyUnitInfo
                                                                      ?.cities![
                                                                          index]
                                                                      .unitTypeAR ??
                                                                  '-',
                                                      style: AppTextStyle
                                                          .normalGrey11,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 1.0.h),
                                              Row(
                                                children: [
                                                  Text(
                                                    AppMetaLabels().rent,
                                                    style: AppTextStyle
                                                        .normalGrey11,
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    width: 55.w,
                                                    alignment: SessionController()
                                                                .getLanguage() ==
                                                            1
                                                        ? Alignment.centerRight
                                                        : Alignment.centerLeft,
                                                    child: Text(
                                                      "${AppMetaLabels().aed} ${controller.propertyUnitInfo?.cities?[index].currentRent ?? 0.0}",
                                                      style: AppTextStyle
                                                          .normalGrey11,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 1.0.h),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        SessionController().getLanguage() == 1
                                            ? EdgeInsets.only(
                                                right: 1.8.h,
                                              )
                                            : EdgeInsets.only(
                                                left: 1.8.h,
                                              ),
                                    child: SizedBox(
                                      width: 0.13.w,
                                      child: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: AppColors.grey1,
                                        size: 20,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
        }),
        BottomShadow(),
      ]),
    );
  }
}
