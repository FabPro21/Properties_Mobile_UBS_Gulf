import 'package:fap_properties/views/auth/country_picker/country_picker_controller.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/background_image_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_white.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class CountryPicker extends StatefulWidget {
  @override
  State<CountryPicker> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  final TextEditingController searchControler = TextEditingController();

  final cPController = Get.find<CountryPickerController>();

  @override
  void initState() {
    if (cPController.countryPicker.value.countries == null ||
        cPController.countryPicker.value.countries.isEmpty)
      cPController.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (cPController.countryPicker.value.countries == null ||
    //     cPController.countryPicker.value.countries.isEmpty)
    //   cPController.getData();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: SessionController().getLanguage() == 1
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: Stack(
          children: [
            const AppBackgroundImage(),
            SafeArea(
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 2.0.h, left: 4.w, right: 4.w),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 12.w,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  AppMetaLabels().change,
                                  style: AppTextStyle.normalWhite9,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 1.0.h),
                                  child: Text(
                                    AppMetaLabels().countryCode +
                                        ' ' +
                                        cPController.loadingData.value
                                            .toString(),
                                    style: AppTextStyle.semiBoldWhite13,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              iconSize: 7.w,
                              padding: EdgeInsets.all(1.w),
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(
                                Icons.cancel_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(() {
                      return cPController.loadingData.value == true
                          ? SizedBox()
                          : Padding(
                              padding: EdgeInsets.all(2.0.h),
                              child: TextField(
                                controller: searchControler,
                                cursorColor: Colors.white,
                                style: AppTextStyle.normalWhite14,
                                onChanged: (value) {
                                  cPController.onSearch.value = value;
                                  setState(() {});
                                  if (value.isEmpty) {
                                    cPController.getData();
                                  }
                                },
                                onEditingComplete: () {
                                  cPController.getData();
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white10,
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(
                                        left: 1.5.h, right: 1.5.h),
                                    child: Icon(
                                      Icons.search,
                                      size: 4.0.h,
                                      color: Colors.white60,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(1.3.h),
                                    borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 0.1.h),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(1.3.h),
                                    borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 0.1.h),
                                  ),
                                  hintText: AppMetaLabels().search,
                                  hintStyle: AppTextStyle.normalBlack14
                                      .copyWith(
                                          color: AppColors.whiteColor
                                              .withOpacity(0.4)),
                                ),
                              ),
                            );
                    }),
                    Obx(() {
                      return cPController.loadingData.value == true
                          ? Padding(
                              padding: EdgeInsets.only(top: 30.0.h),
                              child: LoadingIndicatorWhite(),
                            )
                          : cPController.error.value != ''
                              ? Padding(
                                  padding: EdgeInsets.only(top: 10.0.h),
                                  child: AppErrorWidget(
                                    errorText: cPController.error.value,
                                    onRetry: () {
                                      cPController.getData();
                                    },
                                    color: AppMetaLabels().color,
                                  ),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: cPController.length,
                                    itemBuilder: (context, index) {
                                      if (cPController.onSearch.value.isEmpty) {
                                        return onSelectCountry(index);
                                      } else if ((cPController
                                                      .countryPicker
                                                      .value
                                                      .countries[index]
                                                      ?.countryCode ??
                                                  "")
                                              .toLowerCase()
                                              .contains(cPController
                                                  .onSearch.value) ||
                                          (cPController
                                                      .countryPicker
                                                      .value
                                                      .countries[index]
                                                      .dialingCode ??
                                                  "")
                                              .toLowerCase()
                                              .contains(cPController
                                                  .onSearch.value)) {
                                        return onSelectCountry(index);
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell onSelectCountry(int index) {
    return InkWell(
      onTap: () {
        cPController.selectCountry(index);
        cPController.onSearch.value = '';
        Get.back();
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(2.0.h, 1.3.h, 2.0.h, 1.3.h),
            child: Row(
              children: [
                Container(
                  width: 7.0.w,
                  height: 3.0.h,
                  child: Image.network(
                    'http://' +
                        cPController.countryPicker.value.countries[index].flag,
                    fit: BoxFit.contain,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace stackTrace) {
                      return Icon(Icons.error);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 2.0.h),
                  child: Text(
                    cPController
                            .countryPicker.value.countries[index].countryCode
                            .toString() ??
                        "",
                    style: AppTextStyle.normalWhite13,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 1.0.h),
                  child: Text(
                    "(${cPController.countryPicker.value.countries[index].dialingCode.toString()})" ??
                        "",
                    style: AppTextStyle.normalWhite13,
                  ),
                ),
                Spacer(),
                Obx(() {
                  return cPController.selectedIndex.value == index
                      ? Icon(
                          Icons.done,
                          color: Colors.white,
                        )
                      : SizedBox();
                })
              ],
            ),
          ),
          index == cPController.length - 1 ? Container() : AppDivider(),
        ],
      ),
    );
  }
}
