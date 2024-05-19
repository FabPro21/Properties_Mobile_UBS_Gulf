import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/landlord/landlord_contracts/landlord_contract_details_tabs/landlord_contracts_charges/charges_receipts/landlord_charges_receipts_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/srno_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class LandlordChargesReceipts extends StatefulWidget {
  final int chargesTypeId;
  const LandlordChargesReceipts({Key key, @required this.chargesTypeId})
      : super(key: key);
  @override
  State<LandlordChargesReceipts> createState() =>
      _LandlordChargesReceiptsState();
}

class _LandlordChargesReceiptsState extends State<LandlordChargesReceipts> {
  LandlordChargesReceiptsController _controller = Get.put(LandlordChargesReceiptsController());
  String amountCurrency = "";

  @override
  void initState() {
    _controller.getContractChargesReceipts(widget.chargesTypeId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 4.0.h, left: 2.5.h, right: 2.5.h),
              child: Row(
                children: [
                  Text(
                    AppMetaLabels().receipts,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.semiBoldBlack16,
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(241, 241, 245, 1),
                        shape: BoxShape.circle),
                    child: Padding(
                      padding: EdgeInsets.all(0.7.h),
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.close,
                            size: 2.5.h, color: Color.fromRGBO(70, 82, 95, 1)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 1.0.h),
              child: AppDivider(),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(2.0.h),
              child: Container(
                width: 100.0.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(1.0.h),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 1.0.h,
                      spreadRadius: 0.6.h,
                      offset: Offset(0.0.h, 0.7.h),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(2.0.h),
                  child: Obx(() {
                    return _controller.loading.value == true
                        ? Center(child: LoadingIndicatorBlue())
                        : _controller.error != ''
                            ? Center(
                                child: AppErrorWidget(
                                  errorText: _controller.error,
                                ),
                              )
                            : SingleChildScrollView(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount: _controller.receipts.length,
                                    itemBuilder: (context, index) {
                                      double am = _controller
                                          .receipts[index].paymentAmount;
                                      final paidFormatter =
                                          NumberFormat('#,##0.00', 'AR');
                                      amountCurrency = paidFormatter.format(am);
                                      return Container(
                                        decoration: BoxDecoration(
                                          // color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(1.0.h),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SrNoWidget(
                                                text: index + 1, size: 4.h),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 2.0.h),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                            AppMetaLabels()
                                                                .receiptNo,
                                                            style: AppTextStyle
                                                                .semiBoldBlack10),
                                                        Spacer(),
                                                        Text(
                                                          _controller
                                                                  .receipts[
                                                                      index]
                                                                  .receiptNo
                                                                  .toString() ??
                                                              "",
                                                          style: AppTextStyle
                                                              .semiBoldBlack10,
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    rowList(
                                                        AppMetaLabels().date,
                                                        _controller
                                                            .receipts[index]
                                                            .transactionDate),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    rowList(
                                                        AppMetaLabels()
                                                            .paymentType,
                                                        _controller
                                                            .receipts[index]
                                                            .paymentType),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          AppMetaLabels()
                                                              .amount,
                                                          style: AppTextStyle
                                                              .normalBlack10,
                                                        ),
                                                        Spacer(),
                                                        Text(
                                                          '${AppMetaLabels().aed} $amountCurrency',
                                                          style: AppTextStyle
                                                              .semiBoldBlack10,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 1.0.h),
                                                    index ==
                                                            _controller.receipts
                                                                    .length -
                                                                1
                                                        ? Container()
                                                        : AppDivider(),
                                                    SizedBox(height: 1.0.h),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              );
                  }),
                ),
              ),
            )),
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
