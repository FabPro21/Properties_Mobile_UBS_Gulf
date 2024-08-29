import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:get/get.dart';

import '../../../../../../data/models/tenant_models/contract_payment_cheque_models.dart';
import '../../../../../../data/models/tenant_models/contract_payment_model.dart';

class TenantPaymentDetailsController extends GetxController {
  var getcheque = GetContractChequesModel().obs;
  var paymentAmount = "0.0".obs;

  var loadingData = true.obs;
  int length = 0;
  RxString onSearch = "".obs;

  RxString error = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  getCheque(Payment payment) async {
    loadingData.value = true;
    var result =
        await TenantRepository.getCheque(payment.transactionId.toString());

    if (result is GetContractChequesModel) {
      if (getcheque.value.status == AppMetaLabels().notFound) {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
      } else {
        getcheque.value = result;
        length = getcheque.value.transactionCheque!.length;
        update();
        loadingData.value = false;
      }
    } else {
      error.value = AppMetaLabels().noDatafound;
      loadingData.value = false;
    }
  }
}
