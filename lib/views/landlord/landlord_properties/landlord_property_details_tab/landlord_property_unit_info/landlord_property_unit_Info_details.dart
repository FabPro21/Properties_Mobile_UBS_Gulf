import 'dart:io';

import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/landlord/landlord_properties/landlord_property_details_tab/landlord_property_detail_tab_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as Gm;
import 'package:sizer/sizer.dart';

class LandlordPropertyUnitInfoDetails extends StatefulWidget {
  final String unitID;
  const LandlordPropertyUnitInfoDetails({Key key, this.unitID})
      : super(key: key);

  @override
  _LandlordPropertyUnitInfoDetailsState createState() =>
      _LandlordPropertyUnitInfoDetailsState();
}

class _LandlordPropertyUnitInfoDetailsState
    extends State<LandlordPropertyUnitInfoDetails> {
  LandlordPropertiesTabDetailController controller =
      Get.put(LandlordPropertiesTabDetailController());

  double mapHeight = 0.0;
  Map<Gm.MarkerId, Gm.Marker> markers = <Gm.MarkerId, Gm.Marker>{};

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initFuncCall();
    });
    super.initState();
  }

  initFuncCall() async {
    print('Widget unit ID :: ${widget.unitID}');
    await controller.getPropertyUnitDetail(widget.unitID);
    setState(() {});
  }

  Set<Annotation> _createAnnotation() {
    var lat;
    var lng;
    if (controller.propertyUnitDetailModel.propertyUnitDetails.first.latitude !=
            "" &&
        controller
                .propertyUnitDetailModel.propertyUnitDetails.first.longitude !=
            "") {
      lat = double.parse(controller
              .propertyUnitDetailModel.propertyUnitDetails.first.latitude) ??
          0.0;
      lng = double.parse(controller
              .propertyUnitDetailModel.propertyUnitDetails.first.longitude) ??
          0.0;
    } else {
      lat = 0.0;
      lng = 0.0;
    }
    return <Annotation>[
      Annotation(
          annotationId: AnnotationId("annotation_1"),
          position: LatLng(lat, lng),
          icon: BitmapDescriptor.markerAnnotation,
          infoWindow: InfoWindow(
            snippet: SessionController().getLanguage() == 1
                ? controller.propertyUnitDetailModel.propertyUnitDetails.first
                        .address ??
                    ""
                : controller.propertyUnitDetailModel.propertyUnitDetails.first
                        .addressAR ??
                    "",
            title: SessionController().getLanguage() == 1
                ? controller.propertyUnitDetailModel.propertyUnitDetails.first
                        .propertyName ??
                    ""
                : controller.propertyUnitDetailModel.propertyUnitDetails.first
                        .propertyNameAR ??
                    "",
          )),
    ].toSet();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.propertyUnitDetailModel.propertyUnitDetails != null) {
      if (controller.loadingPropertiesUnitDetail.value == false) {
        if (controller.propertyUnitDetailModel.propertyUnitDetails.first
                .unitCategoryName ==
            'Residential') {
          mapHeight = 30;
        }
        if (controller.propertyUnitDetailModel.propertyUnitDetails.first
                .unitCategoryName ==
            'Commercial') {
          mapHeight = 40;
        }

        var lat;
        var lng;
        if (controller.propertyUnitDetailModel.propertyUnitDetails.first
                    .latitude !=
                "" &&
            controller.propertyUnitDetailModel.propertyUnitDetails.first
                    .longitude !=
                "") {
          lat = double.parse(controller
              .propertyUnitDetailModel.propertyUnitDetails.first.latitude);
          lng = double.parse(controller
              .propertyUnitDetailModel.propertyUnitDetails.first.longitude);
        } else {
          lat = 0.0;
          lng = 0.0;
        }
        _createAnnotation();
        final marker = Gm.Marker(
          markerId: Gm.MarkerId('Hello'),
          position: Gm.LatLng(lat, lng),
          // icon: BitmapDescriptor.,
          infoWindow: Gm.InfoWindow(
            title: SessionController().getLanguage() == 1
                ? controller.propertyUnitDetailModel.propertyUnitDetails.first
                        .address ??
                    ""
                : controller.propertyUnitDetailModel.propertyUnitDetails.first
                        .addressAR ??
                    "",
            snippet: SessionController().getLanguage() == 1
                ? controller.propertyUnitDetailModel.propertyUnitDetails.first
                        .propertyName ??
                    ""
                : controller.propertyUnitDetailModel.propertyUnitDetails.first
                        .propertyNameAR ??
                    "",
          ),
        );
        setState(() {
          markers[Gm.MarkerId('place_name')] = marker;
        });
        setState(() {});
      }
    }

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
              AppMetaLabels().propertyDetailsLand,
              style: AppTextStyle.semiBoldWhite14,
            ),
          ),
          body: SingleChildScrollView(child: Obx(() {
            return SizedBox(
                height: controller.loadingPropertiesUnitDetail.value == true
                    ? 70.h
                    : 100.h,
                child: controller.loadingPropertiesUnitDetail.value == true
                    ? LoadingIndicatorBlue()
                    : controller.errorLoadingPropertiesUnitDetail.value != ''
                        ? SizedBox(
                            height: 60.h,
                            child: Center(
                              child: CustomErrorWidget(
                                errorText: controller
                                    .errorLoadingPropertiesUnitDetail.value,
                                errorImage: AppImagesPath.noContractsFound,
                              ),
                            ),
                          )
                        : controller.propertyUnitDetailModel
                                    .propertyUnitDetails ==
                                null
                            ? SizedBox()
                            : Column(
                                children: [
                                  Flexible(
                                    child: Container(
                                      width: 100.0.w,
                                      height: 100.0.h,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 1.0.h,
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: 1.0.h,
                                                    left: 3.0.w,
                                                    right: 3.0.w,
                                                    bottom: 1.0.h),
                                                child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: 1.h),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              1.0.h),
                                                    ),
                                                    child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      2.0.h),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black12,
                                                              blurRadius: 0.5.h,
                                                              spreadRadius:
                                                                  0.3.h,
                                                              offset: Offset(
                                                                  0.0.h, 0.7.h),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(2.0
                                                                            .h),
                                                                child:
                                                                    Container(
                                                                  // height: 13.0.h,
                                                                  // color: Colors.red,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            90.0.w,
                                                                        child:
                                                                            Text(
                                                                          SessionController().getLanguage() == 1
                                                                              ? controller.propertyUnitDetailModel.propertyUnitDetails.first.propertyName ?? ''
                                                                              : controller.propertyUnitDetailModel.propertyUnitDetails.first.propertyNameAR ?? '',
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              AppTextStyle.semiBoldBlack12,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            0.5.h,
                                                                      ),
                                                                      Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color.fromRGBO(
                                                                            241,
                                                                            248,
                                                                            252,
                                                                            0.1,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(1.0.h),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.only(top: 1.2.h),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              SizedBox(
                                                                                width: 24.w,
                                                                                child: Center(
                                                                                  child: columnList(
                                                                                    AppMetaLabels().unitCatgLand,
                                                                                    SessionController().getLanguage() == 1 ? controller.propertyUnitDetailModel.propertyUnitDetails.first.unitCategoryName ?? '' : controller.propertyUnitDetailModel.propertyUnitDetails.first.unitCategoryNameAR ?? '',
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 24.w,
                                                                                child: Center(
                                                                                  child: columnList(
                                                                                    AppMetaLabels().unitTypeLand,
                                                                                    SessionController().getLanguage() == 1 ? controller.propertyUnitDetailModel.propertyUnitDetails.first.unitType ?? '' : controller.propertyUnitDetailModel.propertyUnitDetails.first.unitTypeAR ?? '',
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 24.w,
                                                                                child: Center(
                                                                                  child: columnList(
                                                                                    AppMetaLabels().unitView,
                                                                                    SessionController().getLanguage() == 1 ? controller.propertyUnitDetailModel.propertyUnitDetails.first.unitView ?? '' : controller.propertyUnitDetailModel.propertyUnitDetails.first.unitViewAR ?? '',
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            2.0.h,
                                                                      ),
                                                                      if (controller
                                                                              .propertyUnitDetailModel
                                                                              .propertyUnitDetails
                                                                              .first
                                                                              .unitCategoryName ==
                                                                          'Residential')
                                                                        Container(
                                                                          margin:
                                                                              EdgeInsets.only(top: 2.h),
                                                                          decoration: BoxDecoration(
                                                                              color: Color.fromRGBO(247, 247, 247, 1),
                                                                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(2.h), bottomRight: Radius.circular(2.h))),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.all(2.0.h),
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                      child: containerList(AppMetaLabels().bedRoomsLand, controller.propertyUnitDetailModel.propertyUnitDetails.first.bedRooms.toString(), alignment: CrossAxisAlignment.start),
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: containerList(AppMetaLabels().kitchenLand, controller.propertyUnitDetailModel.propertyUnitDetails.first.noofKitchens.toString(), alignment: CrossAxisAlignment.center),
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: containerList(AppMetaLabels().maidRoomsLand, controller.propertyUnitDetailModel.propertyUnitDetails.first.maidRooms.toString(), alignment: CrossAxisAlignment.end),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 1.5.h,
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                      child: containerList(AppMetaLabels().livingRoomsLand, controller.propertyUnitDetailModel.propertyUnitDetails.first.noofLivingRooms.toString(), alignment: CrossAxisAlignment.start),
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: containerList(AppMetaLabels().balconiesLand, controller.propertyUnitDetailModel.propertyUnitDetails.first.noofBalconies.toString(), alignment: CrossAxisAlignment.center),
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: containerList(AppMetaLabels().washRoomsLand, controller.propertyUnitDetailModel.propertyUnitDetails.first.noofWashrooms.toString(), alignment: CrossAxisAlignment.end),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      SizedBox(
                                                                          height: controller.propertyUnitDetailModel.propertyUnitDetails.first.unitCategoryName != 'Residential'
                                                                              ? 2.h
                                                                              : 0),
                                                                      if (controller
                                                                              .propertyUnitDetailModel
                                                                              .propertyUnitDetails
                                                                              .first
                                                                              .unitCategoryName ==
                                                                          'Commercial')
                                                                        Column(
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                Expanded(
                                                                                  child: SizedBox(
                                                                                    width: 18.w,
                                                                                    child: columnList(
                                                                                        AppMetaLabels().areaSize,
                                                                                        "${controller.propertyUnitDetailModel.propertyUnitDetails.first.areaSize} ${SessionController().getLanguage() == 1 ? controller.propertyUnitDetailModel.propertyUnitDetails.first.measurementType : controller.propertyUnitDetailModel.propertyUnitDetails.first.measurementType.contains('SQM') ? " المساحة بالمتر المربع" : "المساحة بالقدم المربع"} "),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ])))),
                                            Padding(
                                              padding: EdgeInsets.all(2.0.h),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 1.0.h),
                                                    child: Align(
                                                      alignment: SessionController()
                                                                  .getLanguage() ==
                                                              1
                                                          ? Alignment.centerLeft
                                                          : Alignment
                                                              .centerRight,
                                                      child: Text(
                                                        AppMetaLabels()
                                                            .location,
                                                        style: AppTextStyle
                                                            .semiBoldBlack12,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 1.5.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .location_on_outlined,
                                                        size: 3.0.h,
                                                        color: AppColors
                                                            .blackColor,
                                                      ),
                                                      Container(
                                                        width: 70.0.w,
                                                        child: Text(
                                                          SessionController()
                                                                      .getLanguage() ==
                                                                  1
                                                              ? controller
                                                                      .propertyUnitDetailModel
                                                                      .propertyUnitDetails
                                                                      .first
                                                                      .address ??
                                                                  ""
                                                              : controller
                                                                      .propertyUnitDetailModel
                                                                      .propertyUnitDetails
                                                                      .first
                                                                      .addressAR ??
                                                                  "",
                                                          style: AppTextStyle
                                                              .normalBlack10,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 1.5.h,
                                                  ),
                                                  Platform.isAndroid
                                                      ? Container(
                                                          width: 100.0.w,
                                                          height: mapHeight.h,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          2.0.h)),
                                                          clipBehavior:
                                                              Clip.hardEdge,
                                                          child: Gm.GoogleMap(
                                                            initialCameraPosition:
                                                                controller
                                                                    .kGooglePlex,
                                                            myLocationButtonEnabled:
                                                                false,
                                                            onMapCreated: (Gm
                                                                    .GoogleMapController
                                                                controller) {},
                                                            markers: markers
                                                                .values
                                                                .toSet(),
                                                          ),
                                                        )
                                                      : Container(
                                                          width: 100.0.w,
                                                          height: mapHeight.h,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          2.0.h)),
                                                          clipBehavior:
                                                              Clip.hardEdge,
                                                          child: AppleMap(
                                                            initialCameraPosition:
                                                                controller
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
                              ));
          })),
        ));
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
            maxLines: 2,
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
