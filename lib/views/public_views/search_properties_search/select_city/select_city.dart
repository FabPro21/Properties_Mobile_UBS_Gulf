import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;
import 'select_city_controller.dart';

class SelectCity extends StatefulWidget {
  SelectCity({Key key}) : super(key: key);

  @override
  State<SelectCity> createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  final TextEditingController searchControler = TextEditingController();
  var selectCityController = Get.put(SelectCityController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? ui.TextDirection.ltr
          : ui.TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 2.0.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 2.0.h, right: 2.0.h),
                  child: Row(
                    children: [
                      Text(
                        AppMetaLabels().city,
                        style: AppTextStyle.semiBoldBlack16,
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.cancel_outlined,
                          color: Colors.grey,
                          size: 3.5.h,
                        ),
                      ),
                    ],
                  ),
                ),
                AppDivider(),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.0.h, vertical: 2.0.h),
                          child: Text(
                            AppMetaLabels().selectCity,
                            style: AppTextStyle.semiBoldBlack11,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1.0.h),
                          child: TextField(
                            controller: searchControler,
                            onChanged: (value) {
                              searchControler.text = value;
                              searchControler.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset: searchControler.text.length));
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.search,
                                size: 2.0.h,
                                color: Colors.grey,
                              ),
                              contentPadding:
                                  EdgeInsets.only(left: 5.0.w, right: 5.0.w),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0.5.h),
                                borderSide: BorderSide(
                                    color: Colors.blue, width: 0.1.h),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0.5.h),
                                borderSide: BorderSide(
                                    color: Colors.blue, width: 0.1.h),
                              ),
                              hintText: AppMetaLabels().searchCity,
                              hintStyle: AppTextStyle.normalBlack10
                                  .copyWith(color: Colors.grey),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(2.0.h),
                          child: Obx(() {
                            return selectCityController.loadingData.value ==
                                    true
                                ? Padding(
                                    padding: EdgeInsets.only(top: 10.0.h),
                                    child: LoadingIndicatorBlue(),
                                  )
                                : selectCityController.error.value != ''
                                    ? AppErrorWidget(
                                        errorText:
                                            selectCityController.error.value,
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: selectCityController.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          if (searchControler.text.isEmpty) {
                                            return selectLocation(index);
                                          } else if ((selectCityController
                                                          .selectCity
                                                          .value
                                                          .emirate[index]
                                                          .emirateName ??
                                                      "")
                                                  .toLowerCase()
                                                  .contains(
                                                      searchControler.text) ||
                                              (selectCityController
                                                              .selectCity
                                                              .value
                                                              .emirate[index]
                                                              .emirateName ??
                                                          "")
                                                      .toLowerCase()
                                                      .contains(searchControler
                                                          .text) &&
                                                  SessionController()
                                                          .getLanguage() ==
                                                      1) {
                                            return selectLocation(index);
                                          } else if ((selectCityController
                                                          .selectCity
                                                          .value
                                                          .emirate[index]
                                                          .emirateNameAr ??
                                                      "")
                                                  .toLowerCase()
                                                  .contains(
                                                      searchControler.text) ||
                                              (selectCityController
                                                              .selectCity
                                                              .value
                                                              .emirate[index]
                                                              .emirateNameAr ??
                                                          "")
                                                      .toLowerCase()
                                                      .contains(searchControler
                                                          .text) &&
                                                  SessionController()
                                                          .getLanguage() !=
                                                      1) {
                                            return selectLocation(index);
                                          } else {
                                            return Container();
                                          }
                                        });
                          }),
                        ),
                      ],
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

  InkWell selectLocation(int index) {
    return InkWell(
      onTap: () async {
        SessionController().setCityId(selectCityController
                .selectCity.value.emirate[index].emirateId
                .toString() ??
            "");
        Get.back(result: [
          SessionController().getLanguage() == 1
              ? selectCityController
                      .selectCity.value.emirate[index].emirateName ??
                  ""
              : selectCityController
                      .selectCity.value.emirate[index].emirateNameAr ??
                  "",
          selectCityController.selectCity.value.emirate[index].emirateId
                  .toString() ??
              ""
        ]);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(2.0.h),
            child: Text(
              SessionController().getLanguage() == 1
                  ? selectCityController
                          .selectCity.value.emirate[index].emirateName ??
                      ""
                  : selectCityController
                          .selectCity.value.emirate[index].emirateNameAr ??
                      "",
              style: AppTextStyle.normalGrey10,
            ),
          ),
          index == selectCityController.length - 1 ? Container() : AppDivider(),
        ],
      ),
    );
  }
}
