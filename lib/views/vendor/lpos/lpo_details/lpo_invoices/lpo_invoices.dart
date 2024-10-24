import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/bottom_shadow.dart';
import 'package:fap_properties/views/widgets/srno_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sizer/sizer.dart';

import 'lpo_invoices_controller.dart';

class LpoInvoicesSereen extends StatefulWidget {
  const LpoInvoicesSereen({Key? key}) : super(key: key);

  @override
  _LpoInvoicesSereenState createState() => _LpoInvoicesSereenState();
}

class _LpoInvoicesSereenState extends State<LpoInvoicesSereen> {
  var _controller = Get.put(LpoInvoicesController());
  String amount = "";

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Stack(
        children: [
          BottomShadow(),
          Obx(() {
            return _controller.loadingData.value
                ? LoadingIndicatorBlue()
                : _controller.error.value != ''
                    ? AppErrorWidget(
                        errorText: _controller.error.value,
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 2.0.h, left: 2.w, right: 2.w),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 1.0.h,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(2.0.h),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Colors.grey[200] ?? Colors.grey,
                                          blurRadius: 0.4.h,
                                          spreadRadius: 0.8.h,
                                          offset: Offset(0.1.h, 0.1.h),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            itemCount: _controller.length,
                                            itemBuilder: (context, index) {
                                              ////////////////////////
                                              // Amount
                                              ////////////////////////
                                              var a = _controller
                                                  .getLpoInvoices
                                                  .value
                                                  .invoice?[index]
                                                  .invoiceAmount;
                                              final dFormatter =
                                                  intl.NumberFormat(
                                                      '#,##0.00', 'AR');
                                              amount = dFormatter.format(a);
                                              return Padding(
                                                padding: EdgeInsets.all(2.0.h),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 2.h,
                                                          right: 2.h),
                                                      child: SrNoWidget(
                                                          text: index + 1,
                                                          size: 4.h),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 2.0.h),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  AppMetaLabels()
                                                                      .invoiceNumber,
                                                                  style: AppTextStyle
                                                                      .semiBoldBlack11,
                                                                ),
                                                                Spacer(),
                                                                SizedBox(
                                                                  width:
                                                                      Get.width *
                                                                          0.3,
                                                                  child: Text(
                                                                    _controller
                                                                        .getLpoInvoices
                                                                        .value
                                                                        .invoice![
                                                                            index]
                                                                        .lpono
                                                                        .toString(),
                                                                    style: AppTextStyle
                                                                        .semiBoldBlack11,
                                                                    textAlign: SessionController().getLanguage() ==
                                                                            1
                                                                        ? TextAlign
                                                                            .end
                                                                        : TextAlign
                                                                            .start,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 1.0.h,
                                                            ),
                                                            rowList(
                                                              index,
                                                              AppMetaLabels()
                                                                  .reqDate,
                                                              _controller
                                                                      .getLpoInvoices
                                                                      .value
                                                                      .invoice![
                                                                          index]
                                                                      .requestDate ??
                                                                  "",
                                                            ),
                                                            SizedBox(
                                                              height: 1.0.h,
                                                            ),
                                                            rowList(
                                                              index,
                                                              AppMetaLabels()
                                                                  .invoiceDate,
                                                              _controller
                                                                  .getLpoInvoices
                                                                  .value
                                                                  .invoice![
                                                                      index]
                                                                  .invoiceDate
                                                                  .toString(),
                                                            ),
                                                            SizedBox(
                                                              height: 1.0.h,
                                                            ),
                                                            rowList(
                                                              index,
                                                              AppMetaLabels()
                                                                  .invoiceAmount,
                                                              "${AppMetaLabels().aed} $amount",
                                                            ),
                                                            SizedBox(
                                                              height: 1.0.h,
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
                                                                StatusWidget(
                                                                  text: SessionController()
                                                                              .getLanguage() ==
                                                                          1
                                                                      ? _controller
                                                                              .getLpoInvoices
                                                                              .value
                                                                              .invoice![
                                                                                  index]
                                                                              .statusName ??
                                                                          ""
                                                                      : _controller
                                                                              .getLpoInvoices
                                                                              .value
                                                                              .invoice![index]
                                                                              .statusNameAr ??
                                                                          "",
                                                                  valueToCompare: _controller
                                                                          .getLpoInvoices
                                                                          .value
                                                                          .invoice![
                                                                              index]
                                                                          .statusName ??
                                                                      "",
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 1.0.h,
                                                            ),
                                                            index ==
                                                                    _controller
                                                                            .length -
                                                                        1
                                                                ? Container()
                                                                : AppDivider(),
                                                            index ==
                                                                    _controller
                                                                            .length -
                                                                        1
                                                                ? Container()
                                                                : SizedBox(
                                                                    height:
                                                                        1.0.h,
                                                                  ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
          }),
        ],
      ),
    );
  }

  Row rowList(int index, t1, t2) {
    return Row(
      children: [
        Text(t1,

            // AppMetaLabels().name,
            style: AppTextStyle.normalBlack10),
        Spacer(),
        Text(
          t2,
          style: AppTextStyle.normalBlack10,
        ),
      ],
    );
  }
}
