import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/public_views/search_properties_services_request/public_service_request_tab.dart';
import 'package:fap_properties/views/widgets/common_widgets/backbround_concave.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/common_widgets/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../data/helpers/session_controller.dart';
import 'public_service_request_controller.dart';

class PublicServiceRequestList extends StatefulWidget {
  const PublicServiceRequestList({Key? key}) : super(key: key);

  @override
  _PublicServiceRequestState createState() => _PublicServiceRequestState();
}

class _PublicServiceRequestState extends State<PublicServiceRequestList> {
  var getServicesController = Get.put(PublicServiceRequestController());
  final TextEditingController searchControler = TextEditingController();
  //GlobalKey _toolTipKey = GlobalKey();
  _getData() async {
    await getServicesController.getSericeRequest();
  }

  @override
  void initState() {
    _getData();
    //getServicesController.getSericeRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: SessionController().getLanguage() == 1
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: Stack(children: [
          AppBackgroundConcave(),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(2.5.h),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppMetaLabels().serviceRequests,
                      style: AppTextStyle.semiBoldWhite14,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 2.0.h,
                    right: 2.0.h,
                    top: 4.0.h,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1.0.h),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(0.3.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              autofocus: false,
                              controller: searchControler,
                              onChanged: (value) {
                                getServicesController.searchData(value.trim());
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.1),
                                prefixIcon: Icon(
                                  Icons.search,
                                  size: 2.0.h,
                                  color: Colors.grey,
                                ),
                                contentPadding:
                                    EdgeInsets.only(left: 5.0.w, right: 5.0.w),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.5.h),
                                  borderSide: BorderSide(
                                      color: AppColors.whiteColor,
                                      width: 0.1.h),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.5.h),
                                  borderSide: BorderSide(
                                      color: AppColors.whiteColor,
                                      width: 0.1.h),
                                ),
                                hintText: AppMetaLabels().searchServices,
                                hintStyle: AppTextStyle.normalBlack10
                                    .copyWith(color: Colors.grey),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              searchControler.clear();
                              getServicesController.getSericeRequest();
                              //getTSRController.getData();
                            },
                            icon: Icon(
                              Icons.refresh,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Obx(() {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 4.0.h, right: 2.0.h, left: 2.0.h, bottom: 2.0.h),
                      child: Container(
                        width: 92.0.w,
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
                        child: getServicesController.loadingData.value == true
                            ? LoadingIndicatorBlue()
                            : getServicesController.error.value != '' ||
                                    getServicesController.serviceReq.length == 0
                                ? Center(
                                    child: CustomErrorWidget(
                                      errorText: AppMetaLabels()
                                          .noServiceRequestsFound,
                                      errorImage: AppImagesPath.noServicesFound,
                                    ),
                                  )
                                : ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount:
                                        getServicesController.serviceReq.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            left: 2.5.w, right: 2.5.w),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 80.w,
                                              child: InkWell(
                                                onTap: () {
                                                  Get.to(
                                                    () =>
                                                        PublicServiceRequestTab(
                                                      // requestNo: 23838828,
                                                      requestNo:
                                                          getServicesController
                                                                  .serviceReq[
                                                                      index]
                                                                  .requestNo ??
                                                              0,
                                                      unitId: 123,
                                                      canCommunicate:
                                                          !getServicesController
                                                                  .serviceReq[
                                                                      index]
                                                                  .status!
                                                                  .toLowerCase()
                                                                  .contains(
                                                                      'closed') &&
                                                              !getServicesController
                                                                  .serviceReq[
                                                                      index]
                                                                  .status!
                                                                  .toLowerCase()
                                                                  .contains(
                                                                      'cancelled'),
                                                    ),
                                                  );
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 2.0.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          SessionController()
                                                                      .getLanguage() ==
                                                                  1
                                                              ? getServicesController
                                                                      .serviceReq[
                                                                          index]
                                                                      .category ??
                                                                  ""
                                                              : getServicesController
                                                                      .serviceReq[
                                                                          index]
                                                                      .categoryAR ??
                                                                  "",
                                                          style: AppTextStyle
                                                              .semiBoldGrey10,
                                                        ),
                                                        Spacer(),
                                                        Text(
                                                          getServicesController
                                                              .serviceReq[index]
                                                              .requestNo
                                                              .toString(),
                                                          //  "req no",
                                                          style: AppTextStyle
                                                              .semiBoldGrey10,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    Text(
                                                      SessionController()
                                                                  .getLanguage() ==
                                                              1
                                                          ? getServicesController
                                                                  .serviceReq[
                                                                      index]
                                                                  .subCategory ??
                                                              ""
                                                          : getServicesController
                                                                  .serviceReq[
                                                                      index]
                                                                  .subCategoryAR ??
                                                              "",
                                                      // "subcategory",
                                                      style: AppTextStyle
                                                          .normalGrey10,
                                                    ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    Text(
                                                      SessionController()
                                                                  .getLanguage() ==
                                                              1
                                                          ? getServicesController
                                                                  .serviceReq[
                                                                      index]
                                                                  .propertyName ??
                                                              ""
                                                          : getServicesController
                                                                  .serviceReq[
                                                                      index]
                                                                  .propertyNameAr ??
                                                              "",
                                                      // "propertyname",
                                                      style: AppTextStyle
                                                          .normalGrey10,
                                                    ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    Text(
                                                      getServicesController
                                                              .serviceReq[index]
                                                              .unitRefNo ??
                                                          "",
                                                      // "-Unitrefno",
                                                      style: AppTextStyle
                                                          .semiBoldGrey10,
                                                    ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 0.5.w),
                                                          child: Text(
                                                            getServicesController
                                                                    .serviceReq[
                                                                        index]
                                                                    .date ??
                                                                "",
                                                            // "date",
                                                            style: AppTextStyle
                                                                .semiBoldGrey10,
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        StatusWidget(
                                                          text: SessionController()
                                                                      .getLanguage() ==
                                                                  1
                                                              ? getServicesController
                                                                      .serviceReq[
                                                                          index]
                                                                      .status ??
                                                                  ""
                                                              : getServicesController
                                                                      .serviceReq[
                                                                          index]
                                                                      .statusAr ??
                                                                  "",
                                                          valueToCompare:
                                                              getServicesController
                                                                  .serviceReq[
                                                                      index]
                                                                  .status,
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 1.0.h,
                                                    ),
                                                    index ==
                                                            getServicesController
                                                                    .serviceReq
                                                                    .length -
                                                                1
                                                        ? Container()
                                                        : AppDivider(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(
                                                  () => PublicServiceRequestTab(
                                                    requestNo:
                                                        getServicesController
                                                                .serviceReq[
                                                                    index]
                                                                .requestNo ??
                                                            0,
                                                    unitId: 123,
                                                    canCommunicate:
                                                        !getServicesController
                                                                .serviceReq[
                                                                    index]
                                                                .status!
                                                                .toLowerCase()
                                                                .contains(
                                                                    'closed') &&
                                                            !getServicesController
                                                                .serviceReq[
                                                                    index]
                                                                .status!
                                                                .toLowerCase()
                                                                .contains(
                                                                    'cancelled'),
                                                  ),
                                                );
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right: 1.0.h, left: 1.h),
                                                child: SizedBox(
                                                  width: 0.15.w,
                                                  child: Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    color: AppColors.grey1,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
