import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/contract_payment_model.dart';
import 'package:fap_properties/data/models/tenant_models/unverified_contract_payments.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

import '../../../../../data/models/tenant_models/contract_payment_cheque_models.dart';

class ContractPaymentsController extends GetxController {
  ContractPaymentModel payments = ContractPaymentModel();
  var loadingData = true.obs;
  int length = 0;
  RxString onSearch = "".obs;
  RxString error = "".obs;

  UnverifiedContractPayments unverifiedPayments = UnverifiedContractPayments();
  RxBool loadingUnverified = true.obs;
  String errorLoadingUnverified = '';

  @override
  void onInit() {
    getData();
    getUnverifiedPayments();
    super.onInit();
  }

  getData() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      loadingData.value = true;
      error.value = '';
      var result = await TenantRepository.contractPayments();
      if (result is ContractPaymentModel) {
        if (payments.status == AppMetaLabels().notFound) {
          error.value = AppMetaLabels().noDatafound;
        } else {
          payments = result;

          length = payments.payments.length;

          for (int i = 0; i < length; i++) {
            print(
                'Cheque Api Condition : paymentType :: ${payments.payments[i].paymentType.trim().toLowerCase()}');
            print(
                'Cheque Api Condition : TID :: ${payments.payments[i].transactionId}');
          }
        }
      } else {
        error.value = AppMetaLabels().noDatafound;
      }
    } catch (e) {
      error.value = AppMetaLabels().someThingWentWrong;
      print("this is the error from controller= $e");
    }
    loadingData.value = false;
  }

  getUnverifiedPayments() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      loadingUnverified.value = true;
      errorLoadingUnverified = '';
      var result = await TenantRepository.getUnverifiedPayments();

      if (result is UnverifiedContractPayments) {
        if (result.contractPayments.isEmpty) {
          errorLoadingUnverified = AppMetaLabels().noDatafound;
        } else {
          unverifiedPayments = result;
        }
      } else {
        errorLoadingUnverified = result;
      }
    } catch (e) {
      errorLoadingUnverified = AppMetaLabels().someThingWentWrong;
    }
    loadingUnverified.value = false;
  }

  getCheque(int index) async {
    payments.payments[index].loadingCheque.value = true;
    payments.payments[index].errorLoadingCheque = '';
    var result = await TenantRepository.getCheque(
        payments.payments[index].transactionId.toString());
    if (result is GetContractChequesModel) {
      if (result.status == AppMetaLabels().notFound) {
        payments.payments[index].errorLoadingCheque =
            AppMetaLabels().noDatafound;
      } else {
        payments.payments[index].cheque = result;
      }
    } else {
      payments.payments[index].errorLoadingCheque = AppMetaLabels().noDatafound;
    }
    payments.payments[index].loadingCheque.value = false;
  }
}
