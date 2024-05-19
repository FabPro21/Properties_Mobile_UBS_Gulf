import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request/add_new_service_request/tenant_sub_case_category/tenant_sub_case_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class TenantSubCaseCategory extends StatefulWidget {
  TenantSubCaseCategory({Key key}) : super(key: key);

  @override
  State<TenantSubCaseCategory> createState() => _TenantSubCaseCategoryState();
}

class _TenantSubCaseCategoryState extends State<TenantSubCaseCategory> {
  final TextEditingController searchControler = TextEditingController();
  var caseSubCategoryController = Get.put(CaseSubCategoryController());

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
                        AppMetaLabels().subCategory,
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
                            AppMetaLabels().selectSubCategory,
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
                              contentPadding: EdgeInsets.only(left: 5.0.w,right: 5.0.w),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0.5.h),
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 0.1.h),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0.5.h),
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 0.1.h),
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
                            return caseSubCategoryController.loadingData.value ==
                                    true
                                ? Padding(
                                    padding: EdgeInsets.only(top: 10.0.h),
                                    child: LoadingIndicatorBlue(),
                                  )
                                : caseSubCategoryController.error.value != ''
                                    ? AppErrorWidget(
                                        errorText:
                                            caseSubCategoryController.error.value,
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            caseSubCategoryController.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          if (searchControler.text.isEmpty) {
                                            return selectServices(index);
                                          } else if ((caseSubCategoryController
                                                          .caseSubCategory
                                                          .value
                                                          .caseSubCategories[
                                                              index]
                                                          .name ??
                                                      "")
                                                  .toLowerCase()
                                                  .contains(
                                                      searchControler.text) ||
                                              (caseSubCategoryController
                                                          .caseSubCategory
                                                          .value
                                                          .caseSubCategories[
                                                              index]
                                                          .name ??
                                                      "")
                                                  .toLowerCase()
                                                  .contains(
                                                      searchControler.text)) {
                                            return selectServices(index);
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

  InkWell selectServices(int index) {
    return InkWell(
      onTap: () {
        SessionController().setCaseCategoryId(
          caseSubCategoryController
                  .caseSubCategory.value.caseSubCategories[index].id
                  .toString() ??
              "",
        );
        Get.back(result: [
       SessionController().getLanguage()==1?   caseSubCategoryController
                  .caseSubCategory.value.caseSubCategories[index].name
                  .toString() ??
              "":caseSubCategoryController
                  .caseSubCategory.value.caseSubCategories[index].nameAR
                  .toString() ??
              "",
          caseSubCategoryController
                  .caseSubCategory.value.caseSubCategories[index].id
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
            SessionController().getLanguage() == 1?  caseSubCategoryController
                      .caseSubCategory.value.caseSubCategories[index].name ??
                  "":caseSubCategoryController
                      .caseSubCategory.value.caseSubCategories[index].nameAR ??
                  "",
              style: AppTextStyle.normalGrey10,
            ),
          ),
          index == caseSubCategoryController.length - 1
              ? Container()
              : AppDivider(),
        ],
      ),
    );
  }
}
