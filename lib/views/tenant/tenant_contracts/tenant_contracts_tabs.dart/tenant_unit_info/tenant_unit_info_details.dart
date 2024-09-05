import 'dart:typed_data';

import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_tabs.dart/tenant_unit_info/tenant_unit_info_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class UnitInfoDetails extends StatelessWidget {
  final String? unitRefNo;
  UnitInfoDetails({Key? key, this.unitRefNo}) : super(key: key);
  final TenantUnitInfoDetailsController _unitInfoDetailsController =
      Get.put(TenantUnitInfoDetailsController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Obx(() {
            return _unitInfoDetailsController.loadingData.value
                ? LoadingIndicatorBlue()
                : _unitInfoDetailsController.error.value != ''
                    ? CustomErrorWidget(
                        errorText: _unitInfoDetailsController.error.value,
                        errorImage: AppImagesPath.noServicesFound,
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 4.0.h, left: 4.0.w, right: 4.0.w),
                            child: Row(
                              children: [
                                Container(
                                  width: 80.w,
                                  child: Text(
                                    SessionController().getLanguage() == 1
                                        ? _unitInfoDetailsController
                                                .unitDetails
                                                .value
                                                .contractUnit!
                                                .propertyName ??
                                            ''
                                        : _unitInfoDetailsController
                                                .unitDetails
                                                .value
                                                .contractUnit!
                                                .propertyNameAr ??
                                            '',
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        AppTextStyle.semiBoldBlack16.copyWith(
                                      fontSize: 18.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  // width: 7.5.w,

                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(241, 241, 245, 1),
                                      shape: BoxShape.circle),
                                  child: Padding(
                                    padding: EdgeInsets.all(0.7.h),
                                    child: InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Icon(Icons.close,
                                          size: 2.5.h,
                                          color: Color.fromRGBO(70, 82, 95, 1)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AppDivider(),
                          Expanded(
                            child: SingleChildScrollView(
                                child: Padding(
                              padding: EdgeInsets.only(
                                  top: 0.0.h,
                                  left: 4.0.w,
                                  right: 4.0.w,
                                  bottom: 2.h),
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
                                    children: [
                                      Container(
                                        width: 92.0.w,
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
                                                    _unitInfoDetailsController
                                                        .getImage(),
                                                builder: (
                                                  BuildContext context,
                                                  AsyncSnapshot<Uint8List>
                                                      snapshot,
                                                ) {
                                                  if (snapshot.hasData) {
                                                    return Image.memory(
                                                        snapshot.data!,
                                                        fit: BoxFit.cover);
                                                  } else {
                                                    return Center(
                                                      child: Text(
                                                        _unitInfoDetailsController
                                                            .unitDetails
                                                            .value
                                                            .contractUnit!
                                                            .unitName??"",
                                                        style: AppTextStyle
                                                            .semiBoldBlack16
                                                            .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 30.0.sp,
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(2.0.h),
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                unitRefNo ?? '',
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTextStyle
                                                    .semiBoldBlack12,
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
                                                      Container(
                                                        width: 25.0.w,
                                                        child: columnList(
                                                            AppMetaLabels()
                                                                .unitCategory,
                                                            SessionController()
                                                                        .getLanguage() ==
                                                                    1
                                                                ? _unitInfoDetailsController
                                                                        .unitDetails
                                                                        .value
                                                                        .contractUnit!
                                                                        .unitCategory ??
                                                                    ''
                                                                : _unitInfoDetailsController
                                                                        .unitDetails
                                                                        .value
                                                                        .contractUnit!
                                                                        .unitCategoryAr ??
                                                                    ''),
                                                      ),
                                                      Container(
                                                        width: 25.0.w,
                                                        child: columnList(
                                                            AppMetaLabels()
                                                                .unitType,
                                                            SessionController()
                                                                        .getLanguage() ==
                                                                    1
                                                                ? _unitInfoDetailsController
                                                                        .unitDetails
                                                                        .value
                                                                        .contractUnit!
                                                                        .unitType ??
                                                                    ''
                                                                : _unitInfoDetailsController
                                                                        .unitDetails
                                                                        .value
                                                                        .contractUnit!
                                                                        .unitTypeAr ??
                                                                    ''),
                                                      ),
                                                      Container(
                                                        width: 25.0.w,
                                                        child: columnList(
                                                            AppMetaLabels()
                                                                .unitView,
                                                            SessionController()
                                                                        .getLanguage() ==
                                                                    1
                                                                ? _unitInfoDetailsController
                                                                        .unitDetails
                                                                        .value
                                                                        .contractUnit!
                                                                        .unitView ??
                                                                    ''
                                                                : _unitInfoDetailsController
                                                                        .unitDetails
                                                                        .value
                                                                        .contractUnit!
                                                                        .unitViewAr ??
                                                                    ''),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.0.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 25.0.w,
                                                    child: columnList(
                                                        AppMetaLabels().area,
                                                        _unitInfoDetailsController
                                                                .unitDetails
                                                                .value
                                                                .contractUnit!
                                                                .areasize ??
                                                            'N/A'),
                                                  ),
                                                  Container(
                                                    width: 25.0.w,
                                                    child: columnList(
                                                        AppMetaLabels()
                                                            .currentRent,
                                                        "${AppMetaLabels().aed} ${_unitInfoDetailsController.unitDetails.value.contractUnit!.currentRent ?? 0.0}"),
                                                  ),
                                                  Container(
                                                    width: 25.0.w,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      _unitInfoDetailsController
                                              .loadingAdditionalData.value
                                          ? Padding(
                                              padding: EdgeInsets.all(1.5.h),
                                              child: LoadingIndicatorBlue(),
                                            )
                                          : _unitInfoDetailsController
                                                          .errorLoadingAdditional
                                                          .value !=
                                                      '' &&
                                                  _unitInfoDetailsController
                                                      .errorLoadingAdditional
                                                      .value
                                                      .contains('No data found')
                                              ? SizedBox()
                                              : Container(
                                                  padding:
                                                      EdgeInsets.all(1.5.h),
                                                  decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        247, 247, 247, 1),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        AppMetaLabels()
                                                            .facilities,
                                                        style: AppTextStyle
                                                            .semiBoldBlack10,
                                                      ),
                                                      SizedBox(
                                                        height: 1.h,
                                                      ),
                                                      _unitInfoDetailsController
                                                                  .errorLoadingAdditional
                                                                  .value !=
                                                              ''
                                                          ? AppErrorWidget(
                                                              errorText:
                                                                  _unitInfoDetailsController
                                                                      .errorLoadingAdditional
                                                                      .value,
                                                            )
                                                          : ListView.builder(
                                                              shrinkWrap: true,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              itemCount:
                                                                  _unitInfoDetailsController
                                                                      .length,
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                return Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          1.0.h,
                                                                    ),
                                                                    Text(
                                                                      SessionController().getLanguage() ==
                                                                              1
                                                                          ? _unitInfoDetailsController.additionalUnitDetails.value.additionalInfo![index].facilityDescription ??
                                                                              ""
                                                                          : _unitInfoDetailsController.additionalUnitDetails.value.additionalInfo![index].facilityDescriptionAr ??
                                                                              "",
                                                                      style: AppTextStyle
                                                                          .normalBlack10,
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            ),
                                                      SizedBox(
                                                        height: 1.h,
                                                      ),
                                                      AppDivider(),
                                                    ],
                                                  )),
                                      _unitInfoDetailsController
                                                  .unitDetails
                                                  .value
                                                  .contractUnit!
                                                  .unitCategory ==
                                              AppMetaLabels().residential
                                          ? Container(
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      247, 247, 247, 1),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  2.h),
                                                          bottomRight:
                                                              Radius.circular(
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
                                                                _unitInfoDetailsController
                                                                        .unitDetails
                                                                        .value
                                                                        .contractUnit!
                                                                        .bedRooms
                                                                        .toString() ,
                                                                alignment:
                                                                    CrossAxisAlignment
                                                                        .start),
                                                          ),
                                                          Expanded(
                                                            child: containerList(
                                                                AppMetaLabels()
                                                                    .kitchens,
                                                                _unitInfoDetailsController
                                                                        .unitDetails
                                                                        .value
                                                                        .contractUnit!
                                                                        .kitchens
                                                                        .toString(),
                                                                alignment:
                                                                    CrossAxisAlignment
                                                                        .center),
                                                          ),
                                                          Expanded(
                                                            child: containerList(
                                                                AppMetaLabels()
                                                                    .maidRooms,
                                                                _unitInfoDetailsController
                                                                        .unitDetails
                                                                        .value
                                                                        .contractUnit!
                                                                        .maidRooms
                                                                        .toString() ,
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
                                                                _unitInfoDetailsController
                                                                        .unitDetails
                                                                        .value
                                                                        .contractUnit!
                                                                        .livingRooms
                                                                        .toString() ,
                                                                alignment:
                                                                    CrossAxisAlignment
                                                                        .start),
                                                          ),
                                                          Expanded(
                                                            child: containerList(
                                                                AppMetaLabels()
                                                                    .balconies,
                                                                _unitInfoDetailsController
                                                                        .unitDetails
                                                                        .value
                                                                        .contractUnit!
                                                                        .balconies
                                                                        .toString(),
                                                                alignment:
                                                                    CrossAxisAlignment
                                                                        .center),
                                                          ),
                                                          Expanded(
                                                            child: containerList(
                                                                AppMetaLabels()
                                                                    .washrooms,
                                                                _unitInfoDetailsController
                                                                        .unitDetails
                                                                        .value
                                                                        .contractUnit!
                                                                        .washrooms
                                                                        .toString() ,
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
                                                                    .driverRooms,
                                                                _unitInfoDetailsController
                                                                        .unitDetails
                                                                        .value
                                                                        .contractUnit!
                                                                        .driverRooms
                                                                        .toString() ,
                                                                alignment:
                                                                    CrossAxisAlignment
                                                                        .start),
                                                          ),
                                                          Expanded(
                                                            child: SizedBox(),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                          ),
                        ],
                      );
          }),
        ),
      ),
    );
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
