import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

import '../../../../data/models/tenant_models/contract_payment_model.dart';

class TenantPaymentsController extends GetxController {
  var getPayments = ContractPaymentModel().obs;

  var loadingData = true.obs;
  int length = 0;
  RxString error = "".obs;

  @override
  void onInit() {
    // getData();
    super.onInit();
  }

  RxBool isSearch = false.obs;
  searchDataByApi(String pageNoP, String searchText) async {
    try {
      bool _isInternetConnected = await BaseClientClass.isInternetConnected();
      if (!_isInternetConnected) {
        await Get.to(NoInternetScreen());
      }
      error.value = '';
      errorNoMoreData.value = '';
      loadingData.value = true;
      var result = await TenantRepository.paymentsSearch(
        pageNoP,
        searchText,
      );
      if (result is ContractPaymentModel) {
        getPayments.value = result;
        isSearch.value = true;
        if (getPayments.value.status == AppMetaLabels().notFound) {
          error.value = AppMetaLabels().noDatafound;
          loadingData.value = false;
        } else {
          List<Payment> _searchedPayments = [];
          for (int i = 0; i < getPayments.value.payments.length; i++) {
            _searchedPayments.add(getPayments.value.payments[i]);
          }
          payments = _searchedPayments;
          if (payments.length == 0)
            error.value = AppMetaLabels().noPaymentFound;
          else
            error.value = '';
          loadingData.value = false;
        }
      } else {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
      }
      update();
    } catch (e) {
      loadingData.value = false;
      print("this is the error from controller= $e");
    }
  }

  String pageNo = '1';
  getData(String pageNoP) async {
    try {
      bool _isInternetConnected = await BaseClientClass.isInternetConnected();
      if (!_isInternetConnected) {
        await Get.to(NoInternetScreen());
      }
      error.value = '';
      errorNoMoreData.value = '';
      loadingData.value = true;
      var result = await TenantRepository.paymentsPagination(pageNoP);
      isSearch.value = false;
      if (result is ContractPaymentModel) {
        getPayments.value = result;
        if (getPayments.value.status == AppMetaLabels().notFound) {
          error.value = AppMetaLabels().noDatafound;
          loadingData.value = false;
        } else {
          getPayments.value = result;
          payments = result.payments;
          update();
          loadingData.value = false;
        }
      } else {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
      }
      update();
    } catch (e) {
      loadingData.value = false;
      print("this is the error from controller= $e");
    }
  }

  var loadingDataMore = false.obs;
  RxString errorNoMoreData = ''.obs;
  getData1(String pageNoP) async {
    try {
      bool _isInternetConnected = await BaseClientClass.isInternetConnected();
      if (!_isInternetConnected) {
        await Get.to(NoInternetScreen());
      }
      errorNoMoreData.value = '';
      loadingDataMore.value = true;
      var result = await TenantRepository.paymentsPagination(pageNoP);
      isSearch.value = false;
      if (result is ContractPaymentModel) {
        getPayments.value = result;
        if (getPayments.value.status == AppMetaLabels().notFound) {
          errorNoMoreData.value = AppMetaLabels().noDatafound;
          loadingDataMore.value = false;
        } else {
          for (int i = 0; i < getPayments.value.payments.length; i++) {
            payments.add(getPayments.value.payments[i]);
          }
          // getPayments.value = result;
          update();
          loadingDataMore.value = false;
        }
      } else {
        errorNoMoreData.value = AppMetaLabels().noDatafound;
        loadingDataMore.value = false;
      }
      update();
    } catch (e) {
      loadingDataMore.value = false;
      print("this is the error from controller= $e");
    }
  }

  List<Payment> payments = [Payment()].obs;
  searchData(String qry) {
    if (getPayments.value.payments != null) {
      loadingData.value = true;
      List<Payment> _searchedPayments = [];
      for (int i = 0; i < getPayments.value.payments.length; i++) {
        if (getPayments.value.payments[i].receiptNo.contains(qry) ||
            getPayments.value.payments[i].contractNo.contains(qry)) {
          _searchedPayments.add(getPayments.value.payments[i]);
        }
      }
      payments = _searchedPayments;
      if (payments.length == 0)
        error.value = AppMetaLabels().noPaymentFound;
      else
        error.value = '';
      loadingData.value = false;
    }
  }
}
