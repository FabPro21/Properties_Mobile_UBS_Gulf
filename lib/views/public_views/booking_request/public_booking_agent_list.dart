import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/public_views/booking_request/booking_request_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PublicBookingAgentList extends StatefulWidget {
  const PublicBookingAgentList({Key? key}) : super(key: key);

  @override
  _PublicBookingAgentListState createState() => _PublicBookingAgentListState();
}

class _PublicBookingAgentListState extends State<PublicBookingAgentList> {
  final TextEditingController searchControler = TextEditingController();

  var agentController = Get.put(BookingRequestController());

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
                        AppMetaLabels().agentList,
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
                            AppMetaLabels().selectAgent,
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
                              contentPadding: EdgeInsets.only(left: 5.0.w,right:5.w),
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
                              hintText: AppMetaLabels().searchAgent,
                              hintStyle: AppTextStyle.normalBlack10
                                  .copyWith(color: Colors.grey),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(2.0.h),
                          child: Obx(() {
                            return agentController.loadingAgent.value == true
                                ? Padding(
                                    padding: EdgeInsets.only(top: 10.0.h),
                                    child: LoadingIndicatorBlue(),
                                  )
                                : agentController.errorAgent.value != ''
                                    ? AppErrorWidget(
                                        errorText:
                                            agentController.errorAgent.value,
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: agentController.lengthAgent,
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          if (searchControler.text.isEmpty) {
                                            return selectAgent(index);
                                          } else if ((agentController
                                                          .selectAgent
                                                          .value
                                                          .agentList![index]
                                                          .agentName ??
                                                      "")
                                                  .toLowerCase()
                                                  .contains(
                                                      searchControler.text) ||
                                              (agentController
                                                              .selectAgent
                                                              .value
                                                              .agentList![index]
                                                              .agentName ??
                                                          "")
                                                      .toLowerCase()
                                                      .contains(searchControler
                                                          .text) &&
                                                  SessionController()
                                                          .getLanguage() ==
                                                      1) {
                                            return selectAgent(index);
                                          } else if ((agentController
                                                          .selectAgent
                                                          .value
                                                          .agentList![index]
                                                          .agentName ??
                                                      "")
                                                  .toLowerCase()
                                                  .contains(
                                                      searchControler.text) ||
                                              (agentController
                                                              .selectAgent
                                                              .value
                                                              .agentList![index]
                                                              .agentName ??
                                                          "")
                                                      .toLowerCase()
                                                      .contains(searchControler
                                                          .text) &&
                                                  SessionController()
                                                          .getLanguage() !=
                                                      1) {
                                            return selectAgent(index);
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

  InkWell selectAgent(int index) {
    return InkWell(
      onTap: () async {
        Get.back(result: [
          SessionController().getLanguage() == 1
              ? agentController.selectAgent.value.agentList![index].agentName ??
                  ""
              : agentController.selectAgent.value.agentList![index].nameAr ?? "",
          agentController.selectAgent.value.agentList![index].agentId
                  .toString() 
        ]);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(2.0.h),
            child: Text(
              SessionController().getLanguage() == 1
                  ? agentController
                          .selectAgent.value.agentList![index].agentName ??
                      ""
                  : agentController.selectAgent.value.agentList![index].nameAr ??
                      "",
              style: AppTextStyle.normalGrey10,
            ),
          ),
          index == agentController.lengthAgent - 1 ? Container() : AppDivider(),
        ],
      ),
    );
  }
}
