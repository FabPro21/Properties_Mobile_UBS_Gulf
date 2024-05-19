import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/public_views/search_properties_search/get_unit_type/get_unit_type_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'get_property_category_controller.dart';

class GetPropertyCategory extends StatefulWidget {
  GetPropertyCategory({Key key}) : super(key: key);

  @override
  State<GetPropertyCategory> createState() => _GetPropertyCategoryState();
}

class _GetPropertyCategoryState extends State<GetPropertyCategory> {
  final TextEditingController searchControler = TextEditingController();

  var gPCController = Get.put(GetPropertyCategoryController());
  var _controller = Get.put(GetUnitTypeController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
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
                        AppMetaLabels().category,
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
                            AppMetaLabels().selectCategory,
                            // "Select Category",
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
                              hintText: AppMetaLabels().searchCategory,
                              hintStyle: AppTextStyle.normalBlack10
                                  .copyWith(color: Colors.grey),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(2.0.h),
                          child: Obx(() {
                            return gPCController.loadingData.value == true
                                ? Padding(
                                    padding: EdgeInsets.only(top: 10.0.h),
                                    child: LoadingIndicatorBlue(),
                                  )
                                : gPCController.error.value != ''
                                    ? AppErrorWidget(
                                        errorText: gPCController.error.value,
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: gPCController.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          if (searchControler.text.isEmpty) {
                                            return selectLocation(index);
                                          } else if ((gPCController
                                                          .getPropertyCategory
                                                          .value
                                                          .propertyCategory[
                                                              index]
                                                          .propertyCategory ??
                                                      "")
                                                  .toLowerCase()
                                                  .contains(
                                                      searchControler.text) ||
                                              (gPCController
                                                              .getPropertyCategory
                                                              .value
                                                              .propertyCategory[
                                                                  index]
                                                              .propertyCategory ??
                                                          "")
                                                      .toLowerCase()
                                                      .contains(searchControler
                                                          .text) &&
                                                  SessionController()
                                                          .getLanguage() ==
                                                      1) {
                                            return selectLocation(index);
                                          } else if ((gPCController
                                                          .getPropertyCategory
                                                          .value
                                                          .propertyCategory[
                                                              index]
                                                          .propertyCategoryAr ??
                                                      "")
                                                  .toLowerCase()
                                                  .contains(
                                                      searchControler.text) ||
                                              (gPCController
                                                              .getPropertyCategory
                                                              .value
                                                              .propertyCategory[
                                                                  index]
                                                              .propertyCategoryAr ??
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
        _controller.getData(SessionController().getLanguage() == 1
            ? gPCController.getPropertyCategory.value.propertyCategory[index]
                    .propertyCategory ??
                ""
            : gPCController.getPropertyCategory.value.propertyCategory[index]
                        .propertyCategory +
                    'AR' ??
                "");
        // _controller.getData(
        //  gPCController.getPropertyCategory.value
        //         .propertyCategory[index].propertyCategory ??
        //     "");
        // 112233 show area
        // SessionController().showArea.value =
        //     _controller.getUnitType.value.unitTypes.showArea;
        print("-------- ${SessionController().showArea} ---------");

        SessionController().setPropCatId(gPCController.getPropertyCategory.value
                .propertyCategory[index].propertyCategoryId
                .toString() ??
            "");
        SessionController().setPropCatName(gPCController.getPropertyCategory
                .value.propertyCategory[index].propertyCategory ??
            "");
        _controller.loadingData.value = true;
        _controller.loadingData.value = false;

        Get.back(result: [
          SessionController().getLanguage() == 1
              ? gPCController.getPropertyCategory.value.propertyCategory[index]
                      .propertyCategory ??
                  ""
              : gPCController.getPropertyCategory.value.propertyCategory[index]
                      .propertyCategoryAr ??
                  "",
          gPCController.getPropertyCategory.value.propertyCategory[index]
                  .propertyCategoryId
                  .toString() ??
              "",
          gPCController.getPropertyCategory.value.propertyCategory[index]
                  .propertyCategory
                  .toString() ??
              "",
        ]);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(2.0.h),
            child: Text(
              SessionController().getLanguage() == 1
                  ? gPCController.getPropertyCategory.value
                          .propertyCategory[index].propertyCategory ??
                      ""
                  : gPCController.getPropertyCategory.value
                          .propertyCategory[index].propertyCategoryAr ??
                      "",
              style: AppTextStyle.normalGrey10,
            ),
          ),
          index == gPCController.length - 1 ? Container() : AppDivider(),
        ],
      ),
    );
  }
}
