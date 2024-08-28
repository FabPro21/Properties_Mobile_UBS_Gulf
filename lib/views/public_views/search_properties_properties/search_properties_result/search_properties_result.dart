import 'dart:typed_data';

import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/screen_disable.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import 'get_property_detail/get_property_detail.dart';
import 'search_properties_result_controller.dart';

class SearchPropertiesResult extends StatefulWidget {
  final String? propName;
  final String? minRent;
  final String? maxRent;
  final String? minArea;
  final String? maxArea;

  final String? minRoom;
  final String? maxRoom;
  final String? areaType;
  const SearchPropertiesResult(
      {Key? key,
      this.propName,
      this.minRent,
      this.maxRent,
      this.minArea,
      this.maxArea,
      this.areaType,
      this.minRoom,
      this.maxRoom})
      : super(key: key);

  @override
  _SearchPropertiesResultState createState() => _SearchPropertiesResultState();
}

class _SearchPropertiesResultState extends State<SearchPropertiesResult>
    with SingleTickerProviderStateMixin {
  final sPRController = Get.put(SearchPropertiesResultController());
  AnimationController? _controller;
  Stream<Uint8List>? stream;

  _getData() async {
    await sPRController.getDataPagination(
        widget.propName??"",
        widget.minRent,
        widget.maxRent,
        widget.areaType,
        widget.minArea,
        widget.maxArea,
        widget.minRoom,
        widget.maxRoom,
        sPRController.pageNo);
    // await sPRController.getData(
    //     widget.propName,
    //     widget.minRent,
    //     widget.maxRent,
    //     widget.areaType,
    //     widget.minArea,
    //     widget.maxArea,
    //     widget.minRoom,
    //     widget.maxRoom,
    //     pagenum.toString());
  }

  @override
  void initState() {
    print('Inside Init :::::::');
    print(widget.propName);
    print(widget.minRent);
    print(widget.maxRent);
    print(widget.areaType);
    print(widget.minArea);
    print(widget.maxArea);
    print(widget.minRoom);
    print(widget.maxRoom);
    _getData();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Directionality(
        textDirection: SessionController().getLanguage() == 1
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
              ),
              iconSize: 2.0.h,
              onPressed: () {
                sPRController.pageNo = '1';
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
              AppMetaLabels().properties,
              style: AppTextStyle.semiBoldWhite14,
            ),
            actions: [
              Obx(
                () {
                  return sPRController.error.value != ''
                      ? SizedBox()
                      : IconButton(
                          tooltip: 'Sort by rent',
                          onPressed: () {
                            if (sPRController.sortedBy == 'asc')
                              _controller!.forward();
                            else
                              _controller!.reverse();
                            sPRController.sortList();
                          },
                          icon: RotationTransition(
                            turns: Tween(begin: 0.0, end: 0.5)
                                .animate(_controller!),
                            child: Icon(Icons.sort),
                          ),
                        );
                },
              )
            ],
          ),
          body: sPRController.loadingData.value == true
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
                            color: Colors.grey[200]??Colors.grey,
                            blurRadius: 0.4.h,
                            spreadRadius: 0.1.h,
                            offset: Offset(0.1.h, 0.1.h),
                          ),
                        ],
                      ),
                      child: LoadingIndicatorBlue(),
                    ),
                  ),
                )
              : sPRController.error.value != ''
                  ? Align(
                    alignment: Alignment.center,
                    child: Container(
                        height: 33.0.h,
                        width: 94.0.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.0.w, vertical: 3.0.h),
                        margin: EdgeInsets.symmetric(
                            horizontal: 3.0.w, vertical: 3.0.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(1.0.h),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[200]??Colors.grey,
                              blurRadius: 1.0.h,
                              spreadRadius: 0.6.h,
                              offset: Offset(0.0.h, 0.7.h),
                            ),
                          ],
                        ),
                        child: CustomErrorWidget(
                          errorText: AppMetaLabels().noPropertiesFound,
                          errorImage: AppImagesPath.noServicesFound,
                        ),
                      ),
                  )
                  : Stack(
                      children: [
                        SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(2.0.h),
                            child: Container(
                              width: 100.0.w,
                              padding: EdgeInsets.only(top: 1.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2.0.h),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[200]??Colors.grey,
                                    blurRadius: 0.5.h,
                                    spreadRadius: 0.8.h,
                                    offset: Offset(0.1.h, 0.1.h),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: sPRController.properties.length,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      final paidFormatter =
                                          intl.NumberFormat('#,##0.00', 'AR');
                                      String? rent =
                                          "${AppMetaLabels().aed} ${paidFormatter.format(sPRController.properties[index].rentPerAnnumMin ?? 0.0)}";
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            left: 2.0.h, right: 0.0.h),
                                        child: InkWell(
                                          onTap: () {
                                            SessionController().setPropId(
                                              sPRController
                                                  .properties[index].unitID
                                                  .toString(),
                                            );
                                            Get.to(() => GetPropertyDetails(
                                                  unitId: sPRController
                                                      .properties[index].unitID,
                                                  index: index,
                                                ));
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
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
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1.0.h),
                                                    child: Container(
                                                      width: 19.0.w,
                                                      height: 11.0.h,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    1.0.h),
                                                      ),
                                                      child: StreamBuilder<
                                                          Uint8List>(
                                                        stream: sPRController
                                                            .getPropertyImageN1(
                                                                sPRController
                                                                    .properties[
                                                                        index]
                                                                    .propertyId),
                                                        builder: (
                                                          BuildContext context,
                                                          AsyncSnapshot<
                                                                  Uint8List>
                                                              snapshot,
                                                        ) {
                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .waiting) {
                                                            return SizedBox(
                                                              width: 19.0.w,
                                                              height: 11.0.h,
                                                              child: Shimmer
                                                                  .fromColors(
                                                                baseColor: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.2),
                                                                highlightColor:
                                                                    Colors.grey
                                                                        .withOpacity(
                                                                            0.5),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              2.h),
                                                                  child: Image
                                                                      .asset(
                                                                    AppImagesPath
                                                                        .thumbnail,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          if (snapshot
                                                              .hasData) {
                                                            return Image.memory(
                                                                snapshot.data!,
                                                                fit: BoxFit
                                                                    .cover);
                                                          } else {
                                                            return Center(
                                                                child: Icon(Icons
                                                                    .ac_unit));
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 1.0.h,
                                                        bottom: 1.h,
                                                        right: 1.0.h),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          // color: Colors.red,
                                                          width: 59.0.w,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                SessionController()
                                                                            .getLanguage() ==
                                                                        1
                                                                    ? sPRController
                                                                            .properties[
                                                                                index]
                                                                            .propertyName ??
                                                                        ""
                                                                    : sPRController
                                                                            .properties[index]
                                                                            .propertyNameAr ??
                                                                        "",
                                                                style: AppTextStyle
                                                                    .semiBoldBlack11,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              SizedBox(
                                                                height: 1.0.h,
                                                              ),
                                                              Text(
                                                                "${AppMetaLabels().unit}: ${sPRController.properties[index].unitRefNo}",
                                                                style: AppTextStyle
                                                                    .semiBoldGrey10,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              SizedBox(
                                                                height: 1.0.h,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .location_on_outlined,
                                                                    color: AppColors
                                                                        .greyColor,
                                                                    size: 2.5.h,
                                                                  ),
                                                                  Container(
                                                                    width:
                                                                        50.0.w,
                                                                    child: Text(
                                                                      SessionController().getLanguage() ==
                                                                              1
                                                                          ? sPRController.properties[index].address ??
                                                                              ""
                                                                          : sPRController.properties[index].addressAr ??
                                                                              "",
                                                                      style: AppTextStyle
                                                                          .normalGrey10,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 1.2.h,
                                                              ),
                                                              // Residentail and Commercial
                                                              Container(
                                                                // color: Colors.red,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    sPRController.properties[index].bedRooms.toString() !=
                                                                            0.toString()
                                                                        ? SizedBox(
                                                                            width:
                                                                                16.w,
                                                                            child:
                                                                                columnList(AppMetaLabels().beds, "${sPRController.properties[index].bedRooms ?? ""}"),
                                                                          )
                                                                        : SizedBox(),
                                                                    sPRController.properties[index].bath.toString() !=
                                                                            0.toString()
                                                                        ? SizedBox(
                                                                            width:
                                                                                16.w,
                                                                            child:
                                                                                columnList(AppMetaLabels().bath, "${sPRController.properties[index].bath ?? ""}"),
                                                                          )
                                                                        : SizedBox(),
                                                                    sPRController.properties[index].areaSize !=
                                                                            0.00
                                                                        ? SizedBox(
                                                                            width:
                                                                                25.w,
                                                                            child:
                                                                                columnList(sPRController.properties[index].uom, "${sPRController.properties[index].areaSize}"),
                                                                          )
                                                                        : SizedBox(),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: sPRController.properties[index].bedRooms.toString() != 0.toString() &&
                                                                        sPRController.properties[index].bath.toString() !=
                                                                            0
                                                                                .toString() &&
                                                                        sPRController.properties[index].areaSize !=
                                                                            0.00
                                                                    ? 0.h
                                                                    : 1.5.h,
                                                              ),
                                                              // rent amount
                                                              SizedBox(
                                                                width: 25.w,
                                                                child: columnList(
                                                                    AppMetaLabels()
                                                                        .rent,
                                                                    rent,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 1.0.h,
                                                                  left: 0.5.h),
                                                          child: SizedBox(
                                                            width: 0.15.w,
                                                            child: Icon(
                                                              Icons
                                                                  .arrow_forward_ios_rounded,
                                                              color: AppColors
                                                                  .grey1,
                                                              size: 20,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              index ==
                                                      sPRController.properties
                                                              .length -
                                                          1
                                                  ? SizedBox()
                                                  : AppDivider(),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  sPRController.properties.length < 6
                                      ? SizedBox()
                                      : Container(
                                          width: 90.w,
                                          height: 5.h,
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Spacer(),
                                                Obx(() {
                                                  return sPRController
                                                              .noMoreDataError
                                                              .value !=
                                                          ''
                                                      ? Text(
                                                          AppMetaLabels()
                                                              .noMoreData,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      : InkWell(
                                                          onTap: () async {
                                                            int pageSize =
                                                                int.parse(
                                                                    sPRController
                                                                        .pageNo);
                                                            int naePageNo =
                                                                pageSize + 1;
                                                            sPRController
                                                                    .pageNo =
                                                                naePageNo
                                                                    .toString();
                                                            await sPRController
                                                                .getDataPaginationLoadMore(
                                                                    widget
                                                                        .propName??"",
                                                                    widget
                                                                        .minRent,
                                                                    widget
                                                                        .maxRent,
                                                                    widget
                                                                        .areaType,
                                                                    widget
                                                                        .minArea,
                                                                    widget
                                                                        .maxArea,
                                                                    widget
                                                                        .minRoom,
                                                                    widget
                                                                        .maxRoom,
                                                                    sPRController
                                                                        .pageNo);

                                                            setState(() {});
                                                          },
                                                          child: SizedBox(
                                                              height: 3.h,
                                                              child: RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text: AppMetaLabels()
                                                                          .loadMoreData,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .blue,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    WidgetSpan(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .arrow_forward_ios,
                                                                        size:
                                                                            15,
                                                                        color: Colors
                                                                            .blue,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )),
                                                        );
                                                }),
                                                SizedBox(
                                                  width: 5,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 4.0.h),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 6.0.h,
                                  width: 30.0.w,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.white, // background
                                      // onPrimary: Colors.yellow, // foreground
                                    ),
                                    onPressed: () async {
                                      Get.back();
                                      // Get.to(() => SearchPropertiesFilter());
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.format_align_center,
                                          size: 2.0.h,
                                          color: Colors.black,
                                        ),
                                        Text(
                                          AppMetaLabels().filter,
                                          style: AppTextStyle.semiBoldBlack11,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // InkWell(
                                //   onTap: () {
                                //   },
                                //   child: Container(
                                //     height: 6.0.h,
                                //     width: 25.0.w,
                                //     decoration: BoxDecoration(
                                //         color: Color.fromRGBO(0, 98, 255, 1),
                                //         borderRadius:
                                //             BorderRadius.circular(100.0.h)),
                                //     child: Row(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.spaceEvenly,
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.center,
                                //       children: [
                                //         Icon(
                                //           Icons.location_on_outlined,
                                //           size: 3.0.h,
                                //           color: Colors.white,
                                //         ),
                                //         Text(
                                //           "Map",
                                //           style: AppTextStyle.normalWhite12,
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        sPRController.isLoadingMore.value
                            ? Container(
                                height: double.infinity,
                                width: double.infinity,
                                child: Center(child: LoadingIndicatorBlue()),
                              )
                            : SizedBox(),
                        sPRController.isLoadingMore.value
                            ? ScreenDisableWidget()
                            : SizedBox()
                      ],
                    ),
        ),
      );
    });
  }

  Column columnList(String? t1, String? t2,
      {CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          t1!,
          style: AppTextStyle.normalGrey10,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: 0.5.h,
        ),
        Text(
          t2!,
          style: AppTextStyle.semiBoldBlack8,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
// import 'dart:typed_data';

// import 'package:fap_properties/data/helpers/session_controller.dart';
// import 'package:fap_properties/utils/constants/assets_path.dart';
// import 'package:fap_properties/utils/constants/meta_labels.dart';
// import 'package:fap_properties/utils/styles/colors.dart';
// import 'package:fap_properties/utils/styles/text_styles.dart';
// import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
// import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
// import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart' as intl;
// import 'package:shimmer/shimmer.dart';
// import 'package:sizer/sizer.dart';

// import 'get_property_detail/get_property_detail.dart';
// import 'search_properties_result_controller.dart';

// class SearchPropertiesResult extends StatefulWidget {
//   final String? propName;
//   final String? minRent;
//   final String? maxRent;
//   final String? minArea;
//   final String? maxArea;

//   final String? minRoom;
//   final String? maxRoom;
//   final String? areaType;
//   const SearchPropertiesResult(
//       {Key key,
//       this.propName,
//       this.minRent,
//       this.maxRent,
//       this.minArea,
//       this.maxArea,
//       this.areaType,
//       this.minRoom,
//       this.maxRoom})
//       : super(key: key);

//   @override
//   _SearchPropertiesResultState createState() => _SearchPropertiesResultState();
// }

// class _SearchPropertiesResultState extends State<SearchPropertiesResult>
//     with SingleTickerProviderStateMixin {
//   final sPRController = Get.put(SearchPropertiesResultController());
//   AnimationController _controller;
//   Stream<Uint8List> stream;

//   _getData() async {
//     await sPRController.getDataPagination(
//         widget.propName,
//         widget.minRent,
//         widget.maxRent,
//         widget.areaType,
//         widget.minArea,
//         widget.maxArea,
//         widget.minRoom,
//         widget.maxRoom,
//         sPRController.pageNo);
//     // await sPRController.getData(
//     //     widget.propName,
//     //     widget.minRent,
//     //     widget.maxRent,
//     //     widget.areaType,
//     //     widget.minArea,
//     //     widget.maxArea,
//     //     widget.minRoom,
//     //     widget.maxRoom,
//     //     pagenum.toString());
//   }

//   @override
//   void initState() {
//     _getData();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Directionality(
//         textDirection: SessionController().getLanguage() == 1
//             ? TextDirection.ltr
//             : TextDirection.rtl,
//         child: Scaffold(
//           resizeToAvoidBottomInset: false,
//           backgroundColor: Colors.white,
//           appBar: AppBar(
//             leading: IconButton(
//               icon: Icon(
//                 Icons.arrow_back_ios,
//               ),
//               iconSize: 2.0.h,
//               onPressed: () {
//                 sPRController.pageNo = '1';
//                 Get.back();
//               },
//             ),
//             flexibleSpace: Container(
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 image: DecorationImage(
//                   image: AssetImage(
//                     AppImagesPath.appbarimg,
//                   ),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             backgroundColor: Colors.white,
//             title: Text(
//               AppMetaLabels().properties,
//               style: AppTextStyle.semiBoldWhite14,
//             ),
//             actions: [
//               IconButton(
//                 tooltip: 'Sort by rent',
//                 onPressed: () {
//                   if (sPRController.sortedBy == 'asc')
//                     _controller.forward();
//                   else
//                     _controller.reverse();
//                   sPRController.sort();
//                 },
//                 icon: RotationTransition(
//                   turns: Tween(begin: 0.0, end: 0.5).animate(_controller),
//                   child: Icon(Icons.sort),
//                 ),
//               )
//             ],
//           ),
//           body: sPRController.loadingData.value == true
//               ? Center(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: 3.0.w, vertical: 3.0.h),
//                     child: Container(
//                       height: 33.0.h,
//                       width: 94.0.w,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(1.0.h),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey[200],
//                             blurRadius: 0.4.h,
//                             spreadRadius: 0.1.h,
//                             offset: Offset(0.1.h, 0.1.h),
//                           ),
//                         ],
//                       ),
//                       child: LoadingIndicatorBlue(),
//                     ),
//                   ),
//                 )
//               : sPRController.error.value != ''
//                   ? Container(
//                       height: 33.0.h,
//                       width: 94.0.w,
//                       padding: EdgeInsets.symmetric(
//                           horizontal: 3.0.w, vertical: 3.0.h),
//                       margin: EdgeInsets.symmetric(
//                           horizontal: 3.0.w, vertical: 3.0.h),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(1.0.h),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey[200],
//                             blurRadius: 1.0.h,
//                             spreadRadius: 0.6.h,
//                             offset: Offset(0.0.h, 0.7.h),
//                           ),
//                         ],
//                       ),
//                       child: CustomErrorWidget(
//                         errorText: AppMetaLabels().noPropertiesFound,
//                         errorImage: AppImagesPath.noServicesFound,
//                       ),
//                     )
//                   : Stack(
//                       children: [
//                         SingleChildScrollView(
//                           child: Padding(
//                             padding: EdgeInsets.all(2.0.h),
//                             child: Container(
//                               width: 100.0.w,
//                               padding: EdgeInsets.only(top: 1.h),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(2.0.h),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey[200],
//                                     blurRadius: 0.5.h,
//                                     spreadRadius: 0.8.h,
//                                     offset: Offset(0.1.h, 0.1.h),
//                                   ),
//                                 ],
//                               ),
//                               child: Column(
//                                 children: [
//                                   ListView.builder(
//                                     shrinkWrap: true,
//                                     physics: NeverScrollableScrollPhysics(),
//                                     itemCount: sPRController.properties.length,
//                                     padding: EdgeInsets.zero,
//                                     itemBuilder: (context, index) {
//                                       final paidFormatter =
//                                           intl.NumberFormat('#,##0.00', 'AR');
//                                       String? rent =
//                                           "${AppMetaLabels().aed} ${paidFormatter.format(sPRController.properties[index].rentPerAnnumMin ?? 0.0)}";
//                                       return Padding(
//                                         padding: EdgeInsets.only(
//                                             left: 2.0.h, right: 0.0.h),
//                                         child: InkWell(
//                                           onTap: () {
//                                             SessionController().setPropId(
//                                               sPRController
//                                                   .properties[index].unitID
//                                                   .toString(),
//                                             );
//                                             Get.to(() => GetPropertyDetails(
//                                                   unitId: sPRController
//                                                       .properties[index].unitID,
//                                                   index: index,
//                                                 ));
//                                           },
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                             children: [
//                                               SizedBox(
//                                                 height: 1.0.h,
//                                               ),
//                                               Row(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.start,
//                                                 children: [
//                                                   ClipRRect(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             1.0.h),
//                                                     child: Container(
//                                                       width: 19.0.w,
//                                                       height: 11.0.h,
//                                                       decoration: BoxDecoration(
//                                                         color: Colors.white,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(
//                                                                     1.0.h),
//                                                       ),
//                                                       child: StreamBuilder<
//                                                           Uint8List>(
//                                                         stream: sPRController
//                                                             .getPropertyImage(
//                                                                 5),
//                                                         builder: (
//                                                           BuildContext context,
//                                                           AsyncSnapshot<
//                                                                   Uint8List>
//                                                               snapshot,
//                                                         ) {
//                                                           if (snapshot
//                                                                   .connectionState ==
//                                                               ConnectionState
//                                                                   .waiting) {
//                                                             return SizedBox(
//                                                               width: 19.0.w,
//                                                               height: 11.0.h,
//                                                               child: Shimmer
//                                                                   .fromColors(
//                                                                 baseColor: Colors
//                                                                     .grey
//                                                                     .withOpacity(
//                                                                         0.2),
//                                                                 highlightColor:
//                                                                     Colors.grey
//                                                                         .withOpacity(
//                                                                             0.5),
//                                                                 child:
//                                                                     ClipRRect(
//                                                                   borderRadius:
//                                                                       BorderRadius
//                                                                           .circular(
//                                                                               2.h),
//                                                                   child: Image
//                                                                       .asset(
//                                                                     AppImagesPath
//                                                                         .thumbnail,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             );
//                                                           }
//                                                           if (snapshot
//                                                               .hasData) {
//                                                             return Image.memory(
//                                                                 snapshot.data,
//                                                                 fit: BoxFit
//                                                                     .cover);
//                                                           } else {
//                                                             return Center(
//                                                                 child: Icon(Icons
//                                                                     .ac_unit));
//                                                           }
//                                                         },
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Padding(
//                                                     padding: EdgeInsets.only(
//                                                         left: 1.0.h,
//                                                         bottom: 1.h,
//                                                         right: 1.0.h),
//                                                     child: Row(
//                                                       children: [
//                                                         Container(
//                                                           // color: Colors.red,
//                                                           width: 59.0.w,
//                                                           child: Column(
//                                                             crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .start,
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .start,
//                                                             children: [
//                                                               Text(
//                                                                 SessionController()
//                                                                             .getLanguage() ==
//                                                                         1
//                                                                     ? sPRController
//                                                                             .properties[
//                                                                                 index]
//                                                                             .propertyName ??
//                                                                         ""
//                                                                     : sPRController
//                                                                             .properties[index]
//                                                                             .propertyNameAr ??
//                                                                         "",
//                                                                 style: AppTextStyle
//                                                                     .semiBoldBlack11,
//                                                                 overflow:
//                                                                     TextOverflow
//                                                                         .ellipsis,
//                                                               ),
//                                                               SizedBox(
//                                                                 height: 1.0.h,
//                                                               ),
//                                                               Text(
//                                                                 "${AppMetaLabels().unit}: ${sPRController.properties[index].unitRefNo}",
//                                                                 style: AppTextStyle
//                                                                     .semiBoldGrey10,
//                                                                 overflow:
//                                                                     TextOverflow
//                                                                         .ellipsis,
//                                                               ),
//                                                               SizedBox(
//                                                                 height: 1.0.h,
//                                                               ),
//                                                               Row(
//                                                                 children: [
//                                                                   Icon(
//                                                                     Icons
//                                                                         .location_on_outlined,
//                                                                     color: AppColors
//                                                                         .greyColor,
//                                                                     size: 2.5.h,
//                                                                   ),
//                                                                   Container(
//                                                                     width:
//                                                                         50.0.w,
//                                                                     child: Text(
//                                                                       SessionController().getLanguage() ==
//                                                                               1
//                                                                           ? sPRController.properties[index].address ??
//                                                                               ""
//                                                                           : sPRController.properties[index].addressAr ??
//                                                                               "",
//                                                                       style: AppTextStyle
//                                                                           .normalGrey10,
//                                                                       overflow:
//                                                                           TextOverflow
//                                                                               .ellipsis,
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                               SizedBox(
//                                                                 height: 1.2.h,
//                                                               ),
//                                                               Container(
//                                                                 // color: Colors.red,
//                                                                 child: Row(
//                                                                   mainAxisAlignment:
//                                                                       MainAxisAlignment
//                                                                           .spaceEvenly,
//                                                                   children: [
//                                                                     sPRController.properties[index].unitCategory ==
//                                                                             'Residential'
//                                                                         ? SizedBox(
//                                                                             width:
//                                                                                 8.w,
//                                                                             child:
//                                                                                 columnList(AppMetaLabels().beds, "${sPRController.properties[index].bedRooms ?? ""}"),
//                                                                           )
//                                                                         : SizedBox(),
//                                                                     sPRController.properties[index].unitCategory ==
//                                                                             'Residential'
//                                                                         ? SizedBox(
//                                                                             width:
//                                                                                 8.w,
//                                                                             child:
//                                                                                 columnList(AppMetaLabels().bath, "${sPRController.properties[index].bath ?? ""}"),
//                                                                           )
//                                                                         : SizedBox(),
//                                                                     // sPRController
//                                                                     //                 .properties[
//                                                                     //                     index]
//                                                                     //                 .areaSize !=
//                                                                     //             null &&
//                                                                     //         sPRController
//                                                                     //                 .properties[
//                                                                     //                     index]
//                                                                     //                 .areaSize !=
//                                                                     //             ''
//                                                                     //             &&
//                                                                     sPRController.properties[index].areaSize !=
//                                                                             0.00
//                                                                         ? SizedBox(
//                                                                             width:
//                                                                                 18.w,
//                                                                             child:
//                                                                                 columnList(sPRController.properties[index].uom, "${sPRController.properties[index].areaSize}"),
//                                                                           )
//                                                                         : SizedBox(),
//                                                                     SizedBox(
//                                                                       width:
//                                                                           25.w,
//                                                                       child: columnList(
//                                                                           AppMetaLabels()
//                                                                               .targetRent,
//                                                                           rent,
//                                                                           crossAxisAlignment:
//                                                                               CrossAxisAlignment.end),
//                                                                     )
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         Padding(
//                                                           padding:
//                                                               EdgeInsets.only(
//                                                                   right: 1.0.h,
//                                                                   left: 0.5.h),
//                                                           child: SizedBox(
//                                                             width: 0.15.w,
//                                                             child: Icon(
//                                                               Icons
//                                                                   .arrow_forward_ios_rounded,
//                                                               color: AppColors
//                                                                   .grey1,
//                                                               size: 20,
//                                                             ),
//                                                           ),
//                                                         )
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               index ==
//                                                       sPRController.properties
//                                                               .length -
//                                                           1
//                                                   ? SizedBox()
//                                                   : AppDivider(),
//                                             ],
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                   sPRController.properties.length < 6
//                                       ? SizedBox()
//                                       : Container(
//                                           width: 90.w,
//                                           height: 5.h,
//                                           child: Center(
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.end,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.end,
//                                               children: [
//                                                 Spacer(),
//                                                 Obx(() {
//                                                   return sPRController
//                                                               .noMoreDataError
//                                                               .value !=
//                                                           ''
//                                                       ? Text(
//                                                           AppMetaLabels()
//                                                               .noMoreData,
//                                                           style: TextStyle(
//                                                               color:
//                                                                   Colors.blue,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold),
//                                                         )
//                                                       : InkWell(
//                                                           onTap: () async {
//                                                             int pageSize =
//                                                                 int.parse(
//                                                                     sPRController
//                                                                         .pageNo);
//                                                             int naePageNo =
//                                                                 pageSize + 1;
//                                                             sPRController
//                                                                     .pageNo =
//                                                                 naePageNo
//                                                                     .toString();
//                                                             await sPRController
//                                                                 .getDataPaginationLoadMore(
//                                                                     widget
//                                                                         .propName,
//                                                                     widget
//                                                                         .minRent,
//                                                                     widget
//                                                                         .maxRent,
//                                                                     widget
//                                                                         .areaType,
//                                                                     widget
//                                                                         .minArea,
//                                                                     widget
//                                                                         .maxArea,
//                                                                     widget
//                                                                         .minRoom,
//                                                                     widget
//                                                                         .maxRoom,
//                                                                     sPRController
//                                                                         .pageNo);
//                                                             setState(() {});
//                                                           },
//                                                           child: SizedBox(
//                                                               height: 3.h,
//                                                               child: RichText(
//                                                                 textAlign:
//                                                                     TextAlign
//                                                                         .center,
//                                                                 text: TextSpan(
//                                                                   children: [
//                                                                     TextSpan(
//                                                                       text: AppMetaLabels()
//                                                                           .loadMoreData,
//                                                                       style: TextStyle(
//                                                                           color: Colors
//                                                                               .blue,
//                                                                           fontWeight:
//                                                                               FontWeight.bold),
//                                                                     ),
//                                                                     WidgetSpan(
//                                                                       child:
//                                                                           Icon(
//                                                                         Icons
//                                                                             .arrow_forward_ios,
//                                                                         size:
//                                                                             15,
//                                                                         color: Colors
//                                                                             .blue,
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               )),
//                                                         );
//                                                 }),
//                                                 SizedBox(
//                                                   width: 5,
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(bottom: 4.0.h),
//                           child: Align(
//                             alignment: Alignment.bottomCenter,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   height: 6.0.h,
//                                   width: 30.0.w,
//                                   child: ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor:
//                                           Colors.white, // background
//                                       // onPrimary: Colors.yellow, // foreground
//                                     ),
//                                     onPressed: () async {
//                                       Get.back();
//                                       // Get.to(() => SearchPropertiesFilter());
//                                     },
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceAround,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Icon(
//                                           Icons.format_align_center,
//                                           size: 2.0.h,
//                                           color: Colors.black,
//                                         ),
//                                         Text(
//                                           AppMetaLabels().filter,
//                                           style: AppTextStyle.semiBoldBlack11,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 // InkWell(
//                                 //   onTap: () {
//                                 //   },
//                                 //   child: Container(
//                                 //     height: 6.0.h,
//                                 //     width: 25.0.w,
//                                 //     decoration: BoxDecoration(
//                                 //         color: Color.fromRGBO(0, 98, 255, 1),
//                                 //         borderRadius:
//                                 //             BorderRadius.circular(100.0.h)),
//                                 //     child: Row(
//                                 //       mainAxisAlignment:
//                                 //           MainAxisAlignment.spaceEvenly,
//                                 //       crossAxisAlignment:
//                                 //           CrossAxisAlignment.center,
//                                 //       children: [
//                                 //         Icon(
//                                 //           Icons.location_on_outlined,
//                                 //           size: 3.0.h,
//                                 //           color: Colors.white,
//                                 //         ),
//                                 //         Text(
//                                 //           "Map",
//                                 //           style: AppTextStyle.normalWhite12,
//                                 //         ),
//                                 //       ],
//                                 //     ),
//                                 //   ),
//                                 // ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         sPRController.isLoadingMore.value
//                             ? Container(
//                                 height: double.infinity,
//                                 width: double.infinity,
//                                 child: Center(child: LoadingIndicatorBlue()),
//                               )
//                             : SizedBox()
//                       ],
//                     ),
//         ),
//       );
//     });
//   }

//   Column columnList(String? t1, String? t2,
//       {CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start}) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: crossAxisAlignment,
//       children: [
//         Text(
//           t1,
//           style: AppTextStyle.normalGrey10,
//           overflow: TextOverflow.ellipsis,
//         ),
//         SizedBox(
//           height: 0.5.h,
//         ),
//         Text(
//           t2,
//           style: AppTextStyle.semiBoldBlack8,
//           overflow: TextOverflow.ellipsis,
//         ),
//       ],
//     );
//   }
// }
