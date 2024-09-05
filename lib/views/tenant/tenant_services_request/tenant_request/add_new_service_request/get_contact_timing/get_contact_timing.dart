import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'get_contact_timing_controller.dart';

class GetContactTiming extends StatefulWidget {
  GetContactTiming({Key? key}) : super(key: key);

  @override
  State<GetContactTiming> createState() => _GetContactTimingState();
}

class _GetContactTimingState extends State<GetContactTiming> {
  final TextEditingController searchControler = TextEditingController();
  var getCTController = Get.put(GetContactTimingController());

  @override
  void initState() {
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
                        AppMetaLabels().contactTime,
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
                            AppMetaLabels().contactTime,
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
                            return getCTController.loadingData.value == true
                                ? Padding(
                                    padding: EdgeInsets.only(top: 10.0.h),
                                    child: LoadingIndicatorBlue(),
                                  )
                                : getCTController.error.value != ''
                                    ? AppErrorWidget(
                                        errorText: getCTController.error.value,
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: getCTController.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          if (searchControler.text.isEmpty) {
                                            return selectServices(index);
                                          } else if ((getCTController
                                                      .getContactTiming
                                                      .value
                                                      .contactTiming![index]
                                                      .name ??
                                                  "")
                                              .toLowerCase()
                                              .contains(searchControler.text)) {
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
        SessionController().setCaseTypeId(
          getCTController.getContactTiming.value.contactTiming![index].id
                  .toString(),
        );
        Get.back(result: [
          getCTController.getContactTiming.value.contactTiming![index].name
                  .toString(),
          getCTController.getContactTiming.value.contactTiming![index].id
                  .toString(),
        ]);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(2.0.h),
            child: Text(
              getCTController
                      .getContactTiming.value.contactTiming![index].name ??
                  "",
              style: AppTextStyle.normalGrey10,
            ),
          ),
          index == getCTController.length - 1 ? Container() : AppDivider(),
        ],
      ),
    );
  }
}
