import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../data/helpers/session_controller.dart';
import 'get_tenant_properties_controller.dart';

class GetTenantProperties extends StatefulWidget {
  GetTenantProperties({Key? key}) : super(key: key);

  @override
  State<GetTenantProperties> createState() => _GetTenantPropertiesState();
}

class _GetTenantPropertiesState extends State<GetTenantProperties> {
  final TextEditingController searchControler = TextEditingController();
  var getTPController = Get.find<GetTenantPropertiesController>();

  @override
  Widget build(BuildContext context) {
    getTPController.getData();
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Obx(() {
        return Scaffold(
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
                          AppMetaLabels().property,
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
                              AppMetaLabels().selectProperty,
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
                                contentPadding: EdgeInsets.only(left: 5.0.w,right: 5.w),
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
                            child: getTPController.loadingData.value == true
                                ? Padding(
                                    padding: EdgeInsets.only(top: 10.0.h),
                                    child: LoadingIndicatorBlue(),
                                  )
                                : getTPController.error.value != ''
                                    ? AppErrorWidget(
                                        errorText: getTPController.error.value,
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: getTPController.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          if (searchControler.text.isEmpty) {
                                            return selectPropertys(index);
                                          } else if ((getTPController
                                                      .getTenantProperties
                                                      .value
                                                      .properties![index]
                                                      .unitName ??
                                                  "")
                                              .toLowerCase()
                                              .contains(searchControler.text)) {
                                            return selectPropertys(index);
                                          } else {
                                            return Container();
                                          }
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
        );
      }),
    );
  }

  InkWell selectPropertys(int index) {
    return InkWell(
      onTap: () {
        Get.back(result: [

        SessionController().getLanguage() == 1
                        ?  getTPController.getTenantProperties.value.properties![index]
                      .propertyName ??
                  ""
                        :  getTPController.getTenantProperties.value.properties![index]
                      .propertyNameAR ??
                  "",
          getTPController
                  .getTenantProperties.value.properties![index].contractUnitID
                  .toString() ,
        ]);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(4.0.w, 2.h, 4.0.w, 1.0.h),
            child: Text(
              SessionController().getLanguage() == 1
                        ?  getTPController.getTenantProperties.value.properties![index]
                      .propertyName ??
                  ""
                        :  getTPController.getTenantProperties.value.properties![index]
                      .propertyNameAR ??
                  "",
            
              style: AppTextStyle.normalGrey10,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(4.0.w, 0, 4.0.w, 2.0.h),
            child: Text(
              SessionController().getLanguage() == 1?  getTPController
                      .getTenantProperties.value.properties![index].unitName ??
                  "":getTPController
                      .getTenantProperties.value.properties![index].unitNameAr ??
                  "",
              style: AppTextStyle.semiBoldGrey10,
            ),
          ),
          index == getTPController.length - 1 ? Container() : AppDivider(),
        ],
      ),
    );
  }
}
