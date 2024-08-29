import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'get_cities_controller.dart';

class GetCities extends StatefulWidget {
  GetCities({Key? key}) : super(key: key);

  @override
  State<GetCities> createState() => _GetCitiesState();
}

class _GetCitiesState extends State<GetCities> {
  final TextEditingController searchControler = TextEditingController();
  var getCitiesController = Get.put(GetCitiesController());

  @override
  Widget build(BuildContext context) {
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
                      AppMetaLabels().locationType,
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
                          AppMetaLabels().locationType,
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
                            contentPadding: EdgeInsets.only(left: 5.0.w),
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
                            hintText: AppMetaLabels().searchLocation,
                            hintStyle: AppTextStyle.normalBlack10
                                .copyWith(color: Colors.grey),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0.h),
                        child: Obx(() {
                          return getCitiesController.loadingData.value == true
                              ? Padding(
                                  padding: EdgeInsets.only(top: 10.0.h),
                                  child: LoadingIndicatorBlue(),
                                )
                              : getCitiesController.error.value != ''
                                  ? AppErrorWidget(
                                      errorText:
                                          getCitiesController.error.value,
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: getCitiesController.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        if (searchControler.text.isEmpty) {
                                          return selectLocation(index);
                                        } else if ((getCitiesController
                                                        .getCities
                                                        .value
                                                        .cities![index]
                                                        .cityName ??
                                                    "")
                                                .toLowerCase()
                                                .contains(
                                                    searchControler.text) ||
                                            (getCitiesController
                                                        .getCities
                                                        .value
                                                        .cities![index]
                                                        .cityName ??
                                                    "")
                                                .toLowerCase()
                                                .contains(
                                                    searchControler.text)) {
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
    );
  }

  InkWell selectLocation(int index) {
    return InkWell(
      onTap: () {
        Get.back(result: [
          getCitiesController.getCities.value.cities![index].cityName ?? "",
          getCitiesController.getCities.value.cities![index].cityId.toString() 
        ]);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(2.0.h),
            child: Text(
              getCitiesController.getCities.value.cities![index].cityName ?? "",
              style: AppTextStyle.normalGrey10,
            ),
          ),
          index == getCitiesController.length - 1 ? Container() : AppDivider(),
        ],
      ),
    );
  }
}
