// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'dart:io' as io;
import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as Gm;
import 'package:intl/intl.dart' as intl;
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../../../data/helpers/session_controller.dart';
import '../../../booking_request/booking_request.dart';
import '../search_properties_result_controller.dart';
import 'get_property_detail_controller.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';

class GetPropertyDetails extends StatefulWidget {
  final int? unitId;
  final int? index;
  GetPropertyDetails({Key? key, this.unitId, this.index}) : super(key: key);

  @override
  State<GetPropertyDetails> createState() => _GetPropertyDetailsState();
}

class _GetPropertyDetailsState extends State<GetPropertyDetails> {
  final Completer<Gm.GoogleMapController> mapsController = Completer();

  final gPDController = Get.put(GetPropertyDetailController());

  final sPRController = Get.put(SearchPropertiesResultController());
  Map<Gm.MarkerId, Gm.Marker> markers = <Gm.MarkerId, Gm.Marker>{};
  // LatLng _center = LatLng(9.669111, 80.014007);
  void onMapCreated(Gm.GoogleMapController controller) {
    // mapController = _mapsController;

    // print("lat log is ===> ${gPDController.data.value.property!.latitude} ====${gPDController.data.value.property!.longitude}");
    final marker = Gm.Marker(
      markerId:
          Gm.MarkerId(gPDController.data.value.property!.propertyName ?? ""),
      position: Gm.LatLng(
          gPDController.data.value.property!.latitude == null
              ? 0.0
              : double.parse(gPDController.data.value.property!.latitude ?? ""),
          gPDController.data.value.property!.longitude == null
              ? 0.0
              : double.parse(
                  gPDController.data.value.property!.longitude ?? "")),
      // icon: BitmapDescriptor.,
      infoWindow: Gm.InfoWindow(
        title: gPDController.data.value.property!.propertyName,
        anchor: Offset(0.5, 0.5),
        //snippet: 'address',
      ),
    );
    setState(() {
      markers[Gm.MarkerId(
          gPDController.data.value.property!.propertyName ?? "")] = marker;
    });
  }

  Set<Annotation> _createAnnotation() {
    var lat = gPDController.data.value.property!.latitude == null
        ? 0.0
        : double.parse(gPDController.data.value.property!.latitude!);
    var lng = gPDController.data.value.property!.longitude == null
        ? 0.0
        : double.parse(gPDController.data.value.property!.longitude!);
    return <Annotation>[
      Annotation(
          annotationId: AnnotationId(
              "${gPDController.data.value.property!.propertyName}"),
          position: LatLng(lat, lng),
          icon: BitmapDescriptor.markerAnnotation,
          infoWindow: InfoWindow(
            snippet: SessionController().getLanguage() == 1
                ? gPDController.data.value.property!.address ?? ""
                : gPDController.data.value.property!.addressAr ?? "",
            title: SessionController().getLanguage() == 1
                ? gPDController.data.value.property!.propertyName ?? ""
                : gPDController.data.value.property!.propertyNameAr ?? "",
          )),
    ].toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final paidFormatter = intl.NumberFormat('#,##0.00', 'AR');
      String price = '';
      if (gPDController.data.value.property! != null)
        price =
            "${AppMetaLabels().aed} ${paidFormatter.format(gPDController.data.value.property!.amount ?? 0.0)}";
      return Directionality(
        textDirection: SessionController().getLanguage() == 1
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
              ),
              iconSize: 2.0.h,
              onPressed: () {
                Get.back();
              },
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(
                    AppImagesPath.appbarimg,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            backgroundColor: Colors.white,
            title: Text(
              AppMetaLabels().propertyDetails,
              style: AppTextStyle.semiBoldWhite14,
            ),
          ),
          body: gPDController.loadingData.value == true
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 3.0.w, vertical: 3.0.h),
                    child: Container(
                      height: 33.0.h,
                      width: 94.0.w,
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
                      child: LoadingIndicatorBlue(),
                    ),
                  ),
                )
              : gPDController.error.value != ''
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 3.0.w, vertical: 3.0.h),
                      child: Container(
                        height: 33.0.h,
                        width: 94.0.w,
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
                        child: AppErrorWidget(
                          errorText: gPDController.error.value,
                        ),
                      ),
                    )
                  : Container(
                      width: 100.0.w,
                      height: 100.0.h,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 1.0.h,
                                  left: 3.0.w,
                                  right: 3.0.w,
                                  bottom: 1.0.h),
                              child: Container(
                                margin: EdgeInsets.only(top: 1.h),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(1.0.h),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2.0.h),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 0.5.h,
                                        spreadRadius: 0.3.h,
                                        offset: Offset(0.0.h, 0.7.h),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 100.0.w,
                                        height: 30.5.h,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(2.0.h),
                                              topRight: Radius.circular(2.0.h),
                                            ),
                                            child: Container(
                                              height: 36.0.h,
                                              width: 100.0.w,
                                              color: Colors.grey[300],
                                              child: StreamBuilder<Uint8List>(
                                                stream:
                                                    sPRController.getUnitImage(
                                                        widget.index!),
                                                builder: (
                                                  BuildContext context,
                                                  AsyncSnapshot<Uint8List>
                                                      snapshot,
                                                ) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                2.0.h),
                                                        topRight:
                                                            Radius.circular(
                                                                2.0.h),
                                                      ),
                                                      child: SizedBox(
                                                        height: 36.0.h,
                                                        width: 100.0.w,
                                                        child:
                                                            Shimmer.fromColors(
                                                          baseColor: Colors.grey
                                                              .withOpacity(0.1),
                                                          highlightColor: Colors
                                                              .grey
                                                              .withOpacity(0.5),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      2.0.h),
                                                              topRight: Radius
                                                                  .circular(
                                                                      2.0.h),
                                                            ),
                                                            child: Image.asset(
                                                                AppImagesPath
                                                                    .thumbnail,
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  if (snapshot.hasData) {
                                                    return Image.memory(
                                                        snapshot.data!,
                                                        fit: BoxFit.cover);
                                                  } else {
                                                    return Center(
                                                        child: Icon(
                                                            Icons.ac_unit));
                                                  }
                                                },
                                              ),
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(2.0.h),
                                        child: Container(
                                          // height: 13.0.h,
                                          // color: Colors.red,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 90.0.w,
                                                child: Text(
                                                  SessionController()
                                                              .getLanguage() ==
                                                          1
                                                      ? gPDController
                                                              .data
                                                              .value
                                                              .property!
                                                              .propertyName ??
                                                          ""
                                                      : gPDController
                                                              .data
                                                              .value
                                                              .property!
                                                              .propertyNameAr ??
                                                          "",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextStyle
                                                      .semiBoldBlack12,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.0.h,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    AppMetaLabels().unitRefNo,
                                                    style: AppTextStyle
                                                        .semiBoldBlack10,
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    gPDController.data.value
                                                        .property!.unitRefNo!,
                                                    style: AppTextStyle
                                                        .semiBoldBlack10,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 1.0.h,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    AppMetaLabels().targetRent,
                                                    style: AppTextStyle
                                                        .semiBoldBlack10,
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    price,
                                                    style: AppTextStyle
                                                        .semiBoldBlack10,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 1.0.h,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                    241,
                                                    248,
                                                    252,
                                                    0.1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          1.0.h),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 1.2.h),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      columnList(
                                                        AppMetaLabels()
                                                            .unitCategory,
                                                        SessionController()
                                                                    .getLanguage() ==
                                                                1
                                                            ? gPDController
                                                                    .data
                                                                    .value
                                                                    .property!
                                                                    .unitCategoryName ??
                                                                ""
                                                            : gPDController
                                                                    .data
                                                                    .value
                                                                    .property!
                                                                    .unitCategoryNameAr ??
                                                                "",
                                                      ),
                                                      columnList(
                                                        AppMetaLabels()
                                                            .unitType,
                                                        SessionController()
                                                                    .getLanguage() ==
                                                                1
                                                            ? gPDController
                                                                    .data
                                                                    .value
                                                                    .property!
                                                                    .unitType ??
                                                                ""
                                                            : gPDController
                                                                    .data
                                                                    .value
                                                                    .property!
                                                                    .unitTypeAR ??
                                                                "",
                                                      ),
                                                      columnList(
                                                        AppMetaLabels()
                                                            .unitView,
                                                        SessionController()
                                                                    .getLanguage() ==
                                                                1
                                                            ? gPDController
                                                                    .data
                                                                    .value
                                                                    .property!
                                                                    .unitView ??
                                                                ""
                                                            : gPDController
                                                                    .data
                                                                    .value
                                                                    .property!
                                                                    .unitViewAR ??
                                                                "",
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              // SizedBox(
                                              //   height: 1.0.h,
                                              // ),
                                              // Row(
                                              //   children: [
                                              //     Container(
                                              //       decoration: BoxDecoration(
                                              //         color: Color.fromRGBO(
                                              //             72, 88, 106, 1),
                                              //         shape: BoxShape.circle,
                                              //       ),
                                              //       child: Padding(
                                              //         padding:
                                              //             EdgeInsets.all(1.5.h),
                                              //         child: Text(
                                              //           gPDController
                                              //               .data
                                              //               .value
                                              //               .property!
                                              //               .landlordName[0],
                                              //           style: AppTextStyle
                                              //               .semiBoldWhite14,
                                              //         ),
                                              //       ),
                                              //     ),
                                              //     Padding(
                                              //       padding: EdgeInsets.only(
                                              //           left: 1.5.h),
                                              //       child: Column(
                                              //         crossAxisAlignment:
                                              //             CrossAxisAlignment
                                              //                 .start,
                                              //         children: [
                                              //           Text(
                                              //             gPDController
                                              //                     .data
                                              //                     .value
                                              //                     .property!
                                              //                     .landlordName ??
                                              //                 "",
                                              //             style: AppTextStyle
                                              //                 .semiBoldBlack12,
                                              //           ),
                                              //           Text(
                                              //             AppMetaLabels()
                                              //                 .landLord,
                                              //             style: AppTextStyle
                                              //                 .normalGrey10,
                                              //           ),
                                              //         ],
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                              if (gPDController
                                                      .data
                                                      .value
                                                      .property!
                                                      .unitCategoryName ==
                                                  'Residential')
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 2.h),
                                                  decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          247, 247, 247, 1),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      2.h),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      2.h))),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(2.0.h),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: containerList(
                                                                  AppMetaLabels()
                                                                      .bedRooms,
                                                                  gPDController
                                                                      .data
                                                                      .value
                                                                      .property!
                                                                      .bedRooms
                                                                      .toString(),
                                                                  alignment:
                                                                      CrossAxisAlignment
                                                                          .start),
                                                            ),
                                                            Expanded(
                                                              child: containerList(
                                                                  AppMetaLabels()
                                                                      .kitchens,
                                                                  gPDController
                                                                      .data
                                                                      .value
                                                                      .property!
                                                                      .noofKitchens
                                                                      .toString(),
                                                                  alignment:
                                                                      CrossAxisAlignment
                                                                          .center),
                                                            ),
                                                            Expanded(
                                                              child: containerList(
                                                                  AppMetaLabels()
                                                                      .maidRooms,
                                                                  gPDController
                                                                      .data
                                                                      .value
                                                                      .property!
                                                                      .maidRooms
                                                                      .toString(),
                                                                  alignment:
                                                                      CrossAxisAlignment
                                                                          .end),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 1.5.h,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: containerList(
                                                                  AppMetaLabels()
                                                                      .livingRooms,
                                                                  gPDController
                                                                      .data
                                                                      .value
                                                                      .property!
                                                                      .noofLivingRooms
                                                                      .toString(),
                                                                  alignment:
                                                                      CrossAxisAlignment
                                                                          .start),
                                                            ),
                                                            Expanded(
                                                              child: containerList(
                                                                  AppMetaLabels()
                                                                      .balconies,
                                                                  gPDController
                                                                      .data
                                                                      .value
                                                                      .property!
                                                                      .noofBalconies
                                                                      .toString(),
                                                                  alignment:
                                                                      CrossAxisAlignment
                                                                          .center),
                                                            ),
                                                            Expanded(
                                                              child: containerList(
                                                                  AppMetaLabels()
                                                                      .washrooms,
                                                                  gPDController
                                                                      .data
                                                                      .value
                                                                      .property!
                                                                      .noofWashrooms
                                                                      .toString(),
                                                                  alignment:
                                                                      CrossAxisAlignment
                                                                          .end),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            2.0.h, 0, 2.h, 2.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 1.5.h,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 15.0.w,
                                                  child: Image.asset(
                                                    AppImagesPath.view360,
                                                  ),
                                                ),
                                                Text(
                                                  AppMetaLabels()
                                                      .discoverVirtualApartment,
                                                  style: AppTextStyle
                                                      .semiBoldBlue10,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 1.5.h,
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 1.0.h),
                                              child: Text(
                                                AppMetaLabels().location,
                                                style: AppTextStyle
                                                    .semiBoldBlack11,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 1.5.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  size: 3.0.h,
                                                  color: AppColors.blackColor,
                                                ),
                                                Container(
                                                  width: 70.0.w,
                                                  child: Text(
                                                    SessionController()
                                                                .getLanguage() ==
                                                            1
                                                        ? gPDController
                                                                .data
                                                                .value
                                                                .property!
                                                                .address
                                                                .toString() 
                                                        : gPDController
                                                                .data
                                                                .value
                                                                .property!
                                                                .addressAr
                                                                .toString(),
                                                    style: AppTextStyle
                                                        .normalBlack10,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 1.5.h,
                                            ),
                                            io.Platform.isAndroid
                                                ? Container(
                                                    width: 100.0.w,
                                                    height: 20.0.h,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    2.0.h)),
                                                    clipBehavior: Clip.hardEdge,
                                                    child: Gm.GoogleMap(
                                                      initialCameraPosition:
                                                          gPDController
                                                              .cameraPosition,
                                                      myLocationButtonEnabled:
                                                          false,
                                                      onMapCreated:
                                                          onMapCreated,
                                                      gestureRecognizers: {
                                                        Factory<
                                                            OneSequenceGestureRecognizer>(
                                                          () =>
                                                              EagerGestureRecognizer(),
                                                        ),
                                                      },
                                                      markers: markers.values
                                                          .toSet(),
                                                    ),
                                                  )
                                                : Container(
                                                    width: 100.0.w,
                                                    height: 20.0.h,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    2.0.h)),
                                                    clipBehavior: Clip.hardEdge,
                                                    child: AppleMap(
                                                      initialCameraPosition:
                                                          gPDController
                                                              .kApplePlex,
                                                      myLocationButtonEnabled:
                                                          false,
                                                      onMapCreated:
                                                          (AppleMapController
                                                              controller) {},
                                                      annotations:
                                                          _createAnnotation(),
                                                    ),
                                                  ),
                                            SizedBox(
                                              height: 7.0.h,
                                            ),
                                            Container(
                                              height: 6.0.h,
                                              width: 100.0.w,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.0.h)),
                                              clipBehavior: Clip.hardEdge,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color.fromRGBO(
                                                          0, 61, 166, 1),
                                                ),
                                                onPressed: () async {
                                                  Get.to(() => BookingRequest(
                                                        property: gPDController
                                                            .data
                                                            .value
                                                            .property!,
                                                        index: widget.index,
                                                      ));
                                                },
                                                child: Text(
                                                  AppMetaLabels().reqBooking,
                                                  style: AppTextStyle
                                                      .semiBoldWhite12,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 1.5.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
        ),
      );
    });
  }

  Column columnList(String date, String dateValue) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 0.5.h),
          child: Text(
            date,
            style: AppTextStyle.normalBlack10,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 1.0.h),
          child: Text(
            dateValue,
            style: AppTextStyle.semiBoldBlack10,
          ),
        ),
      ],
    );
  }

  Widget containerList(String text1, String text2,
      {CrossAxisAlignment alignment = CrossAxisAlignment.center}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: alignment,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 0.5.h),
          child: Text(
            text1,
            style: AppTextStyle.normalBlack11,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 0.6.h),
          child: Text(
            text2,
            style: AppTextStyle.semiBoldBlack10,
          ),
        ),
      ],
    );
  }
}
