import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/landlord/landlord_invoice/invoices_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/backbround_concave.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/srno_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../data/helpers/session_controller.dart';

class InvoicesScreenLandlord extends StatefulWidget {
  InvoicesScreenLandlord({Key? key}) : super(key: key);

  @override
  State<InvoicesScreenLandlord> createState() => _InvoicesScreenLandlordState();
}

class _InvoicesScreenLandlordState extends State<InvoicesScreenLandlord> {
  var _controller = Get.put(LandlordInvoicesController());
  final TextEditingController searchControler = TextEditingController();
  @override
  void initState() {
    _controller.pageNo = '1';
    _controller.errorLoadMore.value = '';
    _controller.loadingDataLoadMore.value = false;
    _controller.getAllInvoicsePagination(_controller.pageNo, '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.only(top: 3.0.h),
                  child: Text(
                    AppMetaLabels().reportsLand,
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
                                // _controller.searchData(value);
                                _controller.pageNo = '1';
                                _controller.errorLoadMore.value = '';
                                await _controller.getAllInvoicsePagination(
                                  _controller.pageNo,
                                  value.trim(),
                                );
                                setState(() {});

                                if (value.isEmpty) {
                                  await _controller.getAllInvoicsePagination(
                                    _controller.pageNo,
                                    '',
                                  );
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
                                      color: AppColors.whiteColor,
                                      width: 0.1.h),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.5.h),
                                  borderSide: BorderSide(
                                      color: AppColors.whiteColor,
                                      width: 0.1.h),
                                ),
                                hintText: AppMetaLabels().searchInvoices,
                                hintStyle: AppTextStyle.normalBlack10
                                    .copyWith(color: Colors.grey),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // _getData();
                              _controller.getAllInvoicsePagination(
                                  _controller.pageNo, '');
                              searchControler.clear();
                            },
                            icon: Icon(
                              Icons.refresh,
                            ),
                          ),
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
                              // height: 70.5.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2.0.h),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 0.4.h,
                                    spreadRadius: 0.5.h,
                                    offset: Offset(0.1.h, 0.1.h),
                                  ),
                                ],
                              ),
                              child: Obx(() {
                                return _controller.loadingData.value == true
                                    ? Center(
                                        child: LoadingIndicatorBlue(),
                                      )
                                    : _controller.error.value != ''
                                        ? Center(
                                            child: CustomErrorWidget(
                                              errorText:
                                                  _controller.error.value,
                                              errorImage:
                                                  AppImagesPath.noServicesFound,
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(2.0.h),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  blurRadius: 0.5.h,
                                                  spreadRadius: 0.8.h,
                                                  offset: Offset(0.1.h, 0.1.h),
                                                ),
                                              ],
                                            ),
                                            child: ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              padding: EdgeInsets.zero,
                                              itemCount:
                                                  _controller.allInvoice.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(2.0.h),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SrNoWidget(
                                                              text: index + 1,
                                                              size: 4.h),
                                                          Expanded(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          2.0.h,
                                                                      right: 2.0
                                                                          .h),
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    alignment: SessionController().getLanguage() ==
                                                                            1
                                                                        ? Alignment
                                                                            .topLeft
                                                                        : Alignment
                                                                            .topRight,
                                                                    child: Text(
                                                                      SessionController().getLanguage() == 1
                                                                          ? _controller
                                                                              .allInvoice[
                                                                                  index]
                                                                              .company
                                                                              .toString()
                                                                          : _controller
                                                                              .allInvoice[index]
                                                                              .companyAR
                                                                              .toString(),
                                                                      maxLines:
                                                                          2,
                                                                      style: AppTextStyle
                                                                          .semiBoldBlack12,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        1.0.h,
                                                                  ),
                                                                  rowList(
                                                                    AppMetaLabels()
                                                                        .propertyNameLand,
                                                                    SessionController().getLanguage() ==
                                                                            1
                                                                        ? _controller
                                                                            .allInvoice[
                                                                                index]
                                                                            .propertyName
                                                                            .toString()
                                                                        : _controller
                                                                            .allInvoice[index]
                                                                            .propertyNameAR
                                                                            .toString(),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        1.0.h,
                                                                  ),
                                                                  rowList(
                                                                    AppMetaLabels()
                                                                        .inoviceNo,
                                                                    _controller
                                                                        .allInvoice[
                                                                            index]
                                                                        .invoiceNumber
                                                                        .toString(),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        1.0.h,
                                                                  ),
                                                                  rowList(
                                                                      AppMetaLabels()
                                                                          .invoiceDate,
                                                                      _controller
                                                                          .allInvoice[
                                                                              index]
                                                                          .invoiceDate
                                                                          .toString()),
                                                                  SizedBox(
                                                                    height:
                                                                        1.0.h,
                                                                  ),
                                                                  rowList(
                                                                      AppMetaLabels()
                                                                          .invoiceAmount,
                                                                      "${AppMetaLabels().aed} ${_controller.allInvoice[index].invoiceAmount}"),
                                                                  SizedBox(
                                                                    height:
                                                                        1.0.h,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        AppMetaLabels()
                                                                            .status,

                                                                        // AppMetaLabels().name,
                                                                        style: AppTextStyle
                                                                            .semiBoldBlack10,
                                                                      ),
                                                                      Spacer(),
                                                                      StatusWidgetVendor(
                                                                        text: SessionController().getLanguage() == 1
                                                                            ? _controller.allInvoice[index].statusName ??
                                                                                ""
                                                                            : _controller.allInvoice[index].statusNameAR ??
                                                                                "",
                                                                        valueToCompare:
                                                                            _controller.allInvoice[index].statusName ??
                                                                                "",
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        1.0.h,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    index ==
                                                            _controller
                                                                    .allInvoice
                                                                    .length -
                                                                1
                                                        ? Container()
                                                        : AppDivider(),
                                                    index ==
                                                            _controller
                                                                    .allInvoice
                                                                    .length -
                                                                1
                                                        ? _controller.allInvoice
                                                                    .length <
                                                                20
                                                            ? SizedBox()
                                                            // : _controller
                                                            //         .isSearch.value
                                                            //     ? SizedBox()
                                                            : Center(
                                                                child: Obx(() {
                                                                  return _controller
                                                                              .errorLoadMore
                                                                              .value !=
                                                                          ''
                                                                      ? SizedBox()
                                                                      : _controller
                                                                              .loadingDataLoadMore
                                                                              .value
                                                                          ? SizedBox(
                                                                              width: 75.w,
                                                                              height: 5.h,
                                                                              child: Center(
                                                                                child: LoadingIndicatorBlue(),
                                                                              ),
                                                                            )
                                                                          : InkWell(
                                                                              onTap: () async {
                                                                                int pageSize = int.parse(_controller.pageNo);
                                                                                int naePageNo = pageSize + 1;
                                                                                _controller.pageNo = naePageNo.toString();

                                                                                await _controller.getAllInvoicsePaginationLoadMore(_controller.pageNo, searchControler.text);

                                                                                setState(() {});
                                                                              },
                                                                              child: SizedBox(
                                                                                  width: 85.w,
                                                                                  height: 3.h,
                                                                                  child: RichText(
                                                                                    textAlign: TextAlign.end,
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
                                                                            );
                                                                }),
                                                              )
                                                        : SizedBox(),
                                                    SizedBox(
                                                      height: 1.5.h,
                                                    )
                                                  ],
                                                );
                                              },
                                            ),
                                          );
                              }),
                            ),
                          ),
                        )))
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Row rowList(String t1, String t2) {
    return Row(
      children: [
        Text(
          t1,
          style: AppTextStyle.normalBlack10,
        ),
        Spacer(),
        Text(
          t2,
          style: AppTextStyle.normalBlack10,
        ),
      ],
    );
  }
}
