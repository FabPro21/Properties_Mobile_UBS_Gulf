import 'package:fap_properties/views/vendor/lpos/lpos_screen_controller.dart';
import 'package:fap_properties/views/vendor/vendor_contracts/vendor_contracts_controller.dart';
import 'package:fap_properties/views/vendor/vendor_dashboard/vendor_dashboard_screen/vendor_dashboard_controller.dart';
import 'package:get/get.dart';

class VendorDashboardTabsController extends GetxController {
  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    Get.lazyPut(() => VendorDashboardController());
    Get.lazyPut(() => VendorContractsController());
    Get.lazyPut(() => GetAllLpoController());
    super.onInit();
  }

  void setIndex(int index) {
    selectedIndex.value = index;
  }
}
