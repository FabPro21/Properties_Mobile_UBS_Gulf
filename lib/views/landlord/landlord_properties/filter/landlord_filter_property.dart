// ignore_for_file: unnecessary_null_comparison

import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/landlord_models/filter_property_category_model.dart';
import 'package:fap_properties/data/models/landlord_models/filter_property_emirate_model.dart';
import 'package:fap_properties/data/models/landlord_models/filter_property_type_model.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/landlord/landlord_contracts/landlord_contract_filter/landlord_filter_property/landlord_filter_property.dart';
import 'package:fap_properties/views/landlord/landlord_properties/filter/landlord_filter_category/landlord_filter_category.dart';
import 'package:fap_properties/views/landlord/landlord_properties/filter/landlord_filter_property_controller.dart';
import 'package:fap_properties/views/landlord/landlord_properties/filter/landlord_filter_property_emirat/landlord_filter_emirate.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LandLordFilterProperties extends StatefulWidget {
  final bool? clear;
  const LandLordFilterProperties({Key? key, this.clear}) : super(key: key);

  @override
  _LandLordFilterPropertiesState createState() =>
      _LandLordFilterPropertiesState();
}

class _LandLordFilterPropertiesState extends State<LandLordFilterProperties> {
  final TextEditingController propertyController = TextEditingController();
  final LandLordFilterPropController lDFilterController =
      Get.put(LandLordFilterPropController());

  @override
  void initState() {
    propertyController.text = lDFilterController.propertyName;
    if (widget.clear!) {
      lDFilterController.resetValues();
    }
    propertyController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        // backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(4.0.h),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppMetaLabels().filter,
                          style: AppTextStyle.semiBoldBlack16,
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            lDFilterController.filterError.value = '';
                            Get.back();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(118, 118, 128, 0.12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(0.5.h),
                              child: Icon(Icons.close,
                                  size: 2.0.h,
                                  color: Color.fromRGBO(158, 158, 158, 1)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppDivider(),
                    ////////////////////////////////////
                    ////   Property
                    ////////////////////////////////////
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Text(
                      AppMetaLabels().propertyNameLand,
                      style: AppTextStyle.semiBoldBlack12,
                    ),
                    SizedBox(
                      height: 1.0.h,
                    ),
                    Container(
                      width: 100.0.w,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(246, 248, 249, 1),
                        borderRadius: BorderRadius.circular(1.0.h),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child:
                                textField(propertyController, (dynamic value) {
                              lDFilterController.propertyName = value;
                            }),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.0.h),
                            child: ClearButton(
                              clear: () {
                                propertyController.clear();
                                lDFilterController.propertyName = "";
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    ////////////////////////////////////
                    ////   Property
                    ////////////////////////////////////
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Text(
                      AppMetaLabels().propertyType,
                      style: AppTextStyle.semiBoldBlack12,
                    ),
                    SizedBox(height: 1.0.h),
                    InkWell(
                      onTap: () async {
                        var propType =
                            await Get.to(() => LandlordFilterProperty());
                        if (propType != null)
                          lDFilterController.propType.value = propType;
                      },
                      child: Container(
                        width: 100.0.w,
                        height: 5.5.h,
                        padding: EdgeInsets.only(left: 3.w),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(246, 248, 249, 1),
                          borderRadius: BorderRadius.circular(1.0.h),
                        ),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Obx(() {
                              return Text(
                                  lDFilterController.propType.value == null
                                      ? ''
                                      : SessionController().getLanguage() == 1
                                          ? lDFilterController.propType.value
                                                  .propertyType ??
                                              ''
                                          : lDFilterController.propType.value
                                                  .propertyTypeAR ??
                                              '',
                                  style: AppTextStyle.normalBlack12);
                            }),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0.h),
                              child: ClearButton(
                                clear: () {
                                  lDFilterController.propType.value =
                                      PropertyType();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    ////////////////////////////////////
                    ////   Emirate
                    ////////////////////////////////////
                    Text(
                      AppMetaLabels().emirate,
                      style: AppTextStyle.semiBoldBlack12,
                    ),
                    SizedBox(
                      height: 1.0.h,
                    ),
                    InkWell(
                      onTap: () async {
                        var emirateName =
                            await Get.to(() => LandlordFilterEmirate());
                        if (emirateName != null)
                          lDFilterController.emirateName.value = emirateName;
                      },
                      child: Container(
                          width: 100.0.w,
                          height: 5.5.h,
                          padding: EdgeInsets.only(left: 3.w),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(246, 248, 249, 1),
                            borderRadius: BorderRadius.circular(1.0.h),
                          ),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Obx(() {
                                return Text(
                                    SessionController().getLanguage() == 1
                                        ? lDFilterController.emirateName.value
                                                .emirateName ??
                                            ''
                                        : lDFilterController.emirateName.value
                                                .emirateNameAR ??
                                            '',
                                    style: AppTextStyle.normalBlack12);
                              }),
                              Spacer(),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 2.0.h),
                                child: ClearButton(
                                  clear: () {
                                    lDFilterController.emirateName.value =
                                        PropertyEmirate();
                                  },
                                ),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    ////////////////////////////////////
                    ////   Category
                    ////////////////////////////////////
                    Text(
                      AppMetaLabels().category,
                      style: AppTextStyle.semiBoldBlack12,
                    ),
                    SizedBox(
                      height: 1.0.h,
                    ),
                    InkWell(
                      onTap: () async {
                        var category =
                            await Get.to(() => LandlordFilterPCategory());
                        if (category != null)
                          lDFilterController.propCategory.value = category;
                      },
                      child: Container(
                          width: 100.0.w,
                          height: 5.5.h,
                          padding: EdgeInsets.only(left: 3.w),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(246, 248, 249, 1),
                            borderRadius: BorderRadius.circular(1.0.h),
                          ),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Obx(() {
                                return Text(
                                    SessionController().getLanguage() == 1
                                        ? lDFilterController.propCategory.value
                                                .propertyCategory ??
                                            ''
                                        : lDFilterController.propCategory.value
                                                .propertyCategoryAR ??
                                            '',
                                    style: AppTextStyle.normalBlack12);
                              }),
                              Spacer(),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 2.0.h),
                                child: ClearButton(
                                  clear: () {
                                    lDFilterController.propCategory.value =
                                        ProppertyCategoris();
                                  },
                                ),
                              ),
                            ],
                          )),
                    ),

                    SizedBox(
                      height: 3.0.h,
                    ),
                    Obx(() {
                      return lDFilterController.filterError.value == ""
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.only(top: 1.0.h),
                              child: Container(
                                width: 85.0.w,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 59, 48, 0.6),
                                  borderRadius: BorderRadius.circular(1.0.h),
                                  border: Border.all(
                                    color: Color.fromRGBO(255, 59, 48, 1),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(0.7.h),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        color: Colors.white,
                                        size: 3.5.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 1.0.h),
                                        child: Text(
                                          lDFilterController.filterError.value,
                                          style: AppTextStyle.semiBoldWhite11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                    }),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2.0.h),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 5.0.h,
                      width: 28.0.w,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(0, 98, 255, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0.h),
                          ),
                        ),
                        onPressed: () {
                          lDFilterController.goBack();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.format_align_center,
                              size: 1.9.h,
                              color: Colors.white,
                            ),
                            Text(
                              AppMetaLabels().apply,
                              style: AppTextStyle.semiBoldWhite11,
                            ),
                          ],
                        ),
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
  }

  TextField textField(controller, Function(String) onChanged) {
    return TextField(
      // inputFormatters: TextInputFormatter().searchPropertyNameContractNoIF,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromRGBO(246, 248, 249, 1),
        focusColor: Colors.red,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.0.h),
        ),
      ),
    );
  }
}

class ClearButton extends StatelessWidget {
  final Function? clear;
  const ClearButton({Key? key, this.clear}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        clear!();
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromRGBO(118, 118, 128, 0.12),
        ),
        child: Padding(
          padding: EdgeInsets.all(0.5.h),
          child: Icon(Icons.close,
              size: 2.0.h, color: Color.fromRGBO(158, 158, 158, 1)),
        ),
      ),
    );
  }
}
