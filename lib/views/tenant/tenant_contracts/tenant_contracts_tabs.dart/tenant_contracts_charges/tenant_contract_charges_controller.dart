import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/get_contract_charges_model.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GetContractChargesController extends GetxController {
  var getCharges = GetContractChargesModel().obs;

  var loadingData = true.obs;
  int length = 0;
  RxString onSearch = "".obs;
  dynamic totalCharges;
  RxDouble paidCharges = 0.0.obs;
  RxDouble outstandingCharges = 0.0.obs;
  RxString totalChargesCurrency = "0.0".obs;
  RxString paidChargesCurrency = "0.0".obs;
  RxString outstandingChargesCurrency = "0.0".obs;
  RxString error = "".obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    // try {
    loadingData.value = true;
    var result = await TenantRepository.getCharges();
    if (result is GetContractChargesModel) {
      if (getCharges.value.status == AppMetaLabels().notFound) {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
      } else {
        getCharges.value = result;
        length = getCharges.value.contractCharges.length;
        totalCharges = getCharges.value.totalCharges;

        double am = double.parse(getCharges.value.totalCharges.toString());
        final paidFormatter = NumberFormat('#,##0.00', 'AR');
        totalChargesCurrency.value = paidFormatter.format(am);

        double p = getCharges.value.paidCharges;
        final paidcharges = NumberFormat('#,##0.00', 'AR');
        paidChargesCurrency.value = paidcharges.format(p);

        var o = getCharges.value.outstandingCharges;
        final oCharges = NumberFormat('#,##0.00', 'AR');
        outstandingChargesCurrency.value = oCharges.format(o);

        outstandingCharges.value =
            double.parse(getCharges.value.outstandingCharges.toString());
        paidCharges.value = getCharges.value.paidCharges;

        update();
        loadingData.value = false;
      }
    } else {
      error.value = AppMetaLabels().noDatafound;
      loadingData.value = false;
    }
  }
}
