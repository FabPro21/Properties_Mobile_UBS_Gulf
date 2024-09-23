// ignore_for_file: deprecated_member_use, unnecessary_null_comparison
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/vendor_models/installmment_drop_sown_model.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_field_style.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/utils/text_validator.dart';
import 'package:fap_properties/views/vendor/vendor_invoice_detail/vendor_invoice_details_controller.dart';
import 'package:fap_properties/views/widgets/bottom_shadow.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';

class VendorInvoiceMainDetails extends StatefulWidget {
  final String? caller;
  final String? caseNo;
  VendorInvoiceMainDetails({
    Key? key,
    this.caller,
    this.caseNo,
  }) : super(key: key) {
    Get.put(VendorInvoiceDetailsController());
  }

  @override
  _VendorInvoiceMainDetailsState createState() =>
      _VendorInvoiceMainDetailsState();
}

class _VendorInvoiceMainDetailsState extends State<VendorInvoiceMainDetails> {
  final vendorController = Get.find<VendorInvoiceDetailsController>();
  final controller = Get.find<VendorInvoiceDetailsController>();
  ScrollController scrollcontrollerLpo =
      ScrollController(initialScrollOffset: 0.0);
  ScrollController scrollcontrollerAMc =
      ScrollController(initialScrollOffset: 0.0);
  ScrollController scrollcontrollerInstallment =
      ScrollController(initialScrollOffset: 0.0);

  TextEditingController feedbackDescController = TextEditingController();

  // new
  TextEditingController srNoController = TextEditingController();
  TextEditingController instNoController = TextEditingController();
  TextEditingController invoiceNOController = TextEditingController();
  TextEditingController invoiceAmountController = TextEditingController();
  TextEditingController tRNOfController = TextEditingController();
  TextEditingController workCompletionDateController = TextEditingController();
  TextEditingController invoiceDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    // if widget.caller == 'Add New Invoice'
    // then
    // clear all text field
    // else
    // call func for get data related to the Invoice No
    vendorController.callerInvoice = widget.caller!;
    if (vendorController.callerInvoice == 'Add New Invoice' &&
        !vendorController.isEnableInvoiceNo.value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        vendorController.getLpodropDownForInvoice();
        vendorController.getAMCdropDownForInvoice();
      });
      print('');
      vendorController.isServiceRqTypeRadioButtonVal.value = -1;
      srNoController.clear();
      instNoController.clear();
      invoiceAmountController.clear();
      tRNOfController.clear();
      workCompletionDateController.clear();
      invoiceNOController.clear();
      invoiceDateController.clear();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        vendorController.caseNoInvoice =
            widget.caseNo == null || widget.caseNo == ''
                ? controller.caseNoInvoice
                : int.parse(widget.caseNo!);
        print('CALLING IN ADD NEW SERVICE :::::::: ELSE ++++++ >');
        getdata();
      });
    }

    super.initState();
  }

  Future<void> getdata() async {
    var result =
        await vendorController.getRequest(controller.caseNoInvoice.toString());
    print('Result ::::::::::: Controller :::: $result');

    if (result['detail']['serviceType'].toString() == "LPO") {
      vendorController.isServiceRqTypeRadioButtonVal.value = 0;
    } else {
      vendorController.isServiceRqTypeRadioButtonVal.value = 1;
    }

    srNoController.text = result['detail']['serviceNo'].toString();
    instNoController.text = result['detail']['instNo'].toString();
    // instNoController.text = result['detail']['instNo'].toString();
    invoiceAmountController.text = result['detail']['invoiceAmount'].toString();
    tRNOfController.text = result['detail']['trNofLandlord'].toString();
    workCompletionDateController.text =
        result['detail']['workCompletionDate'].toString();
    descriptionController.text = result['detail']['description'].toString();
    invoiceNOController.text =
        result['detail']['invoiceNumber'].toString() == null
            ? ''
            : result['detail']['invoiceNumber'].toString();
    invoiceDateController.text =
        result['detail']['invoiceDate'].toString() == null
            ? ''
            : result['detail']['invoiceDate'].toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('caller :::: ******* :::::: => ${vendorController.callerInvoice}');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Obx(() {
            return vendorController.loadingData.value == true
                ? Padding(
                    padding: EdgeInsets.only(top: 10.0.h),
                    child: LoadingIndicatorBlue(),
                  )
                : Container(
                    margin: EdgeInsets.only(
                      left: 2.0.w,
                      right: 2.0.w,
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 2.0.w, top: 2.0.h, right: 2.0.w, bottom: 2.h),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
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
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              // Payment For
                              Container(
                                width: 94.0.w,
                                height: 11.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(2.0.h),
                                  border: Border.all(
                                      color: vendorController
                                                  .serviceTypeError.value !=
                                              ''
                                          ? Colors.red
                                          : Colors.transparent),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 0.5.h,
                                      spreadRadius: 0.1.h,
                                      offset: Offset(0.1.h, 0.1.h),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 1.5.h, right: 1.5.h, top: 1.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppMetaLabels().paymentFor,
                                        style: AppTextStyle.semiBoldGrey12,
                                      ),
                                      // Radio Buttons
                                      // Service Request type
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 45,
                                              child: Radio(
                                                value: 0,
                                                groupValue: vendorController
                                                    .isServiceRqTypeRadioButtonVal
                                                    .value, //_selectedValue,
                                                activeColor:
                                                    AppColors.blueColor,
                                                onChanged: vendorController
                                                        .isEnableInvoiceNo.value
                                                    ? null
                                                    : (int? value) {
                                                        setState(() {
                                                          vendorController
                                                              .isServiceRqTypeRadioButtonVal
                                                              .value = value!;
                                                          vendorController
                                                              .serviceTypeError
                                                              .value = '';
                                                          vendorController
                                                              .isShowListLPO
                                                              .value = true;
                                                          srNoController.text =
                                                              '';
                                                          srNoController
                                                              .clear();
                                                          instNoController
                                                              .text = '';
                                                          instNoController
                                                              .clear();
                                                        });
                                                        print(
                                                            'Value ::: ${vendorController.isServiceRqTypeRadioButtonVal.value}');
                                                      },
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  vendorController
                                                      .isServiceRqTypeRadioButtonVal
                                                      .value = 0;
                                                  vendorController
                                                      .serviceTypeError
                                                      .value = '';
                                                  vendorController.isShowListLPO
                                                      .value = true;
                                                  srNoController.text = '';
                                                  srNoController.clear();
                                                  instNoController.text = '';
                                                  instNoController.clear();
                                                });
                                                print(
                                                    'Value ::: ${vendorController.isServiceRqTypeRadioButtonVal.value}');
                                              },
                                              child: Text(
                                                AppMetaLabels().lpo,
                                                style:
                                                    AppTextStyle.normalGrey10,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            SizedBox(
                                              width: 45,
                                              child: Radio(
                                                value: 1,
                                                groupValue: vendorController
                                                    .isServiceRqTypeRadioButtonVal
                                                    .value,
                                                activeColor:
                                                    AppColors.blueColor,
                                                onChanged: vendorController
                                                        .isEnableInvoiceNo.value
                                                    ? null
                                                    : (int? value) {
                                                        setState(() {
                                                          setState(() {
                                                            vendorController
                                                                .isServiceRqTypeRadioButtonVal
                                                                .value = value!;
                                                            vendorController
                                                                .serviceTypeError
                                                                .value = '';
                                                            vendorController
                                                                .isShowListAMC
                                                                .value = true;
                                                            srNoController
                                                                .text = '';
                                                            srNoController
                                                                .clear();
                                                            instNoController
                                                                .text = '';
                                                            instNoController
                                                                .clear();
                                                          });
                                                        });
                                                        print(
                                                            'Value ::: ${vendorController.isServiceRqTypeRadioButtonVal.value}');
                                                      },
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  setState(() {
                                                    vendorController
                                                        .isServiceRqTypeRadioButtonVal
                                                        .value = 1;
                                                    vendorController
                                                        .serviceTypeError
                                                        .value = '';
                                                    vendorController
                                                        .isShowListAMC
                                                        .value = true;
                                                    srNoController.text = '';
                                                    srNoController.clear();
                                                    instNoController.text = '';
                                                    instNoController.clear();
                                                  });
                                                });
                                              },
                                              child: Text(
                                                AppMetaLabels().amc,
                                                style:
                                                    AppTextStyle.normalGrey10,
                                              ),
                                            )
                                          ]),
                                    ],
                                  ),
                                ),
                              ),
                              // error for service Type
                              SizedBox(
                                height:
                                    vendorController.serviceTypeError.value ==
                                            ''
                                        ? 2.h
                                        : 0.5.h,
                              ),
                              vendorController.serviceTypeError.value == ''
                                  ? SizedBox()
                                  : Text(
                                      '  ' +
                                          vendorController
                                              .serviceTypeError.value,
                                      style: AppTextStyle.normalErrorText1,
                                    ),
                              SizedBox(
                                height:
                                    vendorController.serviceTypeError.value !=
                                            ''
                                        ? 1.h
                                        : 0.h,
                              ),
                              // Textfield
                              // Service No
                              // Service Type
                              // Inst.No
                              // Invoice Amount
                              // TRN of Landlord
                              Container(
                                width: 94.0.w,
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
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 1.5.h,
                                      right: 1.5.h,
                                      top: 2.h,
                                      bottom: 2.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (vendorController
                                              .isServiceRqTypeRadioButtonVal
                                              .value !=
                                          -1)
                                        // Service Request NO
                                        Obx((() => Text(
                                              vendorController
                                                          .isServiceRqTypeRadioButtonVal
                                                          .value ==
                                                      0
                                                  ? AppMetaLabels().lpoNo
                                                  : vendorController
                                                              .isServiceRqTypeRadioButtonVal
                                                              .value ==
                                                          1
                                                      ? AppMetaLabels().aMCNo
                                                      : AppMetaLabels()
                                                          .serviceNO,
                                              style:
                                                  AppTextStyle.semiBoldGrey12,
                                            ))),

                                      // Lpo
                                      if (vendorController
                                              .isServiceRqTypeRadioButtonVal
                                              .value ==
                                          0)
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 0.5.h,
                                              left: 1.0.w,
                                              right: 1.0.w),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                              top: 0.1.h,
                                              bottom: 0.1.h,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                color: vendorController
                                                            .serviceNoError
                                                            .value ==
                                                        ''
                                                    ? Colors.transparent
                                                    : Colors.red,
                                                width: 0.2.w,
                                              ),
                                            ),
                                            child: TextFormField(
                                              readOnly: true,
                                              controller: srNoController,
                                              enabled: true,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]'))
                                              ],
                                              style: AppTextStyle.normalGrey10,
                                              onChanged: (value) {
                                                if (value.isNotEmpty) {
                                                  vendorController
                                                      .serviceNoError
                                                      .value = '';
                                                }
                                              },
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      signed: true,
                                                      decimal: false),
                                              decoration:
                                                  textFieldDecoration.copyWith(
                                                hintText: vendorController
                                                                .isServiceRqTypeRadioButtonVal
                                                                .value ==
                                                            0 &&
                                                        vendorController
                                                                .lopsNoModelData
                                                                .lpos ==
                                                            null
                                                    ? AppMetaLabels().noLPOFound
                                                    : AppMetaLabels()
                                                            .pleaseEnter
                                                            .replaceAll(
                                                                '.', '') +
                                                        ' ' +
                                                        AppMetaLabels().lpo,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                  ),
                                                ),
                                                suffixIcon: vendorController
                                                            .lopsNoModelData
                                                            .lpos !=
                                                        null
                                                    ? IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            vendorController
                                                                    .isShowListLPO
                                                                    .value =
                                                                !vendorController
                                                                    .isShowListLPO
                                                                    .value;
                                                            vendorController
                                                                .isServiceRqTypeRadioButtonVal
                                                                .value = 0;
                                                          });
                                                        },
                                                        icon: Icon(vendorController
                                                                    .isShowListLPO
                                                                    .value !=
                                                                true
                                                            ? Icons
                                                                .arrow_drop_down
                                                            : Icons
                                                                .arrow_drop_up),
                                                      )
                                                    : SizedBox(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      if (vendorController
                                              .isServiceRqTypeRadioButtonVal
                                              .value ==
                                          0)
                                        // List of Lpo/Amc
                                        vendorController.isServiceRqTypeRadioButtonVal
                                                        .value ==
                                                    -1 ||
                                                vendorController
                                                        .isShowListLPO.value ==
                                                    false
                                            ? SizedBox()
                                            : vendorController
                                                        .lopsNoModelData.lpos ==
                                                    null
                                                ? SizedBox()
                                                : Container(
                                                    width: 90.w,
                                                    height: vendorController
                                                                .lopsNoModelData
                                                                .lpos!
                                                                .length <
                                                            4
                                                        ? vendorController
                                                                .lopsNoModelData
                                                                .lpos!
                                                                .length *
                                                            3.5.h
                                                        : 15.h,
                                                    margin: EdgeInsets.only(
                                                      left: 6,
                                                      right: 6,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white60,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                                1.0.h),
                                                        bottomRight:
                                                            Radius.circular(
                                                                1.0.h),
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black12,
                                                          blurRadius: 0.5.h,
                                                          spreadRadius: 0.1.h,
                                                          offset: Offset(
                                                              0.1.h, 0.1.h),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Scrollbar(
                                                      controller:
                                                          scrollcontrollerLpo,
                                                      // isAlwaysShown: true,
                                                      child: ListView.builder(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        controller:
                                                            scrollcontrollerLpo,
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            vendorController
                                                                .lopsNoModelData
                                                                .lpos!
                                                                .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Column(
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    srNoController
                                                                        .text = vendorController
                                                                            .lopsNoModelData
                                                                            .lpos![index]
                                                                            .name ??
                                                                        "";
                                                                    vendorController
                                                                        .serviceNoError
                                                                        .value = '';
                                                                    vendorController
                                                                        .selectedLopAmcDropDownVal
                                                                        .value = vendorController
                                                                            .lopsNoModelData
                                                                            .lpos![index]
                                                                            .id ??
                                                                        0;
                                                                    vendorController.balanceAmountofSelectedLPO.value = double.parse(vendorController
                                                                        .lopsNoModelData
                                                                        .lpos![
                                                                            index]
                                                                        .balance
                                                                        .toString());

                                                                    vendorController
                                                                        .isShowListLPO
                                                                        .value = false;
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              4),
                                                                  child: Text(
                                                                    vendorController
                                                                            .lopsNoModelData
                                                                            .lpos![index]
                                                                            .name ??
                                                                        "",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              if (vendorController
                                                                      .isServiceRqTypeRadioButtonVal
                                                                      .value ==
                                                                  0)
                                                                index ==
                                                                        vendorController.lopsNoModelData.lpos!.length -
                                                                            1
                                                                    ? SizedBox()
                                                                    : AppDivider(),
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),

                                      if (vendorController
                                              .isServiceRqTypeRadioButtonVal
                                              .value ==
                                          1)
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 0.5.h,
                                              left: 1.0.w,
                                              right: 1.0.w),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                              top: 0.1.h,
                                              bottom: 0.1.h,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                color: vendorController
                                                            .serviceNoError
                                                            .value ==
                                                        ''
                                                    ? Colors.transparent
                                                    : Colors.red,
                                                width: 0.2.w,
                                              ),
                                            ),
                                            child: TextFormField(
                                              controller: srNoController,
                                              readOnly: true,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]'))
                                              ],
                                              style: AppTextStyle.normalGrey10,
                                              onChanged: (value) {
                                                if (value.isNotEmpty) {
                                                  vendorController
                                                      .serviceNoError
                                                      .value = '';
                                                }
                                              },
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      signed: true,
                                                      decimal: false),
                                              decoration:
                                                  textFieldDecoration.copyWith(
                                                hintText: vendorController
                                                                .isServiceRqTypeRadioButtonVal
                                                                .value ==
                                                            1 &&
                                                        vendorController
                                                                .aMCModelData
                                                                .amcData ==
                                                            null
                                                    ? AppMetaLabels()
                                                        .noAMCNosFound
                                                    : AppMetaLabels()
                                                            .pleaseEnter
                                                            .replaceAll(
                                                                '.', '') +
                                                        ' ' +
                                                        AppMetaLabels().aMCNo,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                  ),
                                                ),
                                                suffixIcon: vendorController
                                                        .isEnableInvoiceNo.value
                                                    ? SizedBox()
                                                    : vendorController
                                                                .aMCModelData
                                                                .amcData !=
                                                            null
                                                        ? IconButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                vendorController
                                                                        .isShowListAMC
                                                                        .value =
                                                                    !vendorController
                                                                        .isShowListAMC
                                                                        .value;
                                                                vendorController
                                                                    .isServiceRqTypeRadioButtonVal
                                                                    .value = 1;
                                                              });
                                                            },
                                                            icon: Icon(vendorController
                                                                        .isShowListAMC
                                                                        .value !=
                                                                    true
                                                                ? Icons
                                                                    .arrow_drop_down
                                                                : Icons
                                                                    .arrow_drop_up),
                                                          )
                                                        : SizedBox(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      if (vendorController
                                              .isServiceRqTypeRadioButtonVal
                                              .value ==
                                          1)
                                        // List of Lpo/Amc
                                        vendorController.isServiceRqTypeRadioButtonVal
                                                        .value ==
                                                    -1 ||
                                                vendorController
                                                        .isShowListAMC.value ==
                                                    false
                                            ? SizedBox()
                                            : vendorController
                                                        .aMCModelData.amcData ==
                                                    null
                                                ? SizedBox()
                                                : Container(
                                                    width: 90.w,
                                                    height: vendorController
                                                                .aMCModelData
                                                                .amcData!
                                                                .length <
                                                            4
                                                        ? vendorController
                                                                .aMCModelData
                                                                .amcData!
                                                                .length *
                                                            3.5.h
                                                        : 15.h,
                                                    margin: EdgeInsets.only(
                                                      left: 6,
                                                      right: 6,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white60,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                                1.0.h),
                                                        bottomRight:
                                                            Radius.circular(
                                                                1.0.h),
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black12,
                                                          blurRadius: 0.5.h,
                                                          spreadRadius: 0.1.h,
                                                          offset: Offset(
                                                              0.1.h, 0.1.h),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Scrollbar(
                                                      controller:
                                                          scrollcontrollerAMc,
                                                      // isAlwaysShown: true,
                                                      child: ListView.builder(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        controller:
                                                            scrollcontrollerAMc,
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            vendorController
                                                                .aMCModelData
                                                                .amcData!
                                                                .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Column(
                                                            children: [
                                                              InkWell(
                                                                onTap: vendorController
                                                                        .isEnableInvoiceNo
                                                                        .value
                                                                    ? () {}
                                                                    : () async {
                                                                        setState(
                                                                            () {
                                                                          srNoController.text =
                                                                              vendorController.aMCModelData.amcData![index].name ?? "";
                                                                          vendorController
                                                                              .serviceNoError
                                                                              .value = '';
                                                                          vendorController
                                                                              .errorInstallment
                                                                              .value = '';
                                                                          vendorController.installmentModelData =
                                                                              InstallmentDropDownModel();
                                                                        });
                                                                        await vendorController.getAMCInstdropDownForInvoice(
                                                                            vendorController.aMCModelData.amcData![index].name.toString(),
                                                                            vendorController.aMCModelData.amcData![index].id.toString());
                                                                        setState(
                                                                            () {
                                                                          vendorController
                                                                              .selectedLopAmcDropDownVal
                                                                              .value = vendorController
                                                                                  .aMCModelData.amcData![index].id ??
                                                                              0;
                                                                          vendorController
                                                                              .isServiceRqTypeRadioButtonVal
                                                                              .value = 1;
                                                                          vendorController
                                                                              .isShowListAMC
                                                                              .value = false;
                                                                          vendorController
                                                                              .isShowListAMCIns
                                                                              .value = true;
                                                                        });
                                                                      },
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              4),
                                                                  child: Text(
                                                                    vendorController
                                                                            .aMCModelData
                                                                            .amcData![index]
                                                                            .name ??
                                                                        "",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              if (vendorController
                                                                      .isServiceRqTypeRadioButtonVal
                                                                      .value ==
                                                                  1)
                                                                index == vendorController.aMCModelData.amcData!.length - 1 &&
                                                                        vendorController.isServiceRqTypeRadioButtonVal.value ==
                                                                            1
                                                                    ? SizedBox()
                                                                    : AppDivider(),
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),

                                      // error for service No
                                      SizedBox(
                                        height: vendorController
                                                    .serviceNoError.value ==
                                                ''
                                            ? 1.5.h
                                            : 0.5.h,
                                      ),
                                      vendorController.serviceNoError.value ==
                                              ''
                                          ? SizedBox()
                                          : Text(
                                              ' ' +
                                                  vendorController
                                                      .serviceNoError.value,
                                              style:
                                                  AppTextStyle.normalErrorText1,
                                            ),
                                      SizedBox(
                                        height: vendorController
                                                    .serviceNoError.value !=
                                                ''
                                            ? 1.h
                                            : 0,
                                      ),
                                      //
                                      // Inst.No
                                      if (vendorController
                                                  .isServiceRqTypeRadioButtonVal
                                                  .value ==
                                              1 ||
                                          vendorController
                                                  .isServiceRqTypeRadioButtonVal
                                                  .value ==
                                              -1)
                                        Text(
                                          AppMetaLabels()
                                              .instalmentNoWithoutColon,
                                          style: AppTextStyle.semiBoldGrey12,
                                        ),
                                      if (vendorController
                                                  .isServiceRqTypeRadioButtonVal
                                                  .value ==
                                              1 ||
                                          vendorController
                                                  .isServiceRqTypeRadioButtonVal
                                                  .value ==
                                              -1)
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 0.5.h,
                                              left: 1.0.w,
                                              right: 1.0.w),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                              top: 0.1.h,
                                              bottom: 0.1.h,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                color: vendorController
                                                            .instNOError
                                                            .value ==
                                                        ''
                                                    ? Colors.transparent
                                                    : Colors.red,
                                                width: 0.2.w,
                                              ),
                                            ),
                                            child: TextFormField(
                                              controller: instNoController,
                                              readOnly: true,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(
                                                        r'^\d*\.?\d{0,2}'))
                                              ],
                                              style: AppTextStyle.normalGrey10,
                                              onChanged: (value) {
                                                if (value.isNotEmpty) {
                                                  vendorController
                                                      .instNOError.value = '';
                                                }
                                              },
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      signed: true,
                                                      decimal: true),
                                              decoration:
                                                  textFieldDecoration.copyWith(
                                                      hintText: vendorController
                                                                  .errorInstallment
                                                                  .value ==
                                                              'No data found'
                                                          ? AppMetaLabels()
                                                              .noInstallmentfound
                                                          : AppMetaLabels()
                                                              .instalmentNoWithoutColon,
                                                      suffixIcon: vendorController
                                                              .isEnableInvoiceNo
                                                              .value
                                                          ? SizedBox()
                                                          : vendorController
                                                                      .isServiceRqTypeRadioButtonVal
                                                                      .value ==
                                                                  1
                                                              ? IconButton(
                                                                  onPressed:
                                                                      srNoController.text ==
                                                                              ''
                                                                          ? null
                                                                          : () {
                                                                              setState(() {
                                                                                vendorController.isShowListAMCIns.value = !vendorController.isShowListAMCIns.value;
                                                                                vendorController.isServiceRqTypeRadioButtonVal.value = 1;
                                                                              });
                                                                              setState(() {});
                                                                            },
                                                                  icon: vendorController
                                                                              .errorInstallment
                                                                              .value ==
                                                                          'No data found'
                                                                      ? SizedBox()
                                                                      : Icon(vendorController.isShowListAMCIns.value !=
                                                                              true
                                                                          ? Icons
                                                                              .arrow_drop_down
                                                                          : Icons
                                                                              .arrow_drop_up),
                                                                )
                                                              : SizedBox(),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent),
                                                      )),
                                            ),
                                          ),
                                        ),
                                      if (vendorController
                                                  .isServiceRqTypeRadioButtonVal
                                                  .value ==
                                              1 ||
                                          vendorController
                                                  .isServiceRqTypeRadioButtonVal
                                                  .value ==
                                              -1)
                                        // installment list
                                        vendorController
                                                    .isShowListAMCIns.value !=
                                                true
                                            ? SizedBox()
                                            : vendorController.errorInstallment
                                                            .value ==
                                                        'No data found' ||
                                                    vendorController
                                                            .errorInstallment
                                                            .value !=
                                                        '' ||
                                                    vendorController
                                                            .installmentModelData
                                                            .installmentData ==
                                                        null
                                                ? SizedBox()
                                                : Container(
                                                    width: 90.w,
                                                    margin: EdgeInsets.only(
                                                      left: 6,
                                                      right: 6,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white60,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                                1.0.h),
                                                        bottomRight:
                                                            Radius.circular(
                                                                1.0.h),
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black12,
                                                          blurRadius: 0.5.h,
                                                          spreadRadius: 0.1.h,
                                                          offset: Offset(
                                                              0.1.h, 0.1.h),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Scrollbar(
                                                      controller:
                                                          scrollcontrollerInstallment,
                                                      // isAlwaysShown: true,
                                                      child: ListView.builder(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        controller:
                                                            scrollcontrollerInstallment,
                                                        shrinkWrap: true,
                                                        itemCount: vendorController
                                                            .installmentModelData
                                                            .installmentData!
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Column(
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    instNoController.text = vendorController
                                                                        .installmentModelData
                                                                        .installmentData![
                                                                            index]
                                                                        .name
                                                                        .toString();
                                                                    vendorController
                                                                        .instNOError
                                                                        .value = '';
                                                                    vendorController
                                                                            .selectedInstallmentDropDownVal
                                                                            .value =
                                                                        vendorController
                                                                            .installmentModelData
                                                                            .installmentData![index]
                                                                            .id
                                                                            .toString();

                                                                    vendorController.selectedInstallmentDropDownNo.value = vendorController
                                                                        .installmentModelData
                                                                        .installmentData![
                                                                            index]
                                                                        .instNo
                                                                        .toString();

                                                                    vendorController.balanceAmountofSelectedInstallment.value = double.parse(vendorController
                                                                        .installmentModelData
                                                                        .installmentData![
                                                                            index]
                                                                        .balance
                                                                        .toString());

                                                                    vendorController
                                                                        .isShowListLPO
                                                                        .value = false;
                                                                    vendorController
                                                                        .isShowListAMCIns
                                                                        .value = false;
                                                                    vendorController
                                                                        .isShowListAMC
                                                                        .value = false;
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: double
                                                                      .infinity,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              4),
                                                                  child: Text(
                                                                    vendorController
                                                                        .installmentModelData
                                                                        .installmentData![
                                                                            index]
                                                                        .name
                                                                        .toString(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              index ==
                                                                      vendorController
                                                                              .installmentModelData
                                                                              .installmentData!
                                                                              .length -
                                                                          1
                                                                  ? SizedBox()
                                                                  : AppDivider(),
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                      if (vendorController
                                                  .isServiceRqTypeRadioButtonVal
                                                  .value ==
                                              1 ||
                                          vendorController
                                                  .isServiceRqTypeRadioButtonVal
                                                  .value ==
                                              -1)
                                        // error for Inst.No
                                        SizedBox(
                                          height: vendorController
                                                      .instNOError.value ==
                                                  ''
                                              ? 1.5.h
                                              : 0.5.h,
                                        ),
                                      if (vendorController
                                                  .isServiceRqTypeRadioButtonVal
                                                  .value ==
                                              1 ||
                                          vendorController
                                                  .isServiceRqTypeRadioButtonVal
                                                  .value ==
                                              -1)
                                        vendorController.instNOError.value == ''
                                            ? SizedBox()
                                            : Text(
                                                '  ' +
                                                    vendorController
                                                        .instNOError.value,
                                                style: AppTextStyle
                                                    .normalErrorText1,
                                              ),
                                      SizedBox(
                                        height: vendorController
                                                    .instNOError.value !=
                                                ''
                                            ? 1.0.h
                                            : 0,
                                      ),
                                      // Invoice
                                      // Invoice Number
                                      Container(
                                        width: 90.w,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 22.w,
                                              child: Text(
                                                AppMetaLabels().invoicesNo,
                                                style:
                                                    AppTextStyle.semiBoldGrey12,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                              width: 62.w,
                                              child: Text(
                                                AppMetaLabels()
                                                    .specialCharNotAllowed,
                                                style: AppTextStyle.normalGrey9,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 0.5.h,
                                            left: 1.0.w,
                                            right: 1.0.w),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            top: 0.1.h,
                                            bottom: 0.1.h,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            border: Border.all(
                                              color: vendorController
                                                          .invoiceNoError
                                                          .value ==
                                                      ''
                                                  ? Colors.transparent
                                                  : Colors.red,
                                              width: 0.2.w,
                                            ),
                                          ),
                                          child: TextFormField(
                                            controller: invoiceNOController,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r"^[a-zA-Z0-9]*$"))
                                            ],
                                            style: AppTextStyle.normalGrey10,
                                            onChanged: (value) {
                                              if (value.isNotEmpty) {
                                                vendorController
                                                    .invoiceNoError.value = '';
                                              }
                                            },
                                            // keyboardType:
                                            //     TextInputType.numberWithOptions(
                                            //         signed: true,
                                            //         decimal: true),
                                            decoration:
                                                textFieldDecoration.copyWith(
                                                    hintText: AppMetaLabels()
                                                        .invoicesNo,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent),
                                                    )),
                                          ),
                                        ),
                                      ),
                                      // error for Invoice NO
                                      SizedBox(
                                        height: vendorController
                                                    .invoiceNoError.value ==
                                                ''
                                            ? 2.h
                                            : 0.5.h,
                                      ),
                                      vendorController.invoiceNoError.value ==
                                              ''
                                          ? SizedBox()
                                          : Text(
                                              '  ' +
                                                  vendorController
                                                      .invoiceNoError.value,
                                              style:
                                                  AppTextStyle.normalErrorText1,
                                            ),
                                      SizedBox(
                                        height: vendorController
                                                    .invoiceNoError.value ==
                                                ''
                                            ? 0.0.h
                                            : 1.h,
                                      ),
                                      // Invoice Date
                                      Text(
                                        AppMetaLabels().invoiceDate,
                                        style: AppTextStyle.semiBoldGrey12,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          vendorController
                                              .invoiceDateError.value = '';
                                          var expDate;
                                          expDate = await showRoundedDatePicker(
                                            theme: ThemeData(
                                                primaryColor:
                                                    AppColors.blueColor),
                                            height: 50.0.h,
                                            context: context,
                                            // locale: Locale('en'),
                                            locale: SessionController()
                                                        .getLanguage() ==
                                                    1
                                                ? Locale('en', '')
                                                : Locale('ar', ''),
                                            //  7300 =>  20 years
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now()
                                                .subtract(Duration(days: 7300)),
                                            lastDate: DateTime.now(),
                                            borderRadius: 2.0.h,
                                            styleDatePicker:
                                                MaterialRoundedDatePickerStyle(
                                              decorationDateSelected:
                                                  BoxDecoration(
                                                      color:
                                                          AppColors.blueColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100)),
                                              textStyleButtonPositive:
                                                  TextStyle(
                                                color: AppColors.blueColor,
                                              ),
                                              textStyleButtonNegative:
                                                  TextStyle(
                                                color: AppColors.blueColor,
                                              ),
                                              backgroundHeader:
                                                  Colors.grey.shade300,
                                              // Appbar year like '2023' button
                                              textStyleYearButton: TextStyle(
                                                fontSize: 30.sp,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                                backgroundColor:
                                                    Colors.grey.shade100,
                                                leadingDistribution:
                                                    TextLeadingDistribution
                                                        .even,
                                              ),
                                              // Appbar day like 'Thu, Mar 16' button
                                              textStyleDayButton: TextStyle(
                                                fontSize: 18.sp,
                                                color: Colors.white,
                                              ),

                                              // Heading year like 'S M T W TH FR SA ' button
                                              // textStyleDayHeader: TextStyle(
                                              //   fontSize: 30.sp,
                                              //   color: Colors.white,
                                              //   backgroundColor: Colors.red,
                                              //   decoration: TextDecoration.overline,
                                              //   decorationColor: Colors.pink,
                                              // ),
                                            ),
                                          );
                                          if (expDate != null) {
                                            DateFormat dateFormat =
                                                new DateFormat(AppMetaLabels()
                                                    .dateFormatForShowRoundedDatePicker);
                                            invoiceDateController.text =
                                                dateFormat.format(expDate);
                                          }
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 0.5.h,
                                              left: 1.0.w,
                                              right: 1.0.w),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                              top: 0.1.h,
                                              bottom: 0.1.h,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                color: vendorController
                                                            .invoiceDateError
                                                            .value ==
                                                        ''
                                                    ? Colors.transparent
                                                    : Colors.red,
                                                width: 0.2.w,
                                              ),
                                            ),
                                            child: TextFormField(
                                              enabled: false,
                                              controller: invoiceDateController,
                                              onChanged: ((value) {
                                                if (value.isNotEmpty) {
                                                  vendorController
                                                      .invoiceDateError
                                                      .value = '';
                                                }
                                              }),
                                              decoration:
                                                  textFieldDecoration.copyWith(
                                                hintText:
                                                    AppMetaLabels().invoiceDate,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                              ),
                                              style: AppTextStyle.normalGrey10,
                                            ),
                                          ),
                                        ),
                                      ),
                                      // error for Invoice Date
                                      SizedBox(
                                        height: vendorController
                                                    .invoiceDateError.value ==
                                                ''
                                            ? 1.h
                                            : 0.5.h,
                                      ),
                                      // Error for Invoice Date
                                      vendorController.invoiceDateError.value ==
                                              ''
                                          ? SizedBox()
                                          : Padding(
                                              padding: EdgeInsets.only(left: 5),
                                              child: Text(
                                                vendorController
                                                    .invoiceDateError.value,
                                                style: AppTextStyle
                                                    .normalErrorText1,
                                              ),
                                            ),
                                      SizedBox(
                                        height: vendorController
                                                    .invoiceDateError.value ==
                                                ''
                                            ? 0.5.h
                                            : 1.h,
                                      ),
                                      // InvoiceAmount
                                      Text(
                                        AppMetaLabels().invoiceAmount,
                                        style: AppTextStyle.semiBoldGrey12,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 0.5.h,
                                            left: 1.0.w,
                                            right: 1.0.w),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            top: 0.1.h,
                                            bottom: 0.1.h,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            border: Border.all(
                                              color: vendorController
                                                          .invoiceAmountError
                                                          .value ==
                                                      ''
                                                  ? Colors.transparent
                                                  : Colors.red,
                                              width: 0.2.w,
                                            ),
                                          ),
                                          child: TextFormField(
                                            controller: invoiceAmountController,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'^\d*\.?\d{0,2}'))
                                            ],
                                            style: AppTextStyle.normalGrey10,
                                            onChanged: (value) {
                                              if (value.isNotEmpty) {
                                                vendorController
                                                    .invoiceAmountError
                                                    .value = '';
                                              }
                                            },
                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                                    signed: true,
                                                    decimal: true),
                                            decoration:
                                                textFieldDecoration.copyWith(
                                                    hintText: AppMetaLabels()
                                                        .invoiceAmount,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent),
                                                    )),
                                          ),
                                        ),
                                      ),
                                      // error for Invoice amount
                                      SizedBox(
                                        height: vendorController
                                                    .invoiceAmountError.value ==
                                                ''
                                            ? 1.5.h
                                            : 0.5.h,
                                      ),
                                      vendorController
                                                  .invoiceAmountError.value ==
                                              ''
                                          ? SizedBox()
                                          : Text(
                                              '  ' +
                                                  vendorController
                                                      .invoiceAmountError.value,
                                              style:
                                                  AppTextStyle.normalErrorText1,
                                            ),

                                      // SizedBox(
                                      //   height: vendorController
                                      //               .invoiceAmountError.value !=
                                      //           ''
                                      //       ? 1.0.h
                                      //       : 0,
                                      // ),
                                      //
                                      // TRN of Landlord
                                      // Text(
                                      //   AppMetaLabels().tRNofLandlord,
                                      //   style: AppTextStyle.semiBoldGrey12,
                                      // ),
                                      // Padding(
                                      //   padding: EdgeInsets.only(
                                      //       top: 0.5.h,
                                      //       left: 1.0.w,
                                      //       right: 1.0.w),
                                      //   child: Container(
                                      //     padding: EdgeInsets.only(
                                      //       top: 0.1.h,
                                      //       bottom: 0.1.h,
                                      //     ),
                                      //     decoration: BoxDecoration(
                                      //       borderRadius:
                                      //           BorderRadius.circular(5.0),
                                      //       border: Border.all(
                                      //         color: vendorController
                                      //                     .tRNofLandlordError
                                      //                     .value ==
                                      //                 ''
                                      //             ? Colors.transparent
                                      //             : Colors.red,
                                      //         width: 0.2.w,
                                      //       ),
                                      //     ),
                                      //     child: TextFormField(
                                      //       controller: tRNOfController,
                                      //       inputFormatters: [
                                      //         FilteringTextInputFormatter.allow(
                                      //             RegExp(r'[0-9]')),
                                      //       ],
                                      //       style: AppTextStyle.normalGrey10,
                                      //       onChanged: (value) {
                                      //         if (value.isNotEmpty) {
                                      //           vendorController
                                      //               .tRNofLandlordError
                                      //               .value = '';
                                      //         }
                                      //       },
                                      //       keyboardType:
                                      //           TextInputType.numberWithOptions(
                                      //               signed: true,
                                      //               decimal: false),
                                      //       decoration:
                                      //           textFieldDecoration.copyWith(
                                      //               hintText: AppMetaLabels()
                                      //                   .tRNofLandlord,
                                      //               enabledBorder:
                                      //                   OutlineInputBorder(
                                      //                 borderRadius:
                                      //                     BorderRadius.circular(
                                      //                         5.0),
                                      //                 borderSide: BorderSide(
                                      //                     color: Colors
                                      //                         .transparent),
                                      //               )),
                                      //     ),
                                      //   ),
                                      // ),
                                      // error for TRn
                                      // SizedBox(
                                      //   height: vendorController
                                      //               .invoiceAmountError.value ==
                                      //           ''
                                      //       ? 0.5.h
                                      //       : 0.h,
                                      // ),

                                      vendorController
                                                  .tRNofLandlordError.value ==
                                              ''
                                          ? SizedBox()
                                          : Text(
                                              '  ' +
                                                  vendorController
                                                      .tRNofLandlordError.value,
                                              style:
                                                  AppTextStyle.normalErrorText1,
                                            ),
                                      SizedBox(
                                        height: vendorController
                                                    .tRNofLandlordError.value !=
                                                ''
                                            ? 1.h
                                            : 1.h,
                                      ),

                                      if (vendorController
                                                  .isServiceRqTypeRadioButtonVal
                                                  .value ==
                                              0 ||
                                          vendorController
                                                  .isServiceRqTypeRadioButtonVal
                                                  .value ==
                                              -1)
                                        // WorkCompletionDate
                                        Text(
                                          AppMetaLabels().workCompletionDate,
                                          style: AppTextStyle.semiBoldGrey12,
                                        ),
                                      if (vendorController
                                                  .isServiceRqTypeRadioButtonVal
                                                  .value ==
                                              0 ||
                                          vendorController
                                                  .isServiceRqTypeRadioButtonVal
                                                  .value ==
                                              -1)
                                        InkWell(
                                          onTap: () async {
                                            vendorController
                                                .workCompletionError.value = '';
                                            var expDate;
                                            expDate =
                                                await showRoundedDatePicker(
                                              theme: ThemeData(
                                                  primaryColor:
                                                      AppColors.blueColor),
                                              height: 50.0.h,
                                              context: context,
                                              // locale: Locale('en'),
                                              locale: SessionController()
                                                          .getLanguage() ==
                                                      1
                                                  ? Locale('en', '')
                                                  : Locale('ar', ''),
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now()
                                                  .subtract(Duration(days: 15)),
                                              lastDate: DateTime.now(),
                                              borderRadius: 2.0.h,
                                              styleDatePicker:
                                                  MaterialRoundedDatePickerStyle(
                                                decorationDateSelected:
                                                    BoxDecoration(
                                                        color:
                                                            AppColors.blueColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100)),
                                                textStyleButtonPositive:
                                                    TextStyle(
                                                  color: AppColors.blueColor,
                                                ),
                                                textStyleButtonNegative:
                                                    TextStyle(
                                                  color: AppColors.blueColor,
                                                ),
                                                backgroundHeader:
                                                    Colors.grey.shade300,
                                                // Appbar year like '2023' button
                                                textStyleYearButton: TextStyle(
                                                  fontSize: 30.sp,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                  backgroundColor:
                                                      Colors.grey.shade100,
                                                  leadingDistribution:
                                                      TextLeadingDistribution
                                                          .even,
                                                ),
                                                // Appbar day like 'Thu, Mar 16' button
                                                textStyleDayButton: TextStyle(
                                                  fontSize: 18.sp,
                                                  color: Colors.white,
                                                ),

                                                // Heading year like 'S M T W TH FR SA ' button
                                                // textStyleDayHeader: TextStyle(
                                                //   fontSize: 30.sp,
                                                //   color: Colors.white,
                                                //   backgroundColor: Colors.red,
                                                //   decoration: TextDecoration.overline,
                                                //   decorationColor: Colors.pink,
                                                // ),
                                              ),
                                            );
                                            if (expDate != null) {
                                              DateFormat dateFormat =
                                                  new DateFormat(AppMetaLabels()
                                                      .dateFormatForShowRoundedDatePicker);
                                              workCompletionDateController
                                                      .text =
                                                  dateFormat.format(expDate);
                                            }
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 0.5.h,
                                                left: 1.0.w,
                                                right: 1.0.w),
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                top: 0.1.h,
                                                bottom: 0.1.h,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                border: Border.all(
                                                  color: vendorController
                                                              .workCompletionError
                                                              .value ==
                                                          ''
                                                      ? Colors.transparent
                                                      : Colors.red,
                                                  width: 0.2.w,
                                                ),
                                              ),
                                              child: TextFormField(
                                                enabled: false,
                                                controller:
                                                    workCompletionDateController,
                                                onChanged: ((value) {
                                                  if (value.isNotEmpty) {
                                                    vendorController
                                                        .workCompletionError
                                                        .value = '';
                                                  }
                                                }),
                                                decoration: textFieldDecoration
                                                    .copyWith(
                                                  hintText: AppMetaLabels()
                                                      .workCompletionDate,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                ),
                                                style:
                                                    AppTextStyle.normalGrey10,
                                              ),
                                            ),
                                          ),
                                        ),
                                      if (vendorController
                                                  .isServiceRqTypeRadioButtonVal
                                                  .value ==
                                              0 ||
                                          vendorController
                                                  .isServiceRqTypeRadioButtonVal
                                                  .value ==
                                              -1)
                                        // error for work completion
                                        SizedBox(
                                          height: vendorController
                                                      .workCompletionError
                                                      .value ==
                                                  ''
                                              ? 1.h
                                              : 0.5.h,
                                        ),
                                      if (vendorController
                                                  .isServiceRqTypeRadioButtonVal
                                                  .value ==
                                              0 ||
                                          vendorController
                                                  .isServiceRqTypeRadioButtonVal
                                                  .value ==
                                              -1)
                                        // Error work Completion date
                                        vendorController.workCompletionError
                                                    .value ==
                                                ''
                                            ? SizedBox()
                                            : Padding(
                                                padding:
                                                    EdgeInsets.only(left: 5),
                                                child: Text(
                                                  vendorController
                                                      .workCompletionError
                                                      .value,
                                                  style: AppTextStyle
                                                      .normalErrorText1,
                                                ),
                                              ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Padding(
                                padding: EdgeInsets.all(0.2.h),
                                child: Container(
                                  width: 100.0.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: vendorController
                                                  .descriptionError.value ==
                                              ''
                                          ? Colors.transparent
                                          : Colors.red,
                                      width: 0.2.w,
                                    ),
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
                                  child: Padding(
                                    padding: EdgeInsets.all(2.0.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppMetaLabels().remarks,
                                          style: AppTextStyle.semiBoldGrey12,
                                        ),
                                        SizedBox(
                                          height: 2.0.h,
                                        ),
                                        Obx((() => TextFormField(
                                              controller: descriptionController,
                                              onChanged: (value) {
                                                if (value.isNotEmpty) {
                                                  vendorController
                                                      .descriptionError
                                                      .value = '';
                                                }
                                              },
                                              decoration:
                                                  textFieldDecoration.copyWith(
                                                      hintText: AppMetaLabels()
                                                          .enterRemarks,
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        borderSide: BorderSide(
                                                          color: vendorController
                                                                      .descriptionError
                                                                      .value ==
                                                                  ''
                                                              ? Colors
                                                                  .transparent
                                                              : Colors.red,
                                                        ),
                                                      )),
                                              keyboardType:
                                                  TextInputType.multiline,
                                              style: AppTextStyle.normalGrey10,
                                              maxLines: 5,
                                            ))),
                                        // error for Inst.No
                                        SizedBox(
                                          height: vendorController
                                                      .descriptionError.value ==
                                                  ''
                                              ? 1.h
                                              : 0.5.h,
                                        ),
                                        vendorController
                                                    .descriptionError.value ==
                                                ''
                                            ? SizedBox()
                                            : Padding(
                                                padding:
                                                    EdgeInsets.only(left: 5),
                                                child: Text(
                                                  vendorController
                                                      .descriptionError.value,
                                                  style: AppTextStyle
                                                      .normalErrorText1,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 2.0.h,
                              ),
                              Obx(() {
                                return vendorController.isEnableInvoiceNo.value
                                    ? SizedBox()
                                    : vendorController.isLoading.value
                                        ? Center(
                                            child: LoadingIndicatorBlue(),
                                          )
                                        : SizedBox(
                                            width: 90.0.w,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          1.3.h),
                                                ),
                                                backgroundColor: Color.fromRGBO(
                                                    0, 61, 166, 1),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 6.0.h,
                                                    vertical: 1.5.h),
                                              ),
                                              onPressed: () async {
                                                // if widget.caller == 'Add New Invoice'
                                                // then
                                                // Call Func for add new
                                                // else
                                                // move toward commmunication
                                                /////////////
                                                if (vendorController
                                                        .callerInvoice ==
                                                    'Add New Invoice') {
                                                  if (vendorController
                                                          .isServiceRqTypeRadioButtonVal
                                                          .value ==
                                                      -1) {
                                                    vendorController
                                                            .serviceTypeError
                                                            .value =
                                                        AppMetaLabels()
                                                            .pleaseSelectServiceType;
                                                    return;
                                                  }
                                                  // without installment validation
                                                  if (vendorController
                                                          .isServiceRqTypeRadioButtonVal
                                                          .value ==
                                                      0) {
                                                    // service no error
                                                    if (srNoController.text ==
                                                            '' ||
                                                        srNoController.text ==
                                                            null) {
                                                      vendorController
                                                              .serviceNoError
                                                              .value =
                                                          AppMetaLabels()
                                                                  .pleaseSelect
                                                                  .replaceAll(
                                                                      '.', '') +
                                                              ' ' +
                                                              AppMetaLabels()
                                                                  .lpoNo;
                                                      return;
                                                    }
                                                    // Invoice NO error
                                                    if (invoiceNOController
                                                                .text ==
                                                            '' ||
                                                        invoiceNOController
                                                                .text ==
                                                            null) {
                                                      vendorController
                                                              .invoiceNoError
                                                              .value =
                                                          AppMetaLabels()
                                                              .pleaseEnterInvoiceNOVal;
                                                      return;
                                                    }
                                                    // Invoice Date error
                                                    if (invoiceDateController
                                                                .text ==
                                                            '' ||
                                                        invoiceDateController
                                                                .text ==
                                                            null) {
                                                      vendorController
                                                              .invoiceDateError
                                                              .value =
                                                          AppMetaLabels()
                                                              .pleaseSelectInvoiceDate;
                                                      return;
                                                    }

                                                    // Invoice Amount error
                                                    if (invoiceAmountController
                                                                .text ==
                                                            '' ||
                                                        invoiceAmountController
                                                                .text ==
                                                            null) {
                                                      vendorController
                                                              .invoiceAmountError
                                                              .value =
                                                          AppMetaLabels()
                                                              .pleaseEnterInvoiceAmountVal;
                                                      return;
                                                    }
                                                    if (double.parse(
                                                            invoiceAmountController
                                                                .text) <=
                                                        0) {
                                                      vendorController
                                                              .invoiceAmountError
                                                              .value =
                                                          AppMetaLabels()
                                                              .pleaseEnterValidAMountSeparate;
                                                      return;
                                                    }
                                                    if (double.parse(
                                                            invoiceAmountController
                                                                .text) >
                                                        vendorController
                                                            .balanceAmountofSelectedLPO
                                                            .value) {
                                                      setState(() {
                                                        vendorController
                                                            .invoiceAmountError
                                                            .value = AppMetaLabels()
                                                                .yourBalanceAMount +
                                                            "${vendorController.balanceAmountofSelectedLPO.value}" +
                                                            AppMetaLabels()
                                                                .pleaseEnterValidAMountSeparate;
                                                      });
                                                      return;
                                                    }
                                                    // validation of invoice amount
                                                    // TRN error
                                                    // if (tRNOfController.text ==
                                                    //         '' ||
                                                    //     tRNOfController.text ==
                                                    //         null) {
                                                    //   vendorController
                                                    //           .tRNofLandlordError
                                                    //           .value =
                                                    //       AppMetaLabels()
                                                    //           .pleaseEnterInvoiceTRNVal;
                                                    //   return;
                                                    // }
                                                    // Work Completion error
                                                    if (workCompletionDateController
                                                                .text ==
                                                            '' ||
                                                        workCompletionDateController
                                                                .text ==
                                                            null) {
                                                      vendorController
                                                              .workCompletionError
                                                              .value =
                                                          AppMetaLabels()
                                                              .pleaseSelectWorkCompleteionDate;
                                                      return;
                                                    }
                                                    // description
                                                    if (descriptionController
                                                                .text ==
                                                            '' ||
                                                        descriptionController
                                                                .text ==
                                                            null) {
                                                      vendorController
                                                              .descriptionError
                                                              .value =
                                                          AppMetaLabels()
                                                              .pleaseEnterDescription;
                                                      return;
                                                    }
                                                    var des =
                                                        descriptionController
                                                            .text
                                                            .replaceAll(
                                                                '\n', ' ');
                                                    if (!textValidator
                                                        .hasMatch(des)) {
                                                      vendorController
                                                              .descriptionError
                                                              .value =
                                                          AppMetaLabels()
                                                              .invalidText;
                                                      return;
                                                    }
                                                    if (des.trim().isEmpty ==
                                                        true) {
                                                      vendorController
                                                              .descriptionError
                                                              .value =
                                                          AppMetaLabels()
                                                              .invalidText;
                                                      return;
                                                    }

                                                    var serviceType;
                                                    setState(() {
                                                      serviceType = vendorController
                                                                  .isServiceRqTypeRadioButtonVal
                                                                  .value ==
                                                              0
                                                          ? 'LPO'
                                                          : 'AMC';
                                                    });
                                                    await vendorController.submitRequest(
                                                        serviceType,
                                                        vendorController
                                                            .selectedLopAmcDropDownVal
                                                            .value
                                                            .toString(),
                                                        '0',
                                                        invoiceAmountController
                                                            .text,
                                                        tRNOfController.text,
                                                        workCompletionDateController
                                                            .text,
                                                        descriptionController
                                                            .text
                                                            .trim(),
                                                        invoiceNOController
                                                            .text,
                                                        invoiceDateController
                                                            .text,
                                                        '0');

                                                    if (vendorController
                                                            .errorMainInfo
                                                            .value !=
                                                        '') {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                                contentPadding:
                                                                    EdgeInsets.fromLTRB(
                                                                        1.0.w,
                                                                        1.0.h,
                                                                        1.0.w,
                                                                        1.0.h),
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                content: SizedBox(
                                                                    width:
                                                                        100.w,
                                                                    child:
                                                                        showDialogForData()));
                                                          });
                                                    }
                                                    // with installment validation
                                                  } else {
                                                    // service no error
                                                    if (srNoController.text ==
                                                            '' ||
                                                        srNoController.text ==
                                                            null ||
                                                        vendorController
                                                                .selectedLopAmcDropDownVal
                                                                .value ==
                                                            -1) {
                                                      vendorController
                                                              .serviceNoError
                                                              .value =
                                                          AppMetaLabels()
                                                                  .pleaseSelect
                                                                  .replaceAll(
                                                                      '.', '') +
                                                              ' ' +
                                                              AppMetaLabels()
                                                                  .aMCNo;
                                                      return;
                                                    }

                                                    // Inst No error
                                                    if (instNoController.text ==
                                                            '' ||
                                                        instNoController.text ==
                                                                null &&
                                                            vendorController
                                                                    .isServiceRqTypeRadioButtonVal
                                                                    .value ==
                                                                1 ||
                                                        vendorController
                                                                .selectedInstallmentDropDownVal
                                                                .value ==
                                                            '') {
                                                      vendorController
                                                          .instNOError
                                                          .value = AppMetaLabels()
                                                              .pleaseSelect
                                                              .replaceAll(
                                                                  '.', '') +
                                                          ' ' +
                                                          AppMetaLabels()
                                                              .instalmentNoWithoutColon;
                                                      return;
                                                    }
                                                    // Invoice NO error
                                                    if (invoiceNOController
                                                                .text ==
                                                            '' ||
                                                        invoiceNOController
                                                                .text ==
                                                            null) {
                                                      vendorController
                                                              .invoiceNoError
                                                              .value =
                                                          AppMetaLabels()
                                                              .pleaseEnterInvoiceNOVal;
                                                      return;
                                                    }
                                                    // Invoice Date error
                                                    if (invoiceDateController
                                                                .text ==
                                                            '' ||
                                                        invoiceDateController
                                                                .text ==
                                                            null) {
                                                      vendorController
                                                              .invoiceDateError
                                                              .value =
                                                          AppMetaLabels()
                                                              .pleaseSelectInvoiceDate;
                                                      return;
                                                    }
                                                    // Invoice Amount error
                                                    if (invoiceAmountController
                                                                .text ==
                                                            '' ||
                                                        invoiceAmountController
                                                                .text ==
                                                            null) {
                                                      vendorController
                                                              .invoiceAmountError
                                                              .value =
                                                          AppMetaLabels()
                                                              .pleaseEnterInvoiceAmountVal;
                                                      return;
                                                    }
                                                    if (double.parse(
                                                            invoiceAmountController
                                                                .text) <=
                                                        0) {
                                                      vendorController
                                                              .invoiceAmountError
                                                              .value =
                                                          AppMetaLabels()
                                                              .pleaseEnterValidAMountSeparate;
                                                      return;
                                                    }

                                                    if (double.parse(
                                                            invoiceAmountController
                                                                .text) >
                                                        vendorController
                                                            .balanceAmountofSelectedInstallment
                                                            .value) {
                                                      setState(() {
                                                        vendorController
                                                                .invoiceAmountError
                                                                .value =
                                                            '${AppMetaLabels().yourBalanceAMount} ${vendorController.balanceAmountofSelectedInstallment.value} ,${AppMetaLabels().pleaseEnterValidAMountSeparate}';
                                                      });
                                                      return;
                                                    }

                                                    // TRN error
                                                    // if (tRNOfController.text ==
                                                    //         '' ||
                                                    //     tRNOfController.text ==
                                                    //         null) {
                                                    //   vendorController
                                                    //           .tRNofLandlordError
                                                    //           .value =
                                                    //       AppMetaLabels()
                                                    //           .pleaseEnterInvoiceTRNVal;
                                                    //   return;
                                                    // }
                                                    // Work Completion error
                                                    // if (workCompletionDateController
                                                    //             .text ==
                                                    //         '' ||
                                                    //     workCompletionDateController
                                                    //             .text ==
                                                    //         null) {
                                                    //   vendorController
                                                    //           .workCompletionError
                                                    //           .value =
                                                    //       AppMetaLabels()
                                                    //           .pleaseSelectWorkCompleteionDate;
                                                    //   return;
                                                    // }
                                                    // description
                                                    if (descriptionController
                                                                .text ==
                                                            '' ||
                                                        descriptionController
                                                                .text ==
                                                            null) {
                                                      vendorController
                                                              .descriptionError
                                                              .value =
                                                          AppMetaLabels()
                                                              .pleaseEnterDescription;
                                                      return;
                                                    }
                                                    var des =
                                                        descriptionController
                                                            .text
                                                            .replaceAll(
                                                                '\n', ' ');
                                                    print(
                                                        'descriptionController :::: $des');
                                                    if (!textValidator
                                                        .hasMatch(des)) {
                                                      vendorController
                                                              .descriptionError
                                                              .value =
                                                          AppMetaLabels()
                                                              .invalidText;
                                                      return;
                                                    }
                                                    if (des.trim().isEmpty ==
                                                        true) {
                                                      vendorController
                                                              .descriptionError
                                                              .value =
                                                          AppMetaLabels()
                                                              .invalidText;
                                                      return;
                                                    }

                                                    var serviceType;
                                                    setState(() {
                                                      serviceType = vendorController
                                                                  .selectedLopAmcDropDownVal
                                                                  .value ==
                                                              0
                                                          ? 'LPO'
                                                          : 'AMC';
                                                    });
                                                    print(
                                                        'calling func for $serviceType');
                                                    var currentDate;
                                                    DateFormat dateFormat =
                                                        new DateFormat(
                                                            AppMetaLabels()
                                                                .dateFormatForShowRoundedDatePicker);

                                                    currentDate = dateFormat
                                                        .format(DateTime.now());
                                                    await vendorController
                                                        .submitRequest(
                                                            serviceType,
                                                            vendorController
                                                                .selectedLopAmcDropDownVal
                                                                .value
                                                                .toString(),
                                                            vendorController
                                                                .selectedInstallmentDropDownNo
                                                                .value,
                                                            invoiceAmountController
                                                                .text,
                                                            tRNOfController
                                                                .text,
                                                            // workCompletionDateController
                                                            //     .text,
                                                            currentDate,
                                                            descriptionController
                                                                .text
                                                                .trim(),
                                                            invoiceNOController
                                                                .text,
                                                            invoiceDateController
                                                                .text,
                                                            vendorController
                                                                .selectedInstallmentDropDownVal
                                                                .value);
                                                    if (vendorController
                                                            .errorMainInfo
                                                            .value !=
                                                        '') {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                                contentPadding:
                                                                    EdgeInsets.fromLTRB(
                                                                        1.0.w,
                                                                        1.0.h,
                                                                        1.0.w,
                                                                        1.0.h),
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                content: SizedBox(
                                                                    width:
                                                                        100.w,
                                                                    child:
                                                                        showDialogForData()));
                                                          });
                                                    }
                                                    // setState(() {
                                                    //   controller
                                                    //       .key.currentState
                                                    //       ?.next();
                                                    // });
                                                  }
                                                } else {}
                                              },
                                              child: Text(
                                                AppMetaLabels().next,
                                                style: AppTextStyle
                                                    .semiBoldWhite14,
                                              ),
                                            ),
                                          );
                              }),
                              SizedBox(
                                height: 2.h,
                              ),
                            ]),
                      ),
                    ),
                  );
          }),
          Obx(() {
            return vendorController.loadingDataOfInstallment.value == true
                ? Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.3),
                    child: Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      color: Colors.blue,
                    )),
                  )
                : SizedBox();
          }),
          BottomShadow(),
        ],
      ),
    );
  }

  Widget showDialogForData() {
    return Container(
      padding: EdgeInsets.all(3.0.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.0.h),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0.5.h,
            spreadRadius: 0.3.h,
            offset: Offset(0.1.h, 0.1.h),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 4.0.h,
          ),
          Icon(
            Icons.error,
            size: 9.0.h,
          ),
          SizedBox(
            height: 3.0.h,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: AppMetaLabels().invoiceColudNotGenerated,
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  text: vendorController.errorMainInfo.value.toString() ==
                          'Bad Request'
                      ? 'Incorrect Data'
                      : vendorController.errorMainInfo.value.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 3.0.h,
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 5.0.h,
              width: 65.0.w,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.0.w),
                          side: BorderSide(color: Colors.blue))),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  AppMetaLabels().ok,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.semiBoldBlack10,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 3.0.h,
          ),
        ],
      ),
    );
  }
}
