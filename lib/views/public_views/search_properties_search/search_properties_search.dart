// ignore_for_file: unnecessary_null_comparison

import 'package:badges/badges.dart' as badge;
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/public_views/search_properties_search/get_unit_type/get_unit_type_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/app_logo_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/backbround_concave.dart';
import 'package:fap_properties/views/public_views/search_properties_properties/search_properties_result/search_properties_result.dart';
import 'package:fap_properties/views/public_views/search_properties_search/search_properties_search_conrtoller.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../views/widgets/clear_button.dart';
import '../public_notifications/public_count_notifications_controlller.dart';
import '../public_notifications/public_notifications.dart';
import 'get_property_category/get_property_category.dart';
import 'get_unit_type/get_unit_type.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:flutter/services.dart';

import 'select_city/select_city.dart';

class SearchPropertiesSearch extends StatefulWidget {
  const SearchPropertiesSearch({Key? key}) : super(key: key);

  @override
  _SearchPropertiesSearchState createState() => _SearchPropertiesSearchState();
}

class _SearchPropertiesSearchState extends State<SearchPropertiesSearch> {
  final TextEditingController searchControler = TextEditingController();
  final TextEditingController minRentControler = TextEditingController();
  final TextEditingController maxRentControler = TextEditingController();
  final TextEditingController minAreaControler = TextEditingController();
  final TextEditingController maxAreaControler = TextEditingController();
  final TextEditingController maxRoomControler = TextEditingController();
  final TextEditingController minRoomControler = TextEditingController();
  var gPCController = Get.put(GetUnitTypeController());
  final sPSConrtoller = Get.put(SearchPropertiesSearchConrtoller());
  final _countController = Get.put(PublicCountNotificationsController());
  final FocusNode _nodeTextMinRent = FocusNode();
  final FocusNode _nodeTextMaxRent = FocusNode();
  final FocusNode _nodeTextMinArea = FocusNode();
  final FocusNode _nodeTextMaxArea = FocusNode();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        keyboardBarColor: Colors.grey[200],
        nextFocus: true,
        actions: [
          KeyboardActionsItem(
            focusNode: _nodeTextMinRent,
          ),
          KeyboardActionsItem(
            focusNode: _nodeTextMaxRent,
          ),
          KeyboardActionsItem(
            focusNode: _nodeTextMinArea,
          ),
          KeyboardActionsItem(
            focusNode: _nodeTextMaxArea,
          ),
        ]);
  }

  var cityResult;
  var categoryResult;
  String _selectedValue = AppMetaLabels().sqFt;

  @override
  void initState() {
    // Emirate
    sPSConrtoller.cityName.value = AppMetaLabels().pleaseSelect;
    // category
    sPSConrtoller.categoryName.value = AppMetaLabels().pleaseSelect;
    // Unite Type
    sPSConrtoller.unitType.value = AppMetaLabels().pleaseSelect;
    SessionController().showArea.value = false;
    // rent
    minRentControler.clear();
    maxRentControler.clear();
    minRoomControler.clear();
    maxRoomControler.clear();
    _selectedValue = AppMetaLabels().sqFt;
    minAreaControler.clear();
    maxAreaControler.clear();
    SessionController().setCityId("");
    SessionController().setPropCatId("");
    SessionController().setUnitTypeName("");
    _selectedValue = AppMetaLabels().sqFt;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Obx(() {
        return Directionality(
          textDirection: SessionController().getLanguage() == 1
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: Stack(
            children: [
              const AppBackgroundConcave(),
              SafeArea(
                child: KeyboardActions(
                  config: _buildConfig(context),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.0.h),
                          child: Row(
                            children: [
                              SizedBox(width: 45.0.w, child: AppLogoMena()),
                              const Spacer(),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.0.w, vertical: 0.0.h),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(() => PublicNotification());
                                  },
                                  child: badge.Badge(
                                    showBadge:
                                        _countController.countN.value == 0 ||
                                                _countController.countN.value ==
                                                    null
                                            ? false
                                            : true,
                                    badgeAnimation:
                                        badge.BadgeAnimation.rotation(
                                      animationDuration: Duration(seconds: 300),
                                      colorChangeAnimationDuration:
                                          Duration(seconds: 1),
                                      loopAnimation: false,
                                      curve: Curves.fastOutSlowIn,
                                      colorChangeAnimationCurve:
                                          Curves.easeInCubic,
                                    ),
                                    position: badge.BadgePosition.topEnd(
                                        top: -1.0.h, end: 0.0.h),
                                    badgeContent: Text(
                                      "${_countController.countN.value}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.0.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.notifications_outlined,
                                      color: Colors.white,
                                      size: 5.0.h,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 2.0.h, right: 2.0.h, top: 2.0.h),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(1.0.h),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(0.3.h),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: searchControler,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(
                                            r'^[a-zA-Z\u0621-\u064A0-9_\-=@,:\.\ ]+$'))
                                      ],
                                      onChanged: (value) {
                                        // getContractsController.searchData(value.trim())                                      },
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey.withOpacity(0.1),
                                        prefixIcon: Icon(
                                          Icons.search,
                                          size: 2.0.h,
                                          color: Colors.grey,
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            left: 5.0.w, right: 5.0.w),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(0.5.h),
                                          borderSide: BorderSide(
                                              color: AppColors.whiteColor,
                                              width: 0.1.h),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(0.5.h),
                                          borderSide: BorderSide(
                                              color: AppColors.whiteColor,
                                              width: 0.1.h),
                                        ),
                                        hintText:
                                            AppMetaLabels().searchByKeyword,
                                        hintStyle: AppTextStyle.normalBlack10
                                            .copyWith(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();
                                      searchControler.clear();
                                      print(searchControler.text);
                                    },
                                    icon: Icon(
                                      Icons.refresh,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(2.0.h),
                          child: Container(
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
                                  Row(
                                    children: [
                                      Text(
                                        AppMetaLabels().searchProperties,
                                        style: AppTextStyle.semiBoldBlack12,
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: () {
                                          // Emirate
                                          sPSConrtoller.cityName.value =
                                              AppMetaLabels().pleaseSelect;
                                          // category
                                          sPSConrtoller.categoryName.value =
                                              AppMetaLabels().pleaseSelect;
                                          // Unite Type
                                          sPSConrtoller.unitType.value =
                                              AppMetaLabels().pleaseSelect;
                                          SessionController().showArea.value =
                                              false;
                                          // rent
                                          // minRentControler.clear();
                                          // maxRentControler.clear();
                                          // minRoomControler.clear();
                                          // maxRoomControler.clear();
                                          // _selectedValue = AppMetaLabels().sqFt;
                                          // minAreaControler.clear();
                                          // maxAreaControler.clear();
                                          searchControler.text = '';
                                          minRentControler.text = '';
                                          maxRentControler.text = '';
                                          minAreaControler.text = '';
                                          maxAreaControler.text = '';
                                          minRoomControler.text = '';
                                          maxRoomControler.text = '';
                                          SessionController().setCityId("");
                                          SessionController().setPropCatId("");
                                          SessionController()
                                              .setUnitTypeName("");
                                          _selectedValue = AppMetaLabels().sqFt;
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: Colors.blue,
                                              width: 0.4.w,
                                            ),
                                          ),
                                          child: Text(
                                            AppMetaLabels().reset,
                                            style: AppTextStyle.semiBoldBlack11
                                                .copyWith(color: Colors.blue),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.0.h,
                                  ),
                                  // Emirate
                                  Text(
                                    AppMetaLabels().city,
                                    style: AppTextStyle.normalGrey10,
                                  ),
                                  SizedBox(
                                    height: 1.0.h,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      cityResult =
                                          await Get.to(() => SelectCity());

                                      if (cityResult != null) {
                                        sPSConrtoller.cityName.value =
                                            cityResult[0];
                                        sPSConrtoller.cityId.value =
                                            cityResult[1];
                                      } else {
                                        cityResult =
                                            AppMetaLabels().pleaseSelect;
                                      }
                                    },
                                    child: Container(
                                      width: 100.0.w,
                                      height: 5.0.h,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(246, 248, 249, 1),
                                        borderRadius:
                                            BorderRadius.circular(0.5.h),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 1.5.h, right: 1.5.h),
                                        child: Row(
                                          children: [
                                            Text(
                                              sPSConrtoller.cityName.value,
                                              style: AppTextStyle.normalGrey10,
                                            ),
                                            Spacer(),
                                            ClearButton(
                                              clear: () {
                                                SessionController()
                                                    .setCityId('');
                                                sPSConrtoller.cityName.value =
                                                    AppMetaLabels()
                                                        .pleaseSelect;
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  // Category
                                  Text(
                                    AppMetaLabels().category,
                                    style: AppTextStyle.normalGrey10,
                                  ),
                                  SizedBox(
                                    height: 1.0.h,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      SessionController().setUnitTypeName('');
                                      sPSConrtoller.unitType.value =
                                          AppMetaLabels().pleaseSelect;
                                      categoryResult = await Get.to(
                                          () => GetPropertyCategory());
                                      if (categoryResult != null) {
                                        sPSConrtoller.categoryName.value =
                                            categoryResult[0];
                                        sPSConrtoller.categoryId.value =
                                            categoryResult[1];
                                        sPSConrtoller.categoryNameAR.value =
                                            categoryResult[2];
                                      } else {
                                        categoryResult =
                                            AppMetaLabels().pleaseSelect;
                                      }
                                    },
                                    child: Container(
                                      width: 100.0.w,
                                      height: 5.0.h,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(246, 248, 249, 1),
                                        borderRadius:
                                            BorderRadius.circular(0.5.h),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 1.5.h, right: 1.5.h),
                                        child: Row(
                                          children: [
                                            Text(
                                              sPSConrtoller.categoryName.value,
                                              // SessionController().getServicesType(),
                                              style: AppTextStyle.normalGrey10,
                                            ),
                                            Spacer(),
                                            ClearButton(
                                              clear: () {
                                                SessionController()
                                                    .setPropCatId('');
                                                sPSConrtoller
                                                        .categoryName.value =
                                                    AppMetaLabels()
                                                        .pleaseSelect;
                                                SessionController()
                                                    .showArea
                                                    .value = false;
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.0.h,
                                  ),
                                  // Unite Type
                                  Text(
                                    AppMetaLabels().unitType,
                                    style: AppTextStyle.normalGrey10,
                                  ),
                                  SizedBox(
                                    height: 1.0.h,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      print('Tapping');
                                      if (sPSConrtoller.categoryName.value ==
                                              AppMetaLabels().pleaseSelect ||
                                          sPSConrtoller.categoryName.value ==
                                              "" ||
                                          sPSConrtoller.categoryName.value ==
                                              null) {
                                        SnakBarWidget.getSnackBarErrorBlue(
                                            AppMetaLabels().alert,
                                            AppMetaLabels()
                                                .pleaseSelectCategory);
                                      } else {
                                        var unitType =
                                            await Get.to(() => GetUnitType(
                                                  categoryName: SessionController()
                                                              .getLanguage() ==
                                                          1
                                                      ? sPSConrtoller
                                                          .categoryName.value
                                                      : sPSConrtoller
                                                          .categoryNameAR.value,
                                                ));
                                        if (unitType != null) {
                                          sPSConrtoller.unitType.value =
                                              unitType[0];
                                        } else {
                                          unitType =
                                              AppMetaLabels().pleaseSelect;
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: 100.0.w,
                                      height: 5.0.h,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(246, 248, 249, 1),
                                        borderRadius:
                                            BorderRadius.circular(0.5.h),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 1.5.h, right: 1.5.h),
                                        child: Row(
                                          children: [
                                            Text(
                                              sPSConrtoller.unitType.value,
                                              // SessionController().getServicesType(),
                                              style: AppTextStyle.normalGrey10,
                                            ),
                                            Spacer(),
                                            ClearButton(
                                              clear: () {
                                                SessionController()
                                                    .setUnitTypeName('');
                                                sPSConrtoller.unitType.value =
                                                    AppMetaLabels()
                                                        .pleaseSelect;
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  ////////////////////////////// changed by kamran, Rent //////////////////
                                  SizedBox(
                                    height: 2.0.h,
                                  ),
                                  Text(
                                    AppMetaLabels().rent,
                                    style: AppTextStyle.normalGrey10,
                                  ),
                                  SizedBox(
                                    height: 1.0.h,
                                  ),
                                  Row(
                                    children: [
                                      //////////////// Min Rent ////////////////////
                                      Container(
                                        width: 35.0.w,
                                        height: 5.0.h,
                                        child: TextField(
                                          controller: minRentControler,
                                          focusNode: _nodeTextMinRent,
                                          keyboardType: TextInputType.number,
                                          style: AppTextStyle.normalGrey11,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(8),
                                            FilteringTextInputFormatter.allow(
                                                RegExp(
                                                    r'^[a-zA-Z\u0621-\u064A0-9_\-=@,:\.\ ]+$'))
                                          ],
                                          onChanged: (value) {
                                            // getContractsController.searchData(value);
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Color.fromRGBO(
                                                246, 248, 249, 1),
                                            contentPadding: EdgeInsets.only(
                                                left: 3.0.w, right: 5.0.w),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0.5.h),
                                              borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  width: 0.1.h),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                0.5.h,
                                              ),
                                              borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  width: 0.1.h),
                                            ),
                                            hintText: AppMetaLabels().min,
                                            hintStyle: AppTextStyle
                                                .normalBlack10
                                                .copyWith(color: Colors.grey),
                                          ),
                                        ),
                                      ),

                                      /////////////// Max Rent //////////////////
                                      Spacer(),
                                      Container(
                                        width: 35.0.w,
                                        height: 5.0.h,
                                        child: TextField(
                                          controller: maxRentControler,
                                          focusNode: _nodeTextMaxRent,
                                          style: AppTextStyle.normalGrey11,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(8),
                                            FilteringTextInputFormatter.allow(
                                                RegExp(
                                                    r'^[a-zA-Z\u0621-\u064A0-9_\-=@,:\.\ ]+$'))
                                          ],
                                          onChanged: (value) {
                                            // getContractsController.searchData(value);
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Color.fromRGBO(
                                                246, 248, 249, 1),
                                            contentPadding: EdgeInsets.only(
                                                left: 3.0.w, right: 5.0.w),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0.5.h),
                                              borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  width: 0.1.h),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                0.5.h,
                                              ),
                                              borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  width: 0.1.h),
                                            ),
                                            hintText: AppMetaLabels().max,
                                            hintStyle: AppTextStyle
                                                .normalBlack10
                                                .copyWith(color: Colors.grey),
                                          ),
                                        ),
                                      ),

                                      //////////////////////////////////////
                                    ],
                                  ),

                                  //////////////////////////////// Area //////////////////////////////////

                                  SizedBox(
                                    height: 2.0.h,
                                  ),
                                  Obx(() {
                                    return SessionController().showArea.value ==
                                            false
                                        ? SizedBox(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                //              SizedBox(
                                                //   height: 2.0.h,
                                                // ),
                                                Text(
                                                  AppMetaLabels().noofRooms,
                                                  style:
                                                      AppTextStyle.normalGrey10,
                                                ),
                                                SizedBox(
                                                  height: 1.0.h,
                                                ),
                                                Row(
                                                  children: [
                                                    //////////////// Min Rooms ////////////////////
                                                    Container(
                                                      width: 35.0.w,
                                                      height: 5.0.h,
                                                      child: TextField(
                                                        controller:
                                                            minRoomControler,
                                                        focusNode:
                                                            _nodeTextMinArea,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        style: AppTextStyle
                                                            .normalGrey11,
                                                        inputFormatters: [
                                                          LengthLimitingTextInputFormatter(
                                                              2),
                                                          FilteringTextInputFormatter
                                                              .allow(RegExp(
                                                                  r'^[a-zA-Z\u0621-\u064A0-9_\-=@,:\.\ ]+$'))
                                                        ],
                                                        onChanged: (value) {
                                                          // getContractsController.searchData(value);
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          filled: true,
                                                          fillColor:
                                                              Color.fromRGBO(
                                                                  246,
                                                                  248,
                                                                  249,
                                                                  1),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  left: 3.0.w,
                                                                  right: 5.0.w),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0.5.h),
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.1),
                                                                width: 0.1.h),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              0.5.h,
                                                            ),
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.1),
                                                                width: 0.1.h),
                                                          ),
                                                          hintText:
                                                              AppMetaLabels()
                                                                  .min,
                                                          hintStyle: AppTextStyle
                                                              .normalBlack10
                                                              .copyWith(
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                      ),
                                                    ),

                                                    /////////////// Max Rooms //////////////////
                                                    Spacer(),
                                                    Container(
                                                      width: 35.0.w,
                                                      height: 5.0.h,
                                                      child: TextField(
                                                        controller:
                                                            maxRoomControler,
                                                        focusNode:
                                                            _nodeTextMaxArea,
                                                        style: AppTextStyle
                                                            .normalGrey11,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        inputFormatters: [
                                                          LengthLimitingTextInputFormatter(
                                                              2),
                                                          FilteringTextInputFormatter
                                                              .allow(RegExp(
                                                                  r'^[a-zA-Z\u0621-\u064A0-9_\-=@,:\.\ ]+$'))
                                                        ],
                                                        onChanged: (value) {
                                                          // getContractsController.searchData(value);
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          filled: true,
                                                          fillColor:
                                                              Color.fromRGBO(
                                                                  246,
                                                                  248,
                                                                  249,
                                                                  1),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  left: 3.0.w,
                                                                  right: 5.0.w),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0.5.h),
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.1),
                                                                width: 0.1.h),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              0.5.h,
                                                            ),
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.1),
                                                                width: 0.1.h),
                                                          ),
                                                          hintText:
                                                              AppMetaLabels()
                                                                  .max,
                                                          hintStyle: AppTextStyle
                                                              .normalBlack10
                                                              .copyWith(
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                      ),
                                                    ),

                                                    //////////////////////////////////////
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                                Text(
                                                  AppMetaLabels().areaSize,
                                                  style:
                                                      AppTextStyle.normalGrey10,
                                                ),
                                                ////////////// Radio Button Area Catrgory ////////////////////
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Radio(
                                                        value: AppMetaLabels()
                                                            .sqFt,
                                                        groupValue:
                                                            _selectedValue,
                                                        activeColor:
                                                            AppColors.blueColor,
                                                        onChanged:
                                                            (String? value) {
                                                          setState(() {
                                                            _selectedValue =
                                                                SessionController()
                                                                            .getLanguage() ==
                                                                        1
                                                                    ? value ??
                                                                        ""
                                                                    : 'المساحة بالقدم المربع';
                                                          });
                                                          print(
                                                              'Value :::::: $_selectedValue');
                                                        },
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            _selectedValue =
                                                                SessionController()
                                                                            .getLanguage() ==
                                                                        1
                                                                    ? 'SQF'
                                                                    : 'المساحة بالقدم المربع';
                                                          });
                                                          print(
                                                              'Value :::::: $_selectedValue');
                                                        },
                                                        child: Text(
                                                          AppMetaLabels().sqFt,
                                                          style: AppTextStyle
                                                              .normalGrey10,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 2.w,
                                                      ),
                                                      Radio(
                                                        value: AppMetaLabels()
                                                            .sqMt,
                                                        groupValue:
                                                            _selectedValue,
                                                        activeColor:
                                                            AppColors.blueColor,
                                                        onChanged:
                                                            (String? value) {
                                                          setState(() {
                                                            _selectedValue =
                                                                SessionController()
                                                                            .getLanguage() ==
                                                                        1
                                                                    ? value ??
                                                                        ""
                                                                    : 'المساحة بالمتر المربع';
                                                          });
                                                          print(
                                                              'Value :::: $_selectedValue');
                                                        },
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            _selectedValue =
                                                                SessionController()
                                                                            .getLanguage() ==
                                                                        1
                                                                    ? 'SQM'
                                                                    : 'المساحة بالمتر المربع';
                                                          });
                                                          print(
                                                              'Value :::: $_selectedValue');
                                                        },
                                                        child: Text(
                                                          AppMetaLabels().sqMt,
                                                          style: AppTextStyle
                                                              .normalGrey10,
                                                        ),
                                                      )
                                                    ]),

                                                //////////////

                                                /////////////////////////////////////////////////////////////
                                                Row(
                                                  children: [
                                                    //////////////// Min Area ////////////////////
                                                    Container(
                                                      width: 35.0.w,
                                                      height: 5.0.h,
                                                      child: TextField(
                                                        controller:
                                                            minAreaControler,
                                                        focusNode:
                                                            _nodeTextMinArea,
                                                        style: AppTextStyle
                                                            .normalGrey11,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        inputFormatters: [
                                                          LengthLimitingTextInputFormatter(
                                                              6),
                                                          FilteringTextInputFormatter
                                                              .allow(RegExp(
                                                                  r'^[a-zA-Z\u0621-\u064A0-9_\-=@,:\.\ ]+$'))
                                                        ],
                                                        onChanged: (value) {
                                                          // getContractsController.searchData(value);
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          filled: true,
                                                          fillColor:
                                                              Color.fromRGBO(
                                                                  246,
                                                                  248,
                                                                  249,
                                                                  1),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  left: 3.0.w,
                                                                  right: 5.0.w),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0.5.h),
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.1),
                                                                width: 0.1.h),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              0.5.h,
                                                            ),
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.1),
                                                                width: 0.1.h),
                                                          ),
                                                          hintText:
                                                              AppMetaLabels()
                                                                  .min,
                                                          hintStyle: AppTextStyle
                                                              .normalBlack10
                                                              .copyWith(
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                      ),
                                                    ),

                                                    /////////////// Max Area //////////////////
                                                    Spacer(),
                                                    Container(
                                                      width: 35.0.w,
                                                      height: 5.0.h,
                                                      child: TextField(
                                                        controller:
                                                            maxAreaControler,
                                                        focusNode:
                                                            _nodeTextMaxArea,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        style: AppTextStyle
                                                            .normalGrey11,
                                                        inputFormatters: [
                                                          LengthLimitingTextInputFormatter(
                                                              6),
                                                          FilteringTextInputFormatter
                                                              .allow(RegExp(
                                                                  r'^[a-zA-Z\u0621-\u064A0-9_\-=@,:\.\ ]+$'))
                                                        ],
                                                        onChanged: (value) {
                                                          // getContractsController.searchData(value);
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          filled: true,
                                                          fillColor:
                                                              Color.fromRGBO(
                                                                  246,
                                                                  248,
                                                                  249,
                                                                  1),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  left: 3.0.w,
                                                                  right: 5.0.w),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0.5.h),
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.1),
                                                                width: 0.1.h),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              0.5.h,
                                                            ),
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.1),
                                                                width: 0.1.h),
                                                          ),
                                                          hintText:
                                                              AppMetaLabels()
                                                                  .max,
                                                          hintStyle: AppTextStyle
                                                              .normalBlack10
                                                              .copyWith(
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                      ),
                                                    ),

                                                    //////////////////////////////////////
                                                  ],
                                                ),
                                              ]);
                                  }),
                                  ///////////////////////////////////////////////////////////////////////

                                  SizedBox(
                                    height: 2.0.h,
                                  ),
                                  SizedBox(
                                    width: 90.0.w,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(1.3.h),
                                        ),
                                        backgroundColor:
                                            Color.fromRGBO(0, 61, 166, 1),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6.0.h, vertical: 1.5.h),
                                      ),
                                      onPressed: () {
                                        Get.to(() => SearchPropertiesResult(
                                              propName: searchControler.text,
                                              minRent: minRentControler.text,
                                              maxRent: maxRentControler.text,
                                              minArea: minAreaControler.text,
                                              maxArea: maxAreaControler.text,
                                              minRoom: minRoomControler.text,
                                              maxRoom: maxRoomControler.text,
                                              areaType: _selectedValue,
                                            ));
                                      },
                                      child: Text(
                                        AppMetaLabels().search,
                                        style: AppTextStyle.semiBoldWhite14,
                                      ),
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
            ],
          ),
        );
      }),
    );
  }
}
