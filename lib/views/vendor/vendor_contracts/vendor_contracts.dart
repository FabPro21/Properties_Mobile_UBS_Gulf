import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/srno_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'vendor_contracts_controller.dart';
import 'vendor_contracts_tabs.dart/vendor_contracts_details.dart/vendor_contract_details.dart';

class VendorContractsScreen extends StatefulWidget {
  VendorContractsScreen({Key key}) : super(key: key);

  @override
  State<VendorContractsScreen> createState() => _VendorContractsScreenState();
}

class _VendorContractsScreenState extends State<VendorContractsScreen> {
  final VendorContractsController getContractsController = Get.find();

  final TextEditingController searchControler = TextEditingController();

  @override
  void initState() {
    getContractsController.pageNo = '1';
    getContractsController.pageNoFilter = '1';
    getContractsController.errorLoadMore.value = '';
    getContractsController.errorLoadMoreFilter.value = '';
    getContractsController.loadingDataLoadMore.value = false;
    getContractsController.getDataPagination(getContractsController.pageNo, '');
    // getContractsController.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 3.0.h),
                child: Text(
                  AppMetaLabels().contracts,
                  style: AppTextStyle.semiBoldWhite15,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.0.h, right: 2.0.h, top: 6.0.h),
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
                            controller: searchControler,
                            onChanged: (value) async {
                              // getContractsController.searchData(value);
                              getContractsController.pageNo = '1';
                              getContractsController.pageNoFilter = '1';
                              getContractsController.errorLoadMore.value = '';
                              getContractsController.errorLoadMoreFilter.value =
                                  '';
                              await getContractsController.getDataPagination(
                                  getContractsController.pageNo, value.trim());
                              setState(() {});

                              if (value.isEmpty) {
                                await getContractsController.getDataPagination(
                                    getContractsController.pageNo, '');
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
                              contentPadding:
                                  EdgeInsets.only(left: 5.0.w, right: 5.0.w),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0.5.h),
                                borderSide: BorderSide(
                                    color: AppColors.whiteColor, width: 0.1.h),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0.5.h),
                                borderSide: BorderSide(
                                    color: AppColors.whiteColor, width: 0.1.h),
                              ),
                              hintText: AppMetaLabels().searchContracts,
                              hintStyle: AppTextStyle.normalBlack10
                                  .copyWith(color: Colors.grey),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            searchControler.clear();
                            // getContractsController.getData();
                            getContractsController.pageNo = '1';
                            getContractsController.pageNoFilter = '1';
                            getContractsController.errorLoadMore.value = '';
                            getContractsController.errorLoadMoreFilter.value =
                                '';
                            getContractsController.getDataPagination(
                                getContractsController.pageNo, '');
                            setState(() {});
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
                  child: SingleChildScrollView(
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
                          return getContractsController.loadingData.value ==
                                  true
                              ? LoadingIndicatorBlue()
                              : getContractsController.error.value != ''
                                  ? CustomErrorWidget(
                                      errorText:
                                          AppMetaLabels().noContractsFound,
                                      errorImage:
                                          AppImagesPath.noContractsFound,
                                    )
                                  : Column(
                                      children: [
                                        ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: getContractsController
                                              .contracts.length,
                                          itemBuilder: (context, index) {
                                            return inkWell(index);
                                          },
                                        ),
                                        getContractsController
                                                    .contracts.length <
                                                19
                                            ? SizedBox()
                                            : getContractsController
                                                        .isFilter.value ==
                                                    false
                                                ? getContractsController
                                                            .errorLoadMore
                                                            .value !=
                                                        ''
                                                    ? SizedBox()
                                                    : InkWell(
                                                        onTap: () async {
                                                          int pageSize = int.parse(
                                                              getContractsController
                                                                  .pageNo);
                                                          int naePageNo =
                                                              pageSize + 1;
                                                          getContractsController
                                                                  .pageNo =
                                                              naePageNo
                                                                  .toString();
                                                          await getContractsController
                                                              .getDataPaginationLoadMore(
                                                                  getContractsController
                                                                      .pageNo,
                                                                  searchControler
                                                                      .text);
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          height: 5.h,
                                                          width: 95.w,
                                                          child: Row(
                                                            children: [
                                                              Spacer(),
                                                              RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text: AppMetaLabels()
                                                                          .loadMoreData,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .blue,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                    WidgetSpan(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .arrow_forward_ios,
                                                                        size:
                                                                            15,
                                                                        color: Colors
                                                                            .blue,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 1.w,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                : getContractsController
                                                            .errorLoadMoreFilter
                                                            .value !=
                                                        ''
                                                    ? SizedBox()
                                                    : InkWell(
                                                        onTap: () async {
                                                          int pageSize = int.parse(
                                                              getContractsController
                                                                  .pageNoFilter);
                                                          int naePageNo =
                                                              pageSize + 1;
                                                          getContractsController
                                                                  .pageNoFilter =
                                                              naePageNo
                                                                  .toString();
                                                          await getContractsController
                                                              .getFilteredDataPagiationLoadMore(
                                                                  getContractsController
                                                                      .pageNoFilter,
                                                                  searchControler
                                                                      .text);
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          height: 5.h,
                                                          width: 95.w,
                                                          child: Row(
                                                            children: [
                                                              Spacer(),
                                                              RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text: AppMetaLabels()
                                                                          .loadMoreData,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .blue,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                    WidgetSpan(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .arrow_forward_ios,
                                                                        size:
                                                                            15,
                                                                        color: Colors
                                                                            .blue,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 1.w,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                      ],
                                    );
                        }),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Obx(() {
            return Padding(
              padding: EdgeInsets.only(bottom: 2.0.h),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 100.0.w,
                  height: 4.0.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 4.0.h,
                        width: 25.0.w,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white, // background
                            // onPrimary: Colors.yellow, // foreground
                          ),
                          onPressed: () async {
                            // getContractsController.applyFilter();
                            setState(() {
                              getContractsController.pageNoFilter = '1';
                            });
                            getContractsController.applyFilterPagination(
                                getContractsController.pageNoFilter);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.format_align_center,
                                size: 2.0.h,
                                color: Colors.black,
                              ),
                              Text(
                                AppMetaLabels().filter,
                                style: AppTextStyle.semiBoldBlack11,
                              ),
                            ],
                          ),
                        ),
                      ),
                      getContractsController.isFilter.value == false
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1.0.h),
                              child: Container(
                                height: 4.0.h,
                                width: 25.0.w,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white, // background
                                    // onPrimary: Colors.yellow, // foreground
                                  ),
                                  onPressed: () async {
                                    // getContractsController.getData();
                                    getContractsController.pageNo = '1';
                                    getContractsController.pageNoFilter = '1';
                                    getContractsController.errorLoadMore.value =
                                        '';
                                    getContractsController
                                        .errorLoadMoreFilter.value = '';
                                    getContractsController.getDataPagination(
                                        getContractsController.pageNo, '');
                                    setState(() {});
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.close,
                                        size: 2.0.h,
                                        color: Colors.black,
                                      ),
                                      Text(
                                        AppMetaLabels().clear,
                                        style: AppTextStyle.semiBoldBlack11,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            );
          }),
          Obx(() {
            return getContractsController.loadingDataLoadMore.value
                ? Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: Center(child: LoadingIndicatorBlue()),
                  )
                : SizedBox();
          })
        ],
      ),
    );
  }

  InkWell inkWell(int index) {
    return InkWell(
      onTap: () {
        SessionController()
            .setContractNo(getContractsController.contracts[index].contractNo);
        SessionController()
            .setContractID(getContractsController.contracts[index].contractId);

        Get.to(() => VendorContractsDetailsTabs());
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(1.5.h),
                child: Container(
                  width: 78.0.w,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SrNoWidget(text: index + 1, size: 4.h),
                      SizedBox(
                        width: 2.w,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Row(
                            //   children: [
                            //     Text(
                            //       AppMetaLabels().contractNo,
                            //       style: AppTextStyle.semiBoldBlack11,
                            //     ),
                            //     Spacer(),
                            //     Text(
                            //       getContractsController
                            //               .contracts[index].contractNo
                            //               .toString() ??
                            //           "",
                            //       style: AppTextStyle.semiBoldBlack11,
                            //     ),
                            //   ],
                            // ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: 50.0.w,
                                  child: Text(
                                    SessionController().getLanguage() == 1
                                        ? getContractsController.getContracts
                                            .value.contracts[index].propertyName
                                        : getContractsController
                                            .getContracts
                                            .value
                                            .contracts[index]
                                            .propertyNameAR,
                                    style: AppTextStyle.semiBoldBlack12,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  getContractsController
                                          .contracts[index].contractNo
                                          .toString() ??
                                      "",
                                  style: AppTextStyle.semiBoldBlack12,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            SizedBox(height: 1.0.h),
                            Row(
                              children: [
                                Text(
                                  AppMetaLabels().contractDate,
                                  style: AppTextStyle.normalGrey10,
                                ),
                                Spacer(),
                                Text(
                                  getContractsController
                                      .contracts[index].contractDate
                                      .toString(),
                                  style: AppTextStyle.normalGrey10,
                                ),
                              ],
                            ),
                            SizedBox(height: 1.0.h),
                            Row(
                              children: [
                                Text(
                                  AppMetaLabels().startDate,
                                  style: AppTextStyle.normalGrey10,
                                ),
                                Spacer(),
                                Text(
                                  getContractsController
                                      .contracts[index].startDate
                                      .toString(),
                                  style: AppTextStyle.normalGrey10,
                                ),
                              ],
                            ),
                            SizedBox(height: 1.0.h),
                            Row(
                              children: [
                                Text(
                                  AppMetaLabels().endDate,
                                  style: AppTextStyle.normalGrey10,
                                ),
                                Spacer(),
                                Text(
                                  getContractsController
                                      .contracts[index].endDate
                                      .toString(),
                                  style: AppTextStyle.normalGrey10,
                                ),
                              ],
                            ),
                            SizedBox(height: 1.0.h),
                            Row(
                              children: [
                                Text(
                                  AppMetaLabels().contractStatus,
                                  style: AppTextStyle.semiBoldBlack11,
                                ),
                                Spacer(),
                                StatusWidgetVendor(
                                  text: SessionController().getLanguage() == 1
                                      ? getContractsController.contracts[index]
                                              .contractStatus ??
                                          ''
                                      : getContractsController.contracts[index]
                                              .contractStatusAr ??
                                          '',
                                  valueToCompare: getContractsController
                                      .contracts[index].contractStatus,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: SessionController().getLanguage() == 1
                    ? EdgeInsets.only(right: 1.8.h)
                    : EdgeInsets.only(left: 1.8.h),
                child: SizedBox(
                  width: 0.15.w,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.grey1,
                    size: 20,
                  ),
                ),
              )
            ],
          ),
          index == getContractsController.contracts.length - 1
              ? Container()
              : AppDivider(),
        ],
      ),
    );
  }
}
