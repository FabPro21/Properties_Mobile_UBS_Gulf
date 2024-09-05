import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../data/helpers/session_controller.dart';
import 'get_unit_type_controller.dart';

class GetUnitType extends StatefulWidget {
  final String? categoryName;
  GetUnitType({Key? key, this.categoryName}) : super(key: key);

  @override
  State<GetUnitType> createState() => _GetUnitTypeState();
}

class _GetUnitTypeState extends State<GetUnitType> {
  final TextEditingController searchControler = TextEditingController();

  var gPCController = Get.put(GetUnitTypeController());
  @override
  void initState() {
    print(" ---------- ${widget.categoryName} ------------");
    gPCController.getData(SessionController().getLanguage() == 1
        ? widget.categoryName ?? ""
        : widget.categoryName! + 'AR');
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
                        AppMetaLabels().unitType,
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
                            AppMetaLabels().selectunitType,
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
                                  EdgeInsets.only(left: 5.0.w, right: 5.w),
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
                              hintText: AppMetaLabels().search,
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
                                : gPCController.error.value != ""
                                    ? AppErrorWidget(
                                        errorText: gPCController.error.value,
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: gPCController.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          // return selectLocation(index);
                                          if (searchControler.text.isEmpty) {
                                            return selectLocation(index);
                                          } else if ((gPCController
                                                          .getUnitType
                                                          .value
                                                          .unitTypes!
                                                          .unitTypes![index]
                                                          .unitTypeName ??
                                                      "")
                                                  .toLowerCase()
                                                  .contains(
                                                      searchControler.text) ||
                                              (gPCController
                                                              .getUnitType
                                                              .value
                                                              .unitTypes!
                                                              .unitTypes![index]
                                                              .unitTypeName ??
                                                          "")
                                                      .toLowerCase()
                                                      .contains(searchControler
                                                          .text) &&
                                                  SessionController()
                                                          .getLanguage() ==
                                                      1) {
                                            return selectLocation(index);
                                          } else if ((gPCController
                                                          .getUnitType
                                                          .value
                                                          .unitTypes!
                                                          .unitTypes![index]
                                                          .unitTypeNameAR ??
                                                      "")
                                                  .toLowerCase()
                                                  .contains(
                                                      searchControler.text) ||
                                              (gPCController
                                                              .getUnitType
                                                              .value
                                                              .unitTypes!
                                                              .unitTypes![index]
                                                              .unitTypeNameAR ??
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
        SessionController().setUnitTypeName(gPCController
                    .getUnitType.value.unitTypes!.unitTypes![index].unitTypeName!
                    .trim() ==
                'معسكر العمل'
            ? 'سكن عمال'
            : gPCController.getUnitType.value.unitTypes!.unitTypes![index]
                        .unitTypeName!
                        .trim() ==
                    'محال البيع بالتجزئة'
                ? 'متجر'
                : gPCController.getUnitType.value.unitTypes!.unitTypes![index]
                            .unitTypeName!
                            .trim() ==
                        'قاعة عرض'
                    ? 'صالة عرض'
                    : gPCController.getUnitType.value.unitTypes!.unitTypes![index]
                            .unitTypeName ??
                        "");
        var selecteUnitName = gPCController
                    .getUnitType.value.unitTypes!.unitTypes![index].unitTypeName!
                    .trim() ==
                'معسكر العمل'
            ? 'سكن عمال'
            : gPCController.getUnitType.value.unitTypes!.unitTypes![index]
                        .unitTypeName!
                        .trim() ==
                    'محال البيع بالتجزئة'
                ? 'متجر'
                : gPCController.getUnitType.value.unitTypes!.unitTypes![index]
                            .unitTypeName!
                            .trim() ==
                        'قاعة عرض'
                    ? 'صالة عرض'
                    : gPCController.getUnitType.value.unitTypes!.unitTypes![index]
                            .unitTypeName ??
                        "";
        Get.back(result: [selecteUnitName]);
        // Get.back(result: [
        //   gPCController
        //           .getUnitType.value.unitTypes!.unitTypes![index].unitTypeName ??
        //       ""
        //   // SessionController().getLanguage() == 1
        //   //     ? gPCController.getUnitType.value.unitTypes!.unitTypes![index]
        //   //             .unitTypeName ??
        //   //         ""
        //   //     : gPCController.getUnitType.value.unitTypes!.unitTypes![index]
        //   //             .unitTypeNameAR ??
        //   //         "",
        //   // gPCController.getUnitType.value.unitTypes!.showArea
        // ]);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(2.0.h),
            // do not change this becasue when we will send arabic unitTypeNameAR get arabic list of name
            // and when we will send english unitTypeName get english list of name
            child: Text(
              // gPCController.getUnitType.value.unitTypes!.unitTypes![index]
              //         .unitTypeName ??
              //     "",
              gPCController.getUnitType.value.unitTypes!.unitTypes![index]
                          .unitTypeName!
                          .trim() ==
                      'معسكر العمل'
                  ? 'سكن عمال'
                  : gPCController.getUnitType.value.unitTypes!.unitTypes![index]
                              .unitTypeName!
                              .trim() ==
                          'محال البيع بالتجزئة'
                      ? 'متجر'
                      : gPCController.getUnitType.value.unitTypes!
                                  .unitTypes![index].unitTypeName!
                                  .trim() ==
                              'قاعة عرض'
                          ? 'صالة عرض'
                          : gPCController.getUnitType.value.unitTypes!
                                  .unitTypes![index].unitTypeName ??
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
