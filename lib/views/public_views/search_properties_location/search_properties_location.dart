import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as Gm;
import 'package:sizer/sizer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui' as ui;
import 'dart:io' as io;
import 'search_properties_location_controller.dart';

class SearchPropertiesLocation extends StatefulWidget {
  const SearchPropertiesLocation({Key? key}) : super(key: key);

  @override
  SearchPropertiesLocationState createState() =>
      SearchPropertiesLocationState();
}

class SearchPropertiesLocationState extends State<SearchPropertiesLocation> {
  // Completer<GoogleMapController> _mapsController = Completer();
  var _locationController = Get.put(PublicLocationController());

  @override
  void initState() {
    _locationController.getLocation();

    super.initState();
  }

  // var anotationList = <Annotation>[];
  // var anotationListMain = <Set<Annotation>>[];
  // Set<Annotation> _createAnnotation() {
  //   var lat;
  //   var lng;

  //   for (int i = 0; i < _locationController.data.value.locationVm!.length; i++) {
  //     if (_locationController.data.value.locationVm![i].lat != 0.0 ||
  //         _locationController.data.value.locationVm![i].lat != null ||
  //         _locationController.data.value.locationVm![i].lng != 0.0 ||
  //         _locationController.data.value.locationVm![i].lng != null) {
  //       lat = _locationController.data.value.locationVm![i].lat ?? 0.0;
  //       lng = _locationController.data.value.locationVm![i].lng ?? 0.0;
  //     } else {
  //       lat = 0.0;
  //       lng = 0.0;
  //     }
  //     anotationList.add(Annotation(
  //         annotationId: AnnotationId("annotation_1"),
  //         position: LatLng(lat, lng),
  //         icon: BitmapDescriptor.markerAnnotation,
  //         infoWindow: InfoWindow(
  //           snippet: SessionController().getLanguage() == 1
  //               ? _locationController.data.value.locationVm![i].address ?? ""
  //               : _locationController.data.value.locationVm![i].address ?? "",
  //           title: SessionController().getLanguage() == 1
  //               ? _locationController.data.value.locationVm![i].title ?? ""
  //               : _locationController.data.value.locationVm![i].titleAr ?? "",
  //         )));
  //   }
  //   print('length ::::: : ${anotationList.length}');
  //   anotationListMain = anotationList.toSet();
  //   return anotationListMain;

  //   // if (_locationController.data.value.locationVm![0].lat != 0.0 ||
  //   //     _locationController.data.value.locationVm![0].lat != null ||
  //   //     _locationController.data.value.locationVm![0].lng != 0.0 ||
  //   //     _locationController.data.value.locationVm![0].lng != null) {
  //   //   lat = _locationController.data.value.locationVm![0].lat ?? 0.0;
  //   //   lng = _locationController.data.value.locationVm![0].lng ?? 0.0;
  //   // } else {
  //   //   lat = 0.0;
  //   //   lng = 0.0;
  //   // }
  //   // return <Annotation>[
  //   //   Annotation(
  //   //       annotationId: AnnotationId("annotation_1"),
  //   //       position: LatLng(lat, lng),
  //   //       icon: BitmapDescriptor.markerAnnotation,
  //   //       infoWindow: InfoWindow(
  //   //         snippet: SessionController().getLanguage() == 1
  //   //             ? _locationController.data.value.locationVm![0].address ?? ""
  //   //             : _locationController.data.value.locationVm![0].address ?? "",
  //   //         title: SessionController().getLanguage() == 1
  //   //             ? _locationController.data.value.locationVm![0].title ?? ""
  //   //             : _locationController.data.value.locationVm![0].titleAr ?? "",
  //   //       )),
  //   // ].toSet();
  // }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? ui.TextDirection.ltr
          : ui.TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: SizedBox(),
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
            centerTitle: true,
            title: Text(
              AppMetaLabels().offices,
              style: AppTextStyle.semiBoldWhite14,
            ),
          ),
          body: Obx(() {
            return _locationController.loading.value
                ? LoadingIndicatorBlue()
                : _locationController.error.value != "" ||
                        _locationController.length.value == 0
                    ? CustomErrorWidget(
                        errorImage: AppImagesPath.noServicesFound,
                        errorText: _locationController.error.value,
                      )
                    : Container(
                        width: 100.0.w,
                        height: 100.0.h,
                        child: ListView.builder(
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          itemCount: _locationController.length.value,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(2.0.h),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(2.0.h),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[200] ?? Colors.grey,
                                      blurRadius: 0.4.h,
                                      spreadRadius: 0.8.h,
                                      offset: Offset(0.1.h, 0.1.h),
                                    ),
                                  ],
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    io.Platform.isAndroid
                                        ? Container(
                                            width: 100.0.w,
                                            height: 25.0.h,
                                            child: Gm.GoogleMap(
                                              initialCameraPosition:
                                                  _locationController
                                                      .data
                                                      .value
                                                      .locationVm![index]
                                                      .cameraPosition!,
                                              myLocationButtonEnabled: false,
                                              zoomControlsEnabled: false,
                                              onMapCreated:
                                                  (Gm.GoogleMapController
                                                      controller) {
                                                // _mapsController.complete(controller);
                                              },
                                              gestureRecognizers: {
                                                Factory<
                                                    OneSequenceGestureRecognizer>(
                                                  () =>
                                                      EagerGestureRecognizer(),
                                                ),
                                              },
                                            ),
                                          )
                                        : Container(
                                            width: 100.0.w,
                                            height: 25.0.h,
                                            child: AppleMap(
                                              initialCameraPosition:
                                                  _locationController
                                                      .data
                                                      .value
                                                      .locationVm![index]
                                                      .cameraPositionAm!,
                                              myLocationButtonEnabled: false,
                                              zoomGesturesEnabled: true,
                                              onMapCreated: (AppleMapController
                                                  controller) {},
                                              gestureRecognizers: {
                                                Factory<
                                                    OneSequenceGestureRecognizer>(
                                                  () =>
                                                      EagerGestureRecognizer(),
                                                ),
                                              },
                                              // annotations:
                                              //     anotationList.toSet()
                                              // annotations:
                                              //     _createAnnotation()
                                            ),
                                          ),
                                    Padding(
                                      padding: EdgeInsets.all(2.0.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            SessionController().getLanguage() ==
                                                    1
                                                ? _locationController
                                                        .data
                                                        .value
                                                        .locationVm![index]
                                                        .title ??
                                                    ""
                                                : _locationController
                                                        .data
                                                        .value
                                                        .locationVm![index]
                                                        .titleAr ??
                                                    "",
                                            style: AppTextStyle.semiBoldBlack12,
                                          ),
                                          SizedBox(
                                            height: 1.0.h,
                                          ),
                                          rowList(
                                              AppMetaLabels().cellNo,
                                              _locationController
                                                      .data
                                                      .value
                                                      .locationVm![index]
                                                      .cellNumber ??
                                                  ""),
                                          SizedBox(
                                            height: 1.0.h,
                                          ),
                                          rowList(
                                              AppMetaLabels().officeTiming,
                                              _locationController
                                                      .data
                                                      .value
                                                      .locationVm![index]
                                                      .officeTiming ??
                                                  ""),
                                          SizedBox(
                                            height: 1.0.h,
                                          ),
                                          AppDivider(),
                                          SizedBox(
                                            height: 1.0.h,
                                          ),
                                          Text(
                                            SessionController().getLanguage() ==
                                                    1
                                                ? _locationController
                                                        .data
                                                        .value
                                                        .locationVm![index]
                                                        .description ??
                                                    ""
                                                : _locationController
                                                        .data
                                                        .value
                                                        .locationVm![index]
                                                        .descriptionAr ??
                                                    "",
                                            style: AppTextStyle.normalGrey10,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
          })),
    );
  }

  Row rowList(String t1, String t2) {
    return Row(
      children: [
        Text(
          t1,
          style: AppTextStyle.normalGrey10,
        ),
        Spacer(),
        SessionController().getLanguage() == 1
            ? SizedBox(
                width: 55.w,
                child: Text(
                  t2,
                  style: AppTextStyle.normalGrey10,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                ),
              )
            : Directionality(
                textDirection: ui.TextDirection.ltr,
                child: SizedBox(
                  width: 55.w,
                  child: Text(
                    t2,
                    style: AppTextStyle.normalGrey10,
                    textAlign: TextAlign.end,
                  ),
                ),
              )
      ],
    );
  }
}
