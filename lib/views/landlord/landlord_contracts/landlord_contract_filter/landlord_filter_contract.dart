// ignore_for_file: unnecessary_null_comparison

import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/landlord_models/filter_property_type_model.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_contract_stauts_model.dart'
    as contractStatus;
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/landlord/landlord_contracts/landlord_contract_filter/landlord_filter_contract_status/landlord_filter_cs.dart';
import 'package:fap_properties/views/landlord/landlord_contracts/landlord_contract_filter/landlord_filter_property/landlord_filter_property.dart';
import 'package:fap_properties/views/landlord/landlord_contracts/landlord_contract_filter/landlord_filter_contract_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LandLordFilterContract extends StatefulWidget {
  final bool clear;
  const LandLordFilterContract({Key? key, required this.clear})
      : super(key: key);

  @override
  _LandLordFilterContractState createState() => _LandLordFilterContractState();
}

class _LandLordFilterContractState extends State<LandLordFilterContract> {
  final TextEditingController propertyController = TextEditingController();
  final LandLordFilterContractController lDFilterController =
      Get.put(LandLordFilterContractController());

  @override
  void initState() {
    propertyController.text = lDFilterController.propertyName;
    if (widget.clear) {
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
                              return SizedBox(
                                width: 60.w,
                                child: Text(
                                  lDFilterController.propType.value == null
                                      ? ''
                                      : SessionController().getLanguage() == 1
                                          ? lDFilterController.propType.value
                                                  .propertyType ??
                                              ''
                                          : lDFilterController.propType.value
                                                  .propertyTypeAR ??
                                              '',
                                  style: AppTextStyle.normalBlack12,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
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
                            await Get.to(() => LandlordFilterCS());
                        if (contractStatus != null)
                          lDFilterController.contractStatus.value =
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
                                return SizedBox(
                                  width: 60.w,
                                  child: Text(
                                    lDFilterController.contractStatus.value ==
                                            null
                                        ? ''
                                        : lDFilterController.contractStatus
                                                    .value.contractType ==
                                                'Active'
                                            ? SessionController()
                                                        .getLanguage() ==
                                                    1
                                                ? lDFilterController
                                                        .contractStatus
                                                        .value
                                                        .contractType ??
                                                    "" + ' / Expired'
                                                : lDFilterController
                                                        .contractStatus
                                                        .value
                                                        .contractTypeAR ??
                                                    "" + ' / منتهي الصلاحية'
                                            : SessionController()
                                                        .getLanguage() ==
                                                    1
                                                ? lDFilterController
                                                        .contractStatus
                                                        .value
                                                        .contractType ??
                                                    ''
                                                : lDFilterController
                                                        .contractStatus
                                                        .value
                                                        .contractTypeAR ??
                                                    '',
                                    style: AppTextStyle.normalBlack12,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }),
                              Spacer(),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 2.0.h),
                                child: ClearButton(
                                  clear: () {
                                    lDFilterController.contractStatus.value =
                                        contractStatus.Data();
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
                                try {
                                  var dT = await showRoundedDatePicker(
                                    theme: ThemeData(
                                        primaryColor: AppColors.blueColor),
                                    height: 50.0.h,
                                    context: context,
                                    // locale: Locale('en'),
                                    locale:
                                        SessionController().getLanguage() == 1
                                            ? Locale('en', '')
                                            : Locale('ar', ''),
                                    initialDate: DateTime.now(),
                                    firstDate:
                                        DateTime(DateTime.now().year - 10),
                                    lastDate:
                                        DateTime(DateTime.now().year + 10),
                                    borderRadius: 2.0.h,
                                    // theme:
                                    //     ThemeData(primarySwatch: Colors.deepPurple),
                                    styleDatePicker:
                                        MaterialRoundedDatePickerStyle(
                                            decorationDateSelected:
                                                BoxDecoration(
                                                    color: AppColors.blueColor,
                                                    borderRadius: BorderRadius
                                                        .circular(100)),
                                            textStyleButtonPositive: TextStyle(
                                              color: AppColors.blueColor,
                                            ),
                                            textStyleButtonNegative: TextStyle(
                                              color: AppColors.blueColor,
                                            ),
                                            backgroundHeader:
                                                Colors.grey.shade300,
                                            // Appbar year like '2023' button
                                            textStyleYearButton: AppTextStyle
                                                .boldBlue30
                                                .copyWith(
                                                    backgroundColor:
                                                        Colors.grey.shade100,
                                                    leadingDistribution:
                                                        TextLeadingDistribution
                                                            .even),
                                            // Appbar day like 'Thu, Mar 16' button
                                            textStyleDayButton:
                                                AppTextStyle.normalWhite16),
                                  );
                                  if (!lDFilterController.setFromDate(dT!)) {
                                    lDFilterController.filterError.value =
                                        AppMetaLabels().validDateRange;
                                  }
                                } catch (e) {}
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
                                          lDFilterController.fromDateText.value,
                                          // lDFilterController.fromDate.value,
                                          style: AppTextStyle.normalBlack11,
                                        ),
                                      );
                                    }),
                                    Spacer(),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.0.h),
                                      child: ClearButton(
                                        clear: () {
                                          lDFilterController.fromDate.value =
                                              "";
                                          lDFilterController
                                              .fromDateText.value = "";
                                          lDFilterController.filterError.value =
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
                                try {
                                  var dT = await showRoundedDatePicker(
                                    theme: ThemeData(
                                        primaryColor: AppColors.blueColor),
                                    height: 50.0.h,
                                    context: context,
                                    // locale: Locale('en'),
                                    locale:
                                        SessionController().getLanguage() == 1
                                            ? Locale('en', '')
                                            : Locale('ar', ''),
                                    initialDate: DateTime.now(),
                                    firstDate:
                                        DateTime(DateTime.now().year - 10),
                                    lastDate:
                                        DateTime(DateTime.now().year + 10),
                                    borderRadius: 2.0.h,
                                    // theme:
                                    //     ThemeData(primarySwatch: Colors.deepPurple),
                                    styleDatePicker:
                                        MaterialRoundedDatePickerStyle(
                                      decorationDateSelected: BoxDecoration(
                                          color: AppColors.blueColor,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      textStyleButtonPositive: TextStyle(
                                        color: AppColors.blueColor,
                                      ),
                                      textStyleButtonNegative: TextStyle(
                                        color: AppColors.blueColor,
                                      ),
                                      backgroundHeader: Colors.grey.shade300,
                                      // Appbar year like '2023' button
                                      textStyleYearButton:
                                          AppTextStyle.boldBlue30.copyWith(
                                              backgroundColor:
                                                  Colors.grey.shade100,
                                              leadingDistribution:
                                                  TextLeadingDistribution.even),
                                      // Appbar day like 'Thu, Mar 16' button
                                      textStyleDayButton:
                                          AppTextStyle.normalWhite16,
                                    ),
                                  );
                                  if (!lDFilterController.setToDate(dT!)) {
                                    lDFilterController.filterError.value =
                                        AppMetaLabels().validDateRange;
                                  }
                                } catch (e) {}
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
                                          lDFilterController.toDateText.value,
                                          style: AppTextStyle.normalBlack11,
                                        ),
                                      );
                                    }),
                                    Spacer(),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.0.h),
                                      child: ClearButton(
                                        clear: () {
                                          lDFilterController.toDate.value = "";
                                          lDFilterController.toDateText.value =
                                              "";
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
  final Function clear;
  const ClearButton({Key? key, required this.clear}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        clear();
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
