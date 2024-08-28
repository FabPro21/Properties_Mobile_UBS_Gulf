import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/landlord/landlord_properties/landlord_property_details_tab/landlord_property_detail_tab_controller.dart';
import 'package:fap_properties/views/widgets/bottom_shadow.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

class LandlordPropertyInfo extends StatefulWidget {
  final String? propertID;
  const LandlordPropertyInfo({Key? key, this.propertID}) : super(key: key);

  @override
  _LandlordPropertyInfoState createState() => _LandlordPropertyInfoState();
}

class _LandlordPropertyInfoState extends State<LandlordPropertyInfo> {
  LandlordPropertiesTabDetailController controller =
      Get.put(LandlordPropertiesTabDetailController());
  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(23.4241, 53.8478),
    zoom: 5.0,
  );
  @override
  void initState() {
    controller.getPropertyDetail(widget.propertID!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Directionality(
          textDirection: SessionController().getLanguage() == 1
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 1.5.h, right: 1.5.h, bottom: 1.h),
                  child: Obx(() {
                    return controller.loadingPropertiesDetail.value == true
                        ? SizedBox(
                            height: 70.h,
                            child: Center(
                              child: LoadingIndicatorBlue(),
                            ),
                          )
                        : controller.errorLoadingPropertiesDetail != ''
                            ? SizedBox(
                                height: 60.h,
                                child: Center(
                                  child: CustomErrorWidget(
                                    errorText:
                                        controller.errorLoadingProperties,
                                    errorImage: AppImagesPath.noContractsFound,
                                  ),
                                ),
                              )
                            : Column(
                                children: [
                                  // Property Name and address
                                  Padding(
                                    padding: EdgeInsets.only(top: 3.0.h),
                                    child: Container(
                                      width: 94.0.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(2.0.h),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 0.5.h,
                                            spreadRadius: 0.3.h,
                                            offset: Offset(0.1.h, 0.1.h),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(2.5.h),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppMetaLabels().propertyInfoLand,
                                              style: AppTextStyle
                                                  .semiBoldBlack12
                                                  .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  AppMetaLabels().name,
                                                  style:
                                                      AppTextStyle.normalGrey11,
                                                ),
                                                Spacer(),
                                                Container(
                                                  alignment: SessionController()
                                                              .getLanguage() ==
                                                          1
                                                      ? Alignment.centerRight
                                                      : Alignment.centerLeft,
                                                  width: 58.w,
                                                  child: Text(
                                                    SessionController()
                                                                .getLanguage() ==
                                                            1
                                                        ? controller
                                                                .propertyDetailInfo!
                                                                .propertyDetails!
                                                                .first
                                                                .propertyName ??
                                                            ''
                                                        : controller
                                                                .propertyDetailInfo!
                                                                .propertyDetails!
                                                                .first
                                                                .propertyNameAR ??
                                                            '',
                                                    maxLines: 1,
                                                    style: AppTextStyle
                                                        .semiBoldBlack11,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 1.5.h,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  AppMetaLabels().emirate,
                                                  style:
                                                      AppTextStyle.normalGrey11,
                                                ),
                                                Spacer(),
                                                Container(
                                                  alignment: SessionController()
                                                              .getLanguage() ==
                                                          1
                                                      ? Alignment.centerRight
                                                      : Alignment.centerLeft,
                                                  width: 58.w,
                                                  child: Text(
                                                    SessionController()
                                                                .getLanguage() ==
                                                            1
                                                        ? controller
                                                                .propertyDetailInfo!
                                                                .propertyDetails!
                                                                .first
                                                                .emirateName ??
                                                            ''
                                                        : controller
                                                                .propertyDetailInfo!
                                                                .propertyDetails!
                                                                .first
                                                                .emirateNameAR ??
                                                            '-',
                                                    maxLines: 1,
                                                    style: AppTextStyle
                                                        .semiBoldBlack11,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 1.5.h,
                                            ),
                                            // road name
                                            // Row(
                                            //   children: [
                                            //     Text(
                                            //       'Road Name',
                                            //       style: AppTextStyle
                                            //           .semiBoldBlack11,
                                            //     ),
                                            //     Spacer(),
                                            //     Container(
                                            //       alignment:
                                            //           Alignment.centerRight,
                                            //       width: 58.w,
                                            //       child: Text(
                                            //         SessionController()
                                            //                     .getLanguage() ==
                                            //                 1
                                            //             ? controller
                                            //                     .propertyDetailInfo!
                                            //                     .propertyDetails!
                                            //                     .first
                                            //                     .roadName ??
                                            //                 ''
                                            //             : controller
                                            //                     .propertyDetailInfo!
                                            //                     .propertyDetails!
                                            //                     .first
                                            //                     .roadNameAR ??
                                            //                 '',
                                            //         style: AppTextStyle
                                            //             .normalBlack10,
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),

                                            // SizedBox(
                                            //   height: 1.5.h,
                                            // ),
                                            Row(
                                              children: [
                                                Text(
                                                  AppMetaLabels().sector,
                                                  style:
                                                      AppTextStyle.normalGrey11,
                                                ),
                                                Spacer(),
                                                Container(
                                                  alignment: SessionController()
                                                              .getLanguage() ==
                                                          1
                                                      ? Alignment.centerRight
                                                      : Alignment.centerLeft,
                                                  width: 58.w,
                                                  child: Text(
                                                    SessionController()
                                                                .getLanguage() ==
                                                            1
                                                        ? controller
                                                                .propertyDetailInfo!
                                                                .propertyDetails!
                                                                .first
                                                                .sector ??
                                                            ''
                                                        : controller
                                                                .propertyDetailInfo!
                                                                .propertyDetails!
                                                                .first
                                                                .sectorAR ??
                                                            '',
                                                    style: AppTextStyle
                                                        .normalBlack10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 1.5.h,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  AppMetaLabels()
                                                      .noofResidentialFlat,
                                                  style:
                                                      AppTextStyle.normalGrey11,
                                                ),
                                                Spacer(),
                                                Container(
                                                  alignment: SessionController()
                                                              .getLanguage() ==
                                                          1
                                                      ? Alignment.centerRight
                                                      : Alignment.centerLeft,
                                                  width: 40.w,
                                                  child: Text(
                                                    controller
                                                            .propertyDetailInfo!
                                                            .propertyDetails!
                                                            .first
                                                            .noofResidentialFlat
                                                            .toString(),
                                                    style: AppTextStyle
                                                        .normalBlack10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 1.5.h,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  AppMetaLabels()
                                                      .noofCommercialFlat,
                                                  style:
                                                      AppTextStyle.normalGrey11,
                                                ),
                                                Spacer(),
                                                Container(
                                                  alignment: SessionController()
                                                              .getLanguage() ==
                                                          1
                                                      ? Alignment.centerRight
                                                      : Alignment.centerLeft,
                                                  width: 40.w,
                                                  child: Text(
                                                    controller
                                                            .propertyDetailInfo!
                                                            .propertyDetails!
                                                            .first
                                                            .noofCommercialFlat
                                                            .toString(),
                                                    style: AppTextStyle
                                                        .normalBlack10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // // Plot No
                                            // SizedBox(
                                            //   height: 1.5.h,
                                            // ),
                                            // Row(
                                            //   children: [
                                            //     Text(
                                            //       'Plot No',
                                            //       style: AppTextStyle
                                            //           .semiBoldBlack11,
                                            //     ),
                                            //     Spacer(),
                                            //     Container(
                                            //       alignment:
                                            //           Alignment.centerRight,
                                            //       width: 58.w,
                                            //       child: Text(
                                            //         controller
                                            //                 .propertyDetailInfo!
                                            //                 .propertyDetails!
                                            //                 .first
                                            //                 .plotNumber ??
                                            //             '',
                                            //         style: AppTextStyle
                                            //             .normalBlack10,
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),
                                            // // Plot Size
                                            // SizedBox(
                                            //   height: 1.5.h,
                                            // ),
                                            // Row(
                                            //   children: [
                                            //     Text(
                                            //       'Plot Size',
                                            //       style: AppTextStyle
                                            //           .semiBoldBlack11,
                                            //     ),
                                            //     Spacer(),
                                            //     Container(
                                            //       alignment:
                                            //           Alignment.centerRight,
                                            //       width: 58.w,
                                            //       child: Text(
                                            //         controller
                                            //                 .propertyDetailInfo!
                                            //                 .propertyDetails!
                                            //                 .first
                                            //                 .plotSize ??
                                            //             '0',
                                            //         style: AppTextStyle
                                            //             .normalBlack10,
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),

                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            controller
                                                            .propertyDetailInfo!
                                                            .propertyDetails!
                                                            .first
                                                            .propertyAddress ==
                                                        '' ||
                                                    controller
                                                            .propertyDetailInfo!
                                                            .propertyDetails!
                                                            .first
                                                            .propertyAddressAR ==
                                                        ''
                                                ? SizedBox()
                                                : Row(
                                                    children: [
                                                      Text(
                                                        AppMetaLabels().address,
                                                        style: AppTextStyle
                                                            .semiBoldBlack11,
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
                                                              ? controller
                                                                      .propertyDetailInfo!
                                                                      .propertyDetails!
                                                                      .first
                                                                      .propertyAddress ??
                                                                  ''
                                                              : controller
                                                                      .propertyDetailInfo!
                                                                      .propertyDetails!
                                                                      .first
                                                                      .propertyAddressAR ??
                                                                  '',
                                                          style: AppTextStyle
                                                              .normalBlack10,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Parking
                                  // Padding(
                                  //   padding: EdgeInsets.only(top: 3.0.h),
                                  //   child: Container(
                                  //     width: 94.0.w,
                                  //     decoration: BoxDecoration(
                                  //       color: Colors.white,
                                  //       borderRadius:
                                  //           BorderRadius.circular(2.0.h),
                                  //       boxShadow: [
                                  //         BoxShadow(
                                  //           color: Colors.black12,
                                  //           blurRadius: 0.5.h,
                                  //           spreadRadius: 0.3.h,
                                  //           offset: Offset(0.1.h, 0.1.h),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     child: Padding(
                                  //       padding: EdgeInsets.all(2.5.h),
                                  //       child: Column(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.start,
                                  //         crossAxisAlignment:
                                  //             CrossAxisAlignment.start,
                                  //         children: [
                                  //           Text('Parking Info',
                                  //               style: AppTextStyle
                                  //                   .semiBoldBlack12
                                  //                   .copyWith(
                                  //                 fontWeight: FontWeight.bold,
                                  //               )),
                                  //           SizedBox(
                                  //             height: 2.h,
                                  //           ),
                                  //           Row(
                                  //             children: [
                                  //               Text(
                                  //                 'No of Parking Lots ',
                                  //                 style: AppTextStyle
                                  //                     .semiBoldBlack11,
                                  //               ),
                                  //               Spacer(),
                                  //               Container(
                                  //                 alignment:
                                  //                     Alignment.centerRight,
                                  //                 width: 42.w,
                                  //                 child: Text(
                                  //                   controller
                                  //                           .propertyDetailInfo!
                                  //                           .propertyDetails!
                                  //                           .first
                                  //                           .noofParkinglot
                                  //                           .toString() ??
                                  //                       '',
                                  //                   style: AppTextStyle
                                  //                       .normalBlack10,
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           ),
                                  //           SizedBox(
                                  //             height: 1.h,
                                  //           ),
                                  //           Row(
                                  //             children: [
                                  //               Text(
                                  //                 'Parking Lot Avaiability',
                                  //                 style: AppTextStyle
                                  //                     .semiBoldBlack11,
                                  //               ),
                                  //               Spacer(),
                                  //               Container(
                                  //                 alignment:
                                  //                     Alignment.centerRight,
                                  //                 width: 42.w,
                                  //                 child: Text(
                                  //                   controller
                                  //                           .propertyDetailInfo!
                                  //                           .propertyDetails!
                                  //                           .first
                                  //                           .parkinglotAvailability ??
                                  //                       '0',
                                  //                   style: AppTextStyle
                                  //                       .normalBlack10,
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           ),
                                  //           SizedBox(
                                  //             height: 1.h,
                                  //           ),
                                  //           Row(
                                  //             children: [
                                  //               Text(
                                  //                 'Rate Per Parking Lot',
                                  //                 style: AppTextStyle
                                  //                     .semiBoldBlack11,
                                  //               ),
                                  //               Spacer(),
                                  //               Container(
                                  //                 alignment:
                                  //                     Alignment.centerRight,
                                  //                 width: 42.w,
                                  //                 child: Text(
                                  //                   controller
                                  //                           .propertyDetailInfo!
                                  //                           .propertyDetails!
                                  //                           .first
                                  //                           .ratePerParkinglot ??
                                  //                       '0',
                                  //                   style: AppTextStyle
                                  //                       .normalBlack10,
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           ),
                                  //           SizedBox(
                                  //             height: 1.h,
                                  //           ),
                                  //           Row(
                                  //             children: [
                                  //               Text(
                                  //                 'Area Size',
                                  //                 style: AppTextStyle
                                  //                     .semiBoldBlack11,
                                  //               ),
                                  //               Spacer(),
                                  //               Container(
                                  //                 alignment:
                                  //                     Alignment.centerRight,
                                  //                 width: 58.w,
                                  //                 child: Text(
                                  //                   controller
                                  //                           .propertyDetailInfo!
                                  //                           .propertyDetails!
                                  //                           .first
                                  //                           .areaSize ??
                                  //                       '0.0',
                                  //                   style: AppTextStyle
                                  //                       .normalBlack10,
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // //  Purchase
                                  // Padding(
                                  //   padding: EdgeInsets.only(top: 3.0.h),
                                  //   child: Container(
                                  //     width: 94.0.w,
                                  //     decoration: BoxDecoration(
                                  //       color: Colors.white,
                                  //       borderRadius:
                                  //           BorderRadius.circular(2.0.h),
                                  //       boxShadow: [
                                  //         BoxShadow(
                                  //           color: Colors.black12,
                                  //           blurRadius: 0.5.h,
                                  //           spreadRadius: 0.3.h,
                                  //           offset: Offset(0.1.h, 0.1.h),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     child: Padding(
                                  //       padding: EdgeInsets.all(2.5.h),
                                  //       child: Column(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.start,
                                  //         crossAxisAlignment:
                                  //             CrossAxisAlignment.start,
                                  //         children: [
                                  //           Row(
                                  //             children: [
                                  //               Text('Purchase Info',
                                  //                   style: AppTextStyle
                                  //                       .semiBoldBlack12
                                  //                       .copyWith(
                                  //                     fontWeight:
                                  //                         FontWeight.bold,
                                  //                   )),
                                  //               Spacer(),
                                  //               Text(
                                  //                   controller
                                  //                           .propertyDetailInfo!
                                  //                           .propertyDetails!
                                  //                           .first
                                  //                           .soldStatus ??
                                  //                       'null',
                                  //                   style: AppTextStyle
                                  //                       .semiBoldBlack12
                                  //                       .copyWith(
                                  //                     fontWeight:
                                  //                         FontWeight.bold,
                                  //                   )),
                                  //             ],
                                  //           ),
                                  //           SizedBox(
                                  //             height: 2.h,
                                  //           ),
                                  //           Row(
                                  //             children: [
                                  //               Text(
                                  //                 'Purchased Price ',
                                  //                 style: AppTextStyle
                                  //                     .semiBoldBlack11,
                                  //               ),
                                  //               Spacer(),
                                  //               Container(
                                  //                 alignment:
                                  //                     Alignment.centerRight,
                                  //                 width: 42.w,
                                  //                 child: Text(
                                  //                   controller
                                  //                           .propertyDetailInfo!
                                  //                           .propertyDetails!
                                  //                           .first
                                  //                           .purchasedPrice ??
                                  //                       '0',
                                  //                   style: AppTextStyle
                                  //                       .normalBlack10,
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           ),
                                  //           SizedBox(
                                  //             height: 1.h,
                                  //           ),
                                  //           Row(
                                  //             children: [
                                  //               Text(
                                  //                 'Purchased Date',
                                  //                 style: AppTextStyle
                                  //                     .semiBoldBlack11,
                                  //               ),
                                  //               Spacer(),
                                  //               Container(
                                  //                 alignment:
                                  //                     Alignment.centerRight,
                                  //                 width: 42.w,
                                  //                 child: Text(
                                  //                   controller
                                  //                           .propertyDetailInfo!
                                  //                           .propertyDetails!
                                  //                           .first
                                  //                           .purchasedDate ??
                                  //                       '0',
                                  //                   style: AppTextStyle
                                  //                       .normalBlack10,
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           ),
                                  //           SizedBox(
                                  //             height: 1.h,
                                  //           ),
                                  //           Row(
                                  //             children: [
                                  //               Text(
                                  //                 'Valuation Price',
                                  //                 style: AppTextStyle
                                  //                     .semiBoldBlack11,
                                  //               ),
                                  //               Spacer(),
                                  //               Container(
                                  //                 alignment:
                                  //                     Alignment.centerRight,
                                  //                 width: 42.w,
                                  //                 child: Text(
                                  //                   controller
                                  //                           .propertyDetailInfo!
                                  //                           .propertyDetails!
                                  //                           .first
                                  //                           .valuationPrice ??
                                  //                       '0',
                                  //                   style: AppTextStyle
                                  //                       .normalBlack10,
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           ),
                                  //           SizedBox(
                                  //             height: 1.h,
                                  //           ),
                                  //           Row(
                                  //             children: [
                                  //               Text(
                                  //                 'Valuation Date',
                                  //                 style: AppTextStyle
                                  //                     .semiBoldBlack11,
                                  //               ),
                                  //               Spacer(),
                                  //               Container(
                                  //                 alignment:
                                  //                     Alignment.centerRight,
                                  //                 width: 42.w,
                                  //                 child: Text(
                                  //                   controller
                                  //                           .propertyDetailInfo!
                                  //                           .propertyDetails!
                                  //                           .first
                                  //                           .valuationDate ??
                                  //                       '0.0',
                                  //                   style: AppTextStyle
                                  //                       .normalBlack10,
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),

                                  SizedBox(
                                    height: 2.h,
                                  )
                                ],
                              );
                  }),
                ),
              ),
              BottomShadow(),
            ],
          ),
        ));
  }
}
