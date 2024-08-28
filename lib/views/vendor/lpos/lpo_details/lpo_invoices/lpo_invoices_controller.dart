import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/lpo_invoices_model.dart';
import 'package:fap_properties/data/repository/vendor_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class LpoInvoicesController extends GetxController {
  Rx<LpoInvoicesModel> getLpoInvoices = LpoInvoicesModel().obs;
  RxBool scrolling = false.obs;
  RxBool loadingData = false.obs;
  RxString error = ''.obs;
  int length = 0;

  @override
  void onInit() {
    lpoInvoices();
    super.onInit();
  }

  void lpoInvoices() async {
    loadingData.value = true;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }

    var result = await VendorRepository.lpoInvoices();
    if (result is LpoInvoicesModel) {
      getLpoInvoices.value = result;
      if (getLpoInvoices.value.status == AppMetaLabels().notFound) {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
      } else {
        getLpoInvoices.value = result;
        length = getLpoInvoices.value.invoice!.length;
        update();
        loadingData.value = false;
      }
    } else {
      error.value = AppMetaLabels().noDatafound;
      loadingData.value = false;
    }
  }
}
