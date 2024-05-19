import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/contract_invoices_model.dart';
import 'package:fap_properties/data/repository/vendor_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class ContractInvoicesController extends GetxController {
  var contractInvoices = ContractInvoicesModel().obs;

  var loadingData = true.obs;
  int length = 0;
  RxString onSearch = "".obs;
  RxString error = "".obs;

  @override
  void onInit() {
    // getData();
    super.onInit();
  }

  getData() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    // try {
    loadingData.value = true;
    var result = await VendorRepository.contractInvoices();
    if (result is ContractInvoicesModel) {
      contractInvoices.value = result;
      if (contractInvoices.value.status == AppMetaLabels().notFound) {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
      } else {
        contractInvoices.value = result;
        length = contractInvoices.value.invoice.length;
        update();
        loadingData.value = false;
      }
    } else {
      error.value = AppMetaLabels().noDatafound;
      loadingData.value = false;
    }
    // } catch (e) {
    //   loadingData.value = false;
    //   print("this is the error from controller= $e");
    // }
  }
}
