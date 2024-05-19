import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/get_lpo_services_model.dart';
import 'package:fap_properties/data/repository/vendor_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GetLpoServicesController extends GetxController {
  var lpoServices = GetLpoServicesModel().obs;
  var loadingData = false.obs;
  RxString onSearch = "".obs;
  RxString error = "".obs;
  int length = 0;
  RxDouble totalAmountSum = 0.0.obs;

  RxString totalAmount = "0.0".obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    // try {
    loadingData.value = true;
    var result = await VendorRepository.getLposService();
    if (result is GetLpoServicesModel) {
      lpoServices.value = result;
      if (lpoServices.value.status == AppMetaLabels().notFound) {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
      } else {
        lpoServices.value = result;
        length = lpoServices.value.lpoServices.length;

        totalAmountSum.value = 0.0;
        lpoServices.value.lpoServices.forEach((element) {
          totalAmountSum.value = totalAmountSum.value + element.totalAmount;
        });
        var ta = totalAmountSum.value;
        final tFormatter = NumberFormat('#,##0.00', 'AR');
        totalAmount.value = tFormatter.format(ta);
        update();
        loadingData.value = false;
      }
    } else {
      error.value = AppMetaLabels().noDatafound;
      loadingData.value = false;
    }

    update();
    loadingData.value = false;
    // } catch (e) {
    //   loadingData.value = false;
    //   print("this is the error from controller= $e");
    // }
  }
}
