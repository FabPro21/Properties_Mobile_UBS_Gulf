import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_tabs.dart/tenant_contracts_details.dart/tenant_contract_details.dart';
import 'package:fap_properties/views/widgets/srno_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import 'tenant_contracts_controller.dart';

class TenantContractsScreen extends StatefulWidget {
  TenantContractsScreen({Key? key}) : super(key: key);

  @override
  State<TenantContractsScreen> createState() => _TenantContractsScreenState();
}

class _TenantContractsScreenState extends State<TenantContractsScreen> {
  // adding this
  final GetContractsController getContractsController =
      Get.put(GetContractsController());
  // final GetContractsController getContractsController = Get.find();

  final TextEditingController searchControler = TextEditingController();

  @override
  void initState() {
    getContractsController.pageNo = '1';
    getContractsController.errorLoadMore.value = '';
    // getContractsController.getDataPagination(getContractsController.pageNo, '');
    getContractsController.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Obx(() {
        return Stack(
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
                  padding:
                      EdgeInsets.only(left: 2.0.h, right: 2.0.h, top: 6.0.h),
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
                              controller: searchControler,
                              onChanged: (value) async {
                                if (value.isEmpty) {
                                  await getContractsController.getData();
                                  setState(() {});
                                } else {
                                  await getContractsController
                                      .searchDataWithoutAPi(value.trim());
                                  setState(() {});
                                }
                                // if (getContractsController.isFilter.value ==
                                //     false) {
                                //   if (value.isEmpty) {
                                //     await getContractsController
                                //         .getDataPagination(
                                //             getContractsController.pageNo,
                                //             value);
                                //     setState(() {});
                                //   } else {
                                //     await getContractsController.searchData(
                                //       value,
                                //       getContractsController.pageNo,
                                //     );
                                //     setState(() {});
                                //   }
                                // } else {
                                //   if (value.isNotEmpty) {
                                //     await getContractsController
                                //         .searchDataFilter(
                                //       getContractsController.pageNoFilter,
                                //       value,
                                //     );
                                //     setState(() {});
                                //   } else {
                                //     await getContractsController
                                //         .getFilteredData(
                                //             getContractsController.pageNoFilter,
                                //             '');
                                //     setState(() {});
                                //   }
                                // }
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
                              getContractsController.getData();
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
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: 50.h),
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 4.0.h, right: 4.0.w, left: 4.0.w, bottom: 2.h),
                        padding: EdgeInsets.only(top: 0.5.h),
                        // height: 70.5.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2.0.h),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 0.5.h,
                              spreadRadius: 0.8.h,
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
                                        // getContractsController
                                        //             .contracts.length <
                                        //         20
                                        //     ? SizedBox()
                                        //     : getContractsController
                                        //                 .isFilter.value ==
                                        //             false
                                        //         ? getContractsController
                                        //                     .errorLoadMore
                                        //                     .value !=
                                        //                 ''
                                        //             ? SizedBox()
                                        //             : InkWell(
                                        //                 onTap: () async {
                                        //                   int pageSize = int.parse(
                                        //                       getContractsController
                                        //                           .pageNo);
                                        //                   int naePageNo =
                                        //                       pageSize + 1;
                                        //                   getContractsController
                                        //                           .pageNo =
                                        //                       naePageNo
                                        //                           .toString();
                                        //                   await getContractsController
                                        //                       .getDataPaginationLoadMore(
                                        //                           getContractsController
                                        //                               .pageNo,
                                        //                           '');
                                        //                   setState(() {});
                                        //                 },
                                        //                 child: Container(
                                        //                   height: 5.h,
                                        //                   width: 95.w,
                                        //                   child: Row(
                                        //                     children: [
                                        //                       Spacer(),
                                        //                       RichText(
                                        //                         textAlign:
                                        //                             TextAlign
                                        //                                 .center,
                                        //                         text: TextSpan(
                                        //                           children: [
                                        //                             TextSpan(
                                        //                               text:
                                        //                                   "Load More ",
                                        //                               style:
                                        //                                   TextStyle(
                                        //                                 color: Colors
                                        //                                     .blue,
                                        //                               ),
                                        //                             ),
                                        //                             WidgetSpan(
                                        //                               child:
                                        //                                   Icon(
                                        //                                 Icons
                                        //                                     .arrow_forward_ios,
                                        //                                 size:
                                        //                                     15,
                                        //                                 color: Colors
                                        //                                     .blue,
                                        //                               ),
                                        //                             ),
                                        //                           ],
                                        //                         ),
                                        //                       ),
                                        //                       SizedBox(
                                        //                         width: 1.w,
                                        //                       )
                                        //                     ],
                                        //                   ),
                                        //                 ),
                                        //               )
                                        //         : getContractsController
                                        //                     .errorLoadMoreFilter
                                        //                     .value !=
                                        //                 ''
                                        //             ? SizedBox()
                                        //             : InkWell(
                                        //                 onTap: () async {
                                        //                   int pageSize = int.parse(
                                        //                       getContractsController
                                        //                           .pageNoFilter);
                                        //                   int naePageNo =
                                        //                       pageSize + 1;
                                        //                   getContractsController
                                        //                           .pageNoFilter =
                                        //                       naePageNo
                                        //                           .toString();
                                        //                   await getContractsController
                                        //                       .getFilteredDataLoadMore(
                                        //                           getContractsController
                                        //                               .pageNoFilter,
                                        //                           '');
                                        //                   setState(() {});
                                        //                 },
                                        //                 child: Container(
                                        //                   height: 5.h,
                                        //                   width: 95.w,
                                        //                   child: Row(
                                        //                     children: [
                                        //                       Spacer(),
                                        //                       RichText(
                                        //                         textAlign:
                                        //                             TextAlign
                                        //                                 .center,
                                        //                         text: TextSpan(
                                        //                           children: [
                                        //                             TextSpan(
                                        //                               text:
                                        //                                   "Load More ",
                                        //                               style:
                                        //                                   TextStyle(
                                        //                                 color: Colors
                                        //                                     .blue,
                                        //                               ),
                                        //                             ),
                                        //                             WidgetSpan(
                                        //                               child:
                                        //                                   Icon(
                                        //                                 Icons
                                        //                                     .arrow_forward_ios,
                                        //                                 size:
                                        //                                     15,
                                        //                                 color: Colors
                                        //                                     .blue,
                                        //                               ),
                                        //                             ),
                                        //                           ],
                                        //                         ),
                                        //                       ),
                                        //                       SizedBox(
                                        //                         width: 1.w,
                                        //                       )
                                        //                     ],
                                        //                   ),
                                        //                 ),
                                        //               )
                                      ],
                                    );
                        }),
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
                          width: 30.0.w,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () async {
                              getContractsController.pageNoFilter = '1';
                              getContractsController.errorLoadMoreFilter.value =
                                  '';
                              getContractsController.errorLoadMore.value = '';
                              getContractsController.applyFilter();
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
                                padding:
                                    EdgeInsets.symmetric(horizontal: 1.0.h),
                                child: Container(
                                  height: 4.0.h,
                                  width: SessionController().getLanguage() == 1
                                      ? 30.0.w
                                      : 40.0.w,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                    ),
                                    onPressed: () async {
                                      // getContractsController.pageNo = '1';
                                      // getContractsController.getDataPagination(
                                      //     getContractsController.pageNo, '');
                                      getContractsController.getData();
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
            getContractsController.loadingDataMoreData.value
                ? Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: Center(child: LoadingIndicatorBlue()),
                  )
                : SizedBox()
          ],
        );
      }),
    );
  }

  InkWell inkWell(int index) {
    return InkWell(
      onTap: () {
        SessionController()
            .setContractID(getContractsController.contracts[index].contractId);
        SessionController()
            .setContractNo(getContractsController.contracts[index].contractno);

        Get.to(() => ContractsDetailsTabs(
              prevContractNo:
                  getContractsController.contracts[index].previousContactNo ??
                      "",
            ));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.0.h, vertical: 1.5.h),
        child: Column(
          children: [
            SizedBox(
              height: 1.0.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SrNoWidget(text: index + 1, size: 4.h),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 1.0.h, right: 1.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 44.0.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? getContractsController
                                            .contracts[index].propertyName ??
                                        ''
                                    : getContractsController
                                            .contracts[index].propertyNameAr ??
                                        '',
                                style: AppTextStyle.semiBoldBlack12,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${getContractsController.contracts[index].contractno}",
                              style: AppTextStyle.semiBoldBlack12,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 30.0.w,
                              child: Text(
                                AppMetaLabels().unitNo,
                                style: AppTextStyle.semiBoldBlack12,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 40.0.w,
                              child: Text(
                                "${getContractsController.contracts[index].unitRefNo}",
                                style: AppTextStyle.semiBoldBlack12,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${getContractsController.contracts[index].contractStartDate}",
                                  style: AppTextStyle.normalGrey10,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 1.w),
                                  child: Icon(Icons.arrow_forward,
                                      size: 10.sp, color: AppColors.greyColor),
                                ),
                                Text(
                                  "${getContractsController.contracts[index].contractEndDate}",
                                  style: AppTextStyle.normalGrey10,
                                ),
                              ],
                            ),
                            Spacer(),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 22.w),
                              child: FittedBox(
                                child: StatusWidget(
                                  text: SessionController().getLanguage() == 1
                                      ? getContractsController.contracts[index]
                                              .contractStatus ??
                                          ""
                                      : getContractsController.contracts[index]
                                              .contractStatusAr ??
                                          "",
                                  valueToCompare: getContractsController
                                          .contracts[index].contractStatus ??
                                      "",
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: SessionController().getLanguage() == 1 ? 1.8.h : 0.h,
                    left: SessionController().getLanguage() == 1 ? 0.h : 1.8.h,
                  ),
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
      ),
    );
  }
}
