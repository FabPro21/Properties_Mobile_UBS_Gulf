import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/landlord_models/contract_payable/contract_payable_model.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_contract_details_model.dart';
import 'package:fap_properties/data/repository/landlord_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LandlordContractMainInfoController extends GetxController {
  LandlordContractDetailsModel contractDetails;
  RxBool loadingContractDetails = false.obs;
  String errorLoadingContractDetails = '';

  RxBool loadingContractPayables = false.obs;
  RxString errorLoadingContractPayables = ''.obs;

  RxString sumOfAllPayments = '0.00'.obs;
  RxString totalRentalPayment = '0.00'.obs;
  RxString totalAdditionalCharges = '0.00'.obs;
  RxString totalVatOnRent = '0.00'.obs;
  RxString totalVatOnCharges = '0.00'.obs;

  RxString amount = '0.00'.obs;
  int daysPassed = 0;
  double comPtg = 0.0;
  bool showExtend = true;
  RxString obxError = '0'.obs;
  void getContractDetails(int contractId) async {
    obxError.value = '0';
    bool _isIntenetConnected = await BaseClientClass.isInternetConnected();
    if (!_isIntenetConnected) {
      Get.to(() => NoInternetScreen());
    }
    errorLoadingContractDetails = '';
    loadingContractDetails.value = true;
    final response = await LandlordRepository.getContractDetails(contractId);
    obxError.value = '1';
    if (response is LandlordContractDetailsModel) {
      contractDetails = response;
      double am = contractDetails.contract.rentforstay ?? 0;
      final paidFormatter = NumberFormat('#,##0.00', 'AR');
      amount.value = paidFormatter.format(am);

      DateTime startDate =
          DateFormat('dd-MM-yyyy').parse(response.contract.contractStartDate);
      DateTime endDate =
          DateFormat('dd-MM-yyyy').parse(response.contract.contractEndDate);
      DateTime now = DateTime.now();
      if (now.compareTo(startDate) <= 0) {
        daysPassed = 0;
        comPtg = 0;
      } else if (now.compareTo(endDate) >= 0) {
        daysPassed = response.contract.noOfDays;
        comPtg = 1;
      } else {
        daysPassed = now.difference(startDate).inDays + 1;
        comPtg = daysPassed / response.contract.noOfDays;
      }
      loadingContractDetails.value = false;
      if (now.difference(endDate).inDays >= 15) showExtend = false;
      getContractPayables();
    } else
      errorLoadingContractDetails = response;
    loadingContractDetails.value = false;
  }

  var contractPayables = LandLordContractPayableModel();
  void getContractPayables() async {
    bool _isIntenetConnected = await BaseClientClass.isInternetConnected();
    if (!_isIntenetConnected) {
      Get.to(() => NoInternetScreen());
    }
    loadingContractPayables.value = true;
    contractPayables = LandLordContractPayableModel();
    sumOfAllPayments.value = '0.00';
    totalRentalPayment.value = '0.00';
    totalAdditionalCharges.value = '0.00';
    totalVatOnRent.value = '0.00';
    totalVatOnCharges.value = '0.00';
    try {
      var resp = await LandlordRepository.getContractPayable(
          SessionController().getContractID());

      if (resp is LandLordContractPayableModel) {
        print('Response Status ::::: ${resp.status}');
        if (resp.status == AppMetaLabels().notFound) {
          errorLoadingContractPayables.value = AppMetaLabels().noDatafound;
        } else {
          contractPayables = resp;
          removeZeroBalance();
          sumPayments();
          print('Sum Val ::::: ${sumOfAllPayments.value}');
          if (sumOfAllPayments.value == '0.00')
            errorLoadingContractPayables.value = AppMetaLabels().noDatafound;
        }
      } else {
        errorLoadingContractPayables.value = resp;
      }
    } catch (e) {
      print("This is the error from controller : $e");
    } finally {
      loadingContractPayables.value = false;
    }
  }

  void removeZeroBalance() {
    contractPayables.contractPayable.forEach((element) {
      if (element.balance == 0)
        contractPayables.contractPayable.remove(element);
    });
    contractPayables.additionalCharges.forEach((element) {
      if (element.balance == 0)
        contractPayables.contractPayable.remove(element);
    });
    contractPayables.vatCharges.forEach((element) {
      if (element.balance == 0)
        contractPayables.contractPayable.remove(element);
    });
    contractPayables.vatOnRent.forEach((element) {
      if (element.balance == 0)
        contractPayables.contractPayable.remove(element);
    });
  }

  void sumPayments() {
    double rentalSum = 0;
    double additionalSum = 0;
    double vatRentSum = 0;
    double vatChargesSum = 0;
    contractPayables.contractPayable.forEach((element) {
      rentalSum = rentalSum + element.balance;
    });
    contractPayables.additionalCharges.forEach((element) {
      additionalSum = additionalSum + element.balance;
    });
    contractPayables.vatCharges.forEach((element) {
      vatChargesSum = vatChargesSum + element.balance;
    });
    contractPayables.vatOnRent.forEach((element) {
      vatRentSum = vatRentSum + element.balance;
    });
    final amountFormat = NumberFormat('#,##0.00', 'AR');
    this.totalRentalPayment.value = amountFormat.format(rentalSum);
    this.totalAdditionalCharges.value = amountFormat.format(additionalSum);
    this.totalVatOnRent.value = amountFormat.format(vatRentSum);
    this.totalVatOnCharges.value = amountFormat.format(vatChargesSum);
    this.sumOfAllPayments.value = amountFormat
        .format(rentalSum + additionalSum + vatRentSum + vatChargesSum);
  }
}
