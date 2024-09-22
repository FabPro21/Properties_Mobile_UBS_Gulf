// ignore_for_file: unnecessary_null_comparison, deprecated_member_use

import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/screen_disable.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_tabs.dart/tenant_contracts_details.dart/tenant_contract_details.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:photo_view/photo_view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sizer/sizer.dart';
import '../../../../../data/helpers/session_controller.dart';
import '../../../../../data/models/tenant_models/contract_payable/outstanding_payments_model.dart';
import '../online_payments/online_payments.dart';
import 'outstanding_payments_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

class OutstandingPayments extends StatefulWidget {
  final String? contractNo;
  final int? contractId;
  const OutstandingPayments({Key? key, this.contractNo, this.contractId})
      : super(key: key);

  @override
  _OutstandingPaymentsState createState() => _OutstandingPaymentsState();
}

class _OutstandingPaymentsState extends State<OutstandingPayments> {
  var _controller = Get.put(OutstandingPaymentsController());

// chequeController is just to clear the field when cancel the selected copy of cheque
  // TextEditingController chequeController = TextEditingController();
  bool value = false;
  // final formKey = GlobalKey<FormState>();
  final ItemScrollController scrollController = ItemScrollController();
  bool isEnableScreen = true;
  String typeofPayment = '';

  List<TextEditingController> _controllers = [];
  @override
  void initState() {
    initFuncs();

    super.initState();
  }

  initFuncs() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _controller.errorPickupDelivery.value = '';
      await _controller.getOutstandingPayments();
      // after completeion of above func we will decide weather we have to show
      // cheque sample or not
      // for (int i = 0; i < _controller.paymentsToShow.length; i++) {
      //   if (_controller.paymentsToShow[i] is String) {
      //     print(_controller.paymentsToShow[i]);
      //   } else {
      //     if (_controller.paymentsToShow[i].defaultpaymentmethodtype.value ==
      //         2) {
      //       _controller.isChequeSampleShow.value = true;
      //     }
      //   }
      // }
      if (_controller.errorLoadingOutstandingPayments.value == '') {
        // print('isChequeSampleShow :: ${_controller.isChequeSampleShow.value}');
        print(
            'record.first.confirmed :: ${_controller.outstandingPayments.record!.first.confirmed}');
        print(
            'errorLoadingOutstandingPayments :: ${_controller.errorLoadingOutstandingPayments.value}');
        // print(
        // 'Condition : ${(_controller.outstandingPayments.record.first.confirmed != 0 && _controller.errorLoadingOutstandingPayments.value == '' && _controller.isChequeSampleShow.value == true)}');

        if (_controller.outstandingPayments.record!.first.confirmed != 1 &&
                _controller.errorLoadingOutstandingPayments.value == ''
            // && _controller.isChequeSampleShow.value == true
            ) {
          chequeSample();
          return;
        }
      }
    });
  }

  //  Cheque Upload and Download while payment
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          isEnableScreen = true;
          _controller.isShowpopUp.value = false;
        });
        Get.back();
        return false;
      },
      child: Directionality(
        textDirection: SessionController().getLanguage() == 1
            ? ui.TextDirection.ltr
            : ui.TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset:
              _controller.chequeDeliveryOption.value == 2 ? true : false,
          body: Stack(
            children: [
              SafeArea(
                child: Obx(() {
                  return Stack(children: [
                    // Payment Method
                    Padding(
                      padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppMetaLabels().paymentMethod + '',
                            style: AppTextStyle.semiBoldBlack15,
                          ),
                          InkWell(
                            onTap: () => Get.back(),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(118, 118, 128, 0.12),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(0.5.h),
                                child: Icon(Icons.close,
                                    size: 2.5.h,
                                    color: Color.fromRGBO(158, 158, 158, 1)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Divider
                    Padding(
                      padding: EdgeInsets.only(top: 4.0.h, bottom: 2.0.w),
                      child: AppDivider(),
                    ),

                    // Main Info
                    Padding(
                        padding: EdgeInsets.only(top: 4.0.h, bottom: 6.0.h),
                        child: _controller.loadingOutstandingPayments.value
                            ? LoadingIndicatorBlue()
                            : _controller.errorLoadingOutstandingPayments
                                        .value !=
                                    ''
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomErrorWidget(
                                        errorImage: _controller
                                                .paymentsToShow.isEmpty
                                            ? AppImagesPath.noPaymentsFound
                                            : _controller
                                                .errorLoadingOutstandingPayments
                                                .value,
                                        errorText: AppMetaLabels()
                                            .noPendingPaymentFound,
                                        onRetry: () {
                                          _controller.getOutstandingPayments();
                                        },
                                      ),
                                      if (_controller.paymentsToShow.isEmpty)
                                        TextButton(
                                          child: Text(
                                              AppMetaLabels().viewContract),
                                          onPressed: () {
                                            Get.off(
                                                () => ContractsDetailsTabs());
                                          },
                                        )
                                    ],
                                  )
                                : Center(
                                    child: SingleChildScrollView(
                                      child: Container(
                                        width: 92.0.w,
                                        height: 78.h,
                                        padding: EdgeInsets.only(
                                            left: 3.w, right: 3.w, top: 1.5.h),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(2.0.h),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Contract No. number
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  AppMetaLabels().contractNo,
                                                  style: AppTextStyle
                                                      .semiBoldBlack12,
                                                ),
                                                Text(
                                                  widget.contractNo ?? "",
                                                  style: AppTextStyle
                                                      .semiBoldBlack12,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),

                                            // Payments
                                            Text(
                                              AppMetaLabels().payments,
                                              style:
                                                  AppTextStyle.semiBoldBlack12,
                                            ),

                                            // here add
                                            SizedBox(
                                              height: 1.5.h,
                                            ),
                                            //  cheque sample
                                            _controller.errorLoadingOutstandingPayments
                                                        .value ==
                                                    ''
                                                ? Align(
                                                    alignment: SessionController()
                                                                .getLanguage() ==
                                                            1
                                                        ? Alignment.centerRight
                                                        : Alignment.centerLeft,
                                                    child: RichText(
                                                      text: TextSpan(
                                                        text: AppMetaLabels()
                                                            .chequeSample,
                                                        style: AppTextStyle
                                                            .normalBlack9,
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                              text:
                                                                  AppMetaLabels()
                                                                      .clickHere,
                                                              style: AppTextStyle
                                                                  .semiBoldBlue9ul,
                                                              recognizer:
                                                                  TapGestureRecognizer()
                                                                    ..onTap =
                                                                        () {
                                                                      chequeSample();
                                                                      setState(
                                                                          () {});
                                                                    })
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox(),
                                            AppDivider(),
                                            // remaining radio etc  work
                                            Expanded(
                                              child:
                                                  ScrollablePositionedList
                                                      .builder(
                                                          itemScrollController:
                                                              scrollController,
                                                          itemCount: _controller
                                                              .paymentsToShow
                                                              .length,
                                                          padding:
                                                              EdgeInsets.zero,
                                                          itemBuilder:
                                                              (context, index) {
                                                            _controllers.add(
                                                                new TextEditingController());
                                                            return _controller
                                                                            .paymentsToShow[
                                                                        index]
                                                                    is String
                                                                ? Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: 1.5
                                                                            .h,
                                                                        bottom:
                                                                            1.h,
                                                                        left: 4.0
                                                                            .w,
                                                                        right: 4.0
                                                                            .w),
                                                                    // like Rental payment etc
                                                                    child: Text(
                                                                      _controller
                                                                              .paymentsToShow[
                                                                          index], //+' Index: '+ index.toString(),
                                                                      style: AppTextStyle
                                                                          .semiBoldBlack11,
                                                                    ),
                                                                  )
                                                                : paymentListItem(
                                                                    _controller
                                                                            .paymentsToShow[
                                                                        index],
                                                                    index);
                                                          }),
                                            ),
                                            if (_controller
                                                .showDeliveryOptionsTest.value)
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  AppDivider(),
                                                  // How would like to ...
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      top: 1.h,
                                                    ),
                                                    child: Text(
                                                      AppMetaLabels()
                                                          .howToDeliverCheque,
                                                      style: AppTextStyle
                                                          .normalBlack12,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Radio(
                                                        activeColor:
                                                            AppColors.blueColor,
                                                        groupValue: _controller
                                                            .chequeDeliveryOption
                                                            .value,
                                                        onChanged:
                                                            (int? value) {
                                                          _controller
                                                              .errorPickupDelivery
                                                              .value = '';

                                                          if (_controller
                                                                  .outstandingPayments
                                                                  .record!
                                                                  .first
                                                                  .confirmed ==
                                                              0)
                                                            _controller
                                                                .chequeDeliveryOption
                                                                .value = value!;
                                                          else
                                                            SnakBarWidget
                                                                .getSnackBarErrorBlue(
                                                              AppMetaLabels()
                                                                  .alert,
                                                              AppMetaLabels()
                                                                  .paymentConfirmed,
                                                            );
                                                        },
                                                        value: 1,
                                                      ),
                                                      Text(
                                                        AppMetaLabels()
                                                            .selfDelivery,
                                                        style: AppTextStyle
                                                            .normalBlack10,
                                                      ),
                                                      SizedBox(
                                                        width: 0.5.w,
                                                      ),
                                                      Radio(
                                                        activeColor:
                                                            AppColors.blueColor,
                                                        groupValue: _controller
                                                            .chequeDeliveryOption
                                                            .value,
                                                        onChanged:
                                                            (int? value) {
                                                          _controller
                                                              .errorPickupDelivery
                                                              .value = '';

                                                          if (_controller
                                                                  .outstandingPayments
                                                                  .record!
                                                                  .first
                                                                  .confirmed ==
                                                              0)
                                                            _controller
                                                                .chequeDeliveryOption
                                                                .value = value!;
                                                          else
                                                            SnakBarWidget
                                                                .getSnackBarErrorBlue(
                                                              AppMetaLabels()
                                                                  .alert,
                                                              AppMetaLabels()
                                                                  .paymentConfirmed,
                                                            );
                                                        },
                                                        value: 2,
                                                      ),
                                                      Text(
                                                        AppMetaLabels()
                                                            .freePickupBC,
                                                        style: AppTextStyle
                                                            .normalBlack10,
                                                      ),
                                                    ],
                                                  ),
                                                  if (_controller
                                                          .chequeDeliveryOption
                                                          .value ==
                                                      2)
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 1.0.h,
                                                          bottom: 1.0.h),
                                                      child: TextField(
                                                        enabled: _controller
                                                                    .outstandingPayments
                                                                    .record!
                                                                    .first
                                                                    .confirmed ==
                                                                1
                                                            ? false
                                                            : true,
                                                        readOnly: _controller
                                                                .outstandingPayments
                                                                .record!
                                                                .first
                                                                .confirmed ==
                                                            1,
                                                        controller: _controller
                                                            .locationTextController,
                                                        decoration: InputDecoration(
                                                            filled: true,
                                                            fillColor: AppColors
                                                                .greyBG,
                                                            border: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: _controller.errorPickupDelivery.value !=
                                                                            ''
                                                                        ? Colors
                                                                            .red
                                                                        : Colors
                                                                            .transparent,
                                                                    width:
                                                                        0.1)),
                                                            labelText:
                                                                '${AppMetaLabels().chequeCollectionAddress} *',
                                                            hintText:
                                                                AppMetaLabels()
                                                                    .pleaseEnter),
                                                      ),
                                                    ),
                                                  _controller.errorPickupDelivery
                                                              .value ==
                                                          ''
                                                      ? SizedBox()
                                                      : Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 5),
                                                          height: 30,
                                                          width:
                                                              double.infinity,
                                                          child: Text(
                                                            AppMetaLabels()
                                                                .enterValidAddress,
                                                            style: AppTextStyle
                                                                .normalErrorText3,
                                                          ),
                                                        )
                                                ],
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),

                    // botom button
                    // !_controller.gotoOnlinePayments.value &&  confirmed ==1
                    // applying this condition coz
                    // want to show sizedBox() if there is only chequeq remaining
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 7.0.h,
                        padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 0.5.h,
                              spreadRadius: 0.5.h,
                              offset: Offset(0.1.h, 0.1.h),
                            ),
                          ],
                        ),
                        child: Obx(() {
                          // jb tak loading ho ge button ki jgha sizedBox
                          return _controller.loadingOutstandingPayments.value
                              ? SizedBox()
                              : _controller.errorLoadingOutstandingPayments
                                          .value !=
                                      ''
                                  ? SizedBox()
                                  : !_controller.gotoOnlinePayments.value &&
                                          _controller.outstandingPayments
                                                  .record!.first.confirmed ==
                                              1
                                      ? SizedBox()
                                      : _controller
                                                  .errorLoadingOutstandingPayments
                                                  .value !=
                                              ''
                                          ? SizedBox()
                                          : _controller
                                                  .gotoOnlinePaymentsTest.value
                                              ? SizedBox()
                                              : _controller
                                                      .updatingAddress.value
                                                  ? LoadingIndicatorBlue()
                                                  : Center(
                                                      child: Obx(() {
                                                        return !_controller
                                                                .showDeliveryOptionsTestForButton
                                                                .value
                                                            ? ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  print(
                                                                      'Checking :::::::::::: 1');
                                                                  // the below condition in the for loop is for
                                                                  // if any of the installment is un selecteable the will show the alert the select the whole installment' payment options
                                                                  bool
                                                                      isUnselectedInstallment =
                                                                      false;
                                                                  for (int i =
                                                                          0;
                                                                      i <
                                                                          _controller
                                                                              .outstandingPayments
                                                                              .record!
                                                                              .length;
                                                                      i++) {
                                                                    print(
                                                                        'defaultpaymentmethodtype :::::::: ${_controller.outstandingPayments.record![i].defaultpaymentmethodtype!.value}');
                                                                    if (_controller
                                                                            .outstandingPayments
                                                                            .record![i]
                                                                            .defaultpaymentmethodtype!
                                                                            .value ==
                                                                        0) {
                                                                      setState(
                                                                          () {
                                                                        isUnselectedInstallment =
                                                                            true;
                                                                      });
                                                                    }
                                                                  }
                                                                  if (isUnselectedInstallment ==
                                                                      true) {
                                                                    SnakBarWidget.getSnackBarErrorBlueWith5Sec(
                                                                        AppMetaLabels()
                                                                            .alert,
                                                                        AppMetaLabels()
                                                                            .pleaseSelectAllPayments);
                                                                    return;
                                                                  }
                                                                  print(_controller
                                                                      .showDeliveryOptionsTestForButton
                                                                      .value);
                                                                  print(_controller
                                                                      .chequesToShowAddress);
                                                                  int index =
                                                                      _controller
                                                                          .areAllChequesUploaded();
                                                                  if (index >
                                                                      -1) {
                                                                    _controller
                                                                        .outstandingPayments
                                                                        .record![
                                                                            index]
                                                                        .forceUploadCheque
                                                                        .value = true;
                                                                    return;
                                                                  }
                                                                  var isShow = _controller
                                                                      .chequesToShowAddress
                                                                      .contains(
                                                                          'true');
                                                                  if (isShow) {
                                                                    _controller
                                                                        .showDeliveryOptionsTest
                                                                        .value = true;
                                                                    setState(
                                                                        () {
                                                                      _controller
                                                                          .showDeliveryOptionsTestForButton
                                                                          .value = true;
                                                                    });
                                                                    print(
                                                                        'inside IF ${_controller.showDeliveryOptionsTest.value}');
                                                                    return;
                                                                  } else {
                                                                    print(
                                                                        'inside Else');
                                                                    _controller
                                                                        .showDeliveryOptionsTest
                                                                        .value = false;
                                                                    _showConfirmation(
                                                                      context,
                                                                    );
                                                                  }
                                                                },
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                          15.0,
                                                                      right:
                                                                          15.0,
                                                                      top: 8.0,
                                                                      bottom:
                                                                          8.0),
                                                                  child: Text(
                                                                    _controller
                                                                            .gotoOnlinePayments
                                                                            .value
                                                                        ? AppMetaLabels()
                                                                            .confirmPayment
                                                                        : '    ' +
                                                                            AppMetaLabels().submit +
                                                                            '    ',
                                                                    style: AppTextStyle
                                                                        .semiBoldBlack11
                                                                        .copyWith(
                                                                            color:
                                                                                Colors.white),
                                                                  ),
                                                                ),
                                                                style:
                                                                    ButtonStyle(
                                                                        elevation:
                                                                            WidgetStateProperty.all<double>(
                                                                                0.0),
                                                                        backgroundColor:
                                                                            WidgetStateProperty.all<Color>(AppColors
                                                                                .blueColor),
                                                                        shape: WidgetStateProperty.all<
                                                                            RoundedRectangleBorder>(
                                                                          RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(2.0.w),
                                                                          ),
                                                                        )),
                                                              )
                                                            : ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  print(
                                                                      'Checking :::::::::::: 2');
                                                                  // the below condition in the for loop is for
                                                                  // if any of the installment is un selecteable the will show the alert the select the whole installment' payment options
                                                                  bool
                                                                      isUnselectedInstallment =
                                                                      false;
                                                                  for (int i =
                                                                          0;
                                                                      i <
                                                                          _controller
                                                                              .outstandingPayments
                                                                              .record!
                                                                              .length;
                                                                      i++) {
                                                                    print(
                                                                        'Payment Method ID :::::::: ${_controller.outstandingPayments.record![i].defaultpaymentmethodtype!.value}');
                                                                    if (_controller
                                                                            .outstandingPayments
                                                                            .record![i]
                                                                            .defaultpaymentmethodtype!
                                                                            .value ==
                                                                        0) {
                                                                      setState(
                                                                          () {
                                                                        isUnselectedInstallment =
                                                                            true;
                                                                      });
                                                                    }
                                                                  }
                                                                  if (isUnselectedInstallment ==
                                                                      true) {
                                                                    SnakBarWidget.getSnackBarErrorBlueWith5Sec(
                                                                        AppMetaLabels()
                                                                            .alert,
                                                                        AppMetaLabels()
                                                                            .pleaseSelectAllPayments);
                                                                    return;
                                                                  }

                                                                  //
                                                                  print(_controller
                                                                      .showDeliveryOptionsTestForButton
                                                                      .value);
                                                                  print(_controller
                                                                      .chequesToShowAddress);

                                                                  int index =
                                                                      _controller
                                                                          .areAllChequesUploaded();
                                                                  if (index >
                                                                      -1) {
                                                                    _controller
                                                                        .outstandingPayments
                                                                        .record![
                                                                            index]
                                                                        .forceUploadCheque
                                                                        .value = true;
                                                                    return;
                                                                  }
                                                                  if (_controller
                                                                          .chequesToShowAddress
                                                                          .contains(
                                                                              'true') ==
                                                                      true) {
                                                                    if (_controller
                                                                            .chequeDeliveryOption
                                                                            .value ==
                                                                        1) {
                                                                      _showConfirmation(
                                                                        context,
                                                                      );
                                                                    } else {
                                                                      if (_controller
                                                                              .chequeDeliveryOption
                                                                              .value ==
                                                                          2) {
                                                                        if (_controller.locationTextController.text.length <
                                                                            4) {
                                                                          _controller
                                                                              .errorPickupDelivery
                                                                              .value = AppMetaLabels().enterValidAddress;

                                                                          return;
                                                                        } else {
                                                                          _controller
                                                                              .pickupDeliveryText
                                                                              .value = _controller.locationTextController.text;
                                                                          print(_controller
                                                                              .pickupDeliveryText
                                                                              .value);
                                                                          _showConfirmation(
                                                                              context);
                                                                        }
                                                                      }
                                                                    }
                                                                  } else {
                                                                    _showConfirmation(
                                                                      context,
                                                                    );
                                                                  }
                                                                },
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                          15.0,
                                                                      right:
                                                                          15.0,
                                                                      top: 8.0,
                                                                      bottom:
                                                                          8.0),
                                                                  child: Text(
                                                                    _controller
                                                                            .gotoOnlinePayments
                                                                            .value
                                                                        ? AppMetaLabels()
                                                                            .confirmPayment
                                                                        : '    ' +
                                                                            AppMetaLabels().submit +
                                                                            '     ',
                                                                    style: AppTextStyle
                                                                        .semiBoldBlack11
                                                                        .copyWith(
                                                                            color:
                                                                                Colors.white),
                                                                  ),
                                                                ),
                                                                style:
                                                                    ButtonStyle(
                                                                        elevation:
                                                                            WidgetStateProperty.all<double>(
                                                                                0.0),
                                                                        backgroundColor:
                                                                            WidgetStateProperty.all<Color>(AppColors
                                                                                .blueColor),
                                                                        shape: WidgetStateProperty.all<
                                                                            RoundedRectangleBorder>(
                                                                          RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(2.0.w),
                                                                          ),
                                                                        )),
                                                              );
                                                      }),
                                                    );
                        }),
                      ),
                    ),

                    isEnableScreen == false
                        ? ScreenDisableWidget()
                        : SizedBox(),
                  ]);
                }),
              ),
              Obx(() {
                return _controller.isShowpopUp.value != true
                    ? SizedBox()
                    : Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: Colors.black.withOpacity(0.3),
                        child: Center(
                          child: Container(
                              padding: EdgeInsets.all(3.0.w),
                              margin: EdgeInsets.all(3.0.h),
                              // height: 45.0.h,
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
                                    Image.asset(
                                      AppImagesPath.bluttickimg,
                                      height: 12.0.h,
                                      width: 12.0.h,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(
                                      height: 3.0.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: Get.width * 0.03),
                                      child: Text(
                                        AppMetaLabels().stage5_12,
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle.normalBlack12
                                            .copyWith(
                                                color:
                                                    AppColors.renewelgreyclr1,
                                                height: 1.3),
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 5.0.h, bottom: 2.0.h),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: SizedBox(
                                            height: 5.0.h,
                                            width: 65.0.w,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          1.3.h),
                                                ),
                                                backgroundColor: Color.fromRGBO(
                                                    0, 61, 166, 1),
                                              ),
                                              onPressed: () {
                                                _controller.isShowpopUp.value =
                                                    false;
                                                Get.back();
                                              },
                                              child: Text(
                                                AppMetaLabels().ok,
                                                textAlign: TextAlign.center,
                                                style: AppTextStyle
                                                    .semiBoldWhite10,
                                              ),
                                            ),
                                          ),
                                        )),
                                  ])),
                        ),
                      );
              })
            ],
          ),
        ),
      ),
    );
  }

  Padding paymentListItem(Record payable, int index1) {
    // All=0 DONE
    // CardPayment,=1 DONE
    // BankTranfser,=2
    // Cheque=3
    // CardPaymentBankTransfer=4 DONE
    // CardPaymentCheque=5
    // BankTransferCheque=6

    return Padding(
      padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 1.h, bottom: 0.5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: SessionController().getLanguage() == 1
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Instalment No etc
                      Expanded(
                        child: Text(
                          payable.title ?? '',
                          style: AppTextStyle.normalBlack10,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      // AED 25,99,0008
                      Text(
                        '${AppMetaLabels().aed} ${payable.amountFormatted}',
                        style: AppTextStyle.semiBoldBlack10,
                        textAlign: TextAlign.end,
                      ),
                    ],
                  )
                : Directionality(
                    textDirection: ui.TextDirection.ltr,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${AppMetaLabels().aed} ${payable.amountFormatted}',
                          style: AppTextStyle.semiBoldBlack10,
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        // Instalment No etc
                        Expanded(
                          child: Text(
                            payable.titleAr != null
                                ? payable.titleAr!.replaceAll(':', '')
                                : payable.titleAr ?? "",
                            style: AppTextStyle.normalBlack10,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppMetaLabels().dueDate,
                style: AppTextStyle.normalBlack10,
              ),
              Text(
                payable.paymentDate ?? '--',
                style: AppTextStyle.normalBlue10,
              ),
            ],
          ),
          SizedBox(
            height: 1.5.h,
          ),
          // i want to make payment ...
          Text(
            AppMetaLabels().makePaymentThrough,
            style: AppTextStyle.normalBlack9,
          ),
          Obx(() {
            return payable.updatingPaymentMethod.value
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LoadingIndicatorBlue(
                        size: 20,
                      ),
                    ),
                  )
                : payable.errorUpdatingPaymentMethod
                    ? Center(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              child: Icon(
                                Icons.refresh,
                                size: 20,
                                color: Colors.red,
                              ),
                              onTap: () async {
                                setState(() {
                                  isEnableScreen = false;
                                });

                                await _controller.updatePaymentMethod(
                                    payable, index1, context, typeofPayment);
                                setState(() {
                                  isEnableScreen = true;
                                });
                              },
                            )),
                      )
                    : Row(
                        children: [
                          // All=0 DONE
                          // CardPayment,=1 DONE
                          // BankTranfser,=2
                          // Cheque=3
                          // CardPaymentBankTransfer=4 DONE
                          // CardPaymentCheque=5
                          // BankTransferCheque=6

                          // => CardPayment
                          // payable.acceptPaymentType == 0 // for all
                          // payable.acceptPaymentType == 1 // for only CardPayment
                          // payable.acceptPaymentType == 4 // for with Bank transfer
                          // payable.acceptPaymentType == 5 // for with Cheque
                          if (payable.acceptPaymentType == 0 ||
                              payable.acceptPaymentType == 1 ||
                              payable.acceptPaymentType == 4 ||
                              payable.acceptPaymentType == 5)
                            // Card
                            Container(
                              width: 28.w,
                              child: Row(
                                children: [
                                  // Card
                                  Container(
                                    width: 4.w,
                                    child: Transform.scale(
                                      scale: 0.8,
                                      child: Radio(
                                        activeColor: AppColors.blueColor,
                                        groupValue: payable
                                            .defaultpaymentmethodtype!.value,
                                        onChanged: (int? value) async {
                                          setState(() {
                                            typeofPayment = 'onlineOrCard';
                                          });

                                          if (_controller.outstandingPayments
                                                  .record!.first.confirmed ==
                                              0) {
                                            payable.defaultpaymentmethodtype!
                                                .value = value!;
                                            payable.filePath = null;
                                            setState(() {
                                              isEnableScreen = false;
                                            });
                                            print('Index ::::: $index1');
                                            print(
                                                'typeofPayment ::::: $typeofPayment');
                                            await _controller
                                                .updatePaymentMethod(
                                                    payable,
                                                    index1,
                                                    context,
                                                    typeofPayment);
                                            setState(() {
                                              isEnableScreen = true;
                                            });
                                          } else {
                                            SnakBarWidget.getSnackBarErrorBlue(
                                              AppMetaLabels().alert,
                                              AppMetaLabels().paymentConfirmed,
                                            );
                                            return;
                                          }
                                          setState(() {
                                            isEnableScreen = true;
                                          });

                                          setState(() {
                                            _controller.chequesToShowAddress[
                                                index1 - 1] = 'false';
                                          });

                                          // this condition  is for hide or show fields
                                          var isShow = _controller
                                              .chequesToShowAddress
                                              .contains('true');
                                          if (isShow) {
                                            _controller.showDeliveryOptionsTest
                                                .value = true;
                                            setState(() {
                                              _controller
                                                  .showDeliveryOptionsTestForButton
                                                  .value = true;
                                              _controller
                                                  .showDeliveryOptionsTest
                                                  .value = true;
                                            });
                                            return;
                                          } else {
                                            setState(() {
                                              _controller
                                                  .showDeliveryOptionsTestForButton
                                                  .value = false;
                                              _controller
                                                  .showDeliveryOptionsTest
                                                  .value = false;
                                            });
                                          }
                                        },
                                        value: 1,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 0.5.w,
                                  ),
                                  // Card
                                  InkWell(
                                    onTap: payable.acceptPaymentType == 1
                                        ? () {}
                                        : () async {
                                            setState(() {
                                              typeofPayment = 'onlineOrCard';
                                            });
                                            if (_controller.outstandingPayments
                                                    .record!.first.confirmed ==
                                                0) {
                                              payable.defaultpaymentmethodtype!
                                                  .value = 1;
                                              payable.filePath = null;
                                              setState(() {
                                                isEnableScreen = false;
                                              });

                                              await _controller
                                                  .updatePaymentMethod(
                                                      payable,
                                                      index1,
                                                      context,
                                                      typeofPayment);
                                              setState(() {
                                                isEnableScreen = true;
                                              });
                                            } else {
                                              SnakBarWidget
                                                  .getSnackBarErrorBlue(
                                                AppMetaLabels().alert,
                                                AppMetaLabels()
                                                    .paymentConfirmed,
                                              );
                                              return;
                                            }
                                            setState(() {
                                              isEnableScreen = true;
                                            });

                                            setState(() {
                                              _controller.chequesToShowAddress[
                                                  index1 - 1] = 'false';
                                            });

                                            // this condition  is for hide or show fields
                                            var isShow = _controller
                                                .chequesToShowAddress
                                                .contains('true');
                                            if (isShow) {
                                              _controller
                                                  .showDeliveryOptionsTest
                                                  .value = true;
                                              setState(() {
                                                _controller
                                                    .showDeliveryOptionsTestForButton
                                                    .value = true;
                                                _controller
                                                    .showDeliveryOptionsTest
                                                    .value = true;
                                              });
                                              return;
                                            } else {
                                              setState(() {
                                                _controller
                                                    .showDeliveryOptionsTestForButton
                                                    .value = false;
                                                _controller
                                                    .showDeliveryOptionsTest
                                                    .value = false;
                                              });
                                            }
                                          },
                                    child: Text(
                                      AppMetaLabels().cardPayment,
                                      style: AppTextStyle.normalBlack10,
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          SizedBox(
                            width: 2.w,
                          ),
                          // => BankTranfser
                          // payable.acceptPaymentType == 0 // for all
                          // payable.acceptPaymentType == 2 // for only BankTranfser
                          // payable.acceptPaymentType == 4 // for with Bank transfer
                          // payable.acceptPaymentType == 5 // for with Cheque
                          // if (payable.acceptPaymentType == 0 ||
                          //     payable.acceptPaymentType == 2 ||
                          //     payable.acceptPaymentType == 4 ||
                          //     payable.acceptPaymentType == 6)
                          //   Container(
                          //     width: 27.w,
                          //     child: Row(
                          //       children: [
                          //         // BankTranfser
                          //         Container(
                          //           width: 4.w,
                          //           child: Transform.scale(
                          //             scale: 0.8,
                          //             child: Radio(
                          //               groupValue:
                          //                   payable.paymentMethodId.value,
                          //               onChanged: (value) async {
                          //                 setState(() {
                          //                   typeofPayment = 'bankTransfer';
                          //                 });
                          // if (_controller.outstandingPayments
                          //         .record.first.confirmed ==
                          //     0) {
                          // if (_controller.outstandingPayments
                          //                       .record[index1].confirmed ==
                          //                   0) {
                          //                   payable.paymentMethodId.value =
                          //                       value;
                          //                   payable.filePath = null;
                          //                   setState(() {
                          //                     isEnableScreen = false;
                          //                   });
                          //                   await _controller
                          //                       .updatePaymentMethod(
                          //                           payable,
                          //                           index1,
                          //                           context,
                          //                           typeofPayment);
                          //                   setState(() {
                          //                     isEnableScreen = true;
                          //                   });
                          //                 } else {
                          //                   Get.snackbar(
                          //                       AppMetaLabels().alert,
                          //                       AppMetaLabels()
                          //                           .paymentConfirmed,
                          //                       backgroundColor:
                          //                           AppColors.white54);
                          //                   return;
                          //                 }
                          //                 setState(() {
                          //                   isEnableScreen = true;
                          //                 });
                          //                 print('inside IF $index1');
                          //                 setState(() {
                          //                   _controller.chequesToShowAddress[
                          //                       index1 - 1] = 'false';
                          //                 });
                          //                 // this condition  is for hide or show fields
                          //                 var isShow = _controller
                          //                     .chequesToShowAddress
                          //                     .contains('true');
                          //                 if (isShow) {
                          //                   _controller.showDeliveryOptionsTest
                          //                       .value = true;
                          //                   setState(() {
                          //                     _controller
                          //                         .showDeliveryOptionsTestForButton
                          //                         .value = true;
                          //                     _controller
                          //                         .showDeliveryOptionsTest
                          //                         .value = true;
                          //                   });
                          //                   return;
                          //                 } else {
                          //                   setState(() {
                          //                     _controller
                          //                         .showDeliveryOptionsTestForButton
                          //                         .value = false;
                          //                     _controller
                          //                         .showDeliveryOptionsTest
                          //                         .value = false;
                          //                   });
                          //                 }
                          //               },
                          //               value: 3,
                          //             ),
                          //           ),
                          //         ),
                          //         SizedBox(
                          //           width: 0.5.w,
                          //         ),
                          //         Text(
                          //           AppMetaLabels().bankTransfer,
                          //           style: AppTextStyle.normalBlack10,
                          //         ),
                          //         Spacer(),
                          //       ],
                          //     ),
                          //   ),
                          // SizedBox(
                          //   width: 0.1.w,
                          // ),
                          // => Cheque
                          // payable.acceptPaymentType == 0 // for all
                          // payable.acceptPaymentType == 3 // for only cheque
                          // payable.acceptPaymentType == 5 // for with CardPayment
                          // payable.acceptPaymentType == 6 // for with BankTransfer

                          if (payable.acceptPaymentType == 0 ||
                              payable.acceptPaymentType == 3 ||
                              payable.acceptPaymentType == 5 ||
                              payable.acceptPaymentType == 6)
                            // Cheque
                            Container(
                              width: 18.w,
                              child: Row(
                                children: [
                                  Container(
                                    width: 4.w,
                                    child: Transform.scale(
                                      scale: 0.8,
                                      child: Radio(
                                        activeColor: AppColors.blueColor,
                                        toggleable: payable.cheque == null ||
                                            payable.cheque!.isEmpty,
                                        groupValue: payable
                                            .defaultpaymentmethodtype!.value,
                                        onChanged: (int? value) async {
                                          setState(() {
                                            typeofPayment = 'Cheque';
                                          });
                                          setState(() {
                                            isEnableScreen = false;
                                          });
                                          print(value);
                                          if (_controller.outstandingPayments
                                                  .record!.first.confirmed ==
                                              0) {
                                            payable.defaultpaymentmethodtype!
                                                .value = value!;
                                            payable.filePath = null;
                                            setState(() {
                                              isEnableScreen = false;
                                            });

                                            // we commented the updatePaymentMethod because when we tap on cheque we were calling this and
                                            // we will tap on upload after attach copy of cheque and card nbr again call same func
                                            // so for reducing this we commented this
                                            // *
                                            // so insted of updatePaymentMethod we are just add 'true' for the address otption for the cheque
                                            // that we were adding this in the updatePaymentMethod

                                            if (typeofPayment == 'Cheque') {
                                              _controller.chequesToShowAddress[
                                                  index1 - 1] = 'true';
                                            }

                                            setState(() {
                                              isEnableScreen = true;
                                            });
                                          } else
                                            SnakBarWidget.getSnackBarErrorBlue(
                                              AppMetaLabels().alert,
                                              AppMetaLabels().paymentConfirmed,
                                            );

                                          setState(() {
                                            isEnableScreen = true;
                                          });
                                          var isShow = _controller
                                              .chequesToShowAddress
                                              .contains('true');
                                          if (isShow) {
                                            _controller.showDeliveryOptionsTest
                                                .value = true;
                                            setState(() {
                                              _controller
                                                  .showDeliveryOptionsTestForButton
                                                  .value = true;
                                              _controller
                                                  .showDeliveryOptionsTest
                                                  .value = true;
                                            });
                                            return;
                                          } else {
                                            setState(() {
                                              _controller
                                                  .showDeliveryOptionsTestForButton
                                                  .value = false;
                                              _controller
                                                  .showDeliveryOptionsTest
                                                  .value = false;
                                            });
                                          }
                                        },
                                        value: 2,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 0.5.w,
                                  ),
                                  InkWell(
                                    onTap: payable.acceptPaymentType == 3
                                        ? () {}
                                        : () async {
                                            setState(() {
                                              typeofPayment = 'Cheque';
                                            });
                                            setState(() {
                                              isEnableScreen = false;
                                            });
                                            if (_controller
                                                    .outstandingPayments
                                                    .record![index1]
                                                    .confirmed ==
                                                0) {
                                              payable.defaultpaymentmethodtype!
                                                  .value = 2;
                                              payable.filePath = null;
                                              setState(() {
                                                isEnableScreen = false;
                                              });

                                              // we commented the updatePaymentMethod because when we tap on cheque we were calling this and
                                              // we will tap on upload after attach copy of cheque and card nbr again call same func
                                              // so for reducing this we commented this
                                              // *
                                              // so insted of updatePaymentMethod we are just add 'true' for the address otption for the cheque
                                              // that we were adding this in the updatePaymentMethod

                                              if (typeofPayment == 'Cheque') {
                                                _controller
                                                        .chequesToShowAddress[
                                                    index1 - 1] = 'true';
                                              }
                                              setState(() {
                                                isEnableScreen = true;
                                              });
                                            } else
                                              SnakBarWidget
                                                  .getSnackBarErrorBlue(
                                                AppMetaLabels().alert,
                                                AppMetaLabels()
                                                    .paymentConfirmed,
                                              );
                                            setState(() {
                                              isEnableScreen = true;
                                            });
                                            var isShow = _controller
                                                .chequesToShowAddress
                                                .contains('true');
                                            if (isShow) {
                                              _controller
                                                  .showDeliveryOptionsTest
                                                  .value = true;
                                              setState(() {
                                                _controller
                                                    .showDeliveryOptionsTestForButton
                                                    .value = true;
                                                _controller
                                                    .showDeliveryOptionsTest
                                                    .value = true;
                                              });
                                              return;
                                            } else {
                                              setState(() {
                                                _controller
                                                    .showDeliveryOptionsTestForButton
                                                    .value = false;
                                                _controller
                                                    .showDeliveryOptionsTest
                                                    .value = false;
                                              });
                                            }
                                          },
                                    child: Text(
                                      AppMetaLabels().cheque,
                                      style: AppTextStyle.normalBlack10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      );
          }),

// cheque logic
          payable.defaultpaymentmethodtype!.value == 2
              ? Obx(() {
                  return payable.errorUploadingCheque
                      ? Column(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      OpenFile.open(
                                        payable.filePath,
                                      );
                                    },
                                    child: SizedBox(
                                      width: Get.width * 0.66,
                                      child: Text(
                                        payable.filePath!.split('/').last,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 5,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                      onTap: () {
                                        print('Exactly here');
                                        setState(() {
                                          payable.filePath = null;
                                          payable.errorUploadingCheque = false;
                                        });
                                        setState(() {});
                                      },
                                      child: Icon(
                                        Icons.cancel,
                                        size: 23,
                                        color: AppColors.grey1,
                                      ))
                                ],
                              ),
                            ),
                            InkWell(
                              child: Icon(
                                Icons.refresh,
                                size: 25,
                                color: Colors.red,
                              ),
                              onTap: () async {
                                setState(() {
                                  isEnableScreen = false;
                                });
                                await _controller.uploadCheque(
                                  payable,
                                );
                                setState(() {
                                  isEnableScreen = true;
                                });
                                setState(
                                  () {},
                                );
                              },
                            ),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        )
                      : payable.uploadingCheque.value
                          ? LoadingIndicatorBlue(
                              size: 3.h,
                            )
                          : payable.cheque != null &&
                                  payable.cheque!.isNotEmpty &&
                                  !payable.isRejected!
                              ? payable.downloadingCheque.value
                                  ? LoadingIndicatorBlue(
                                      size: 3.h,
                                    )
                                  : SizedBox(
                                      width: 100.w,
                                      child: Column(
                                        children: [
                                          Row(children: [
                                            Icon(
                                              Icons.photo,
                                              color: Colors.black38,
                                            ),
                                            SizedBox(
                                              width: 1.w,
                                            ),
                                            InkWell(
                                              child: SizedBox(
                                                width: 60.w,
                                                child: Text(
                                                  payable.cheque ?? "",
                                                  style: AppTextStyle
                                                      .normalBlue12
                                                      .copyWith(
                                                          color: payable
                                                                  .forceUploadCheque
                                                                  .value
                                                              ? Colors.red
                                                              : AppColors
                                                                  .blueColor),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              //  downloadCheque
                                              onTap: () async {
                                                if (payable.chequeFile !=
                                                    null) {
                                                  _controller.showFile(
                                                      payable,
                                                      payable.chequeFile!,
                                                      'cheque${payable.contractPaymentId}');
                                                } else {
                                                  setState(() {
                                                    isEnableScreen = false;
                                                  });
                                                  await _controller
                                                      .downloadCheque(payable);
                                                  setState(() {
                                                    isEnableScreen = true;
                                                  });
                                                }
                                              },
                                            ),
                                            Spacer(),
                                            if (payable.confirmed != 1)
                                              payable.removingCheque.value
                                                  ? LoadingIndicatorBlue(
                                                      size: 3.h,
                                                    )
                                                  : payable.errorRemovingCheque
                                                          .value
                                                      ? InkWell(
                                                          onTap: () async {
                                                            setState(() {
                                                              isEnableScreen =
                                                                  false;
                                                            });
                                                            await _controller
                                                                .removeCheque(
                                                                    payable);
                                                            setState(() {
                                                              isEnableScreen =
                                                                  true;
                                                            });
                                                          },
                                                          child: Icon(
                                                            Icons.refresh,
                                                            size: 2.5.h,
                                                            color: Colors.red,
                                                          ))
                                                      //  RemoveCheque
                                                      : InkWell(
                                                          onTap: () async {
                                                            setState(() {
                                                              isEnableScreen =
                                                                  false;
                                                            });
                                                            await _controller
                                                                .removeCheque(
                                                                    payable);
                                                            setState(() {
                                                              isEnableScreen =
                                                                  true;
                                                            });
                                                          },
                                                          child: Image.asset(
                                                            AppImagesPath
                                                                .deleteimg,
                                                            width: 2.5.h,
                                                            height: 2.5.h,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        )
                                          ]),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                AppMetaLabels().chequeNo,
                                                style:
                                                    AppTextStyle.normalGrey10,
                                              ),
                                              Spacer(),
                                              Text(
                                                payable.chequeNo ?? "",
                                                style:
                                                    AppTextStyle.normalGrey10,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                              : payable.defaultpaymentmethodtype!.value == 2 &&
                                          !payable
                                              .updatingPaymentMethod.value &&
                                          !payable.errorUpdatingPaymentMethod ||
                                      (payable.isRejected!)
                                  ? SizedBox(
                                      child: InkWell(
                                        onTap: () {
                                          // if (payable.isRejected) {
                                          //   setState(() {
                                          //     payable.forceUploadCheque.value = false;
                                          //     payable.errorChequeNo.value = false;
                                          //   });
                                          //   print(
                                          //       'Cheque ::Before Move::1: Rejected ${payable.chequeNo}');
                                          //   print(
                                          //       'F-Path ::Before Move::1 Rejected ${payable.filePath}');
                                          //   chequeUploadPopUp(payable, index1, true);
                                          // } else {
                                          setState(() {
                                            // payable.chequeNo = '';
                                            payable.filePath = null;
                                            _controllers[index1].text = '';
                                            payable.forceUploadCheque.value =
                                                false;
                                            payable.errorChequeNo.value = false;
                                          });
                                          chequeUploadPopUp(
                                              payable, index1, false);
                                          // }
                                        },
                                        child: Column(
                                          children: [
                                            if (payable.isRejected!)
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: payable
                                                          .downloadingCheque
                                                          .value
                                                      ? LoadingIndicatorBlue(
                                                          size: 3.h,
                                                        )
                                                      : RichText(
                                                          text: TextSpan(
                                                              text:
                                                                  '${AppMetaLabels().yourCheque} ',
                                                              style: AppTextStyle
                                                                  .normalErrorText3,
                                                              children: <TextSpan>[
                                                                TextSpan(
                                                                    text: payable
                                                                        .cheque,
                                                                    style: AppTextStyle
                                                                        .normalBlue10,
                                                                    recognizer:
                                                                        TapGestureRecognizer()
                                                                          ..onTap =
                                                                              () {
                                                                            if (!payable.downloadingCheque.value)
                                                                              _controller.downloadCheque(payable);
                                                                          }),
                                                                TextSpan(
                                                                    text:
                                                                        ' ${AppMetaLabels().fileRejected}',
                                                                    style: AppTextStyle
                                                                        .normalErrorText3)
                                                              ]),
                                                        )),
                                            Container(
                                              width: Get.width * 0.78,
                                              height: Get.height * 0.05,
                                              margin:
                                                  EdgeInsets.only(bottom: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: Colors.blue,
                                                  width: 0.36.w,
                                                ),
                                              ),
                                              child: TextButton(
                                                onPressed: () {
                                                  // if (payable.isRejected) {
                                                  //   setState(() {
                                                  //     payable.chequeNo = '';
                                                  //     payable.filePath = null;
                                                  //     payable.forceUploadCheque.value =
                                                  //         false;
                                                  //     payable.errorChequeNo.value = false;
                                                  //   });
                                                  //   print(
                                                  //       'Cheque ::Before Move:: 2 Rejected ${payable.cheque}');
                                                  //   print(
                                                  //       'F-Path ::Before Move:: 2 Rejected ${payable.chequeNo}');
                                                  //   chequeUploadPopUp(
                                                  //       payable, index1, true);
                                                  // } else {
                                                  setState(() {
                                                    // payable.chequeNo = '';
                                                    payable.filePath = null;
                                                    _controllers[index1].text =
                                                        '';
                                                    payable.forceUploadCheque
                                                        .value = false;
                                                    payable.errorChequeNo
                                                        .value = false;
                                                  });
                                                  chequeUploadPopUp(
                                                      payable, index1, false);
                                                  // }
                                                },
                                                child: Text(
                                                  AppMetaLabels().uploadCheque,
                                                  style:
                                                      AppTextStyle.normalBlue10,
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : SizedBox();
                })
              : SizedBox(),

          // this is the card where cheque will upload
          // Obx(() {
          //   return payable.defaultpaymentmethodtype.value == 2 &&
          //           !payable.updatingPaymentMethod.value &&
          //           !payable.errorUpdatingPaymentMethod
          //       ? Padding(
          //           padding: EdgeInsets.only(bottom: 1.h),
          //           child: payable.uploadingCheque.value ||
          //                   payable.downloadingCheque.value
          //               ? LoadingIndicatorBlue(
          //                   size: 20,
          //                 )
          //               : payable.errorUploadingCheque
          //                   ? Center(
          //                       child: InkWell(
          //                         child: Icon(
          //                           Icons.refresh,
          //                           size: 20,
          //                           color: Colors.red,
          //                         ),
          //                         onTap: () async {
          //                           setState(() {
          //                             isEnableScreen = false;
          //                           });
          //                           await _controller.uploadCheque(
          //                             payable,
          //                           );
          //                           setState(() {
          //                             isEnableScreen = true;
          //                           });
          //                         },
          //                       ),
          //                     )
          //                   : payable.cheque != null &&
          //                           payable.cheque.isNotEmpty &&
          //                           !payable.isRejected
          //                       ? SizedBox(
          //                           width: 100.w,
          //                           child: Column(
          //                             children: [
          //                               Row(children: [
          //                                 Icon(
          //                                   Icons.photo,
          //                                   color: Colors.black38,
          //                                 ),
          //                                 SizedBox(
          //                                   width: 1.w,
          //                                 ),
          //                                 InkWell(
          //                                   child: SizedBox(
          //                                     width: 60.w,
          //                                     child: Text(
          //                                       payable.cheque,
          //                                       style: AppTextStyle.normalBlue12
          //                                           .copyWith(
          //                                               color: payable
          //                                                       .forceUploadCheque
          //                                                       .value
          //                                                   ? Colors.red
          //                                                   : AppColors
          //                                                       .blueColor),
          //                                       overflow: TextOverflow.ellipsis,
          //                                     ),
          //                                   ),
          //                                   //  downloadCheque
          //                                   onTap: () async {
          //                                     if (payable.chequeFile != null) {
          //                                       _controller.showFile(
          //                                           payable,
          //                                           payable.chequeFile,
          //                                           'cheque${payable.contractPaymentId}');
          //                                     } else {
          //                                       setState(() {
          //                                         isEnableScreen = false;
          //                                       });
          //                                       await _controller
          //                                           .downloadCheque(payable);
          //                                       setState(() {
          //                                         isEnableScreen = true;
          //                                       });
          //                                     }
          //                                   },
          //                                 ),
          //                                 Spacer(),
          //                                 if (payable.confirmed != 1)
          //                                   payable.removingCheque.value
          //                                       ? LoadingIndicatorBlue(
          //                                           size: 3.h,
          //                                         )
          //                                       : payable.errorRemovingCheque
          //                                               .value
          //                                           ? InkWell(
          //                                               onTap: () async {
          //                                                 setState(() {
          //                                                   isEnableScreen =
          //                                                       false;
          //                                                 });
          //                                                 await _controller
          //                                                     .removeCheque(
          //                                                         payable);
          //                                                 setState(() {
          //                                                   isEnableScreen =
          //                                                       true;
          //                                                 });
          //                                               },
          //                                               child: Icon(
          //                                                 Icons.refresh,
          //                                                 size: 2.5.h,
          //                                                 color: Colors.red,
          //                                               ))
          //                                           //  RemoveCheque
          //                                           : InkWell(
          //                                               onTap: () async {
          //                                                 setState(() {
          //                                                   isEnableScreen =
          //                                                       false;
          //                                                 });
          //                                                 await _controller
          //                                                     .removeCheque(
          //                                                         payable);
          //                                                 setState(() {
          //                                                   isEnableScreen =
          //                                                       true;
          //                                                 });
          //                                               },
          //                                               child: Image.asset(
          //                                                 AppImagesPath
          //                                                     .deleteimg,
          //                                                 width: 2.5.h,
          //                                                 height: 2.5.h,
          //                                                 fit: BoxFit.contain,
          //                                               ),
          //                                             )
          //                               ]),
          //                               SizedBox(
          //                                 height: 8,
          //                               ),
          //                               Row(
          //                                 children: [
          //                                   Text(
          //                                     AppMetaLabels().chequeNo,
          //                                     style: AppTextStyle.normalGrey10,
          //                                   ),
          //                                   Spacer(),
          //                                   Text(
          //                                     payable.chequeNo,
          //                                     style: AppTextStyle.normalGrey10,
          //                                   ),
          //                                 ],
          //                               )
          //                             ],
          //                           ),
          //                         )
          //                       : Column(
          //                           children: [
          //                             if (payable.isRejected)
          //                               Padding(
          //                                   padding: const EdgeInsets.all(8.0),
          //                                   child: RichText(
          //                                     text: TextSpan(
          //                                         text:
          //                                             '${AppMetaLabels().yourCheque} ',
          //                                         style: AppTextStyle
          //                                             .normalErrorText3,
          //                                         children: <TextSpan>[
          //                                           TextSpan(
          //                                               text: payable.cheque,
          //                                               style: AppTextStyle
          //                                                   .normalBlue10,
          //                                               recognizer:
          //                                                   TapGestureRecognizer()
          //                                                     ..onTap = () {
          //                                                       if (!payable
          //                                                           .downloadingCheque
          //                                                           .value)
          //                                                         _controller
          //                                                             .downloadCheque(
          //                                                                 payable);
          //                                                     }),
          //                                           TextSpan(
          //                                               text:
          //                                                   ' ${AppMetaLabels().fileRejected}',
          //                                               style: AppTextStyle
          //                                                   .normalErrorText3)
          //                                         ]),
          //                                   )),
          //                             Row(
          //                               children: [
          //                                 payable.filePath != null
          //                                     ? Container(
          //                                         width: 78.0.w,
          //                                         child: Row(
          //                                           children: [
          //                                             TextButton(
          //                                               onPressed: () {
          //                                                 OpenFile.open(
          //                                                   payable.filePath,
          //                                                 );
          //                                               },
          //                                               child: SizedBox(
          //                                                 width: 65.5.w,
          //                                                 child: Text(
          //                                                   payable.filePath
          //                                                       .split('/')
          //                                                       .last,
          //                                                   overflow:
          //                                                       TextOverflow
          //                                                           .ellipsis,
          //                                                 ),
          //                                               ),
          //                                             ),
          //                                             Spacer(),
          //                                             InkWell(
          //                                                 onTap: () {
          //                                                   print(
          //                                                       'Exactly here');
          //                                                   setState(() {
          //                                                     payable.filePath =
          //                                                         null;
          //                                                   });
          //                                                 },
          //                                                 child: Icon(
          //                                                   Icons.cancel,
          //                                                   size: 20,
          //                                                   color:
          //                                                       AppColors.grey1,
          //                                                 ))
          //                                           ],
          //                                         ),
          //                                       )
          //                                     : InkWell(
          //                                         onTap: () {
          //                                           _showPicker(
          //                                               context, payable);
          //                                         },
          //                                         child: Container(
          //                                           width: Get.width * 0.78,
          //                                           height: Get.height * 0.05,
          //                                           margin: EdgeInsets.only(
          //                                               bottom: 10),
          //                                           decoration: BoxDecoration(
          //                                             borderRadius:
          //                                                 BorderRadius.circular(
          //                                                     5),
          //                                             border: Border.all(
          //                                               color: Colors.blue,
          //                                               width: 0.36.w,
          //                                             ),
          //                                           ),
          //                                           child: TextButton(
          //                                             onPressed: () {
          //                                               _showPicker(
          //                                                   context, payable);
          //                                             },
          //                                             child: Text(
          //                                               AppMetaLabels()
          //                                                   .uploadCheque,
          //                                               style: payable
          //                                                       .forceUploadCheque
          //                                                       .value
          //                                                   ? AppTextStyle
          //                                                       .normalErrorText3
          //                                                   : AppTextStyle
          //                                                       .normalBlue10,
          //                                               maxLines: 2,
          //                                             ),
          //                                           ),
          //                                         ),
          //                                       ),
          //                               ],
          //                             ),
          //                             Row(
          //                               mainAxisAlignment:
          //                                   MainAxisAlignment.center,
          //                               crossAxisAlignment:
          //                                   CrossAxisAlignment.center,
          //                               children: [
          //                                 SizedBox(
          //                                   height: 4.h,
          //                                   child: Text(
          //                                     '${AppMetaLabels().chequeNo} *',
          //                                     style: payable.errorChequeNo.value
          //                                         ? AppTextStyle
          //                                             .normalErrorText3
          //                                         : AppTextStyle.normalGrey10,
          //                                   ),
          //                                 ),
          //                                 Spacer(),
          //                                 SizedBox(
          //                                     width: 40.w,
          //                                     height: 6.h,
          //                                     child: TextField(
          //                                       // controller: chequeController,
          //                                       controller:
          //                                           _controllers[index1],
          //                                       maxLength: 6,
          //                                       keyboardType:
          //                                           TextInputType.number,
          //                                       inputFormatters: <
          //                                           TextInputFormatter>[
          //                                         FilteringTextInputFormatter
          //                                             .digitsOnly
          //                                       ],
          //                                       decoration: InputDecoration(
          //                                           enabledBorder: OutlineInputBorder(
          //                                               borderSide: BorderSide(
          //                                                   color: payable
          //                                                           .errorChequeNo
          //                                                           .value
          //                                                       ? Colors.red
          //                                                       : AppColors
          //                                                           .grey1)),
          //                                           border:
          //                                               OutlineInputBorder()),
          //                                       onChanged: (value) {
          //                                         if (value.length == 6) {
          //                                           FocusScope.of(context)
          //                                               .unfocus();
          //                                           setState(() {});
          //                                         }
          //                                         payable.chequeNo =
          //                                             value.trim();
          //                                         setState(() {
          //                                           payable.errorChequeNo
          //                                               .value = false;
          //                                         });
          //                                       },
          //                                     ))
          //                               ],
          //                             ),
          //                             SizedBox(
          //                               height: 10,
          //                             ),
          //                             ElevatedButton(
          //                               onPressed: () async {
          //                                 if (payable.isRejected == true &&
          //                                     (_controllers[index1].text ==
          //                                             '' ||
          //                                         _controllers[index1].text ==
          //                                             null)) {
          //                                   SnakBarWidget.getSnackBarErrorBlue(
          //                                       AppMetaLabels().alert,
          //                                       AppMetaLabels()
          //                                           .pleaseEnterCompleteCardNoRejection);
          //                                   return;
          //                                 }
          //                                 payable.forceUploadCheque.value =
          //                                     false;
          //                                 payable.errorChequeNo.value = false;
          //                                 print(
          //                                     '::::chequeNo::: ${payable.chequeNo}');
          //                                 print(
          //                                     '::::chequeNo Rejected::: ${payable.isRejected}');
          //                                 print(
          //                                     '::::::: ${payable.chequeNo.length}');
          //                                 setState(() {
          //                                   isEnableScreen = false;
          //                                 });
          //                                 if (payable.filePath != null &&
          //                                     payable.chequeNo.isNotEmpty &&
          //                                     payable.chequeNo.length == 6) {
          //                                   await _controller
          //                                       .uploadCheque(payable);
          //                                   setState(() {
          //                                     isEnableScreen = true;
          //                                   });
          //                                   return;
          //                                 } else {
          //                                   if (payable.chequeNo.isEmpty ||
          //                                       payable.chequeNo.length < 6) {
          //                                     payable.errorChequeNo.value =
          //                                         true;
          //                                     if (payable.chequeNo.length < 6) {
          //                                       SnakBarWidget
          //                                           .getSnackBarErrorBlue(
          //                                         AppMetaLabels().alert,
          //                                         AppMetaLabels()
          //                                             .pleaseEnterCompleteCardNo,
          //                                       );
          //                                     }
          //                                   }
          //                                   if (payable.filePath == null) {
          //                                     payable.forceUploadCheque.value =
          //                                         true;
          //                                   }
          //                                 }
          //                                 setState(() {
          //                                   isEnableScreen = true;
          //                                 });
          //                               },
          //                               child: Text(
          //                                 ' ' +
          //                                     AppMetaLabels().attachCopy +
          //                                     ' ',
          //                                 style: AppTextStyle.semiBoldBlack11
          //                                     .copyWith(color: Colors.white),
          //                               ),
          //                               style: ButtonStyle(
          //                                   elevation: MaterialStateProperty
          //                                       .all<double>(0.0),
          //                                   backgroundColor:
          //                                       MaterialStateProperty.all<
          //                                           Color>(AppColors.blueColor),
          //                                   shape: MaterialStateProperty.all<
          //                                       RoundedRectangleBorder>(
          //                                     RoundedRectangleBorder(
          //                                       borderRadius:
          //                                           BorderRadius.circular(
          //                                               2.0.w),
          //                                     ),
          //                                   )),
          //                             ),
          //                           ],
          //                         ),
          //         )
          //       : SizedBox();
          // }),

          AppDivider(),
        ],
      ),
    );
  }

  // upload cheque
  chequeUploadPopUp(Record payable, int index1, bool isRejected) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(3.h))),
            title: Transform.scale(
              alignment: Alignment.bottomCenter,
              scale: 1,
              child: Align(
                alignment: Alignment.topRight,
                child: InkWell(
                    onTap: () {
                      // adding this
                      // recalling the whole page api because i wan to update the cheque no if uset click cross button from cheque popup  without upload the cheque even user put no and image both
                      // initFuncs();
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    },
                    child: Icon(
                      Icons.cancel,
                      size: Get.height * 0.03,
                    )),
              ),
            ),
            content: StatefulBuilder(builder: (context, setState) {
              return Obx(() {
                return payable.uploadingCheque.value ||
                        payable.downloadingCheque.value
                    ? SizedBox(
                        height: Get.height * 0.3,
                        child: LoadingIndicatorBlue(
                          size: 20,
                        ),
                      )
                    : payable.defaultpaymentmethodtype!.value == 2 &&
                            !payable.updatingPaymentMethod.value &&
                            !payable.errorUpdatingPaymentMethod
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 0.5.h),
                            child: SizedBox(
                              height: Get.height * 0.27,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text(
                                      AppMetaLabels().cheque +
                                          ' ' +
                                          AppMetaLabels().upload,
                                      style: AppTextStyle.semiBoldBlack15,
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.02,
                                    ),
                                    // Text(
                                    //   AppMetaLabels().chequeNo +
                                    //           ' ' +
                                    //           payable.chequeNo ??
                                    //       "",
                                    //   style: AppTextStyle.semiBoldBlack15,
                                    // ),
                                    // Cheque
                                    Row(
                                      children: [
                                        payable.filePath != null
                                            ? Container(
                                                width: Get.width * 0.63,
                                                child: Row(
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {
                                                        OpenFile.open(
                                                          payable.filePath,
                                                        );
                                                      },
                                                      child: SizedBox(
                                                        width: Get.width * 0.5,
                                                        child: Text(
                                                          payable.filePath!
                                                              .split('/')
                                                              .last,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 5,
                                                        ),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    InkWell(
                                                        onTap: () {
                                                          print('Exactly here');
                                                          setState(() {
                                                            payable.filePath =
                                                                null;
                                                          });
                                                          setState(() {});
                                                        },
                                                        child: Icon(
                                                          Icons.cancel,
                                                          size: 20,
                                                          color:
                                                              AppColors.grey1,
                                                        ))
                                                  ],
                                                ),
                                              )
                                            : Center(
                                                child: InkWell(
                                                  onTap: () {
                                                    _showPicker(
                                                        context, payable);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width: Get.width * 0.63,
                                                        height:
                                                            Get.height * 0.05,
                                                        margin: EdgeInsets.only(
                                                            bottom: 10),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: AppColors
                                                              .blueColor,
                                                          // border: Border.all(color: AppColors.blueColor,width: 0.3.w)
                                                        ),
                                                        child: TextButton(
                                                          onPressed: () {
                                                            _showPicker(context,
                                                                payable);
                                                          },
                                                          child: Text(
                                                            AppMetaLabels()
                                                                .attachChequeCopy,
                                                            style: payable
                                                                    .forceUploadCheque
                                                                    .value
                                                                ? AppTextStyle
                                                                    .normalErrorText3
                                                                : AppTextStyle
                                                                    .normalWhite10,
                                                            maxLines: 2,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                    // cheque no
                                    SizedBox(
                                      height: Get.height * 0.02,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 6.h,
                                          child: Text(
                                            '${AppMetaLabels().chequeNo} * ',
                                            style: payable.errorChequeNo.value
                                                ? AppTextStyle.normalErrorText3
                                                : AppTextStyle.normalGrey10,
                                          ),
                                        ),
                                        Spacer(),
                                        SizedBox(
                                            width: 33.w,
                                            height: 6.h,
                                            child: TextField(
                                              // controller: chequeController,
                                              controller: _controllers[index1],
                                              maxLength: 6,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              decoration: InputDecoration(
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: payable
                                                                  .errorChequeNo
                                                                  .value
                                                              ? Colors.red
                                                              : AppColors
                                                                  .grey1)),
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          bottom: 5)),
                                              onChanged: (value) {
                                                // adding this
                                                if (value.length == 6) {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  setState(() {});
                                                }
                                                // if (value.length == 6) {
                                                //   if (payable.chequeNo.trim() ==
                                                //       value.trim()) {
                                                //     SnakBarWidget
                                                //         .getSnackBarErrorBlue(
                                                //             AppMetaLabels()
                                                //                 .alert,
                                                //             AppMetaLabels()
                                                //                 .pleaseEnterValidChequeNO);
                                                //     _controllers[index1].text =
                                                //         '';
                                                //     return;
                                                //   }
                                                //   FocusScope.of(context)
                                                //       .unfocus();
                                                //   setState(() {});
                                                //   payable.chequeNo =
                                                //       value.trim();

                                                //   setState(() {
                                                //     payable.errorChequeNo
                                                //         .value = false;
                                                //   });
                                                // }
                                              },
                                            ))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    SizedBox(
                                      height: Get.height * 0.05,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          if (payable.isRejected == true &&
                                              (_controllers[index1].text ==
                                                      '' ||
                                                  _controllers[index1].text ==
                                                      null)) {
                                            SnakBarWidget.getSnackBarErrorBlue(
                                                AppMetaLabels().alert,
                                                AppMetaLabels()
                                                    .pleaseEnterCompleteCardNoRejection);
                                            return;
                                          }
                                          if (payable.chequeFile == null) {
                                            SnakBarWidget.getSnackBarErrorBlue(
                                                AppMetaLabels().alert,
                                                AppMetaLabels()
                                                    .pleaseAttachCheque);
                                            return;
                                          }
                                          payable.forceUploadCheque.value =
                                              false;
                                          payable.errorChequeNo.value = false;
                                          print(
                                              '::::chequeNo::: ${payable.chequeNo}');
                                          print(
                                              '::::chequeNo From Text::: ${_controllers[index1].text}');
                                          print(
                                              '::::chequeNo Rejected::: ${payable.isRejected}');
                                          print(
                                              '::::::: ${payable.chequeNo!.length}');
                                          setState(() {
                                            isEnableScreen = false;
                                          });
                                          // adding this
                                          if (payable.chequeNo!.trim() ==
                                              _controllers[index1]
                                                  .text
                                                  .trim()) {
                                            SnakBarWidget.getSnackBarErrorBlue(
                                                AppMetaLabels().alert,
                                                AppMetaLabels()
                                                    .pleaseEnterValidChequeNO);
                                            _controllers[index1].text = '';
                                            setState(() {
                                              isEnableScreen = true;
                                            });
                                            return;
                                          } else {
                                            setState(
                                              () {
                                                payable.chequeNo =
                                                    _controllers[index1]
                                                        .text
                                                        .trim();
                                              },
                                            );
                                          }
                                          //
                                          if (payable.filePath != null &&
                                              payable.chequeNo!.isNotEmpty &&
                                              payable.chequeNo!.length == 6) {
                                            await _controller
                                                .uploadCheque(payable);
                                            setState(() {
                                              isEnableScreen = true;
                                            });
                                            Navigator.of(context).pop();
                                            setState(
                                              () {},
                                            );
                                            return;
                                          } else {
                                            if (payable.chequeNo!.isEmpty ||
                                                payable.chequeNo!.length < 6) {
                                              payable.errorChequeNo.value =
                                                  true;
                                              if (payable.chequeNo!.length <
                                                  6) {
                                                SnakBarWidget
                                                    .getSnackBarErrorBlue(
                                                  AppMetaLabels().alert,
                                                  AppMetaLabels()
                                                      .pleaseEnterCompleteCardNo,
                                                );
                                              }
                                            }
                                            if (payable.filePath == null) {
                                              payable.forceUploadCheque.value =
                                                  true;
                                            }
                                          }
                                          setState(() {
                                            isEnableScreen = true;
                                          });
                                        },
                                        child: Text(
                                          '      ' +
                                              AppMetaLabels().upload +
                                              '     ',
                                          style: AppTextStyle.normalBlack10
                                              .copyWith(color: Colors.white),
                                        ),
                                        style: ButtonStyle(
                                            elevation:
                                                WidgetStateProperty.all<double>(
                                                    0.0),
                                            backgroundColor:
                                                WidgetStateProperty.all<Color>(
                                                    AppColors.blueColor),
                                            shape: WidgetStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        1.5.w),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : SizedBox();
              });
            }),
          );
        });
  }

  // before rejection case
  // chequeUploadPopUp(Record payable, int index1, bool isRejected) {
  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) {
  //         return AlertDialog(
  //           clipBehavior: Clip.antiAlias,
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(3.h))),
  //           title: Transform.scale(
  //             alignment: Alignment.bottomCenter,
  //             scale: 1,
  //             child: Align(
  //               alignment: Alignment.topRight,
  //               child: InkWell(
  //                   onTap: () {
  //                     // recalling the whole page api because i wan to update the cheque no if uset click cross button from cheque popup  without upload the cheque even user put no and image both
  //                     initFuncs();
  //                     Navigator.of(context, rootNavigator: true).pop('dialog');
  //                   },
  //                   child: Icon(
  //                     Icons.cancel,
  //                     size: Get.height * 0.03,
  //                   )),
  //             ),
  //           ),
  //           content: StatefulBuilder(builder: (context, setState) {
  //             return Obx(() {
  //               return payable.uploadingCheque.value ||
  //                       payable.downloadingCheque.value
  //                   ? SizedBox(
  //                       height: Get.height * 0.3,
  //                       child: LoadingIndicatorBlue(
  //                         size: 20,
  //                       ),
  //                     )
  //                   : payable.defaultpaymentmethodtype.value == 2 &&
  //                           !payable.updatingPaymentMethod.value &&
  //                           !payable.errorUpdatingPaymentMethod
  //                       ? Padding(
  //                           padding: EdgeInsets.only(bottom: 0.5.h),
  //                           child: SizedBox(
  //                             height: Get.height * 0.25,
  //                             child: SingleChildScrollView(
  //                               child: Column(
  //                                 children: [
  //                                   Text(
  //                                     AppMetaLabels().cheque +
  //                                         ' ' +
  //                                         AppMetaLabels().upload,
  //                                     style: AppTextStyle.semiBoldBlack15,
  //                                   ),
  //                                   SizedBox(
  //                                     height: Get.height * 0.02,
  //                                   ),
  //                                   Text(
  //                                     AppMetaLabels().chequeNo +
  //                                         ' ' +
  //                                         payable.chequeNo,
  //                                     style: AppTextStyle.semiBoldBlack15,
  //                                   ),
  //                                   // Cheque
  //                                   Row(
  //                                     children: [
  //                                       payable.filePath != null
  //                                           ? Container(
  //                                               width: Get.width * 0.7,
  //                                               child: Row(
  //                                                 children: [
  //                                                   TextButton(
  //                                                     onPressed: () {
  //                                                       OpenFile.open(
  //                                                         payable.filePath,
  //                                                       );
  //                                                     },
  //                                                     child: SizedBox(
  //                                                       width: Get.width * 0.6,
  //                                                       child: Text(
  //                                                         payable.filePath
  //                                                             .split('/')
  //                                                             .last,
  //                                                         overflow: TextOverflow
  //                                                             .ellipsis,
  //                                                         maxLines: 5,
  //                                                       ),
  //                                                     ),
  //                                                   ),
  //                                                   Spacer(),
  //                                                   InkWell(
  //                                                       onTap: () {
  //                                                         print('Exactly here');
  //                                                         setState(() {
  //                                                           payable.filePath =
  //                                                               null;
  //                                                         });
  //                                                         setState(() {});
  //                                                       },
  //                                                       child: Icon(
  //                                                         Icons.cancel,
  //                                                         size: 20,
  //                                                         color:
  //                                                             AppColors.grey1,
  //                                                       ))
  //                                                 ],
  //                                               ),
  //                                             )
  //                                           : Center(
  //                                               child: InkWell(
  //                                                 onTap: () {
  //                                                   _showPicker(
  //                                                       context, payable);
  //                                                 },
  //                                                 child: Row(
  //                                                   mainAxisAlignment:
  //                                                       MainAxisAlignment
  //                                                           .center,
  //                                                   crossAxisAlignment:
  //                                                       CrossAxisAlignment
  //                                                           .center,
  //                                                   children: [
  //                                                     Container(
  //                                                       width: Get.width * 0.7,
  //                                                       height:
  //                                                           Get.height * 0.05,
  //                                                       margin: EdgeInsets.only(
  //                                                           bottom: 10),
  //                                                       decoration:
  //                                                           BoxDecoration(
  //                                                         borderRadius:
  //                                                             BorderRadius
  //                                                                 .circular(10),
  //                                                         color: AppColors
  //                                                             .blueColor,
  //                                                         // border: Border.all(color: AppColors.blueColor,width: 0.3.w)
  //                                                       ),
  //                                                       child: TextButton(
  //                                                         onPressed: () {
  //                                                           _showPicker(context,
  //                                                               payable);
  //                                                         },
  //                                                         child: Text(
  //                                                           AppMetaLabels()
  //                                                               .attachChequeCopy,
  //                                                           style: payable
  //                                                                   .forceUploadCheque
  //                                                                   .value
  //                                                               ? AppTextStyle
  //                                                                   .normalErrorText3
  //                                                               : AppTextStyle
  //                                                                   .normalWhite10,
  //                                                           maxLines: 2,
  //                                                         ),
  //                                                       ),
  //                                                     ),
  //                                                   ],
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                     ],
  //                                   ),
  //                                   // cheque no
  //                                   SizedBox(
  //                                     height: Get.height * 0.02,
  //                                   ),
  //                                   Row(
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.center,
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.center,
  //                                     children: [
  //                                       SizedBox(
  //                                         height: 4.h,
  //                                         child: Text(
  //                                           '${AppMetaLabels().chequeNo} * ',
  //                                           style: payable.errorChequeNo.value
  //                                               ? AppTextStyle.normalErrorText3
  //                                               : AppTextStyle.normalGrey10,
  //                                         ),
  //                                       ),
  //                                       Spacer(),
  //                                       SizedBox(
  //                                           width: 40.w,
  //                                           height: 6.h,
  //                                           child: TextField(
  //                                             // controller: chequeController,
  //                                             controller: _controllers[index1],
  //                                             maxLength: 6,
  //                                             keyboardType:
  //                                                 TextInputType.number,
  //                                             inputFormatters: <
  //                                                 TextInputFormatter>[
  //                                               FilteringTextInputFormatter
  //                                                   .digitsOnly
  //                                             ],
  //                                             decoration: InputDecoration(
  //                                                 enabledBorder: OutlineInputBorder(
  //                                                     borderSide: BorderSide(
  //                                                         color: payable
  //                                                                 .errorChequeNo
  //                                                                 .value
  //                                                             ? Colors.red
  //                                                             : AppColors
  //                                                                 .grey1)),
  //                                                 border: OutlineInputBorder()),
  //                                             onChanged: (value) {
  //                                               if (value.length == 6) {
  //                                                 if (payable.chequeNo.trim() ==
  //                                                     value.trim()) {
  //                                                   SnakBarWidget
  //                                                       .getSnackBarErrorBlue(
  //                                                           AppMetaLabels()
  //                                                               .alert,
  //                                                           AppMetaLabels()
  //                                                               .pleaseEnterValidChequeNO);
  //                                                   _controllers[index1].text =
  //                                                       '';
  //                                                   return;
  //                                                 }
  //                                                 FocusScope.of(context)
  //                                                     .unfocus();
  //                                                 setState(() {});
  //                                                 payable.chequeNo =
  //                                                     value.trim();

  //                                                 setState(() {
  //                                                   payable.errorChequeNo
  //                                                       .value = false;
  //                                                 });
  //                                               }
  //                                             },
  //                                           ))
  //                                     ],
  //                                   ),
  //                                   SizedBox(
  //                                     height: 10,
  //                                   ),

  //                                   SizedBox(
  //                                     height: Get.height * 0.05,
  //                                     child: ElevatedButton(
  //                                       onPressed: () async {
  //                                         if (payable.isRejected == true &&
  //                                             (_controllers[index1].text ==
  //                                                     '' ||
  //                                                 _controllers[index1].text ==
  //                                                     null)) {
  //                                           SnakBarWidget.getSnackBarErrorBlue(
  //                                               AppMetaLabels().alert,
  //                                               AppMetaLabels()
  //                                                   .pleaseEnterCompleteCardNoRejection);
  //                                           return;
  //                                         }
  //                                         if (payable.chequeFile == null) {
  //                                           SnakBarWidget.getSnackBarErrorBlue(
  //                                               AppMetaLabels().alert,
  //                                               AppMetaLabels()
  //                                                   .pleaseAttachCheque);
  //                                           return;
  //                                         }
  //                                         payable.forceUploadCheque.value =
  //                                             false;
  //                                         payable.errorChequeNo.value = false;
  //                                         print(
  //                                             '::::chequeNo::: ${payable.chequeNo}');
  //                                         print(
  //                                             '::::chequeNo Rejected::: ${payable.isRejected}');
  //                                         print(
  //                                             '::::::: ${payable.chequeNo.length}');
  //                                         setState(() {
  //                                           isEnableScreen = false;
  //                                         });
  //                                         if (payable.filePath != null &&
  //                                             payable.chequeNo.isNotEmpty &&
  //                                             payable.chequeNo.length == 6) {
  //                                           await _controller
  //                                               .uploadCheque(payable);
  //                                           setState(() {
  //                                             isEnableScreen = true;
  //                                           });
  //                                           Navigator.of(context).pop();
  //                                           setState(
  //                                             () {},
  //                                           );
  //                                           return;
  //                                         } else {
  //                                           if (payable.chequeNo.isEmpty ||
  //                                               payable.chequeNo.length < 6) {
  //                                             payable.errorChequeNo.value =
  //                                                 true;
  //                                             if (payable.chequeNo.length < 6) {
  //                                               SnakBarWidget
  //                                                   .getSnackBarErrorBlue(
  //                                                 AppMetaLabels().alert,
  //                                                 AppMetaLabels()
  //                                                     .pleaseEnterCompleteCardNo,
  //                                               );
  //                                             }
  //                                           }
  //                                           if (payable.filePath == null) {
  //                                             payable.forceUploadCheque.value =
  //                                                 true;
  //                                           }
  //                                         }
  //                                         setState(() {
  //                                           isEnableScreen = true;
  //                                         });
  //                                       },
  //                                       child: Text(
  //                                         '      ' +
  //                                             AppMetaLabels().upload +
  //                                             '     ',
  //                                         style: AppTextStyle.normalBlack10
  //                                             .copyWith(color: Colors.white),
  //                                       ),
  //                                       style: ButtonStyle(
  //                                           elevation: MaterialStateProperty
  //                                               .all<double>(0.0),
  //                                           backgroundColor:
  //                                               MaterialStateProperty.all<
  //                                                   Color>(AppColors.blueColor),
  //                                           shape: MaterialStateProperty.all<
  //                                               RoundedRectangleBorder>(
  //                                             RoundedRectangleBorder(
  //                                               borderRadius:
  //                                                   BorderRadius.circular(
  //                                                       1.5.w),
  //                                             ),
  //                                           )),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         )
  //                       : SizedBox();
  //             });
  //           }),
  //         );
  //       });
  // }

  // chequeUpload(Record payable, int index1) {
  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) {
  //         return AlertDialog(
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(3.h))),
  //           title: Transform.scale(
  //             alignment: Alignment.bottomCenter,
  //             scale: 1,
  //             child: Align(
  //               alignment: Alignment.topRight,
  //               child: InkWell(
  //                   onTap: () {
  //                     Navigator.of(context, rootNavigator: true).pop('dialog');
  //                   },
  //                   child: Icon(
  //                     Icons.cancel,
  //                     size: Get.height * 0.03,
  //                   )),
  //             ),
  //           ),
  //           content: StatefulBuilder(builder: (context, setState) {
  //             return Obx(() {
  //               return payable.defaultpaymentmethodtype.value == 2 &&
  //                       !payable.updatingPaymentMethod.value &&
  //                       !payable.errorUpdatingPaymentMethod
  //                   ? Padding(
  //                       padding: EdgeInsets.only(bottom: 1.h),
  //                       child: payable.uploadingCheque.value ||
  //                               payable.downloadingCheque.value
  //                           ? LoadingIndicatorBlue(
  //                               size: 20,
  //                             )
  //                           : payable.errorUploadingCheque
  //                               ? InkWell(
  //                                   child: Icon(
  //                                     Icons.refresh,
  //                                     size: 20,
  //                                     color: Colors.red,
  //                                   ),
  //                                   onTap: () async {
  //                                     setState(() {
  //                                       isEnableScreen = false;
  //                                     });
  //                                     await _controller.uploadCheque(
  //                                       payable,
  //                                     );
  //                                     setState(() {
  //                                       isEnableScreen = true;
  //                                     });
  //                                   },
  //                                 )
  //                               : payable.cheque != null &&
  //                                       payable.cheque.isNotEmpty &&
  //                                       !payable.isRejected
  //                                   ? SizedBox(
  //                                       width: 100.w,
  //                                       child: Column(
  //                                         children: [
  //                                           Row(children: [
  //                                             Icon(
  //                                               Icons.photo,
  //                                               color: Colors.black38,
  //                                             ),
  //                                             SizedBox(
  //                                               width: 1.w,
  //                                             ),
  //                                             InkWell(
  //                                               child: SizedBox(
  //                                                 width: 60.w,
  //                                                 child: Text(
  //                                                   payable.cheque,
  //                                                   style: AppTextStyle
  //                                                       .normalBlue12
  //                                                       .copyWith(
  //                                                           color: payable
  //                                                                   .forceUploadCheque
  //                                                                   .value
  //                                                               ? Colors.red
  //                                                               : AppColors
  //                                                                   .blueColor),
  //                                                   overflow:
  //                                                       TextOverflow.ellipsis,
  //                                                 ),
  //                                               ),
  //                                               //  downloadCheque
  //                                               onTap: () async {
  //                                                 if (payable.chequeFile !=
  //                                                     null) {
  //                                                   _controller.showFile(
  //                                                       payable,
  //                                                       payable.chequeFile,
  //                                                       'cheque${payable.contractPaymentId}');
  //                                                 } else {
  //                                                   setState(() {
  //                                                     isEnableScreen = false;
  //                                                   });
  //                                                   await _controller
  //                                                       .downloadCheque(
  //                                                           payable);
  //                                                   setState(() {
  //                                                     isEnableScreen = true;
  //                                                   });
  //                                                 }
  //                                               },
  //                                             ),
  //                                             Spacer(),
  //                                             if (payable.confirmed != 1)
  //                                               payable.removingCheque.value
  //                                                   ? LoadingIndicatorBlue(
  //                                                       size: 3.h,
  //                                                     )
  //                                                   : payable
  //                                                           .errorRemovingCheque
  //                                                           .value
  //                                                       ? InkWell(
  //                                                           onTap: () async {
  //                                                             setState(() {
  //                                                               isEnableScreen =
  //                                                                   false;
  //                                                             });
  //                                                             await _controller
  //                                                                 .removeCheque(
  //                                                                     payable);
  //                                                             setState(() {
  //                                                               isEnableScreen =
  //                                                                   true;
  //                                                             });
  //                                                           },
  //                                                           child: Icon(
  //                                                             Icons.refresh,
  //                                                             size: 2.5.h,
  //                                                             color: Colors.red,
  //                                                           ))
  //                                                       //  RemoveCheque
  //                                                       : InkWell(
  //                                                           onTap: () async {
  //                                                             setState(() {
  //                                                               isEnableScreen =
  //                                                                   false;
  //                                                             });
  //                                                             await _controller
  //                                                                 .removeCheque(
  //                                                                     payable);
  //                                                             setState(() {
  //                                                               isEnableScreen =
  //                                                                   true;
  //                                                             });
  //                                                           },
  //                                                           child: Image.asset(
  //                                                             AppImagesPath
  //                                                                 .deleteimg,
  //                                                             width: 2.5.h,
  //                                                             height: 2.5.h,
  //                                                             fit: BoxFit
  //                                                                 .contain,
  //                                                           ),
  //                                                         )
  //                                           ]),
  //                                           SizedBox(
  //                                             height: 8,
  //                                           ),
  //                                           Row(
  //                                             children: [
  //                                               Text(
  //                                                 AppMetaLabels().chequeNo,
  //                                                 style:
  //                                                     AppTextStyle.normalGrey10,
  //                                               ),
  //                                               Spacer(),
  //                                               Text(
  //                                                 payable.chequeNo,
  //                                                 style:
  //                                                     AppTextStyle.normalGrey10,
  //                                               ),
  //                                             ],
  //                                           )
  //                                         ],
  //                                       ),
  //                                     )
  //                                   :
  //                                   Column(
  //                                       children: [
  //                                         if (payable.isRejected)
  //                                           Padding(
  //                                               padding:
  //                                                   const EdgeInsets.all(8.0),
  //                                               child: RichText(
  //                                                 text: TextSpan(
  //                                                     text:
  //                                                         '${AppMetaLabels().yourCheque} ',
  //                                                     style: AppTextStyle
  //                                                         .normalErrorText3,
  //                                                     children: <TextSpan>[
  //                                                       TextSpan(
  //                                                           text:
  //                                                               payable.cheque,
  //                                                           style: AppTextStyle
  //                                                               .normalBlue10,
  //                                                           recognizer:
  //                                                               TapGestureRecognizer()
  //                                                                 ..onTap = () {
  //                                                                   if (!payable
  //                                                                       .downloadingCheque
  //                                                                       .value)
  //                                                                     _controller
  //                                                                         .downloadCheque(
  //                                                                             payable);
  //                                                                 }),
  //                                                       TextSpan(
  //                                                           text:
  //                                                               ' ${AppMetaLabels().fileRejected}',
  //                                                           style: AppTextStyle
  //                                                               .normalErrorText3)
  //                                                     ]),
  //                                               )),
  //                                        // Cheque
  //                                         Row(
  //                                           children: [
  //                                             payable.filePath != null
  //                                                 ? Container(
  //                                                     width: Get.width * 0.7,
  //                                                     child: Row(
  //                                                       children: [
  //                                                         TextButton(
  //                                                           onPressed: () {
  //                                                             OpenFile.open(
  //                                                               payable
  //                                                                   .filePath,
  //                                                             );
  //                                                           },
  //                                                           child: SizedBox(
  //                                                             width: Get.width *
  //                                                                 0.6,
  //                                                             child: Text(
  //                                                               payable.filePath
  //                                                                   .split('/')
  //                                                                   .last,
  //                                                               overflow:
  //                                                                   TextOverflow
  //                                                                       .ellipsis,
  //                                                               maxLines: 5,
  //                                                             ),
  //                                                           ),
  //                                                         ),
  //                                                         Spacer(),
  //                                                         InkWell(
  //                                                             onTap: () {
  //                                                               print(
  //                                                                   'Exactly here');
  //                                                               setState(() {
  //                                                                 payable.filePath =
  //                                                                     null;
  //                                                               });
  //                                                               setState(() {});
  //                                                             },
  //                                                             child: Icon(
  //                                                               Icons.cancel,
  //                                                               size: 20,
  //                                                               color: AppColors
  //                                                                   .grey1,
  //                                                             ))
  //                                                       ],
  //                                                     ),
  //                                                   )
  //                                                 : Center(
  //                                                     child: InkWell(
  //                                                       onTap: () {
  //                                                         _showPicker(
  //                                                             context, payable);
  //                                                       },
  //                                                       child: Row(
  //                                                         mainAxisAlignment:
  //                                                             MainAxisAlignment
  //                                                                 .center,
  //                                                         crossAxisAlignment:
  //                                                             CrossAxisAlignment
  //                                                                 .center,
  //                                                         children: [
  //                                                           Container(
  //                                                             width: Get.width *
  //                                                                 0.7,
  //                                                             height:
  //                                                                 Get.height *
  //                                                                     0.05,
  //                                                             margin: EdgeInsets
  //                                                                 .only(
  //                                                                     bottom:
  //                                                                         10),
  //                                                             decoration:
  //                                                                 BoxDecoration(
  //                                                               borderRadius:
  //                                                                   BorderRadius
  //                                                                       .circular(
  //                                                                           5),
  //                                                               border:
  //                                                                   Border.all(
  //                                                                 color: Colors
  //                                                                     .blue,
  //                                                                 width: 0.36.w,
  //                                                               ),
  //                                                             ),
  //                                                             child: TextButton(
  //                                                               onPressed: () {
  //                                                                 _showPicker(
  //                                                                     context,
  //                                                                     payable);
  //                                                               },
  //                                                               child: Text(
  //                                                                 AppMetaLabels()
  //                                                                     .upload,
  //                                                                 style: payable
  //                                                                         .forceUploadCheque
  //                                                                         .value
  //                                                                     ? AppTextStyle
  //                                                                         .normalErrorText3
  //                                                                     : AppTextStyle
  //                                                                         .normalBlue10,
  //                                                                 maxLines: 2,
  //                                                               ),
  //                                                             ),
  //                                                           ),
  //                                                         ],
  //                                                       ),
  //                                                     ),
  //                                                   ),
  //                                           ],
  //                                         ),
  //                                         // cheque no
  //                                         Row(
  //                                           mainAxisAlignment:
  //                                               MainAxisAlignment.center,
  //                                           crossAxisAlignment:
  //                                               CrossAxisAlignment.center,
  //                                           children: [
  //                                             SizedBox(
  //                                               height: 4.h,
  //                                               child: Text(
  //                                                 '${AppMetaLabels().chequeNo} * ',
  //                                                 style: payable
  //                                                         .errorChequeNo.value
  //                                                     ? AppTextStyle
  //                                                         .normalErrorText3
  //                                                     : AppTextStyle
  //                                                         .normalGrey10,
  //                                               ),
  //                                             ),
  //                                             Spacer(),
  //                                             SizedBox(
  //                                                 width: 40.w,
  //                                                 height: 6.h,
  //                                                 child: TextField(
  //                                                   // controller: chequeController,
  //                                                   controller:
  //                                                       _controllers[index1],
  //                                                   maxLength: 6,
  //                                                   keyboardType:
  //                                                       TextInputType.number,
  //                                                   inputFormatters: <
  //                                                       TextInputFormatter>[
  //                                                     FilteringTextInputFormatter
  //                                                         .digitsOnly
  //                                                   ],
  //                                                   decoration: InputDecoration(
  //                                                       enabledBorder: OutlineInputBorder(
  //                                                           borderSide: BorderSide(
  //                                                               color: payable
  //                                                                       .errorChequeNo
  //                                                                       .value
  //                                                                   ? Colors.red
  //                                                                   : AppColors
  //                                                                       .grey1)),
  //                                                       border:
  //                                                           OutlineInputBorder()),
  //                                                   onChanged: (value) {
  //                                                     if (value.length == 6) {
  //                                                       FocusScope.of(context)
  //                                                           .unfocus();
  //                                                       setState(() {});
  //                                                     }
  //                                                     payable.chequeNo =
  //                                                         value.trim();
  //                                                     setState(() {
  //                                                       payable.errorChequeNo
  //                                                           .value = false;
  //                                                     });
  //                                                   },
  //                                                 ))
  //                                           ],
  //                                         ),
  //                                         SizedBox(
  //                                           height: 10,
  //                                         ),
  //                                         ElevatedButton(
  //                                           onPressed: () async {
  //                                             if (payable.isRejected == true &&
  //                                                 (_controllers[index1].text ==
  //                                                         '' ||
  //                                                     _controllers[index1]
  //                                                             .text ==
  //                                                         null)) {
  //                                               SnakBarWidget.getSnackBarErrorBlue(
  //                                                   AppMetaLabels().alert,
  //                                                   AppMetaLabels()
  //                                                       .pleaseEnterCompleteCardNoRejection);
  //                                               return;
  //                                             }
  //                                             payable.forceUploadCheque.value =
  //                                                 false;
  //                                             payable.errorChequeNo.value =
  //                                                 false;
  //                                             print(
  //                                                 '::::chequeNo::: ${payable.chequeNo}');
  //                                             print(
  //                                                 '::::chequeNo Rejected::: ${payable.isRejected}');
  //                                             print(
  //                                                 '::::::: ${payable.chequeNo.length}');
  //                                             setState(() {
  //                                               isEnableScreen = false;
  //                                             });
  //                                             if (payable.filePath != null &&
  //                                                 payable.chequeNo.isNotEmpty &&
  //                                                 payable.chequeNo.length ==
  //                                                     6) {
  //                                               await _controller
  //                                                   .uploadCheque(payable);
  //                                               setState(() {
  //                                                 isEnableScreen = true;
  //                                               });
  //                                               return;
  //                                             } else {
  //                                               if (payable.chequeNo.isEmpty ||
  //                                                   payable.chequeNo.length <
  //                                                       6) {
  //                                                 payable.errorChequeNo.value =
  //                                                     true;
  //                                                 if (payable.chequeNo.length <
  //                                                     6) {
  //                                                   SnakBarWidget
  //                                                       .getSnackBarErrorBlue(
  //                                                     AppMetaLabels().alert,
  //                                                     AppMetaLabels()
  //                                                         .pleaseEnterCompleteCardNo,
  //                                                   );
  //                                                 }
  //                                               }
  //                                               if (payable.filePath == null) {
  //                                                 payable.forceUploadCheque
  //                                                     .value = true;
  //                                               }
  //                                             }
  //                                             setState(() {
  //                                               isEnableScreen = true;
  //                                             });
  //                                           },
  //                                           child: Text(
  //                                             ' ' +
  //                                                 AppMetaLabels().attachCopy +
  //                                                 ' ',
  //                                             style: AppTextStyle
  //                                                 .semiBoldBlack11
  //                                                 .copyWith(
  //                                                     color: Colors.white),
  //                                           ),
  //                                           style: ButtonStyle(
  //                                               elevation: MaterialStateProperty
  //                                                   .all<double>(0.0),
  //                                               backgroundColor:
  //                                                   MaterialStateProperty.all<
  //                                                           Color>(
  //                                                       AppColors.blueColor),
  //                                               shape:
  //                                                   MaterialStateProperty.all<
  //                                                       RoundedRectangleBorder>(
  //                                                 RoundedRectangleBorder(
  //                                                   borderRadius:
  //                                                       BorderRadius.circular(
  //                                                           2.0.w),
  //                                                 ),
  //                                               )),
  //                                         ),
  //                                       ],
  //                                     ),
  //                     )
  //                   : SizedBox();
  //             });
  //           }),
  //         );
  //       });
  // }

  void _showPicker(context, Record payable) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Directionality(
              textDirection: SessionController().getLanguage() == 1
                  ? ui.TextDirection.ltr
                  : ui.TextDirection.rtl,
              child: Container(
                color: Colors.white,
                child: new Wrap(
                  children: <Widget>[
                    new ListTile(
                        leading: new Icon(Icons.photo_library),
                        title: new Text(AppMetaLabels().photoLibrary),
                        onTap: () async {
                          await _controller.pickDoc(payable);
                          Navigator.of(context).pop();
                        }),
                    new ListTile(
                      leading: new Icon(Icons.photo_camera),
                      title: new Text(AppMetaLabels().camera),
                      onTap: () async {
                        await _controller.takePhoto(payable);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _showConfirmation(context) {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              height: 22.h,
              child: Column(
                children: [
                  SizedBox(
                    height: Get.width * 0.05,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        AppMetaLabels().paymentConfirmation,
                        maxLines: null,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.semiBoldBlack11,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.width * 0.03,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      SizedBox(
                        width: Get.width * 0.3, // <-- match_parent
                        height: Get.height * 0.05,
                        child: ElevatedButton(
                          onPressed: () {
                            print('object');
                            setState(() {
                              isEnableScreen = true;
                            });
                            print(_controller.pickupDeliveryText.value);
                            if (_controller.isEnableCancelButton.value) {
                              Navigator.of(context).pop();
                              return;
                            }
                          },
                          child: Text(
                            AppMetaLabels().cancel,
                            style: AppTextStyle.semiBoldBlue11
                                .copyWith(color: Colors.blue),
                          ),
                          style: ButtonStyle(
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(2.0.w),
                                        side: BorderSide(color: Colors.blue))),
                            backgroundColor:
                                WidgetStateProperty.all<Color>(Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.1,
                      ),
                      Obx(() {
                        return _controller.updatingAddress.value
                            ? SizedBox(
                                width: Get.width * 0.3, // <-- match_parent
                                height: Get.height * 0.05,
                                child: LoadingIndicatorBlue())
                            : SizedBox(
                                width: Get.width * 0.3, // <-- match_parent
                                height: Get.height * 0.05,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    _controller.isEnableCancelButton.value =
                                        false;
                                    int index =
                                        _controller.areAllChequesUploaded();
                                    if (index > -1) {
                                      _controller
                                          .outstandingPayments
                                          .record![index]
                                          .forceUploadCheque
                                          .value = true;
                                      if (scrollController.isAttached)
                                        scrollController.scrollTo(
                                            index: index,
                                            duration: Duration(seconds: 1));
                                    } else {
                                      bool proceed = true;

                                      if (_controller
                                              .chequeDeliveryOption.value ==
                                          1) {
                                        print('***************** 1');
                                        proceed = await _controller
                                            .updateDeliveryAddress(
                                                _controller
                                                    .pickupDeliveryText.value,
                                                widget.contractId ?? 0,
                                                widget.contractNo ?? "");
                                        print(
                                            'proceed ***************** $proceed');
                                      } else if (_controller
                                              .chequeDeliveryOption.value ==
                                          2) {
                                        print('***************** 2');
                                        proceed = await _controller
                                            .updateDeliveryAddress(
                                                _controller
                                                    .pickupDeliveryText.value,
                                                widget.contractId ?? 0,
                                                widget.contractNo ?? '');
                                        print(
                                            'proceed ***************** $proceed');
                                      }
                                      print(
                                          'proceed After Condition ***************** $proceed');
                                      if (proceed == true) {
                                        print(
                                            'gotoOnlinePayments After Condition ***************** ${_controller.gotoOnlinePayments.value}');
                                        if (_controller
                                            .gotoOnlinePayments.value) {
                                          await Get.off(() => OnlinePayments(
                                              contractNo: widget.contractNo));
                                        } else {
                                          _controller.isShowpopUp.value = true;
                                        }
                                      }
                                    }
                                    Navigator.of(context).pop();
                                    _controller.isEnableCancelButton.value =
                                        true;
                                  },
                                  child: Text(
                                    AppMetaLabels().confirm,
                                    style: AppTextStyle.semiBoldBlack11
                                        .copyWith(color: Colors.white),
                                  ),
                                  style: ButtonStyle(
                                      elevation:
                                          WidgetStateProperty.all<double>(0.0),
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                              AppColors.blueColor),
                                      shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(2.0.w),
                                        ),
                                      )),
                                ),
                              );
                      }),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  void show() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            content: showDialogData(),
          );
        });
  }

  Widget showDialogData() {
    return Container(
        padding: EdgeInsets.all(3.0.w),
        // height: 45.0.h,
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
                height: 3.0.h,
              ),
              Text(
                AppMetaLabels().stage5_12,
                textAlign: TextAlign.center,
                style: AppTextStyle.semiBoldBlack13,
              ),
              SizedBox(
                height: 3.0.h,
              ),
              Padding(
                padding: EdgeInsets.only(top: 0.0.h, bottom: 3.0.h),
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 4.0.h,
                    width: 65.0.w,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: WidgetStateProperty.all<double>(0.0.h),
                          backgroundColor: WidgetStateProperty.all<Color>(
                              AppColors.whiteColor),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0.w),
                                side: BorderSide(
                                  color: AppColors.blueColor,
                                  width: 1.0,
                                )),
                          )),
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        AppMetaLabels().ok,
                        style: AppTextStyle.semiBoldWhite11
                            .copyWith(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              ),
            ]));
  }

  // show how to upload cheque
  chequeSample() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(3.h))),
            title: Transform.scale(
              alignment: Alignment.bottomCenter,
              scale: 1,
              child: Align(
                alignment: Alignment.topRight,
                child: InkWell(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    },
                    child: Icon(
                      Icons.cancel,
                      size: Get.height * 0.03,
                    )),
              ),
            ),
            content: Container(
              height: Get.height * 0.35,
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
                shape: BoxShape.rectangle,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(AppMetaLabels().attachChequeCopy,
                        style: AppTextStyle.semiBoldBlack14),
                    SizedBox(
                      height: Get.height * 0.005,
                    ),
                    SizedBox(
                      child: Center(
                        child: Text(
                          AppMetaLabels().pleaseFillTheCheque,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.normalBlack12,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
                    InkWell(
                      onTap: () {
                        chequeSample1();
                      },
                      child: SizedBox(
                        height: Get.height * 0.15,
                        width: double.infinity,
                        child: Image.asset(
                          'assets/images/common_images/pdf.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  chequeSample1() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(3.h))),
            content: Container(
              height: Get.height * 0.42,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(3.h)),
                        shape: BoxShape.rectangle,
                      ),
                      child: PhotoView(
                        filterQuality: FilterQuality.high,
                        imageProvider:
                            AssetImage('assets/images/common_images/pdf.png'),
                        backgroundDecoration:
                            BoxDecoration(color: Colors.transparent),
                        gaplessPlayback: true,
                        customSize: Get.size * 0.5,
                        enableRotation: false,
                        minScale: PhotoViewComputedScale.contained * 1.8,
                        maxScale: PhotoViewComputedScale.covered * 1.8,
                        initialScale: PhotoViewComputedScale.contained * 1.1,
                        basePosition: Alignment.center,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');
                        },
                        child: Icon(Icons.cancel)),
                  )
                ],
              ),
            ),
          );
        });
  }
}

// Before add the pop up for cheques upload 20 Feb 2024
// import 'package:fap_properties/utils/constants/assets_path.dart';
// import 'package:fap_properties/utils/constants/meta_labels.dart';
// import 'package:fap_properties/utils/screen_disable.dart';
// import 'package:fap_properties/utils/styles/colors.dart';
// import 'package:fap_properties/utils/styles/text_styles.dart';
// import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_tabs.dart/tenant_contracts_details.dart/tenant_contract_details.dart';
// import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
// import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
// import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
// import 'package:fap_properties/views/widgets/snackbar_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:open_file/open_file.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
// import 'package:sizer/sizer.dart';
// import '../../../../../data/helpers/session_controller.dart';
// import '../../../../../data/models/tenant_models/contract_payable/outstanding_payments_model.dart';
// import '../online_payments/online_payments.dart';
// import 'outstanding_payments_controller.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/services.dart';
// import 'dart:ui' as ui;

// class OutstandingPayments extends StatefulWidget {
//   final String contractNo;
//   final int contractId;
//   const OutstandingPayments({Key key, this.contractNo, this.contractId})
//       : super(key: key);

//   @override
//   _OutstandingPaymentsState createState() => _OutstandingPaymentsState();
// }

// class _OutstandingPaymentsState extends State<OutstandingPayments> {
//   var _controller = Get.put(OutstandingPaymentsController());

// // chequeController is just to clear the field when cancel the selected copy of cheque
//   // TextEditingController chequeController = TextEditingController();
//   bool value = false;
//   // final formKey = GlobalKey<FormState>();
//   final ItemScrollController scrollController = ItemScrollController();
//   bool isEnableScreen = true;
//   String typeofPayment = '';

//   List<TextEditingController> _controllers = [];
//   @override
//   void initState() {
//     initFuncs();

//     super.initState();
//   }

//   initFuncs() {
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       _controller.errorPickupDelivery.value = '';
//       await _controller.getOutstandingPayments();
//       // after completeion of above func we will decide weather we have to show
//       // cheque sample or not
//       // for (int i = 0; i < _controller.paymentsToShow.length; i++) {
//       //   if (_controller.paymentsToShow[i] is String) {
//       //     print(_controller.paymentsToShow[i]);
//       //   } else {
//       //     if (_controller.paymentsToShow[i].defaultpaymentmethodtype.value ==
//       //         2) {
//       //       _controller.isChequeSampleShow.value = true;
//       //     }
//       //   }
//       // }
//       if (_controller.errorLoadingOutstandingPayments.value == '') {
//         // print('isChequeSampleShow :: ${_controller.isChequeSampleShow.value}');
//         print(
//             'record.first.confirmed :: ${_controller.outstandingPayments.record.first.confirmed}');
//         print(
//             'errorLoadingOutstandingPayments :: ${_controller.errorLoadingOutstandingPayments.value}');
//         // print(
//         // 'Condition : ${(_controller.outstandingPayments.record.first.confirmed != 0 && _controller.errorLoadingOutstandingPayments.value == '' && _controller.isChequeSampleShow.value == true)}');

//         if (_controller.outstandingPayments.record.first.confirmed != 1 &&
//                 _controller.errorLoadingOutstandingPayments.value == ''
//             // && _controller.isChequeSampleShow.value == true
//             ) {
//           chequeSample();
//           return;
//         }
//       }
//     });
//   }

//   //  Cheque Upload and Download while payment
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         setState(() {
//           isEnableScreen = true;
//           _controller.isShowpopUp.value = false;
//         });
//         Get.back();
//         return;
//       },
//       child: Directionality(
//         textDirection: SessionController().getLanguage() == 1
//             ? ui.TextDirection.ltr
//             : ui.TextDirection.rtl,
//         child: Scaffold(
//           backgroundColor: Colors.white,
//           resizeToAvoidBottomInset:
//               _controller.chequeDeliveryOption.value == 2 ? true : false,
//           body: Stack(
//             children: [
//               SafeArea(
//                 child: Obx(() {
//                   return Stack(children: [
//                     // Payment Method
//                     Padding(
//                       padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             AppMetaLabels().paymentMethod,
//                             style: AppTextStyle.semiBoldBlack15,
//                           ),
//                           InkWell(
//                             onTap: () => Get.back(),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: Color.fromRGBO(118, 118, 128, 0.12),
//                               ),
//                               child: Padding(
//                                 padding: EdgeInsets.all(0.5.h),
//                                 child: Icon(Icons.close,
//                                     size: 2.5.h,
//                                     color: Color.fromRGBO(158, 158, 158, 1)),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Divider
//                     Padding(
//                       padding: EdgeInsets.only(top: 4.0.h, bottom: 2.0.w),
//                       child: AppDivider(),
//                     ),

//                     // Main Info
//                     Padding(
//                         padding: EdgeInsets.only(top: 4.0.h, bottom: 6.0.h),
//                         child: _controller.loadingOutstandingPayments.value
//                             ? LoadingIndicatorBlue()
//                             : _controller.errorLoadingOutstandingPayments
//                                         .value !=
//                                     ''
//                                 ? Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       CustomErrorWidget(
//                                         errorImage: _controller
//                                                 .paymentsToShow.isEmpty
//                                             ? AppImagesPath.noPaymentsFound
//                                             : _controller
//                                                 .errorLoadingOutstandingPayments
//                                                 .value,
//                                         errorText: AppMetaLabels()
//                                             .noPendingPaymentFound,
//                                         onRetry: () {
//                                           _controller.getOutstandingPayments();
//                                         },
//                                       ),
//                                       if (_controller.paymentsToShow.isEmpty)
//                                         TextButton(
//                                           child: Text(
//                                               AppMetaLabels().viewContract),
//                                           onPressed: () {
//                                             Get.off(
//                                                 () => ContractsDetailsTabs());
//                                           },
//                                         )
//                                     ],
//                                   )
//                                 : Center(
//                                     child: SingleChildScrollView(
//                                       child: Container(
//                                         width: 92.0.w,
//                                         height: 78.h,
//                                         padding: EdgeInsets.only(
//                                             left: 3.w, right: 3.w, top: 1.5.h),
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(2.0.h),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: Colors.black12,
//                                               blurRadius: 0.5.h,
//                                               spreadRadius: 0.3.h,
//                                               offset: Offset(0.1.h, 0.1.h),
//                                             ),
//                                           ],
//                                         ),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             // Contract No. number
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   AppMetaLabels().contractNo,
//                                                   style: AppTextStyle
//                                                       .semiBoldBlack12,
//                                                 ),
//                                                 Text(
//                                                   widget.contractNo,
//                                                   style: AppTextStyle
//                                                       .semiBoldBlack12,
//                                                 ),
//                                               ],
//                                             ),
//                                             SizedBox(
//                                               height: 1.h,
//                                             ),

//                                             // Payments
//                                             Text(
//                                               AppMetaLabels().payments,
//                                               style:
//                                                   AppTextStyle.semiBoldBlack12,
//                                             ),

//                                             // here add
//                                             SizedBox(
//                                               height: 1.5.h,
//                                             ),
//                                             //  cheque sample
//                                             _controller.errorLoadingOutstandingPayments
//                                                         .value ==
//                                                     ''
//                                                 ? Align(
//                                                     alignment: SessionController()
//                                                                 .getLanguage() ==
//                                                             1
//                                                         ? Alignment.centerRight
//                                                         : Alignment.centerLeft,
//                                                     child: RichText(
//                                                       text: TextSpan(
//                                                         text: AppMetaLabels()
//                                                             .chequeSample,
//                                                         style: AppTextStyle
//                                                             .normalBlack9,
//                                                         children: <TextSpan>[
//                                                           TextSpan(
//                                                               text:
//                                                                   AppMetaLabels()
//                                                                       .clickHere,
//                                                               style: AppTextStyle
//                                                                   .semiBoldBlue9ul,
//                                                               recognizer:
//                                                                   TapGestureRecognizer()
//                                                                     ..onTap =
//                                                                         () {
//                                                                       chequeSample();
//                                                                       setState(
//                                                                           () {});
//                                                                     })
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   )
//                                                 : SizedBox(),
//                                             AppDivider(),
//                                             // remaining radio etc  work
//                                             Expanded(
//                                               child:
//                                                   ScrollablePositionedList
//                                                       .builder(
//                                                           itemScrollController:
//                                                               scrollController,
//                                                           itemCount: _controller
//                                                               .paymentsToShow
//                                                               .length,
//                                                           padding:
//                                                               EdgeInsets.zero,
//                                                           itemBuilder:
//                                                               (context, index) {
//                                                             _controllers.add(
//                                                                 new TextEditingController());
//                                                             return _controller
//                                                                             .paymentsToShow[
//                                                                         index]
//                                                                     is String
//                                                                 ? Padding(
//                                                                     padding: EdgeInsets.only(
//                                                                         top: 1.5
//                                                                             .h,
//                                                                         bottom:
//                                                                             1.h,
//                                                                         left: 4.0
//                                                                             .w,
//                                                                         right: 4.0
//                                                                             .w),
//                                                                     // like Rental payment etc
//                                                                     child: Text(
//                                                                       _controller
//                                                                               .paymentsToShow[
//                                                                           index], //+' Index: '+ index.toString(),
//                                                                       style: AppTextStyle
//                                                                           .semiBoldBlack11,
//                                                                     ),
//                                                                   )
//                                                                 : paymentListItem(
//                                                                     _controller
//                                                                             .paymentsToShow[
//                                                                         index],
//                                                                     index);
//                                                           }),
//                                             ),
//                                             if (_controller
//                                                 .showDeliveryOptionsTest.value)
//                                               Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   AppDivider(),
//                                                   // How would like to ...
//                                                   Padding(
//                                                     padding: EdgeInsets.only(
//                                                       top: 1.h,
//                                                     ),
//                                                     child: Text(
//                                                       AppMetaLabels()
//                                                           .howToDeliverCheque,
//                                                       style: AppTextStyle
//                                                           .normalBlack12,
//                                                     ),
//                                                   ),
//                                                   Row(
//                                                     children: [
//                                                       Radio(
//                                                         groupValue: _controller
//                                                             .chequeDeliveryOption
//                                                             .value,
//                                                         onChanged: (value) {
//                                                           _controller
//                                                               .errorPickupDelivery
//                                                               .value = '';

//                                                           if (_controller
//                                                                   .outstandingPayments
//                                                                   .record
//                                                                   .first
//                                                                   .confirmed ==
//                                                               0)
//                                                             _controller
//                                                                 .chequeDeliveryOption
//                                                                 .value = value;
//                                                           else
//                                                             Get.snackbar(
//                                                                 AppMetaLabels()
//                                                                     .alert,
//                                                                 AppMetaLabels()
//                                                                     .paymentConfirmed,
//                                                                 backgroundColor:
//                                                                     AppColors
//                                                                         .white54);
//                                                         },
//                                                         value: 1,
//                                                       ),
//                                                       Text(
//                                                         AppMetaLabels()
//                                                             .selfDelivery,
//                                                         style: AppTextStyle
//                                                             .normalBlack10,
//                                                       ),
//                                                       SizedBox(
//                                                         width: 0.5.w,
//                                                       ),
//                                                       Radio(
//                                                         groupValue: _controller
//                                                             .chequeDeliveryOption
//                                                             .value,
//                                                         onChanged: (value) {
//                                                           _controller
//                                                               .errorPickupDelivery
//                                                               .value = '';

//                                                           if (_controller
//                                                                   .outstandingPayments
//                                                                   .record
//                                                                   .first
//                                                                   .confirmed ==
//                                                               0)
//                                                             _controller
//                                                                 .chequeDeliveryOption
//                                                                 .value = value;
//                                                           else
//                                                             Get.snackbar(
//                                                                 AppMetaLabels()
//                                                                     .alert,
//                                                                 AppMetaLabels()
//                                                                     .paymentConfirmed,
//                                                                 backgroundColor:
//                                                                     AppColors
//                                                                         .white54);
//                                                         },
//                                                         value: 2,
//                                                       ),
//                                                       Text(
//                                                         AppMetaLabels()
//                                                             .freePickupBC,
//                                                         style: AppTextStyle
//                                                             .normalBlack10,
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   if (_controller
//                                                           .chequeDeliveryOption
//                                                           .value ==
//                                                       2)
//                                                     Padding(
//                                                       padding: EdgeInsets.only(
//                                                           top: 1.0.h,
//                                                           bottom: 1.0.h),
//                                                       child: TextField(
//                                                         enabled: _controller
//                                                                     .outstandingPayments
//                                                                     .record
//                                                                     .first
//                                                                     .confirmed ==
//                                                                 1
//                                                             ? false
//                                                             : true,
//                                                         readOnly: _controller
//                                                                 .outstandingPayments
//                                                                 .record
//                                                                 .first
//                                                                 .confirmed ==
//                                                             1,
//                                                         controller: _controller
//                                                             .locationTextController,
//                                                         decoration: InputDecoration(
//                                                             filled: true,
//                                                             fillColor: AppColors
//                                                                 .greyBG,
//                                                             border: OutlineInputBorder(
//                                                                 borderSide: BorderSide(
//                                                                     color: _controller.errorPickupDelivery.value !=
//                                                                             ''
//                                                                         ? Colors
//                                                                             .red
//                                                                         : Colors
//                                                                             .transparent,
//                                                                     width:
//                                                                         0.1)),
//                                                             labelText:
//                                                                 '${AppMetaLabels().chequeCollectionAddress} *',
//                                                             hintText:
//                                                                 AppMetaLabels()
//                                                                     .pleaseEnter),
//                                                       ),
//                                                     ),
//                                                   _controller.errorPickupDelivery
//                                                               .value ==
//                                                           ''
//                                                       ? SizedBox()
//                                                       : Container(
//                                                           padding:
//                                                               EdgeInsets.only(
//                                                                   left: 10,
//                                                                   top: 5),
//                                                           height: 30,
//                                                           width:
//                                                               double.infinity,
//                                                           child: Text(
//                                                             AppMetaLabels()
//                                                                 .enterValidAddress,
//                                                             style: AppTextStyle
//                                                                 .normalErrorText3,
//                                                           ),
//                                                         )
//                                                 ],
//                                               ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   )),

//                     // botom button
//                     // !_controller.gotoOnlinePayments.value &&  confirmed ==1
//                     // applying this condition coz
//                     // want to show sizedBox() if there is only chequeq remaining
//                     Align(
//                       alignment: Alignment.bottomCenter,
//                       child: Container(
//                         height: 7.0.h,
//                         padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(15),
//                               topRight: Radius.circular(15)),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black12,
//                               blurRadius: 0.5.h,
//                               spreadRadius: 0.5.h,
//                               offset: Offset(0.1.h, 0.1.h),
//                             ),
//                           ],
//                         ),
//                         child: Obx(() {
//                           // jb tak loading ho ge button ki jgha sizedBox
//                           return _controller.loadingOutstandingPayments.value
//                               ? SizedBox()
//                               : _controller.errorLoadingOutstandingPayments
//                                           .value !=
//                                       ''
//                                   ? SizedBox()
//                                   : !_controller.gotoOnlinePayments.value &&
//                                           _controller.outstandingPayments.record
//                                                   .first.confirmed ==
//                                               1
//                                       ? SizedBox()
//                                       : _controller
//                                                   .errorLoadingOutstandingPayments
//                                                   .value !=
//                                               ''
//                                           ? SizedBox()
//                                           : _controller
//                                                   .gotoOnlinePaymentsTest.value
//                                               ? SizedBox()
//                                               : _controller
//                                                       .updatingAddress.value
//                                                   ? LoadingIndicatorBlue()
//                                                   : Center(
//                                                       child: Obx(() {
//                                                         return !_controller
//                                                                 .showDeliveryOptionsTestForButton
//                                                                 .value
//                                                             ? ElevatedButton(
//                                                                 onPressed:
//                                                                     () async {
//                                                                   print(
//                                                                       'Checking :::::::::::: 1');
//                                                                   // the below condition in the for loop is for
//                                                                   // if any of the installment is un selecteable the will show the alert the select the whole installment' payment options
//                                                                   bool
//                                                                       isUnselectedInstallment =
//                                                                       false;
//                                                                   for (int i =
//                                                                           0;
//                                                                       i <
//                                                                           _controller
//                                                                               .outstandingPayments
//                                                                               .record
//                                                                               .length;
//                                                                       i++) {
//                                                                     print(
//                                                                         'defaultpaymentmethodtype :::::::: ${_controller.outstandingPayments.record[i].defaultpaymentmethodtype.value}');
//                                                                     if (_controller
//                                                                             .outstandingPayments
//                                                                             .record[i]
//                                                                             .defaultpaymentmethodtype
//                                                                             .value ==
//                                                                         0) {
//                                                                       setState(
//                                                                           () {
//                                                                         isUnselectedInstallment =
//                                                                             true;
//                                                                       });
//                                                                     }
//                                                                   }
//                                                                   if (isUnselectedInstallment ==
//                                                                       true) {
//                                                                     SnakBarWidget.getSnackBarErrorBlueWith5Sec(
//                                                                         AppMetaLabels()
//                                                                             .alert,
//                                                                         AppMetaLabels()
//                                                                             .pleaseSelectAllPayments);
//                                                                     return;
//                                                                   }
//                                                                   print(_controller
//                                                                       .showDeliveryOptionsTestForButton
//                                                                       .value);
//                                                                   print(_controller
//                                                                       .chequesToShowAddress);
//                                                                   int index =
//                                                                       _controller
//                                                                           .areAllChequesUploaded();
//                                                                   if (index >
//                                                                       -1) {
//                                                                     _controller
//                                                                         .outstandingPayments
//                                                                         .record[
//                                                                             index]
//                                                                         .forceUploadCheque
//                                                                         .value = true;
//                                                                     return;
//                                                                   }
//                                                                   var isShow = _controller
//                                                                       .chequesToShowAddress
//                                                                       .contains(
//                                                                           'true');
//                                                                   if (isShow) {
//                                                                     _controller
//                                                                         .showDeliveryOptionsTest
//                                                                         .value = true;
//                                                                     setState(
//                                                                         () {
//                                                                       _controller
//                                                                           .showDeliveryOptionsTestForButton
//                                                                           .value = true;
//                                                                     });
//                                                                     print(
//                                                                         'inside IF ${_controller.showDeliveryOptionsTest.value}');
//                                                                     return;
//                                                                   } else {
//                                                                     print(
//                                                                         'inside Else');
//                                                                     _controller
//                                                                         .showDeliveryOptionsTest
//                                                                         .value = false;
//                                                                     _showConfirmation(
//                                                                       context,
//                                                                     );
//                                                                   }
//                                                                 },
//                                                                 child: Padding(
//                                                                   padding: const EdgeInsets
//                                                                           .only(
//                                                                       left:
//                                                                           15.0,
//                                                                       right:
//                                                                           15.0,
//                                                                       top: 8.0,
//                                                                       bottom:
//                                                                           8.0),
//                                                                   child: Text(
//                                                                     _controller
//                                                                             .gotoOnlinePayments
//                                                                             .value
//                                                                         ? AppMetaLabels()
//                                                                             .confirmPayment
//                                                                         : '    ' +
//                                                                             AppMetaLabels().submit +
//                                                                             '    ',
//                                                                     style: AppTextStyle
//                                                                         .semiBoldBlack11
//                                                                         .copyWith(
//                                                                             color:
//                                                                                 Colors.white),
//                                                                   ),
//                                                                 ),
//                                                                 style:
//                                                                     ButtonStyle(
//                                                                         elevation:
//                                                                             MaterialStateProperty.all<double>(
//                                                                                 0.0),
//                                                                         backgroundColor:
//                                                                             MaterialStateProperty.all<Color>(AppColors
//                                                                                 .blueColor),
//                                                                         shape: MaterialStateProperty.all<
//                                                                             RoundedRectangleBorder>(
//                                                                           RoundedRectangleBorder(
//                                                                             borderRadius:
//                                                                                 BorderRadius.circular(2.0.w),
//                                                                           ),
//                                                                         )),
//                                                               )
//                                                             : ElevatedButton(
//                                                                 onPressed:
//                                                                     () async {
//                                                                   print(
//                                                                       'Checking :::::::::::: 2');
//                                                                   // the below condition in the for loop is for
//                                                                   // if any of the installment is un selecteable the will show the alert the select the whole installment' payment options
//                                                                   bool
//                                                                       isUnselectedInstallment =
//                                                                       false;
//                                                                   for (int i =
//                                                                           0;
//                                                                       i <
//                                                                           _controller
//                                                                               .outstandingPayments
//                                                                               .record
//                                                                               .length;
//                                                                       i++) {
//                                                                     print(
//                                                                         'Payment Method ID :::::::: ${_controller.outstandingPayments.record[i].defaultpaymentmethodtype.value}');
//                                                                     if (_controller
//                                                                             .outstandingPayments
//                                                                             .record[i]
//                                                                             .defaultpaymentmethodtype
//                                                                             .value ==
//                                                                         0) {
//                                                                       setState(
//                                                                           () {
//                                                                         isUnselectedInstallment =
//                                                                             true;
//                                                                       });
//                                                                     }
//                                                                   }
//                                                                   if (isUnselectedInstallment ==
//                                                                       true) {
//                                                                     SnakBarWidget.getSnackBarErrorBlueWith5Sec(
//                                                                         AppMetaLabels()
//                                                                             .alert,
//                                                                         AppMetaLabels()
//                                                                             .pleaseSelectAllPayments);
//                                                                     return;
//                                                                   }

//                                                                   //
//                                                                   print(_controller
//                                                                       .showDeliveryOptionsTestForButton
//                                                                       .value);
//                                                                   print(_controller
//                                                                       .chequesToShowAddress);

//                                                                   int index =
//                                                                       _controller
//                                                                           .areAllChequesUploaded();
//                                                                   if (index >
//                                                                       -1) {
//                                                                     _controller
//                                                                         .outstandingPayments
//                                                                         .record[
//                                                                             index]
//                                                                         .forceUploadCheque
//                                                                         .value = true;
//                                                                     return;
//                                                                   }
//                                                                   if (_controller
//                                                                           .chequesToShowAddress
//                                                                           .contains(
//                                                                               'true') ==
//                                                                       true) {
//                                                                     if (_controller
//                                                                             .chequeDeliveryOption
//                                                                             .value ==
//                                                                         1) {
//                                                                       _showConfirmation(
//                                                                         context,
//                                                                       );
//                                                                     } else {
//                                                                       if (_controller
//                                                                               .chequeDeliveryOption
//                                                                               .value ==
//                                                                           2) {
//                                                                         if (_controller.locationTextController.text.length <
//                                                                             4) {
//                                                                           _controller
//                                                                               .errorPickupDelivery
//                                                                               .value = AppMetaLabels().enterValidAddress;

//                                                                           return AppMetaLabels()
//                                                                               .enterValidAddress;
//                                                                         } else {
//                                                                           _controller
//                                                                               .pickupDeliveryText
//                                                                               .value = _controller.locationTextController.text;
//                                                                           print(_controller
//                                                                               .pickupDeliveryText
//                                                                               .value);
//                                                                           _showConfirmation(
//                                                                               context);
//                                                                         }
//                                                                       }
//                                                                     }
//                                                                   } else {
//                                                                     _showConfirmation(
//                                                                       context,
//                                                                     );
//                                                                   }
//                                                                 },
//                                                                 child: Padding(
//                                                                   padding: const EdgeInsets
//                                                                           .only(
//                                                                       left:
//                                                                           15.0,
//                                                                       right:
//                                                                           15.0,
//                                                                       top: 8.0,
//                                                                       bottom:
//                                                                           8.0),
//                                                                   child: Text(
//                                                                     _controller
//                                                                             .gotoOnlinePayments
//                                                                             .value
//                                                                         ? AppMetaLabels()
//                                                                             .confirmPayment
//                                                                         : '    ' +
//                                                                             AppMetaLabels().submit +
//                                                                             '     ',
//                                                                     style: AppTextStyle
//                                                                         .semiBoldBlack11
//                                                                         .copyWith(
//                                                                             color:
//                                                                                 Colors.white),
//                                                                   ),
//                                                                 ),
//                                                                 style:
//                                                                     ButtonStyle(
//                                                                         elevation:
//                                                                             MaterialStateProperty.all<double>(
//                                                                                 0.0),
//                                                                         backgroundColor:
//                                                                             MaterialStateProperty.all<Color>(AppColors
//                                                                                 .blueColor),
//                                                                         shape: MaterialStateProperty.all<
//                                                                             RoundedRectangleBorder>(
//                                                                           RoundedRectangleBorder(
//                                                                             borderRadius:
//                                                                                 BorderRadius.circular(2.0.w),
//                                                                           ),
//                                                                         )),
//                                                               );
//                                                       }),
//                                                     );
//                         }),
//                       ),
//                     ),

//                     isEnableScreen == false
//                         ? ScreenDisableWidget()
//                         : SizedBox(),
//                   ]);
//                 }),
//               ),
//               Obx(() {
//                 return _controller.isShowpopUp.value != true
//                     ? SizedBox()
//                     : Container(
//                         height: double.infinity,
//                         width: double.infinity,
//                         color: Colors.black.withOpacity(0.3),
//                         child: Center(
//                           child: Container(
//                               padding: EdgeInsets.all(3.0.w),
//                               margin: EdgeInsets.all(3.0.h),
//                               // height: 45.0.h,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(2.0.h),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black12,
//                                     blurRadius: 0.5.h,
//                                     spreadRadius: 0.3.h,
//                                     offset: Offset(0.1.h, 0.1.h),
//                                   ),
//                                 ],
//                               ),
//                               child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     SizedBox(
//                                       height: 4.0.h,
//                                     ),
//                                     Image.asset(
//                                       AppImagesPath.bluttickimg,
//                                       height: 12.0.h,
//                                       width: 12.0.h,
//                                       fit: BoxFit.contain,
//                                     ),
//                                     SizedBox(
//                                       height: 3.0.h,
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(
//                                           left: Get.width * 0.03),
//                                       child: Text(
//                                         AppMetaLabels().stage5_12,
//                                         textAlign: TextAlign.center,
//                                         style: AppTextStyle.normalBlack12
//                                             .copyWith(
//                                                 color:
//                                                     AppColors.renewelgreyclr1,
//                                                 height: 1.3),
//                                         maxLines: 5,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                     Padding(
//                                         padding: EdgeInsets.only(
//                                             top: 5.0.h, bottom: 2.0.h),
//                                         child: Align(
//                                           alignment: Alignment.center,
//                                           child: SizedBox(
//                                             height: 5.0.h,
//                                             width: 65.0.w,
//                                             child: ElevatedButton(
//                                               style: ElevatedButton.styleFrom(
//                                                 shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           1.3.h),
//                                                 ),
//                                                 backgroundColor: Color.fromRGBO(
//                                                     0, 61, 166, 1),
//                                               ),
//                                               onPressed: () {
//                                                 _controller.isShowpopUp.value =
//                                                     false;
//                                                 Get.back();
//                                               },
//                                               child: Text(
//                                                 AppMetaLabels().ok,
//                                                 textAlign: TextAlign.center,
//                                                 style: AppTextStyle
//                                                     .semiBoldWhite10,
//                                               ),
//                                             ),
//                                           ),
//                                         )),
//                                   ])),
//                         ),
//                       );
//               })
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Padding paymentListItem(Record payable, int index1) {
//     // All=0 DONE
//     // CardPayment,=1 DONE
//     // BankTranfser,=2
//     // Cheque=3
//     // CardPaymentBankTransfer=4 DONE
//     // CardPaymentCheque=5
//     // BankTransferCheque=6

//     return Padding(
//       padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 1.h, bottom: 0.5.h),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             child: SessionController().getLanguage() == 1
//                 ? Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Instalment No etc
//                       Expanded(
//                         child: Text(
//                           payable.title ?? '',
//                           style: AppTextStyle.normalBlack10,
//                         ),
//                       ),
//                       SizedBox(
//                         width: 8,
//                       ),
//                       // AED 25,99,0008
//                       Text(
//                         '${AppMetaLabels().aed} ${payable.amountFormatted}',
//                         style: AppTextStyle.semiBoldBlack10,
//                         textAlign: TextAlign.end,
//                       ),
//                     ],
//                   )
//                 : Directionality(
//                     textDirection: ui.TextDirection.ltr,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '${AppMetaLabels().aed} ${payable.amountFormatted}',
//                           style: AppTextStyle.semiBoldBlack10,
//                           textAlign: TextAlign.end,
//                         ),
//                         SizedBox(
//                           width: 8,
//                         ),
//                         // Instalment No etc
//                         Expanded(
//                           child: Text(
//                             payable.titleAr != null
//                                 ? payable.titleAr.replaceAll(':', '') ?? ""
//                                 : payable.titleAr ?? "",
//                             style: AppTextStyle.normalBlack10,
//                             textAlign: TextAlign.right,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//           ),
//           SizedBox(
//             height: 1.h,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 AppMetaLabels().dueDate,
//                 style: AppTextStyle.normalBlack10,
//               ),
//               Text(
//                 payable.paymentDate ?? '--',
//                 style: AppTextStyle.normalBlue10,
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 1.5.h,
//           ),
//           // i want to make payment ...
//           Text(
//             AppMetaLabels().makePaymentThrough,
//             style: AppTextStyle.normalBlack9,
//           ),
//           Obx(() {
//             return payable.updatingPaymentMethod.value
//                 ? Center(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: LoadingIndicatorBlue(
//                         size: 20,
//                       ),
//                     ),
//                   )
//                 : payable.errorUpdatingPaymentMethod
//                     ? Center(
//                         child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: InkWell(
//                               child: Icon(
//                                 Icons.refresh,
//                                 size: 20,
//                                 color: Colors.red,
//                               ),
//                               onTap: () async {
//                                 setState(() {
//                                   isEnableScreen = false;
//                                 });

//                                 await _controller.updatePaymentMethod(
//                                     payable, index1, context, typeofPayment);
//                                 setState(() {
//                                   isEnableScreen = true;
//                                 });
//                               },
//                             )),
//                       )
//                     : Row(
//                         children: [
//                           // All=0 DONE
//                           // CardPayment,=1 DONE
//                           // BankTranfser,=2
//                           // Cheque=3
//                           // CardPaymentBankTransfer=4 DONE
//                           // CardPaymentCheque=5
//                           // BankTransferCheque=6

//                           // => CardPayment
//                           // payable.acceptPaymentType == 0 // for all
//                           // payable.acceptPaymentType == 1 // for only CardPayment
//                           // payable.acceptPaymentType == 4 // for with Bank transfer
//                           // payable.acceptPaymentType == 5 // for with Cheque
//                           if (payable.acceptPaymentType == 0 ||
//                               payable.acceptPaymentType == 1 ||
//                               payable.acceptPaymentType == 4 ||
//                               payable.acceptPaymentType == 5)
//                             Container(
//                               width: 28.w,
//                               child: Row(
//                                 children: [
//                                   // onlineOrCard
//                                   Container(
//                                     width: 4.w,
//                                     child: Transform.scale(
//                                       scale: 0.8,
//                                       child: Radio(
//                                         groupValue: payable
//                                             .defaultpaymentmethodtype.value,
//                                         onChanged: (value) async {
//                                           setState(() {
//                                             typeofPayment = 'onlineOrCard';
//                                           });

//                                           if (_controller.outstandingPayments
//                                                   .record.first.confirmed ==
//                                               0) {
//                                             payable.defaultpaymentmethodtype
//                                                 .value = value;
//                                             payable.filePath = null;
//                                             setState(() {
//                                               isEnableScreen = false;
//                                             });
//                                             await _controller
//                                                 .updatePaymentMethod(
//                                                     payable,
//                                                     index1,
//                                                     context,
//                                                     typeofPayment);
//                                             setState(() {
//                                               isEnableScreen = true;
//                                             });
//                                           } else {
//                                             Get.snackbar(
//                                                 AppMetaLabels().alert,
//                                                 AppMetaLabels()
//                                                     .paymentConfirmed,
//                                                 backgroundColor:
//                                                     AppColors.white54);
//                                             return;
//                                           }
//                                           setState(() {
//                                             isEnableScreen = true;
//                                           });

//                                           setState(() {
//                                             _controller.chequesToShowAddress[
//                                                 index1 - 1] = 'false';
//                                           });

//                                           // this condition  is for hide or show fields
//                                           var isShow = _controller
//                                               .chequesToShowAddress
//                                               .contains('true');
//                                           if (isShow) {
//                                             _controller.showDeliveryOptionsTest
//                                                 .value = true;
//                                             setState(() {
//                                               _controller
//                                                   .showDeliveryOptionsTestForButton
//                                                   .value = true;
//                                               _controller
//                                                   .showDeliveryOptionsTest
//                                                   .value = true;
//                                             });
//                                             return;
//                                           } else {
//                                             setState(() {
//                                               _controller
//                                                   .showDeliveryOptionsTestForButton
//                                                   .value = false;
//                                               _controller
//                                                   .showDeliveryOptionsTest
//                                                   .value = false;
//                                             });
//                                           }
//                                         },
//                                         value: 1,
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 0.5.w,
//                                   ),
//                                   InkWell(
//                                     onTap: payable.acceptPaymentType == 1
//                                         ? () {}
//                                         : () async {
//                                             setState(() {
//                                               typeofPayment = 'onlineOrCard';
//                                             });
//                                             if (_controller.outstandingPayments
//                                                     .record.first.confirmed ==
//                                                 0) {
//                                               payable.defaultpaymentmethodtype
//                                                   .value = 1;
//                                               payable.filePath = null;
//                                               setState(() {
//                                                 isEnableScreen = false;
//                                               });
//                                               await _controller
//                                                   .updatePaymentMethod(
//                                                       payable,
//                                                       index1,
//                                                       context,
//                                                       typeofPayment);
//                                               setState(() {
//                                                 isEnableScreen = true;
//                                               });
//                                             } else {
//                                               Get.snackbar(
//                                                   AppMetaLabels().alert,
//                                                   AppMetaLabels()
//                                                       .paymentConfirmed,
//                                                   backgroundColor:
//                                                       AppColors.white54);
//                                               return;
//                                             }
//                                             setState(() {
//                                               isEnableScreen = true;
//                                             });

//                                             setState(() {
//                                               _controller.chequesToShowAddress[
//                                                   index1 - 1] = 'false';
//                                             });

//                                             // this condition  is for hide or show fields
//                                             var isShow = _controller
//                                                 .chequesToShowAddress
//                                                 .contains('true');
//                                             if (isShow) {
//                                               _controller
//                                                   .showDeliveryOptionsTest
//                                                   .value = true;
//                                               setState(() {
//                                                 _controller
//                                                     .showDeliveryOptionsTestForButton
//                                                     .value = true;
//                                                 _controller
//                                                     .showDeliveryOptionsTest
//                                                     .value = true;
//                                               });
//                                               return;
//                                             } else {
//                                               setState(() {
//                                                 _controller
//                                                     .showDeliveryOptionsTestForButton
//                                                     .value = false;
//                                                 _controller
//                                                     .showDeliveryOptionsTest
//                                                     .value = false;
//                                               });
//                                             }
//                                           },
//                                     child: Text(
//                                       AppMetaLabels().cardPayment,
//                                       style: AppTextStyle.normalBlack10,
//                                     ),
//                                   ),
//                                   Spacer(),
//                                 ],
//                               ),
//                             ),
//                           SizedBox(
//                             width: 2.w,
//                           ),
//                           // => BankTranfser
//                           // payable.acceptPaymentType == 0 // for all
//                           // payable.acceptPaymentType == 2 // for only BankTranfser
//                           // payable.acceptPaymentType == 4 // for with Bank transfer
//                           // payable.acceptPaymentType == 5 // for with Cheque
//                           // if (payable.acceptPaymentType == 0 ||
//                           //     payable.acceptPaymentType == 2 ||
//                           //     payable.acceptPaymentType == 4 ||
//                           //     payable.acceptPaymentType == 6)
//                           //   Container(
//                           //     width: 27.w,
//                           //     child: Row(
//                           //       children: [
//                           //         // BankTranfser
//                           //         Container(
//                           //           width: 4.w,
//                           //           child: Transform.scale(
//                           //             scale: 0.8,
//                           //             child: Radio(
//                           //               groupValue:
//                           //                   payable.paymentMethodId.value,
//                           //               onChanged: (value) async {
//                           //                 setState(() {
//                           //                   typeofPayment = 'bankTransfer';
//                           //                 });
//                           // if (_controller.outstandingPayments
//                           //         .record.first.confirmed ==
//                           //     0) {
//                           // if (_controller.outstandingPayments
//                           //                       .record[index1].confirmed ==
//                           //                   0) {
//                           //                   payable.paymentMethodId.value =
//                           //                       value;
//                           //                   payable.filePath = null;
//                           //                   setState(() {
//                           //                     isEnableScreen = false;
//                           //                   });
//                           //                   await _controller
//                           //                       .updatePaymentMethod(
//                           //                           payable,
//                           //                           index1,
//                           //                           context,
//                           //                           typeofPayment);
//                           //                   setState(() {
//                           //                     isEnableScreen = true;
//                           //                   });
//                           //                 } else {
//                           //                   Get.snackbar(
//                           //                       AppMetaLabels().alert,
//                           //                       AppMetaLabels()
//                           //                           .paymentConfirmed,
//                           //                       backgroundColor:
//                           //                           AppColors.white54);
//                           //                   return;
//                           //                 }
//                           //                 setState(() {
//                           //                   isEnableScreen = true;
//                           //                 });
//                           //                 print('inside IF $index1');
//                           //                 setState(() {
//                           //                   _controller.chequesToShowAddress[
//                           //                       index1 - 1] = 'false';
//                           //                 });
//                           //                 // this condition  is for hide or show fields
//                           //                 var isShow = _controller
//                           //                     .chequesToShowAddress
//                           //                     .contains('true');
//                           //                 if (isShow) {
//                           //                   _controller.showDeliveryOptionsTest
//                           //                       .value = true;
//                           //                   setState(() {
//                           //                     _controller
//                           //                         .showDeliveryOptionsTestForButton
//                           //                         .value = true;
//                           //                     _controller
//                           //                         .showDeliveryOptionsTest
//                           //                         .value = true;
//                           //                   });
//                           //                   return;
//                           //                 } else {
//                           //                   setState(() {
//                           //                     _controller
//                           //                         .showDeliveryOptionsTestForButton
//                           //                         .value = false;
//                           //                     _controller
//                           //                         .showDeliveryOptionsTest
//                           //                         .value = false;
//                           //                   });
//                           //                 }
//                           //               },
//                           //               value: 3,
//                           //             ),
//                           //           ),
//                           //         ),
//                           //         SizedBox(
//                           //           width: 0.5.w,
//                           //         ),
//                           //         Text(
//                           //           AppMetaLabels().bankTransfer,
//                           //           style: AppTextStyle.normalBlack10,
//                           //         ),
//                           //         Spacer(),
//                           //       ],
//                           //     ),
//                           //   ),
//                           // SizedBox(
//                           //   width: 0.1.w,
//                           // ),
//                           // => Cheque
//                           // payable.acceptPaymentType == 0 // for all
//                           // payable.acceptPaymentType == 3 // for only cheque
//                           // payable.acceptPaymentType == 5 // for with CardPayment
//                           // payable.acceptPaymentType == 6 // for with BankTransfer

//                           if (payable.acceptPaymentType == 0 ||
//                               payable.acceptPaymentType == 3 ||
//                               payable.acceptPaymentType == 5 ||
//                               payable.acceptPaymentType == 6)
//                             Container(
//                               width: 18.w,
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     width: 4.w,
//                                     child: Transform.scale(
//                                       scale: 0.8,
//                                       child: Radio(
//                                         toggleable: payable.cheque == null ||
//                                             payable.cheque.isEmpty,
//                                         groupValue: payable
//                                             .defaultpaymentmethodtype.value,

//                                         onChanged: (value) async {
//                                           setState(() {
//                                             typeofPayment = 'Cheque';
//                                           });
//                                           setState(() {
//                                             isEnableScreen = false;
//                                           });
//                                           print(value);
//                                           if (_controller.outstandingPayments
//                                                   .record.first.confirmed ==
//                                               0) {
//                                             payable.defaultpaymentmethodtype
//                                                 .value = value;
//                                             payable.filePath = null;
//                                             setState(() {
//                                               isEnableScreen = false;
//                                             });

//                                             // we commented the updatePaymentMethod because when we tap on cheque we were calling this and
//                                             // we will tap on upload after attach copy of cheque and card nbr again call same func
//                                             // so for reducing this we commented this
//                                             // *
//                                             // so insted of updatePaymentMethod we are just add 'true' for the address otption for the cheque
//                                             // that we were adding this in the updatePaymentMethod

//                                             if (typeofPayment == 'Cheque') {
//                                               _controller.chequesToShowAddress[
//                                                   index1 - 1] = 'true';
//                                             }

//                                             setState(() {
//                                               isEnableScreen = true;
//                                             });
//                                           } else
//                                             Get.snackbar(
//                                                 AppMetaLabels().alert,
//                                                 AppMetaLabels()
//                                                     .paymentConfirmed,
//                                                 backgroundColor:
//                                                     AppColors.white54);
//                                           setState(() {
//                                             isEnableScreen = true;
//                                           });
//                                           var isShow = _controller
//                                               .chequesToShowAddress
//                                               .contains('true');
//                                           if (isShow) {
//                                             _controller.showDeliveryOptionsTest
//                                                 .value = true;
//                                             setState(() {
//                                               _controller
//                                                   .showDeliveryOptionsTestForButton
//                                                   .value = true;
//                                               _controller
//                                                   .showDeliveryOptionsTest
//                                                   .value = true;
//                                             });
//                                             return;
//                                           } else {
//                                             setState(() {
//                                               _controller
//                                                   .showDeliveryOptionsTestForButton
//                                                   .value = false;
//                                               _controller
//                                                   .showDeliveryOptionsTest
//                                                   .value = false;
//                                             });
//                                           }
//                                         },
//                                         value: 2,
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 0.5.w,
//                                   ),
//                                   InkWell(
//                                     onTap: payable.acceptPaymentType == 3
//                                         ? () {}
//                                         : () async {
//                                             setState(() {
//                                               typeofPayment = 'Cheque';
//                                             });
//                                             setState(() {
//                                               isEnableScreen = false;
//                                             });
//                                             print(_controller
//                                                 .outstandingPayments
//                                                 .record
//                                                 .first
//                                                 .confirmed);
//                                             print(value);
//                                             if (_controller.outstandingPayments
//                                                     .record[index1].confirmed ==
//                                                 0) {
//                                               payable.defaultpaymentmethodtype
//                                                   .value = 2;
//                                               payable.filePath = null;
//                                               setState(() {
//                                                 isEnableScreen = false;
//                                               });

//                                               // we commented the updatePaymentMethod because when we tap on cheque we were calling this and
//                                               // we will tap on upload after attach copy of cheque and card nbr again call same func
//                                               // so for reducing this we commented this
//                                               // *
//                                               // so insted of updatePaymentMethod we are just add 'true' for the address otption for the cheque
//                                               // that we were adding this in the updatePaymentMethod

//                                               if (typeofPayment == 'Cheque') {
//                                                 _controller
//                                                         .chequesToShowAddress[
//                                                     index1 - 1] = 'true';
//                                               }

//                                               setState(() {
//                                                 isEnableScreen = true;
//                                               });
//                                             } else
//                                               Get.snackbar(
//                                                   AppMetaLabels().alert,
//                                                   AppMetaLabels()
//                                                       .paymentConfirmed,
//                                                   backgroundColor:
//                                                       AppColors.white54);
//                                             setState(() {
//                                               isEnableScreen = true;
//                                             });
//                                             var isShow = _controller
//                                                 .chequesToShowAddress
//                                                 .contains('true');
//                                             if (isShow) {
//                                               _controller
//                                                   .showDeliveryOptionsTest
//                                                   .value = true;
//                                               setState(() {
//                                                 _controller
//                                                     .showDeliveryOptionsTestForButton
//                                                     .value = true;
//                                                 _controller
//                                                     .showDeliveryOptionsTest
//                                                     .value = true;
//                                               });
//                                               return;
//                                             } else {
//                                               setState(() {
//                                                 _controller
//                                                     .showDeliveryOptionsTestForButton
//                                                     .value = false;
//                                                 _controller
//                                                     .showDeliveryOptionsTest
//                                                     .value = false;
//                                               });
//                                             }
//                                           },
//                                     child: Text(
//                                       AppMetaLabels().cheque,
//                                       style: AppTextStyle.normalBlack10,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                         ],
//                       );
//           }),

//           Obx(() {
//             return payable.defaultpaymentmethodtype.value == 2 &&
//                     !payable.updatingPaymentMethod.value &&
//                     !payable.errorUpdatingPaymentMethod
//                 ? Padding(
//                     padding: EdgeInsets.only(bottom: 1.h),
//                     child: payable.uploadingCheque.value ||
//                             payable.downloadingCheque.value
//                         ? LoadingIndicatorBlue(
//                             size: 20,
//                           )
//                         : payable.errorUploadingCheque
//                             ? Center(
//                                 child: InkWell(
//                                   child: Icon(
//                                     Icons.refresh,
//                                     size: 20,
//                                     color: Colors.red,
//                                   ),
//                                   onTap: () async {
//                                     setState(() {
//                                       isEnableScreen = false;
//                                     });
//                                     await _controller.uploadCheque(
//                                       payable,
//                                     );
//                                     setState(() {
//                                       isEnableScreen = true;
//                                     });
//                                   },
//                                 ),
//                               )
//                             : payable.cheque != null &&
//                                     payable.cheque.isNotEmpty &&
//                                     !payable.isRejected
//                                 ? SizedBox(
//                                     width: 100.w,
//                                     child: Column(
//                                       children: [
//                                         Row(children: [
//                                           Icon(
//                                             Icons.photo,
//                                             color: Colors.black38,
//                                           ),
//                                           SizedBox(
//                                             width: 1.w,
//                                           ),
//                                           InkWell(
//                                             child: SizedBox(
//                                               width: 60.w,
//                                               child: Text(
//                                                 payable.cheque,
//                                                 style: AppTextStyle.normalBlue12
//                                                     .copyWith(
//                                                         color: payable
//                                                                 .forceUploadCheque
//                                                                 .value
//                                                             ? Colors.red
//                                                             : AppColors
//                                                                 .blueColor),
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                             ),
//                                             //  downloadCheque
//                                             onTap: () async {
//                                               if (payable.chequeFile != null) {
//                                                 _controller.showFile(
//                                                     payable,
//                                                     payable.chequeFile,
//                                                     'cheque${payable.contractPaymentId}');
//                                               } else {
//                                                 setState(() {
//                                                   isEnableScreen = false;
//                                                 });
//                                                 await _controller
//                                                     .downloadCheque(payable);
//                                                 setState(() {
//                                                   isEnableScreen = true;
//                                                 });
//                                               }
//                                             },
//                                           ),
//                                           Spacer(),
//                                           if (payable.confirmed != 1)
//                                             payable.removingCheque.value
//                                                 ? LoadingIndicatorBlue(
//                                                     size: 3.h,
//                                                   )
//                                                 : payable.errorRemovingCheque
//                                                         .value
//                                                     ? InkWell(
//                                                         onTap: () async {
//                                                           setState(() {
//                                                             isEnableScreen =
//                                                                 false;
//                                                           });
//                                                           await _controller
//                                                               .removeCheque(
//                                                                   payable);
//                                                           setState(() {
//                                                             isEnableScreen =
//                                                                 true;
//                                                           });
//                                                         },
//                                                         child: Icon(
//                                                           Icons.refresh,
//                                                           size: 2.5.h,
//                                                           color: Colors.red,
//                                                         ))
//                                                     //  RemoveCheque
//                                                     : InkWell(
//                                                         onTap: () async {
//                                                           setState(() {
//                                                             isEnableScreen =
//                                                                 false;
//                                                           });
//                                                           await _controller
//                                                               .removeCheque(
//                                                                   payable);
//                                                           setState(() {
//                                                             isEnableScreen =
//                                                                 true;
//                                                           });
//                                                         },
//                                                         child: Image.asset(
//                                                           AppImagesPath
//                                                               .deleteimg,
//                                                           width: 2.5.h,
//                                                           height: 2.5.h,
//                                                           fit: BoxFit.contain,
//                                                         ),
//                                                       )
//                                         ]),
//                                         SizedBox(
//                                           height: 8,
//                                         ),
//                                         Row(
//                                           children: [
//                                             Text(
//                                               AppMetaLabels().chequeNo,
//                                               style: AppTextStyle.normalGrey10,
//                                             ),
//                                             Spacer(),
//                                             Text(
//                                               payable.chequeNo,
//                                               style: AppTextStyle.normalGrey10,
//                                             ),
//                                           ],
//                                         )
//                                       ],
//                                     ),
//                                   )
//                                 : Column(
//                                     children: [
//                                       if (payable.isRejected)
//                                         Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: RichText(
//                                               text: TextSpan(
//                                                   text:
//                                                       '${AppMetaLabels().yourCheque} ',
//                                                   style: AppTextStyle
//                                                       .normalErrorText3,
//                                                   children: <TextSpan>[
//                                                     TextSpan(
//                                                         text: payable.cheque,
//                                                         style: AppTextStyle
//                                                             .normalBlue10,
//                                                         recognizer:
//                                                             TapGestureRecognizer()
//                                                               ..onTap = () {
//                                                                 if (!payable
//                                                                     .downloadingCheque
//                                                                     .value)
//                                                                   _controller
//                                                                       .downloadCheque(
//                                                                           payable);
//                                                               }),
//                                                     TextSpan(
//                                                         text:
//                                                             ' ${AppMetaLabels().fileRejected}',
//                                                         style: AppTextStyle
//                                                             .normalErrorText3)
//                                                   ]),
//                                             )),
//                                       Row(
//                                         children: [
//                                           payable.filePath != null
//                                               ? Container(
//                                                   width: 78.0.w,
//                                                   child: Row(
//                                                     children: [
//                                                       TextButton(
//                                                         onPressed: () {
//                                                           OpenFile.open(
//                                                             payable.filePath,
//                                                           );
//                                                         },
//                                                         child: SizedBox(
//                                                           width: 65.5.w,
//                                                           child: Text(
//                                                             payable.filePath
//                                                                 .split('/')
//                                                                 .last,
//                                                             overflow:
//                                                                 TextOverflow
//                                                                     .ellipsis,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Spacer(),
//                                                       InkWell(
//                                                           onTap: () {
//                                                             print(
//                                                                 'Exactly here');
//                                                             setState(() {
//                                                               payable.filePath =
//                                                                   null;
//                                                             });
//                                                           },
//                                                           child: Icon(
//                                                             Icons.cancel,
//                                                             size: 20,
//                                                             color:
//                                                                 AppColors.grey1,
//                                                           ))
//                                                     ],
//                                                   ),
//                                                 )
//                                               : InkWell(
//                                                   onTap: () {
//                                                     _showPicker(
//                                                         context, payable);
//                                                   },
//                                                   child: Container(
//                                                     width: Get.width * 0.78,
//                                                     height: Get.height * 0.05,
//                                                     margin: EdgeInsets.only(
//                                                         bottom: 10),
//                                                     decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               5),
//                                                       border: Border.all(
//                                                         color: Colors.blue,
//                                                         width: 0.36.w,
//                                                       ),
//                                                     ),
//                                                     child: TextButton(
//                                                       onPressed: () {
//                                                         _showPicker(
//                                                             context, payable);
//                                                       },
//                                                       child: Text(
//                                                         AppMetaLabels()
//                                                             .uploadCheque,
//                                                         style: payable
//                                                                 .forceUploadCheque
//                                                                 .value
//                                                             ? AppTextStyle
//                                                                 .normalErrorText3
//                                                             : AppTextStyle
//                                                                 .normalBlue10,
//                                                         maxLines: 2,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                         ],
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           SizedBox(
//                                             height: 4.h,
//                                             child: Text(
//                                               '${AppMetaLabels().chequeNo} *',
//                                               style: payable.errorChequeNo.value
//                                                   ? AppTextStyle
//                                                       .normalErrorText3
//                                                   : AppTextStyle.normalGrey10,
//                                             ),
//                                           ),
//                                           Spacer(),
//                                           SizedBox(
//                                               width: 40.w,
//                                               height: 6.h,
//                                               child: TextField(
//                                                 // controller: chequeController,
//                                                 controller:
//                                                     _controllers[index1],
//                                                 maxLength: 6,
//                                                 keyboardType:
//                                                     TextInputType.number,
//                                                 inputFormatters: <
//                                                     TextInputFormatter>[
//                                                   FilteringTextInputFormatter
//                                                       .digitsOnly
//                                                 ],
//                                                 decoration: InputDecoration(
//                                                     enabledBorder: OutlineInputBorder(
//                                                         borderSide: BorderSide(
//                                                             color: payable
//                                                                     .errorChequeNo
//                                                                     .value
//                                                                 ? Colors.red
//                                                                 : AppColors
//                                                                     .grey1)),
//                                                     border:
//                                                         OutlineInputBorder()),
//                                                 onChanged: (value) {
//                                                   if (value.length == 6) {
//                                                     FocusScope.of(context)
//                                                         .unfocus();
//                                                     setState(() {});
//                                                   }
//                                                   payable.chequeNo =
//                                                       value.trim();
//                                                   setState(() {
//                                                     payable.errorChequeNo
//                                                         .value = false;
//                                                   });
//                                                 },
//                                               ))
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                       ElevatedButton(
//                                         onPressed: () async {
//                                           if (payable.isRejected == true &&
//                                               (_controllers[index1].text ==
//                                                       '' ||
//                                                   _controllers[index1].text ==
//                                                       null)) {
//                                             SnakBarWidget.getSnackBarErrorBlue(
//                                                 AppMetaLabels().alert,
//                                                 AppMetaLabels()
//                                                     .pleaseEnterCompleteCardNoRejection);
//                                             return;
//                                           }
//                                           payable.forceUploadCheque.value =
//                                               false;
//                                           payable.errorChequeNo.value = false;
//                                           print(
//                                               '::::chequeNo::: ${payable.chequeNo}');
//                                           print(
//                                               '::::chequeNo Rejected::: ${payable.isRejected}');
//                                           print(
//                                               '::::::: ${payable.chequeNo.length}');
//                                           setState(() {
//                                             isEnableScreen = false;
//                                           });
//                                           if (payable.filePath != null &&
//                                               payable.chequeNo.isNotEmpty &&
//                                               payable.chequeNo.length == 6) {
//                                             await _controller
//                                                 .uploadCheque(payable);
//                                             setState(() {
//                                               isEnableScreen = true;
//                                             });
//                                             return;
//                                           } else {
//                                             if (payable.chequeNo.isEmpty ||
//                                                 payable.chequeNo.length < 6) {
//                                               payable.errorChequeNo.value =
//                                                   true;
//                                               if (payable.chequeNo.length < 6) {
//                                                 SnakBarWidget
//                                                     .getSnackBarErrorBlue(
//                                                   AppMetaLabels().alert,
//                                                   AppMetaLabels()
//                                                       .pleaseEnterCompleteCardNo,
//                                                 );
//                                               }
//                                             }
//                                             if (payable.filePath == null) {
//                                               payable.forceUploadCheque.value =
//                                                   true;
//                                             }
//                                           }
//                                           setState(() {
//                                             isEnableScreen = true;
//                                           });
//                                         },
//                                         child: Text(
//                                           ' ' +
//                                               AppMetaLabels().attachCopy +
//                                               ' ',
//                                           style: AppTextStyle.semiBoldBlack11
//                                               .copyWith(color: Colors.white),
//                                         ),
//                                         style: ButtonStyle(
//                                             elevation: MaterialStateProperty
//                                                 .all<double>(0.0),
//                                             backgroundColor:
//                                                 MaterialStateProperty.all<
//                                                     Color>(AppColors.blueColor),
//                                             shape: MaterialStateProperty.all<
//                                                 RoundedRectangleBorder>(
//                                               RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                         2.0.w),
//                                               ),
//                                             )),
//                                       ),
//                                     ],
//                                   ),
//                   )
//                 : SizedBox();
//           }),
//           AppDivider(),
//         ],
//       ),
//     );
//   }

//   void _showPicker(context, Record payable) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Directionality(
//               textDirection: SessionController().getLanguage() == 1
//                   ? ui.TextDirection.ltr
//                   : ui.TextDirection.rtl,
//               child: Container(
//                 color: Colors.white,
//                 child: new Wrap(
//                   children: <Widget>[
//                     new ListTile(
//                         leading: new Icon(Icons.photo_library),
//                         title: new Text(AppMetaLabels().photoLibrary),
//                         onTap: () async {
//                           await _controller.pickDoc(payable);
//                           Navigator.of(context).pop();
//                         }),
//                     new ListTile(
//                       leading: new Icon(Icons.photo_camera),
//                       title: new Text(AppMetaLabels().camera),
//                       onTap: () async {
//                         await _controller.takePhoto(payable);

//                         Navigator.of(context).pop();
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }

//   void _showConfirmation(context) {
//     showModalBottomSheet(
//         context: context,
//         isDismissible: false,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Container(
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(10),
//                       topRight: Radius.circular(10))),
//               height: 22.h,
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: Get.width * 0.05,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: 20, right: 20),
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: Text(
//                         AppMetaLabels().paymentConfirmation,
//                         maxLines: null,
//                         textAlign: TextAlign.center,
//                         style: AppTextStyle.semiBoldBlack11,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: Get.width * 0.03,
//                   ),
//                   new Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Spacer(),
//                       SizedBox(
//                         width: Get.width * 0.3, // <-- match_parent
//                         height: Get.height * 0.05,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             print('object');
//                             setState(() {
//                               isEnableScreen = true;
//                             });
//                             print(_controller.pickupDeliveryText.value);
//                             if (_controller.isEnableCancelButton.value) {
//                               Navigator.of(context).pop();
//                               return;
//                             }
//                           },
//                           child: Text(
//                             AppMetaLabels().cancel,
//                             style: AppTextStyle.semiBoldBlue11
//                                 .copyWith(color: Colors.blue),
//                           ),
//                           style: ButtonStyle(
//                             shape: MaterialStateProperty.all<
//                                     RoundedRectangleBorder>(
//                                 RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(2.0.w),
//                                     side: BorderSide(color: Colors.blue))),
//                             backgroundColor:
//                                 MaterialStateProperty.all<Color>(Colors.white),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: Get.width * 0.1,
//                       ),
//                       Obx(() {
//                         return _controller.updatingAddress.value
//                             ? SizedBox(
//                                 width: Get.width * 0.3, // <-- match_parent
//                                 height: Get.height * 0.05,
//                                 child: LoadingIndicatorBlue())
//                             : SizedBox(
//                                 width: Get.width * 0.3, // <-- match_parent
//                                 height: Get.height * 0.05,
//                                 child: ElevatedButton(
//                                   onPressed: () async {
//                                     _controller.isEnableCancelButton.value =
//                                         false;
//                                     int index =
//                                         _controller.areAllChequesUploaded();
//                                     if (index > -1) {
//                                       _controller
//                                           .outstandingPayments
//                                           .record[index]
//                                           .forceUploadCheque
//                                           .value = true;
//                                       if (scrollController.isAttached)
//                                         scrollController.scrollTo(
//                                             index: index,
//                                             duration: Duration(seconds: 1));
//                                     } else {
//                                       bool proceed = true;

//                                       if (_controller
//                                               .chequeDeliveryOption.value ==
//                                           1) {
//                                         print('***************** 1');
//                                         proceed = await _controller
//                                             .updateDeliveryAddress(
//                                                 _controller
//                                                     .pickupDeliveryText.value,
//                                                 widget.contractId,
//                                                 widget.contractNo);
//                                         print(
//                                             'proceed ***************** $proceed');
//                                       } else if (_controller
//                                               .chequeDeliveryOption.value ==
//                                           2) {
//                                         print('***************** 2');
//                                         proceed = await _controller
//                                             .updateDeliveryAddress(
//                                                 _controller
//                                                     .pickupDeliveryText.value,
//                                                 widget.contractId,
//                                                 widget.contractNo);
//                                         print(
//                                             'proceed ***************** $proceed');
//                                       }
//                                       print(
//                                           'proceed After Condition ***************** $proceed');
//                                       if (proceed == true) {
//                                         print(
//                                             'gotoOnlinePayments After Condition ***************** ${_controller.gotoOnlinePayments.value}');
//                                         if (_controller
//                                             .gotoOnlinePayments.value) {
//                                           await Get.off(() => OnlinePayments(
//                                               contractNo: widget.contractNo));
//                                         } else {
//                                           _controller.isShowpopUp.value = true;
//                                         }
//                                       }
//                                     }
//                                     Navigator.of(context).pop();
//                                     _controller.isEnableCancelButton.value =
//                                         true;
//                                   },
//                                   child: Text(
//                                     AppMetaLabels().confirm,
//                                     style: AppTextStyle.semiBoldBlack11
//                                         .copyWith(color: Colors.white),
//                                   ),
//                                   style: ButtonStyle(
//                                       elevation:
//                                           MaterialStateProperty.all<double>(
//                                               0.0),
//                                       backgroundColor:
//                                           MaterialStateProperty.all<Color>(
//                                               AppColors.blueColor),
//                                       shape: MaterialStateProperty.all<
//                                           RoundedRectangleBorder>(
//                                         RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(2.0.w),
//                                         ),
//                                       )),
//                                 ),
//                               );
//                       }),
//                       Spacer(),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   void show() {
//     showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             contentPadding: EdgeInsets.zero,
//             backgroundColor: Colors.transparent,
//             content: showDialogData(),
//           );
//         });
//   }

//   Widget showDialogData() {
//     return Container(
//         padding: EdgeInsets.all(3.0.w),
//         // height: 45.0.h,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(2.0.h),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 0.5.h,
//               spreadRadius: 0.3.h,
//               offset: Offset(0.1.h, 0.1.h),
//             ),
//           ],
//         ),
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(
//                 height: 3.0.h,
//               ),
//               Text(
//                 AppMetaLabels().stage5_12,
//                 textAlign: TextAlign.center,
//                 style: AppTextStyle.semiBoldBlack13,
//               ),
//               SizedBox(
//                 height: 3.0.h,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 0.0.h, bottom: 3.0.h),
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: SizedBox(
//                     height: 4.0.h,
//                     width: 65.0.w,
//                     child: ElevatedButton(
//                       style: ButtonStyle(
//                           elevation: MaterialStateProperty.all<double>(0.0.h),
//                           backgroundColor: MaterialStateProperty.all<Color>(
//                               AppColors.whiteColor),
//                           shape:
//                               MaterialStateProperty.all<RoundedRectangleBorder>(
//                             RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(2.0.w),
//                                 side: BorderSide(
//                                   color: AppColors.blueColor,
//                                   width: 1.0,
//                                 )),
//                           )),
//                       onPressed: () {
//                         Get.back();
//                       },
//                       child: Text(
//                         AppMetaLabels().ok,
//                         style: AppTextStyle.semiBoldWhite11
//                             .copyWith(color: Colors.blue),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ]));
//   }

//   // show how to upload cheque
//   chequeSample() {
//     showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) {
//           return AlertDialog(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(3.h))),
//             title: Transform.scale(
//               alignment: Alignment.bottomCenter,
//               scale: 1,
//               child: Align(
//                 alignment: Alignment.topRight,
//                 child: InkWell(
//                     onTap: () {
//                       Navigator.of(context, rootNavigator: true).pop('dialog');
//                     },
//                     child: Icon(
//                       Icons.cancel,
//                       size: Get.height * 0.03,
//                     )),
//               ),
//             ),
//             content: Container(
//               height: Get.height * 0.35,
//               decoration: BoxDecoration(
//                 borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
//                 shape: BoxShape.rectangle,
//               ),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(AppMetaLabels().attachChequeCopy,
//                         style: AppTextStyle.semiBoldBlack14),
//                     SizedBox(
//                       height: Get.height * 0.005,
//                     ),
//                     SizedBox(
//                       child: Center(
//                         child: Text(
//                           AppMetaLabels().pleaseFillTheCheque,
//                           textAlign: TextAlign.center,
//                           style: AppTextStyle.normalBlack12,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: Get.height * 0.04,
//                     ),
//                     InkWell(
//                       onTap: () {
//                         chequeSample1();
//                       },
//                       child: SizedBox(
//                         height: Get.height * 0.15,
//                         width: double.infinity,
//                         child: Image.asset(
//                           'assets/images/common_images/pdf.png',
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: Get.height * 0.04,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }

//   chequeSample1() {
//     showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) {
//           return AlertDialog(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(3.h))),
//             content: Container(
//               height: Get.height * 0.42,
//               child: Stack(
//                 children: [
//                   Positioned.fill(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius:
//                             new BorderRadius.all(new Radius.circular(3.h)),
//                         shape: BoxShape.rectangle,
//                       ),
//                       child: PhotoView(
//                         filterQuality: FilterQuality.high,
//                         imageProvider:
//                             AssetImage('assets/images/common_images/pdf.png'),
//                         backgroundDecoration:
//                             BoxDecoration(color: Colors.transparent),
//                         gaplessPlayback: true,
//                         customSize: Get.size * 0.5,
//                         enableRotation: false,
//                         minScale: PhotoViewComputedScale.contained * 1.8,
//                         maxScale: PhotoViewComputedScale.covered * 1.8,
//                         initialScale: PhotoViewComputedScale.contained * 1.1,
//                         basePosition: Alignment.center,
//                       ),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.topRight,
//                     child: InkWell(
//                         onTap: () {
//                           Navigator.of(context, rootNavigator: true)
//                               .pop('dialog');
//                         },
//                         child: Icon(Icons.cancel)),
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }

// }
