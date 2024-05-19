import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/landlord/landlord_contracts/landlord_contracts_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/common_widgets/status_widget.dart';
import 'package:fap_properties/views/widgets/srno_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'landlord_contract_details_tabs/landlord_contract-details_tabs.dart';

class LandLordContracts extends StatefulWidget {
  const LandLordContracts({Key key}) : super(key: key);

  @override
  _LandLordContractsState createState() => _LandLordContractsState();
}

class _LandLordContractsState extends State<LandLordContracts> {
  final searchController = TextEditingController();
  final controller = Get.put(LandlordContractsController());
  @override
  void initState() {
    controller.pageNo = '1';
    controller.pageNoFilter = '1';
    controller.loadingDataLoadMore.value = false;
    controller.errorLoadMore.value = '';
    controller.errorLoadMoreFilter.value = '';
    controller.loadingContracts.value = false;
    controller.errorLoadingContracts.value = '';
    controller.getContracts(controller.pageNo, '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(children: [
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
                      // inputFormatters:
                      //     TextInputFormatter().searchPropertyNameContractNoIF,
                      controller: searchController,
                      onChanged: (value) async {
                        // controller.searchData(value);
                        // controller.searchData(value);
                        setState(() {
                          controller.errorLoadMore.value = '';
                          controller.errorLoadMoreFilter.value = '';
                          controller.pageNo = '1';
                          controller.pageNoFilter = '1';
                        });
                        await controller.getContracts(
                            controller.pageNo, value.trim());
                        if (value.isEmpty) {
                          controller.getContracts(controller.pageNo, '');
                          setState(() {});
                        }
                        setState(() {});
                        setState(() {});
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
                      searchController.clear();
                      setState(() {
                        controller.errorLoadMore.value = '';
                        controller.errorLoadMoreFilter.value = '';
                        controller.pageNo = '1';
                        controller.pageNoFilter = '1';
                      });
                      controller.getContracts(
                          controller.pageNo, searchController.text);
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
                  top: 2.0.h,
                ),
                child: SingleChildScrollView(
                    child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 50.h),
                  child: Container(
                    width: 92.0.w,
                    margin: EdgeInsets.all(1.5.h),
                    padding: EdgeInsets.only(top: 0.5.h),
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
                      return controller.loadingContracts.value == true
                          ? LoadingIndicatorBlue()
                          : controller.errorLoadingContracts.value != ''
                              ? CustomErrorWidget(
                                  errorText:
                                      controller.errorLoadingContracts.value,
                                  errorImage: AppImagesPath.noContractsFound,
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: controller.contracts.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        inkWell(index),
                                        index == controller.contracts.length - 1
                                            ? controller.contracts.length < 20
                                                ? SizedBox()
                                                // : _controller
                                                //         .isSearch.value
                                                //     ? SizedBox()
                                                : controller.isFilter.value ==
                                                        false
                                                    ? Container(
                                                        height: controller
                                                                    .errorLoadMore
                                                                    .value !=
                                                                ''
                                                            ? 2.h
                                                            : 6.h,
                                                        width: 87.w,
                                                        child: Row(
                                                          children: [
                                                            Spacer(),
                                                            Obx(() {
                                                              return controller
                                                                          .errorLoadMore
                                                                          .value !=
                                                                      ''
                                                                  ? SizedBox()
                                                                  : InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        int pageSize =
                                                                            int.parse(controller.pageNo);
                                                                        int naePageNo =
                                                                            pageSize +
                                                                                1;
                                                                        controller.pageNo =
                                                                            naePageNo.toString();
                                                                        if (searchController.text ==
                                                                            '') {
                                                                          await controller.getContractsLoadMore(
                                                                              controller.pageNo,
                                                                              '');
                                                                        } else {
                                                                          await controller.getContractsLoadMore(
                                                                              controller.pageNo,
                                                                              searchController.text);
                                                                        }
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.only(top: 0.5.h),
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
                                                          ],
                                                        ),
                                                      )
                                                    : controller.errorLoadMoreFilter
                                                                .value !=
                                                            ''
                                                        ? SizedBox(
                                                            height: 2.h,
                                                          )
                                                        : InkWell(
                                                            onTap: () async {
                                                              int pageSize = int
                                                                  .parse(controller
                                                                      .pageNoFilter);
                                                              int naePageNo =
                                                                  pageSize + 1;
                                                              controller
                                                                      .pageNoFilter =
                                                                  naePageNo
                                                                      .toString();
                                                              await controller
                                                                  .getFilteredDataLoadMore(
                                                                      controller
                                                                          .pageNoFilter,
                                                                      searchController
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
                                                                    text:
                                                                        TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              AppMetaLabels().loadMoreData,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.blue,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                        WidgetSpan(
                                                                          child:
                                                                              Icon(
                                                                            Icons.arrow_forward_ios,
                                                                            size:
                                                                                15,
                                                                            color:
                                                                                Colors.blue,
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
                                            : SizedBox()
                                      ],
                                    );
                                  },
                                );
                    }),
                  ),
                )))),
      ]),
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
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        setState(() {
                          controller.errorLoadMore.value = '';
                          controller.errorLoadMoreFilter.value = '';
                          controller.pageNo = '1';
                          controller.pageNoFilter = '1';
                        });
                        controller.applyFilter();
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
                  controller.isFilter.value == false
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1.0.h),
                          child: Container(
                            height: 4.0.h,
                            width: SessionController().getLanguage() == 1
                                ? 25.0.w
                                : 40.0.w,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                              onPressed: () async {
                                controller.getContracts(
                                    controller.pageNo, searchController.text);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
        return controller.loadingDataLoadMore.value
            ? Container(
                height: double.infinity,
                width: double.infinity,
                child: Center(child: LoadingIndicatorBlue()),
              )
            : SizedBox();
      })
    ]);
  }

  InkWell inkWell(int index) {
    return InkWell(
      onTap: () {
        SessionController().setContractID(
            int.parse(controller.contracts[index].contractID.toString()));
        SessionController()
            .setContractNo(controller.contracts[index].contractno);
        Get.to(() => LandlordContractDetailsTabs(
              contractId:
                  int.parse(controller.contracts[index].contractID.toString()),
              contractNo: controller.contracts[index].contractno,
              prevContractNo: controller.contracts[index].contractno,
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
                                    ? controller
                                            .contracts[index].propertyName ??
                                        ''
                                    : controller
                                            .contracts[index].propertyNameAR ??
                                        '',
                                style: AppTextStyle.semiBoldBlack12,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${controller.contracts[index].contractno}",
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
                              width: 16.0.w,
                              child: Text(
                                AppMetaLabels().unitNo,
                                style: AppTextStyle.semiBoldBlack12,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Spacer(),
                            Container(
                              width: 53.0.w,
                              alignment: Alignment.centerRight,
                              child: Text(
                                "${controller.contracts[index].unitRefNo}",
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
                                  "${controller.contracts[index].contractStartDate}",
                                  style: AppTextStyle.normalGrey10,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 1.w),
                                  child: Icon(Icons.arrow_forward,
                                      size: 10.sp, color: AppColors.greyColor),
                                ),
                                Text(
                                  "${controller.contracts[index].contractEndDate}",
                                  style: AppTextStyle.normalGrey10,
                                ),
                              ],
                            ),
                            Spacer(),
                            SessionController().getLanguage() == 1 &&
                                        controller.contracts[index]
                                                .contractStatus ==
                                            null ||
                                    controller
                                            .contracts[index].contractStatus ==
                                        ''
                                ? SizedBox()
                                : SessionController().getLanguage() != 1 &&
                                            controller.contracts[index]
                                                    .contractStatusAR ==
                                                null ||
                                        controller.contracts[index]
                                                .contractStatusAR ==
                                            ''
                                    ? SizedBox()
                                    : ConstrainedBox(
                                        constraints:
                                            BoxConstraints(maxWidth: 25.w),
                                        child: FittedBox(
                                          child: StatusWidget(
                                            text: SessionController()
                                                        .getLanguage() ==
                                                    1
                                                ? controller.contracts[index]
                                                        .contractStatus ??
                                                    ''
                                                : controller.contracts[index]
                                                        .contractStatusAR ??
                                                    '',
                                            valueToCompare: controller
                                                    .contracts[index]
                                                    .contractStatus ??
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
            index == controller.contracts.length - 1
                ? Container()
                : AppDivider(),
          ],
        ),
      ),
    );
  }
}
