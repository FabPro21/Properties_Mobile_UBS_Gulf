// ignore_for_file: unnecessary_type_check, unnecessary_null_comparison

import 'package:fap_properties/data/models/tenant_models/contract_payable/outstanding_payments_model.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../data/helpers/base_client.dart';
import '../../../../../data/helpers/session_controller.dart';
import '../../../../../data/models/tenant_models/contract_payable/register_payment_response.dart';
import '../../../../../data/models/tenant_models/contract_payable/tenant_register_payment_model.dart';
import '../../../../../data/repository/tenant_repository.dart';
import '../../../../../utils/constants/meta_labels.dart';
import '../../../../common/no_internet_screen.dart';
import '../make_payment.dart';

class OnlinePaymentsController extends GetxController {
  var contractPayableData = OutstandingPaymentsModel();
  var loadingPayable = true.obs;
  RxString errorPayable = "".obs;

  RxString sumOfSelectedPayments = '0.00'.obs;
  RxString sumOfSelectedPayments1 = '0.00'.obs;
  double sumOfSelectedPayments2 = 0;

  RxBool registeringPayment = false.obs;

  // below 3 Rx var are just for radio button on top
  RxBool isRadioButtonShow = false.obs;
  RxInt isPayemntValue = 1.obs;
  RxList cardPaymentListLength = [].obs;
  RxList bankTransferListLength = [].obs;

  double rentalSum = 0;
  double additionalSum = 0;
  double vatRentSum = 0;
  double vatChargesSum = 0;

  @override
  void onInit() {
    // getOnlinePayable();
    super.onInit();
  }

  Future<int> getOnlinePayable() async {
    try {
      bool _isIntenetConnected = await BaseClientClass.isInternetConnected();
      if (!_isIntenetConnected) {
        Get.to(() => NoInternetScreen());
      }
      contractPayableData = OutstandingPaymentsModel();
      sumOfSelectedPayments.value = '0.00';
      sumOfSelectedPayments1.value = '0.00';
      sumOfSelectedPayments2 = 0;
      errorPayable.value = '';
      loadingPayable.value = true;

      var resp = await TenantRepository.getContractOnlinePayable(
          SessionController().getContractID());
      print(resp);

      print(AppMetaLabels().noDatafound);
      if (resp is OutstandingPaymentsModel) {
        contractPayableData = resp;

        // this for loop is for setting these isBothRadioButtonShow,isCardPayemntShow,isBankTransferShow
        cardPaymentListLength.clear();
        bankTransferListLength.clear();
        for (int i = 0; i < contractPayableData.record!.length; i++) {
          if (contractPayableData.record![i].defaultpaymentmethodtype!.value ==
              1) {
            cardPaymentListLength
                .add(contractPayableData.record![i].defaultpaymentmethodtype!);
          }
          if (contractPayableData.record![i].defaultpaymentmethodtype!.value ==
              3) {
            bankTransferListLength
                .add(contractPayableData.record![i].defaultpaymentmethodtype!);
          }
          if (contractPayableData.record![i].defaultpaymentmethodtype!.value ==
                  1 ||
              contractPayableData.record![i].defaultpaymentmethodtype!.value ==
                  3) {
            isRadioButtonShow.value = true;
          } else {
            isRadioButtonShow.value = false;
          }
        }
        print('====================');
        print(cardPaymentListLength.length);
        if (cardPaymentListLength.length == 0) {
          isPayemntValue.value = 3;
        }
        if (bankTransferListLength.length == 0) {
          isPayemntValue.value = 1;
        }
        print(bankTransferListLength.length);
        print('====================');

        removeZeroBalance();
        sumPayments();
      } else if (resp == AppMetaLabels().noDatafound) {
        errorPayable.value = AppMetaLabels().noDatafound;
        cardPaymentListLength.clear();
        bankTransferListLength.clear();
        Get.back();

        // Testing
        // adding this for Dashboard
        Get.back();
        SnakBarWidget.getSnackBarSuccess(
            AppMetaLabels().success, AppMetaLabels().successfullyPaid);
      } else {
        errorPayable.value = resp.toString();
      }
    } catch (e) {
      print("This is the error from controller : $e");
    } finally {
      loadingPayable.value = false;
    }
    int noOfPayments = 0;
    if (contractPayableData.record! != null)
      noOfPayments = contractPayableData.record!.length;
    return noOfPayments;
  }

  void sumPayments() {
    rentalSum = 0;
    additionalSum = 0;
    vatRentSum = 0;
    vatChargesSum = 0;
    for (int i = 0; i < contractPayableData.record!.length; i++) {
      if (contractPayableData.record![i].type!.toLowerCase() ==
          'contract payable')
        rentalSum = rentalSum + (contractPayableData.record![i].amount??0.0);
      else if (contractPayableData.record![i].type!.toLowerCase() ==
          'additional charges') {
        additionalSum =
            additionalSum + (contractPayableData.record![i].amount??0.0);
        contractPayableData.record![i].isChecked.value = true;
      } else if (contractPayableData.record![i].type!.toLowerCase() ==
          'vat on rent'.toLowerCase()) {
        vatRentSum = vatRentSum + (contractPayableData.record![i].amount??0.0);
        contractPayableData.record![i].isChecked.value = true;
      } else if (contractPayableData.record![i].type!.toLowerCase() ==
          'vat on charges'.toLowerCase()) {
        vatChargesSum =
            vatChargesSum + (contractPayableData.record![i].amount??0.0);
        contractPayableData.record![i].isChecked.value = true;
      }
    }
    sumSelectedPayments();
  }

  // new dun
  void sumSelectedPayments() {
    double sum = 0;
    double sum1 = 0;
    for (int i = 0; i < contractPayableData.record!.length; i++) {
      if (contractPayableData.record![i].isChecked.value) {
        if (contractPayableData.record![i].defaultpaymentmethodtype!.value == 1) {
          sum = sum + (contractPayableData.record![i].amount??0.0);
        } else {
          sum1 = sum1 + (contractPayableData.record![i].amount??0.0);
        }
      }
    }

    final amountFormat = NumberFormat('#,##0.00', 'AR');
    String paymentValue = amountFormat.format(sum);
    this.sumOfSelectedPayments.value = paymentValue;

    final amountFormat1 = NumberFormat('#,##0.00', 'AR');
    String paymentValue1 = amountFormat1.format(sum1);
    this.sumOfSelectedPayments1.value = paymentValue1;
    this.sumOfSelectedPayments2 = sum;
  }
  // void sumSelectedPayments() {
  //   double sum = 0;
  //   for (int i = 0; i < contractPayableData.record!.length; i++) {
  //     if (contractPayableData.record![i].isChecked.value) {
  //       sum = sum + (contractPayableData.record![i].amount);
  //     }
  //   }
  //   final amountFormat = NumberFormat('#,##0.00', 'AR');
  //   String paymentValue = amountFormat.format(sum);
  //   this.sumOfSelectedPayments.value = paymentValue;
  //   this.sumOfSelectedPayments1.value = paymentValue;
  //   this.sumOfSelectedPayments2 = sum;
  // }

  void removeZeroBalance() {
    contractPayableData.record!.forEach((element) {
      if (element.amount == 0) contractPayableData.record!.remove(element);
    });
  }

  void registerPayment(String contractNo) async {
    print('isPayemntValue ;;;;;;;;;;:::::::+++++> ${isPayemntValue.value}');
    List<DetailList> detailList = [];
    List<DetailList> detailList1 = [];
    for (int i = 0; i < contractPayableData.record!.length; i++) {
      if (contractPayableData.record![i].defaultpaymentmethodtype!.value == 1) {
        if (contractPayableData.record![i].isChecked.value) {
          detailList.add(DetailList(
              title: contractPayableData.record![i].title,
              description: contractPayableData.record![i].type!,
              amount: contractPayableData.record![i].amount,
              paymentId: contractPayableData.record![i].contractPaymentId,
              chargeId: contractPayableData.record![i].contractchargeId,
              vatOnChargeId: contractPayableData.record![i].vatOnChargeId,
              vatOnRentContractId:
                  contractPayableData.record![i].vatOnRentContractId,
              paymentSettingId:
                  contractPayableData.record![i].paymentSettingId));
        }
      } else if (contractPayableData.record![i].defaultpaymentmethodtype!.value ==
          3) {
        if (contractPayableData.record![i].isChecked.value) {
          detailList1.add(DetailList(
              title: contractPayableData.record![i].title,
              description: contractPayableData.record![i].type!,
              amount: contractPayableData.record![i].amount,
              paymentId: contractPayableData.record![i].contractPaymentId,
              chargeId: contractPayableData.record![i].contractchargeId,
              vatOnChargeId: contractPayableData.record![i].vatOnChargeId,
              vatOnRentContractId:
                  contractPayableData.record![i].vatOnRentContractId,
              paymentSettingId:
                  contractPayableData.record![i].paymentSettingId));
        }
      } else {}
    }
    if (isPayemntValue.value == 1) {
      print('Detail List ;;;;;;;;;;:::::::+++++> 1111');
      for (int i = 0; i < detailList.length; i++) {
        print(detailList[i].amount);
      }
      print('Detail List ;;;;;;;;;;:::::::+++++>1');
    } else {
      print('Detail List ;;;;;;;;;;:::::::+++++>333');
      for (int i = 0; i < detailList1.length; i++) {
        print(detailList1[i].amount);
      }
      print('Detail List ;;;;;;;;;;:::::::+++++>3');
    }
    // if (detailList.isEmpty) {
    //   // Get.snackbar(AppMetaLabels().error, AppMetaLabels().pleaseSelectPayment,
    //   //     backgroundColor: AppColors.white54);
    //   SnakBarWidget.getSnackBarErrorBlue(
    //       AppMetaLabels().alert, AppMetaLabels().pleaseSelectPayment);
    //   return;
    // }
    registeringPayment.value = true;
    print('>>>>>>>>>>>><<<<<<<<<<<<<<<<<<');
    int userId = SessionController().getUserID()??0;
    print(userId);
    var resp = await TenantRepository.registerPayment(
        TenantRegisterPaymentModel(
            totalAmount: isPayemntValue.value == 1
                ? double.parse(sumOfSelectedPayments.value.replaceAll(',', ''))
                : double.parse(
                    sumOfSelectedPayments1.value.replaceAll(',', '')),
            // totalAmount: sumOfSelectedPayments2,
            contractId: SessionController().getContractID(),
            contractNo: contractNo,
            userId: userId,
            detailList: isPayemntValue.value != 1 ? detailList1 : detailList));

    if (resp is String) {
      print('>>>>>>>>>>>><<<<<<<<<<<<<<<<<Resp False < ${(resp is String)}');
      SnakBarWidget.getSnackBarErrorBlue(AppMetaLabels().error,
          AppMetaLabels().errorProcessingPayment.toString());
      registeringPayment.value = false;
      return;
    }
    if (resp is RegisterPaymentResponse) {
      print('>>>>>>>>>>>><<<<<<<<<<<<<<<<<<');
      print(SessionController().getUserId());
      if (resp.url == null || resp.transactionId == null) {
        // Get.snackbar(
        //     AppMetaLabels().error, AppMetaLabels().errorProcessingPayment,
        //     backgroundColor: AppColors.white54);
        SnakBarWidget.getSnackBarErrorBlue(AppMetaLabels().error,
            AppMetaLabels().errorProcessingPayment.toString());
      } else {
        Get.to(() => MakePayment(data: resp, contractNo: contractNo));
      }
    } else {
      // Get.snackbar(AppMetaLabels().error, resp.toString(),
      //     backgroundColor: AppColors.white54);
      SnakBarWidget.getSnackBarErrorBlue(
          AppMetaLabels().error, resp.toString());
    }
    registeringPayment.value = false;
  }
  // void registerPayment(String contractNo) async {
  //   List<DetailList> detailList = [];
  //   for (int i = 0; i < contractPayableData.record!.length; i++) {
  //     if (contractPayableData.record![i].isChecked.value) {
  //       detailList.add(DetailList(
  //           title: contractPayableData.record![i].title,
  //           description: contractPayableData.record![i].type!,
  //           amount: contractPayableData.record![i].amount,
  //           paymentId: contractPayableData.record![i].contractPaymentId,
  //           chargeId: contractPayableData.record![i].contractchargeId,
  //           vatOnChargeId: contractPayableData.record![i].vatOnChargeId,
  //           vatOnRentContractId:
  //               contractPayableData.record![i].vatOnRentContractId,
  //           paymentSettingId: contractPayableData.record![i].paymentSettingId));
  //     }
  //   }
  //   print('Detail List ;;;;;;;;;;:::::::+++++>');
  //   for (int i = 0; i < contractPayableData.record!.length; i++) {
  //     print(detailList[i].amount);
  //   }
  //   print(detailList);
  //   print('Detail List ;;;;;;;;;;:::::::+++++>');
  //   if (detailList.isEmpty) {
  //     // Get.snackbar(AppMetaLabels().error, AppMetaLabels().pleaseSelectPayment,
  //     //     backgroundColor: AppColors.white54);
  //     SnakBarWidget.getSnackBarErrorBlue(
  //         AppMetaLabels().alert, AppMetaLabels().pleaseSelectPayment);
  //     return;
  //   }
  //   registeringPayment.value = true;
  //   print('>>>>>>>>>>>><<<<<<<<<<<<<<<<<<');
  //   int userId = SessionController().getUserID();
  //   print(userId);
  //   var resp = await TenantRepository.registerPayment(
  //       TenantRegisterPaymentModel(
  //           totalAmount: sumOfSelectedPayments2,
  //           contractId: SessionController().getContractID(),
  //           contractNo: contractNo,
  //           userId: userId,
  //           detailList: detailList));
  //   if (resp is RegisterPaymentResponse) {
  //     print('>>>>>>>>>>>><<<<<<<<<<<<<<<<<<');
  //     print(SessionController().getUserId());
  //     if (resp.url == null || resp.transactionId == null) {
  //       Get.snackbar(
  //           AppMetaLabels().error, AppMetaLabels().errorProcessingPayment,
  //           backgroundColor: AppColors.white54);
  //     } else {
  //       Get.to(() => MakePayment(data: resp, contractNo: contractNo));
  //     }
  //   } else {
  //     Get.snackbar(AppMetaLabels().error, resp.toString(),
  //         backgroundColor: AppColors.white54);
  //   }
  //   registeringPayment.value = false;
  // }

}
