// ignore_for_file: unnecessary_null_comparison

import 'package:fap_properties/data/models/tenant_models/tenant_contracts_filter/get_contracts_status_model.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_contracts_filter/get_property_types_model.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_filter/tenant_contracts_filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../data/helpers/session_controller.dart';
import 'filter_contract_status/filter_contracts_status.dart';
import 'filter_property/filter_property.dart';

class TenantContracrsFilter extends StatefulWidget {
  final bool? clear;
  const TenantContracrsFilter({Key? key, this.clear}) : super(key: key);

  @override
  _TenantContracrsFilterState createState() => _TenantContracrsFilterState();
}

class _TenantContracrsFilterState extends State<TenantContracrsFilter> {
  final TextEditingController propertyController = TextEditingController();
  final TenantContracrsFilterController tCFilterController = Get.find();

  @override
  void initState() {
    propertyController.text = tCFilterController.propertyName;
    if (widget.clear!) {
      tCFilterController.resetValues();
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
                            tCFilterController.filterError.value = '';
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
                      AppMetaLabels().property,
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
                              tCFilterController.propertyName = value;
                            }),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.0.h),
                            child: ClearButton(
                              clear: () {
                                propertyController.clear();
                                tCFilterController.propertyName = "";
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
                            await Get.to(() => ContracrsPropertyFilter());
                        if (propType != null)
                          tCFilterController.propType.value = propType;
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
                                  tCFilterController.propType.value == null
                                      ? ''
                                      : SessionController().getLanguage() == 1
                                          ? tCFilterController.propType.value
                                                  .propertyType ??
                                              ''
                                          : tCFilterController.propType.value
                                                  .propertyTypeAr ??
                                              '',
                                  style: AppTextStyle.normalBlack12);
                            }),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0.h),
                              child: ClearButton(
                                clear: () {
                                  tCFilterController.propType.value =
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
                    Text(
                      AppMetaLabels().contractStatus,
                      style: AppTextStyle.semiBoldBlack12,
                    ),
                    SizedBox(
                      height: 1.0.h,
                    ),
                    InkWell(
                      onTap: () async {
                        var contractStatus =
                            await Get.to(() => ContractsStatusFilter());
                        if (contractStatus != null)
                          tCFilterController.contractStatus.value =
                              contractStatus;
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
                                    tCFilterController.contractStatus.value ==
                                            null
                                        ? ''
                                        : tCFilterController.contractStatus
                                                    .value.contractType ==
                                                'Active'
                                            ? SessionController()
                                                        .getLanguage() ==
                                                    1
                                                ? tCFilterController
                                                        .contractStatus
                                                        .value
                                                        .contractType ??
                                                    "" + ' / Expired'
                                                : tCFilterController
                                                        .contractStatus
                                                        .value
                                                        .contractTypeAr ??
                                                    "" + ' / منتهي الصلاحية'
                                            : SessionController()
                                                        .getLanguage() ==
                                                    1
                                                ? tCFilterController
                                                        .contractStatus
                                                        .value
                                                        .contractType ??
                                                    ''
                                                : tCFilterController
                                                        .contractStatus
                                                        .value
                                                        .contractTypeAr ??
                                                    '',
                                    style: AppTextStyle.normalBlack12);
                              }),
                              Spacer(),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 2.0.h),
                                child: ClearButton(
                                  clear: () {
                                    tCFilterController.contractStatus.value =
                                        ContractStatus();
                                  },
                                ),
                              ),
                            ],
                          )),
                    ),

                    SizedBox(
                      height: 3.0.h,
                    ),
                    Text(
                      AppMetaLabels().contractDate,
                      style: AppTextStyle.semiBoldBlack12,
                    ),
                    SizedBox(
                      height: 1.0.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppMetaLabels().from,
                              style: AppTextStyle.normalBlack10,
                            ),
                            SizedBox(
                              height: 1.0.h,
                            ),
                            InkWell(
                              onTap: () async {
                                var dT = await showRoundedDatePicker(
                                  height: 50.0.h,
                                  context: context,
                                  // locale: Locale('en'),
                                  locale: SessionController().getLanguage() == 1
                                      ? Locale('en', '')
                                      : Locale('ar', ''),
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(DateTime.now().year - 10),
                                  lastDate: DateTime(DateTime.now().year + 10),
                                  borderRadius: 2.0.h,
                                  styleDatePicker:
                                      MaterialRoundedDatePickerStyle(
                                    backgroundHeader: Colors.grey.shade300,
                                    // Appbar year like '2023' button
                                    textStyleYearButton: TextStyle(
                                      fontSize: 30.sp,
                                      color: AppColors.blueColor,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor: Colors.grey.shade100,
                                      leadingDistribution:
                                          TextLeadingDistribution.even,
                                    ),
                                    // Appbar day like 'Thu, Mar 16' button
                                    textStyleDayButton: TextStyle(
                                      fontSize: 18.sp,
                                      color: Colors.white,
                                    ),

                                    // Heading year like 'S M T W TH FR SA ' button
                                    // textStyleDayHeader: TextStyle(
                                    //   fontSize: 30.sp,
                                    //   color: Colors.white,
                                    //   backgroundColor: Colors.red,
                                    //   decoration: TextDecoration.overline,
                                    //   decorationColor: Colors.pink,
                                    // ),
                                  ),
                                );
                                if (!tCFilterController.setFromDate(dT!)) {
                                  tCFilterController.filterError.value =
                                      AppMetaLabels().validDateRange;
                                } else {
                                  setState(() {
                                    tCFilterController.filterError.value = '';
                                  });
                                }
                              },
                              child: Container(
                                width: 40.0.w,
                                height: 5.5.h,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(246, 248, 249, 1),
                                  borderRadius: BorderRadius.circular(1.0.h),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Obx(() {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.0.h),
                                        child: Text(
                                          tCFilterController.fromDateText.value,
                                          // tCFilterController.fromDate.value,
                                          style: AppTextStyle.normalBlack12,
                                        ),
                                      );
                                    }),
                                    Spacer(),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.0.h),
                                      child: ClearButton(
                                        clear: () {
                                          tCFilterController.fromDate.value =
                                              "";
                                          tCFilterController
                                              .fromDateText.value = "";
                                          tCFilterController.filterError.value =
                                              '';
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppMetaLabels().to,
                              style: AppTextStyle.normalBlack12,
                            ),
                            SizedBox(
                              height: 1.0.h,
                            ),
                            InkWell(
                              onTap: () async {
                                var dT = await showRoundedDatePicker(
                                  height: 50.0.h,
                                  context: context,
                                  // locale: Locale('en'),
                                  locale: SessionController().getLanguage() == 1
                                      ? Locale('en', '')
                                      : Locale('ar', ''),
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(DateTime.now().year - 10),
                                  lastDate: DateTime(DateTime.now().year + 10),
                                  borderRadius: 16,
                                  styleDatePicker:
                                      MaterialRoundedDatePickerStyle(
                                    backgroundHeader: Colors.grey.shade300,
                                    // Appbar year like '2023' button
                                    textStyleYearButton: TextStyle(
                                      fontSize: 30.sp,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor: Colors.grey.shade100,
                                      leadingDistribution:
                                          TextLeadingDistribution.even,
                                    ),
                                    // Appbar day like 'Thu, Mar 16' button
                                    textStyleDayButton: TextStyle(
                                      fontSize: 18.sp,
                                      color: Colors.white,
                                    ),

                                    // Heading year like 'S M T W TH FR SA ' button
                                    // textStyleDayHeader: TextStyle(
                                    //   fontSize: 30.sp,
                                    //   color: Colors.white,
                                    //   backgroundColor: Colors.red,
                                    //   decoration: TextDecoration.overline,
                                    //   decorationColor: Colors.pink,
                                    // ),
                                  ),
                                );
                                if (!tCFilterController.setToDate(dT!)) {
                                  tCFilterController.filterError.value =
                                      AppMetaLabels().validDateRange;
                                } else {
                                  setState(() {
                                    tCFilterController.filterError.value = '';
                                  });
                                }
                              },
                              child: Container(
                                width: 40.0.w,
                                height: 5.5.h,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(246, 248, 249, 1),
                                  borderRadius: BorderRadius.circular(1.0.h),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Obx(() {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.0.h),
                                        child: Text(
                                          tCFilterController.toDateText.value,
                                          // tCFilterController.toDate.value,
                                          style: AppTextStyle.normalBlack12,
                                        ),
                                      );
                                    }),
                                    Spacer(),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.0.h),
                                      child: ClearButton(
                                        clear: () {
                                          tCFilterController.toDate.value = "";
                                          tCFilterController.toDateText.value =
                                              "";
                                          tCFilterController.filterError.value =
                                              '';
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Obx(() {
                      return tCFilterController.filterError.value == ""
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
                                          tCFilterController.filterError.value,
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
                          tCFilterController.goBack();
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
