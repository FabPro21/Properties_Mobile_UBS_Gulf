import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/vendor/vendor_contracts/vendor_contracts_tabs.dart/vendor_contracts_details.dart/vendor_contracts_invoices/vendor_contracts_invoices_controller.dart';
import 'package:fap_properties/views/widgets/bottom_shadow.dart';
import 'package:fap_properties/views/widgets/srno_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ContractInvoices extends StatefulWidget {
  const ContractInvoices({Key? key}) : super(key: key);

  @override
  _ContractInvoicesState createState() => _ContractInvoicesState();
}

class _ContractInvoicesState extends State<ContractInvoices> {
  var contractInvoicesController = Get.put(ContractInvoicesController());
  @override
  Widget build(BuildContext context) {
    contractInvoicesController.getData();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          BottomShadow(),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(2.0.h),
              child: Obx(() {
                return contractInvoicesController.loadingData.value == true
                    ? Padding(
                        padding: EdgeInsets.only(top: 25.0.h),
                        child: LoadingIndicatorBlue(),
                      )
                    : contractInvoicesController.error.value != ''
                        ? Padding(
                            padding: EdgeInsets.only(top: 25.0.h),
                            child: AppErrorWidget(
                              errorText: contractInvoicesController.error.value,
                            ),
                          )
                        : Container(
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
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: contractInvoicesController.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(2.0.h),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SrNoWidget(
                                              text: index + 1, size: 4.h),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 2.0.h),
                                              child: Column(
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
                                                      Text(
                                                        contractInvoicesController
                                                                .contractInvoices
                                                                .value
                                                                .invoice![index]
                                                                .invoiceNumber
                                                                .toString(),
                                                        style: AppTextStyle
                                                            .semiBoldBlack11,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 1.0.h,
                                                  ),
                                                  SizedBox(
                                                    height: 1.0.h,
                                                  ),
                                                  rowList(
                                                      AppMetaLabels()
                                                          .invoiceDate,
                                                      contractInvoicesController
                                                              .contractInvoices
                                                              .value
                                                              .invoice![index]
                                                              .invoiceDate
                                                              .toString()
                                                      ),
                                                  SizedBox(
                                                    height: 1.0.h,
                                                  ),
                                                  rowList(
                                                      AppMetaLabels()
                                                          .invoiceAmount,
                                                      "${AppMetaLabels().aed} ${contractInvoicesController.contractInvoices.value.invoice![index].invoiceAmount}"),
                                                  SizedBox(
                                                    height: 1.0.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        AppMetaLabels().status,

                                                        // AppMetaLabels().name,
                                                        style: AppTextStyle
                                                            .semiBoldBlack10,
                                                      ),
                                                      Spacer(),
                                                      StatusWidget(
                                                        text: contractInvoicesController
                                                                .contractInvoices
                                                                .value
                                                                .invoice![index]
                                                                .statusName ??
                                                            "",
                                                        valueToCompare:
                                                            contractInvoicesController
                                                                .contractInvoices
                                                                .value
                                                                .invoice![index]
                                                                .statusName,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 1.0.h,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    index ==
                                            contractInvoicesController.length -
                                                1
                                        ? Container()
                                        : AppDivider(),
                                  ],
                                );
                              },
                            ),
                          );
              }),
            ),
          ),
        ],
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
