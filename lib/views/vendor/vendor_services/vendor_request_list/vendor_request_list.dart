import 'package:fap_properties/data/helpers/session_controller.dart';

import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/backbround_concave.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/vendor/vendor_services/vendor_request_list/vendor_request_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/common_widgets/status_widget.dart';
import '../vendor_request_details/vendor_request_details.dart';

class VendorRequestList extends StatefulWidget {
  const VendorRequestList({Key? key}) : super(key: key);

  @override
  _VendorRequestListState createState() => _VendorRequestListState();
}

class _VendorRequestListState extends State<VendorRequestList> {
  final getVSRController = Get.put(GetVendorServiceRequestsController());
  final searchTextController = TextEditingController();

  @override
  void initState() {
    getVSRController.pageNo = '1';
    getVSRController.errorLoadMore.value = '';
    getVSRController.loadingDataLoadMore.value = false;
    getVSRController.getDataPagination(getVSRController.pageNo, '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ************** Note *************** //
    // Must Update for both users Technician and other user
    // based on SessionController().vendorUserType == 'Technician'
    // ************** Note *************** //
    return SessionController().vendorUserType == 'Technician'
        ? Directionality(
            textDirection: SessionController().getLanguage() == 1
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: Stack(
              children: [
                SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 2.0.h, right: 2.0.h, top: 6.0.h),
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
                                    // inputFormatters: TextInputFormatter()
                                    //     .searchPropertyNameContractNoIF,
                                    controller: searchTextController,
                                    onChanged: (value) async {
                                      // getVSRController.searchData(value);
                                      getVSRController.pageNo = '1';
                                      await getVSRController.getDataPagination(
                                          getVSRController.pageNo,
                                          value.trim());
                                      setState(() {});

                                      if (value.isEmpty) {
                                        await getVSRController
                                            .getDataPagination(
                                                getVSRController.pageNo, '');
                                        setState(() {});
                                      }
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey.withOpacity(0.1),
                                      prefixIcon: Icon(
                                        Icons.search,
                                        size: 2.0.h,
                                        color: Colors.grey,
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          left: 5.0.w, right: 5.0.w),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(0.5.h),
                                        borderSide: BorderSide(
                                            color: AppColors.whiteColor,
                                            width: 0.1.h),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(0.5.h),
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
                                    searchTextController.clear();
                                    // getVSRController.getData();
                                    getVSRController.getDataPagination(
                                        getVSRController.pageNo, '');
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
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 4.0.h,
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(minHeight: 50.h),
                            child: Container(
                              width: 92.0.w,
                              margin: EdgeInsets.all(1.5.h),
                              padding: EdgeInsets.only(top: 0.5.h),
                              // height: 70.5.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2.0.h),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 0.4.h,
                                    spreadRadius: 0.4.h,
                                    offset: Offset(0.1.h, 0.1.h),
                                  ),
                                ],
                              ),
                              child: Obx(() {
                                return getVSRController.loadingData.value ==
                                        true
                                    ? Center(
                                        child: LoadingIndicatorBlue(),
                                      )
                                    : getVSRController.error.value != ''
                                        ? AppErrorWidget(
                                            errorText:
                                                getVSRController.error.value,
                                          )
                                        : ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            itemCount:
                                                getVSRController.svcReqs.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    left: 2.0.h, right: 2.0.h),
                                                child: InkWell(
                                                  onTap: () {
                                                    SessionController()
                                                        .setCaseNo(
                                                      getVSRController
                                                          .svcReqs[index]
                                                          .requestNo
                                                          .toString(),
                                                    );

                                                    Get.to(
                                                      () =>
                                                          VendorRequestDetails(
                                                        caseNo: getVSRController
                                                            .svcReqs[index]
                                                            .requestNo,
                                                        status: getVSRController
                                                                    .svcReqs[
                                                                        index]
                                                                    .status!
                                                                    .toLowerCase() ==
                                                                "closed"
                                                            ? true
                                                            : false,
                                                      ),
                                                    );
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
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
                                                                      ? getVSRController
                                                                              .svcReqs[
                                                                                  index]
                                                                              .category ??
                                                                          ""
                                                                      : getVSRController
                                                                              .svcReqs[index]
                                                                              .categoryAR ??
                                                                          "",
                                                                  style: AppTextStyle
                                                                      .semiBoldGrey10,
                                                                ),
                                                                Spacer(),
                                                                Text(
                                                                  getVSRController
                                                                      .svcReqs[
                                                                          index]
                                                                      .requestNo
                                                                      .toString(),
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
                                                                  ? getVSRController
                                                                          .svcReqs[
                                                                              index]
                                                                          .subCategory ??
                                                                      ""
                                                                  : getVSRController
                                                                          .svcReqs[
                                                                              index]
                                                                          .subcategoryAR ??
                                                                      "",
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
                                                                  ? getVSRController
                                                                          .svcReqs[
                                                                              index]
                                                                          .propertyName ??
                                                                      ""
                                                                  : getVSRController
                                                                          .svcReqs[
                                                                              index]
                                                                          .propertyNameAR ??
                                                                      "",
                                                              style: AppTextStyle
                                                                  .normalGrey10,
                                                            ),
                                                            SizedBox(
                                                              height: 1.h,
                                                            ),
                                                            Text(
                                                              getVSRController
                                                                      .svcReqs[
                                                                          index]
                                                                      .unitRefNo ??
                                                                  "-",
                                                              style: AppTextStyle
                                                                  .semiBoldGrey10,
                                                            ),
                                                            SizedBox(
                                                              height: 1.h,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  getVSRController
                                                                          .svcReqs[
                                                                              index]
                                                                          .date ??
                                                                      "",
                                                                  style: AppTextStyle
                                                                      .semiBoldGrey10,
                                                                ),
                                                                Spacer(),
                                                                getVSRController.svcReqs[index].status!.trim() ==
                                                                            'Received' &&
                                                                        getVSRController.svcReqs[index].category!.trim() ==
                                                                            'Supplier Invoice'
                                                                    ? StatusWidgetVendor(
                                                                        text: AppMetaLabels()
                                                                            .submitted,
                                                                        valueToCompare: getVSRController
                                                                            .svcReqs[index]
                                                                            .status,
                                                                      )
                                                                    : StatusWidgetVendor(
                                                                        text: SessionController().getLanguage() == 1
                                                                            ? getVSRController.svcReqs[index].status ??
                                                                                ""
                                                                            : getVSRController.svcReqs[index].statusAR ??
                                                                                "",
                                                                        valueToCompare: getVSRController
                                                                            .svcReqs[index]
                                                                            .status,
                                                                      )
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 2.0.h,
                                                            ),
                                                            index ==
                                                                    getVSRController
                                                                            .svcReqs
                                                                            .length -
                                                                        1
                                                                ? Container()
                                                                : AppDivider(),
                                                            index ==
                                                                    getVSRController
                                                                            .svcReqs
                                                                            .length -
                                                                        1
                                                                ? getVSRController
                                                                            .svcReqs
                                                                            .length <
                                                                        20
                                                                    ? SizedBox()
                                                                    // : _controller
                                                                    //         .isSearch.value
                                                                    //     ? SizedBox()
                                                                    : Center(
                                                                        child: Obx(
                                                                            () {
                                                                          return getVSRController.errorLoadMore.value != ''
                                                                              ? SizedBox(
                                                                                  height: 2.h,
                                                                                )
                                                                              : getVSRController.loadingDataLoadMore.value
                                                                                  ? SizedBox(
                                                                                      width: 75.w,
                                                                                      height: 5.h,
                                                                                      child: Center(
                                                                                        child: LoadingIndicatorBlue(),
                                                                                      ),
                                                                                    )
                                                                                  : InkWell(
                                                                                      onTap: () async {
                                                                                        int pageSize = int.parse(getVSRController.pageNo);
                                                                                        int naePageNo = pageSize + 1;
                                                                                        getVSRController.pageNo = naePageNo.toString();
                                                                                        if (searchTextController.text == '') {
                                                                                          await getVSRController.getDataPaginationLoadMore(getVSRController.pageNo, '');
                                                                                        } else {
                                                                                          await getVSRController.getDataPaginationLoadMore(getVSRController.pageNo, searchTextController.text);
                                                                                        }
                                                                                        setState(() {});
                                                                                      },
                                                                                      child: Padding(
                                                                                        padding: EdgeInsets.only(top: 0.5.h),
                                                                                        child: SizedBox(
                                                                                            width: 85.w,
                                                                                            height: 3.h,
                                                                                            child: RichText(
                                                                                              textAlign: TextAlign.right,
                                                                                              text: TextSpan(
                                                                                                children: [
                                                                                                  TextSpan(
                                                                                                    text: AppMetaLabels().loadMoreData,
                                                                                                    style: TextStyle(
                                                                                                      color: Colors.blue,
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                    ),
                                                                                                  ),
                                                                                                  WidgetSpan(
                                                                                                    child: Icon(
                                                                                                      Icons.arrow_forward_ios,
                                                                                                      size: 15,
                                                                                                      color: Colors.blue,
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            )),
                                                                                      ),
                                                                                    );
                                                                        }),
                                                                      )
                                                                : SizedBox(),
                                                            SizedBox(
                                                              height: 1.5.h,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 1.0.h,
                                                                left: 1.h),
                                                        child: SizedBox(
                                                          width: 0.15.w,
                                                          child: Icon(
                                                            Icons
                                                                .arrow_forward_ios_rounded,
                                                            color:
                                                                AppColors.grey1,
                                                            size: 20,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                              }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: Directionality(
              textDirection: SessionController().getLanguage() == 1
                  ? TextDirection.ltr
                  : TextDirection.rtl,
              child: Stack(
                children: [
                  AppBackgroundConcave(),
                  SafeArea(
                    child: Column(
                      children: [
                         Padding(
                                padding: EdgeInsets.only(
                                    top: 3.0.h, left: 4.w, right: 4.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      AppMetaLabels().serviceRequests,
                                      style: AppTextStyle.semiBoldWhite15,
                                    ),
                                    SizedBox(
                                      width: 24,
                                    )
                                  ],
                                ),
                              ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 2.0.h, right: 2.0.h, top: 6.0.h),
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
                                      // inputFormatters: TextInputFormatter()
                                      //     .searchPropertyNameContractNoIF,
                                      controller: searchTextController,
                                      onChanged: (value) async {
                                        // getVSRController.searchData(value);
                                        getVSRController.pageNo = '1';
                                        await getVSRController
                                            .getDataPagination(
                                                getVSRController.pageNo,
                                                value.trim());
                                        setState(() {});

                                        if (value.isEmpty) {
                                          await getVSRController
                                              .getDataPagination(
                                                  getVSRController.pageNo, '');
                                          setState(() {});
                                        }
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey.withOpacity(0.1),
                                        prefixIcon: Icon(
                                          Icons.search,
                                          size: 2.0.h,
                                          color: Colors.grey,
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            left: 5.0.w, right: 5.0.w),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(0.5.h),
                                          borderSide: BorderSide(
                                              color: AppColors.whiteColor,
                                              width: 0.1.h),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(0.5.h),
                                          borderSide: BorderSide(
                                              color: AppColors.whiteColor,
                                              width: 0.1.h),
                                        ),
                                        hintText:
                                            AppMetaLabels().searchServices,
                                        hintStyle: AppTextStyle.normalBlack10
                                            .copyWith(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();
                                      searchTextController.clear();
                                      // getVSRController.getData();
                                      getVSRController.getDataPagination(
                                          getVSRController.pageNo, '');
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
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 4.0.h,
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(minHeight: 50.h),
                              child: Container(
                                width: 92.0.w,
                                margin: EdgeInsets.all(1.5.h),
                                padding: EdgeInsets.only(top: 0.5.h),
                                // height: 70.5.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(2.0.h),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 0.4.h,
                                      spreadRadius: 0.4.h,
                                      offset: Offset(0.1.h, 0.1.h),
                                    ),
                                  ],
                                ),
                                child: Obx(() {
                                  return getVSRController.loadingData.value ==
                                          true
                                      ? Center(
                                          child: LoadingIndicatorBlue(),
                                        )
                                      : getVSRController.error.value != ''
                                          ? AppErrorWidget(
                                              errorText:
                                                  getVSRController.error.value,
                                            )
                                          : ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              itemCount: getVSRController
                                                  .svcReqs.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 2.0.h,
                                                      right: 2.0.h),
                                                  child: InkWell(
                                                    onTap: () {
                                                      SessionController()
                                                          .setCaseNo(
                                                        getVSRController
                                                            .svcReqs[index]
                                                            .requestNo
                                                            .toString(),
                                                      );

                                                      Get.to(
                                                        () =>
                                                            VendorRequestDetails(
                                                          caseNo:
                                                              getVSRController
                                                                  .svcReqs[
                                                                      index]
                                                                  .requestNo,
                                                          status: getVSRController
                                                                      .svcReqs[
                                                                          index]
                                                                      .status!
                                                                      .toLowerCase() ==
                                                                  "closed"
                                                              ? true
                                                              : false,
                                                        ),
                                                      );
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                height: 2.0.h,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    SessionController().getLanguage() ==
                                                                            1
                                                                        ? getVSRController.svcReqs[index].category ??
                                                                            ""
                                                                        : getVSRController.svcReqs[index].categoryAR ??
                                                                            "",
                                                                    style: AppTextStyle
                                                                        .semiBoldGrey10,
                                                                  ),
                                                                  Spacer(),
                                                                  Text(
                                                                    getVSRController
                                                                        .svcReqs[
                                                                            index]
                                                                        .requestNo
                                                                        .toString(),
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
                                                                    ? getVSRController
                                                                            .svcReqs[
                                                                                index]
                                                                            .subCategory ??
                                                                        ""
                                                                    : getVSRController
                                                                            .svcReqs[index]
                                                                            .subcategoryAR ??
                                                                        "",
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
                                                                    ? getVSRController
                                                                            .svcReqs[
                                                                                index]
                                                                            .propertyName ??
                                                                        ""
                                                                    : getVSRController
                                                                            .svcReqs[index]
                                                                            .propertyNameAR ??
                                                                        "",
                                                                style: AppTextStyle
                                                                    .normalGrey10,
                                                              ),
                                                              SizedBox(
                                                                height: 1.h,
                                                              ),
                                                              Text(
                                                                getVSRController
                                                                        .svcReqs[
                                                                            index]
                                                                        .unitRefNo ??
                                                                    "-",
                                                                style: AppTextStyle
                                                                    .semiBoldGrey10,
                                                              ),
                                                              SizedBox(
                                                                height: 1.h,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    getVSRController
                                                                            .svcReqs[index]
                                                                            .date ??
                                                                        "",
                                                                    style: AppTextStyle
                                                                        .semiBoldGrey10,
                                                                  ),
                                                                  Spacer(),
                                                                  getVSRController.svcReqs[index].status!.trim() ==
                                                                              'Received' &&
                                                                          getVSRController.svcReqs[index].category!.trim() ==
                                                                              'Supplier Invoice'
                                                                      ? StatusWidgetVendor(
                                                                          text:
                                                                              AppMetaLabels().submitted,
                                                                          valueToCompare: getVSRController
                                                                              .svcReqs[index]
                                                                              .status,
                                                                        )
                                                                      : StatusWidgetVendor(
                                                                          text: SessionController().getLanguage() == 1
                                                                              ? getVSRController.svcReqs[index].status ?? ""
                                                                              : getVSRController.svcReqs[index].statusAR ?? "",
                                                                          valueToCompare: getVSRController
                                                                              .svcReqs[index]
                                                                              .status,
                                                                        )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 2.0.h,
                                                              ),
                                                              index ==
                                                                      getVSRController
                                                                              .svcReqs
                                                                              .length -
                                                                          1
                                                                  ? Container()
                                                                  : AppDivider(),
                                                              index ==
                                                                      getVSRController
                                                                              .svcReqs
                                                                              .length -
                                                                          1
                                                                  ? getVSRController
                                                                              .svcReqs
                                                                              .length <
                                                                          20
                                                                      ? SizedBox()
                                                                      // : _controller
                                                                      //         .isSearch.value
                                                                      //     ? SizedBox()
                                                                      : Center(
                                                                          child:
                                                                              Obx(() {
                                                                            return getVSRController.errorLoadMore.value != ''
                                                                                ? SizedBox(
                                                                                    height: 2.h,
                                                                                  )
                                                                                : getVSRController.loadingDataLoadMore.value
                                                                                    ? SizedBox(
                                                                                        width: 75.w,
                                                                                        height: 5.h,
                                                                                        child: Center(
                                                                                          child: LoadingIndicatorBlue(),
                                                                                        ),
                                                                                      )
                                                                                    : InkWell(
                                                                                        onTap: () async {
                                                                                          int pageSize = int.parse(getVSRController.pageNo);
                                                                                          int naePageNo = pageSize + 1;
                                                                                          getVSRController.pageNo = naePageNo.toString();
                                                                                          if (searchTextController.text == '') {
                                                                                            await getVSRController.getDataPaginationLoadMore(getVSRController.pageNo, '');
                                                                                          } else {
                                                                                            await getVSRController.getDataPaginationLoadMore(getVSRController.pageNo, searchTextController.text);
                                                                                          }
                                                                                          setState(() {});
                                                                                        },
                                                                                        child: Padding(
                                                                                          padding: EdgeInsets.only(top: 0.5.h),
                                                                                          child: SizedBox(
                                                                                              width: 85.w,
                                                                                              height: 3.h,
                                                                                              child: RichText(
                                                                                                textAlign: TextAlign.right,
                                                                                                text: TextSpan(
                                                                                                  children: [
                                                                                                    TextSpan(
                                                                                                      text: AppMetaLabels().loadMoreData,
                                                                                                      style: TextStyle(
                                                                                                        color: Colors.blue,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                      ),
                                                                                                    ),
                                                                                                    WidgetSpan(
                                                                                                      child: Icon(
                                                                                                        Icons.arrow_forward_ios,
                                                                                                        size: 15,
                                                                                                        color: Colors.blue,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              )),
                                                                                        ),
                                                                                      );
                                                                          }),
                                                                        )
                                                                  : SizedBox(),
                                                              SizedBox(
                                                                height: 1.5.h,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 1.0.h,
                                                                  left: 1.h),
                                                          child: SizedBox(
                                                            width: 0.15.w,
                                                            child: Icon(
                                                              Icons
                                                                  .arrow_forward_ios_rounded,
                                                              color: AppColors
                                                                  .grey1,
                                                              size: 20,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                }),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
