import 'package:contained_tab_bar_view_with_custom_page_navigator/contained_tab_bar_view_with_custom_page_navigator.dart';
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/amc-drop_dpwn_model.dart';
import 'package:fap_properties/data/models/vendor_models/installmment_drop_sown_model.dart';
import 'package:fap_properties/data/models/vendor_models/lpo_drop_down.dart';
import 'package:fap_properties/data/repository/vendor_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart' as mat;

class VendorInvoiceDetailsController extends GetxController {
  ////////////////
  // Main Info
  ///////////////
  mat.GlobalKey<ContainedTabBarViewState> key = mat.GlobalKey();
  RxBool isRefreshTheWholeTabs = false.obs;
  //
  RxBool isEnableInvoiceNo = false.obs;
  //
  RxInt tabIndex = 0.obs;
  //
  RxInt isServiceRqTypeRadioButtonVal = (-1).obs;
  //
  RxBool isLoading = false.obs;
  RxBool loadingData = false.obs;
  RxString error = "".obs;
  RxString errorLpo = "".obs;
  RxString errorAmc = "".obs;
  RxString errorInstallment = "".obs;
  RxString errorMainInfo = "".obs;
  //
  int caseNoInvoice = 0;
  String callerInvoice = '';
  int reqID = -1;
  //
  RxBool isEnableBackButton = true.obs;
  //
  RxString serviceNoError = ''.obs;
  RxString instNOError = ''.obs;
  RxString invoiceAmountError = ''.obs;
  RxString invoiceNoError = ''.obs;
  RxString tRNofLandlordError = ''.obs;
  RxString workCompletionError = ''.obs;
  RxString invoiceDateError = ''.obs;
  RxString serviceTypeError = ''.obs;
  RxString descriptionError = ''.obs;

  RxBool isShowListLPO = false.obs;
  RxBool isShowListAMC = false.obs;
  RxBool isShowListAMCIns = false.obs;

  Future<void> submitRequest(String paymenFor, srNo, instNo, invoiceAmount, trn,
      workCompletion, remrks, invoiceNo, invoiceDate, paymentTermID) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    var result;
    try {
      errorMainInfo.value = '';
      isLoading.value = true;
      result = await VendorRepository.saveInvoiceServiceRequest(
          paymenFor,
          srNo,
          instNo,
          invoiceAmount,
          trn,
          workCompletion,
          remrks,
          invoiceNo,
          invoiceDate,
          paymentTermID);
      isLoading.value = false;
      print('Result:::::+::::::::=> ${result['message']}');
      if (result['message'] != 'Added Successfully') {
        errorMainInfo.value = result['message'];
        SnakBarWidget.getSnackBarError('Error', result);
      } else {
        if (result['status'] == 'Ok') {
          isLoading.value = false;
          isEnableInvoiceNo.value = true;
          callerInvoice = 'Communication';
          caseNoInvoice = result['addServiceRequest']['caseNo'];
          reqID = result['requestID'];
          print('Request ID :::::::: ${result['requestID']}');
          print('Request ID :::::::: $reqID');
          print('Befor Move :::callerInvoice::: $callerInvoice');
          print('Befor Move :::caseNo::: $caseNoInvoice');
          key.currentState?.next();
          update();
        } else {
          isLoading.value = false;
          SnakBarWidget.getSnackBarErrorBlue(
            AppMetaLabels().error,
            result,
          );
          errorMainInfo.value = result;
          isLoading.value = false;
        }
      }
    } catch (e) {
      print('Result:::::+Catch::::::::=> $result');
      errorMainInfo.value = result;
      isLoading.value = false;
    }
  }

  Future<dynamic> getRequest(String caseNo) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    try {
      error.value = '';
      loadingData.value = true;
      var result = await VendorRepository.getInvoiceServiceRequest(caseNo);
      isLoading.value = false;
      print('Result ::::::::::: Controller :::: $result');
      if (result['status'] == 'Ok') {
        loadingData.value = false;
        isEnableInvoiceNo.value = true;
        update();
        return result;
      } else {
        loadingData.value = false;
        SnakBarWidget.getSnackBarErrorBlue(
          AppMetaLabels().error,
          result,
        );
        error.value = result;
        loadingData.value = false;
        return result;
      }
    } catch (e) {
      print('Exception  ::: Controller :: $e');
      loadingData.value = false;
    }
  }

  LpoDropDownModel lopsNoModelData = LpoDropDownModel();
  AmcDropDownModel aMCModelData = AmcDropDownModel();
  InstallmentDropDownModel installmentModelData = InstallmentDropDownModel();
  RxBool loadingDataOfInstallment = false.obs;
  RxInt selectedLopAmcDropDownVal = (-1).obs;
  RxDouble balanceAmountofSelectedInstallment = (-0.0).obs;
  RxDouble balanceAmountofSelectedLPO = (-0.0).obs;
  // RxInt balanceAmountofSelectedLPO = (-1).obs;
  RxString selectedInstallmentDropDownVal = ''.obs;
  RxString selectedInstallmentDropDownNo = ''.obs;
  Future getLpodropDownForInvoice() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    var result;
    try {
      error.value = '';
      loadingData.value = true;
      isLoading.value = true;
      result = await VendorRepository.getLpoDropDownForInvoice();
      isLoading.value = false;
      loadingData.value = false;

      if (result is LpoDropDownModel) {
        if (result.statusCode == '200') {
          lopsNoModelData = result;
          return lopsNoModelData;
        } else {
          errorLpo.value = AppMetaLabels().someThingWentWrong;
          return AppMetaLabels().someThingWentWrong;
        }
      } else {
        errorLpo.value = result;
        return result;
      }
    } catch (e) {
      errorLpo.value = result;
      isLoading.value = false;
      loadingData.value = false;
    }
  }

  Future<dynamic> getAMCdropDownForInvoice() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    var result;
    try {
      errorAmc.value = '';
      loadingData.value = true;
      result = await VendorRepository.getAMCropDownForInvoice();
      isLoading.value = false;
      loadingData.value = false;
      if (result is AmcDropDownModel) {
        if (result.statusCode == '200') {
          aMCModelData = result;
          return aMCModelData;
        } else {
          errorAmc.value = AppMetaLabels().someThingWentWrong;
          return AppMetaLabels().someThingWentWrong;
        }
      } else {
        errorAmc.value = result;
        return AppMetaLabels().someThingWentWrong;
      }
    } catch (e) {
      errorAmc.value = result;
      isLoading.value = false;
      loadingData.value = false;
    }
  }

  Future<dynamic> getAMCInstdropDownForInvoice(
      String contractRefNo, contractID) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    var result;
    try {
      errorInstallment.value = '';
      loadingDataOfInstallment.value = true;
      result = await VendorRepository.getAMCInstDropDownForInvoice(
          contractRefNo, contractID);
      loadingDataOfInstallment.value = false;
      if (result is InstallmentDropDownModel) {
        if (result.installmentData!.length == 0) {
          errorInstallment.value = AppMetaLabels().noDatafound;
          loadingDataOfInstallment.value = false;
          return AppMetaLabels().noDatafound;
        }
        if (result.statusCode == '200') {
          installmentModelData = result;
          update();
          return installmentModelData;
        } else {
          errorInstallment.value = AppMetaLabels().someThingWentWrong;
          loadingDataOfInstallment.value = false;
          return AppMetaLabels().someThingWentWrong;
        }
      } else {
        errorInstallment.value = result;
        loadingDataOfInstallment.value = false;
        return result;
      }
    } catch (e) {
      errorInstallment.value = result;
      loadingDataOfInstallment.value = false;
    }
  }

  ////////////////////////////////////////////////
}
