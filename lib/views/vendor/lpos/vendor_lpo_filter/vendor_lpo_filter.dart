import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/vendor_models/get_lpo_status_model.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/vendor/lpos/vendor_lpo_filter/vendor_filter_lpo_status/vendor_filter_lpos_status.dart';
import 'package:fap_properties/views/vendor/lpos/vendor_lpo_filter/vendor_lpo_filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class VendorLpoFilter extends StatefulWidget {
  final bool? clear;
  const VendorLpoFilter({Key? key, this.clear}) : super(key: key);

  @override
  _VendorLpoFilterState createState() => _VendorLpoFilterState();
}

class _VendorLpoFilterState extends State<VendorLpoFilter> {
  final TextEditingController propertyController = TextEditingController();
  VendorLpoFilterController _controller = Get.find();

  @override
  void initState() {
    if (widget.clear!) {
      _controller.resetValues();
      propertyController.text = _controller.propertyName;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
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
                    SizedBox(
                      height: 3.0.h,
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
                              _controller.propertyName = value;
                            }),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.0.h),
                            child: ClearButton(
                              clear: () {
                                propertyController.clear();
                                _controller.propertyName = "";
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      AppMetaLabels().lPOStatus,
                      style: AppTextStyle.semiBoldBlack12,
                    ),
                    SizedBox(
                      height: 1.0.h,
                    ),
                    Obx(() {
                      return InkWell(
                        onTap: () async {
                          var res = await Get.to(() => VendorLpoStatusFilter());
                          print(res);
                          if (res != null &&
                              res != AppMetaLabels().pleaseSelect) {
                            _controller.lpoStatus.value = res;
                          }
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
                              Text(
                                SessionController().getLanguage() == 1
                                    ? _controller
                                            .lpoStatus.value.lpoStatusName ??
                                        ''
                                    : _controller
                                            .lpoStatus.value.lpoStatusNameAr ??
                                        '',
                                style: AppTextStyle.normalBlack12,
                              ),
                              Spacer(),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 1.0.h),
                                child: ClearButton(
                                  clear: () {
                                    _controller.lpoStatus.value = LpoStatus();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Text(
                      AppMetaLabels().lpoDate,
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
                                  if (!_controller.setFromDate(dT!)) {
                                    _controller.filterError.value =
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
                                          _controller.fromDateText.value,
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
                                          _controller.fromDate.value = "";
                                          _controller.fromDateText.value = "";
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
                                  if (!_controller.setToDate(dT!)) {
                                    _controller.filterError.value =
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
                                          _controller.toDateText.value,
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
                                          _controller.toDate.value = "";
                                          _controller.toDateText.value = "";
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
                      return _controller.filterError.value == ""
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
                                          _controller.filterError.value,
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
                      width: 30.0.w,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(0, 98, 255, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0.h),
                          ),
                        ),
                        onPressed: () {
                          _controller.goBack();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.format_align_center,
                              size: 2.0.h,
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
