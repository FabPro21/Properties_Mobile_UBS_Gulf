import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:sizer/sizer.dart';

import '../../../data/helpers/session_controller.dart';
import '../../../utils/constants/meta_labels.dart';
import '../../../utils/styles/colors.dart';
import '../../../utils/styles/text_styles.dart';
import '../../public_views/search_properties_properties/search_properties_result/search_properties_result.dart';
import '../../public_views/search_properties_search/get_property_category/get_property_category.dart';
import '../../public_views/search_properties_search/get_unit_type/get_unit_type.dart';
import '../../public_views/search_properties_search/search_properties_search_conrtoller.dart';
import '../../public_views/search_properties_search/select_city/select_city.dart';
import '../../widgets/clear_button.dart';
import '../../widgets/custom_app_bar2.dart';

class SearchVacantUnits extends StatefulWidget {
  const SearchVacantUnits({Key key}) : super(key: key);

  @override
  State<SearchVacantUnits> createState() => _SearchVacantUnitsState();
}

class _SearchVacantUnitsState extends State<SearchVacantUnits> {
  final TextEditingController searchControler = TextEditingController();

  final TextEditingController minControler = TextEditingController();

  final TextEditingController maxControler = TextEditingController();

  final sPSConrtoller = Get.put(SearchPropertiesSearchConrtoller());

  final FocusNode _nodeTextMin = FocusNode();

  final FocusNode _nodeTextMax = FocusNode();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        keyboardBarColor: Colors.grey[200],
        nextFocus: true,
        actions: [
          KeyboardActionsItem(
            focusNode: _nodeTextMin,
          ),
          KeyboardActionsItem(
            focusNode: _nodeTextMax,
          ),
        ]);
  }

  var cityResult;

  var categoryResult;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
          backgroundColor: AppColors.greyBG,
          body: Obx(() {
            return Column(children: [
              CustomAppBar2(
                title: AppMetaLabels().searchVacantUnits,
              ),
              Expanded(
                child: SafeArea(
                  child: KeyboardActions(
                    config: _buildConfig(context),
                    child: Column(
                      children: [
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
                                  Text(
                                    AppMetaLabels().searchProperties,
                                    style: AppTextStyle.semiBoldBlack12,
                                  ),
                                  SizedBox(
                                    height: 2.0.h,
                                  ),
                                  Text(
                                    AppMetaLabels().citty,
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
                                              sPSConrtoller.cityName.value ??
                                                  "",
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
                                  Text(
                                    AppMetaLabels().category,
                                    style: AppTextStyle.normalGrey10,
                                  ),
                                  SizedBox(
                                    height: 1.0.h,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      categoryResult = await Get.to(
                                          () => GetPropertyCategory());
                                      if (categoryResult != null) {
                                        sPSConrtoller.categoryName.value =
                                            categoryResult[0];
                                        sPSConrtoller.categoryId.value =
                                            categoryResult[1];
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
                                              sPSConrtoller
                                                      .categoryName.value ??
                                                  "",
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
                                  Text(
                                    AppMetaLabels().unitType,
                                    style: AppTextStyle.normalGrey10,
                                  ),
                                  SizedBox(
                                    height: 1.0.h,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      var unitType =
                                          await Get.to(() => GetUnitType(categoryName: SessionController().getPropCatName()
                                                  ));
                                      if (unitType != null) {
                                        sPSConrtoller.unitType.value =
                                            unitType[0];
                                        sPSConrtoller.unitTypeId.value =
                                            unitType[1];
                                      } else {
                                        unitType = AppMetaLabels().pleaseSelect;
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
                                              sPSConrtoller.unitType.value ??
                                                  "",
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
                                  SizedBox(
                                    height: 16.0.h,
                                  ),
                                  SizedBox(
                                    width: 90.0.w,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(1.3.h),
                                        ), backgroundColor: Color.fromRGBO(0, 61, 166, 1),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6.0.h, vertical: 1.5.h),
                                        // textStyle: AppTextStyle.buttonTextStyle,
                                      ),
                                      onPressed: () {
                                        Get.to(() => SearchPropertiesResult(
                                              propName: searchControler.text,
                                            ));
                                      },
                                      child: Text(
                                        AppMetaLabels().submit,
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
              )
            ]);
          })),
    );
  }
}
