import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_controller.dart';
import 'package:fap_properties/views/tenant/tenant_notifications/tenant_notifications_controller.dart';
import 'package:get/get.dart';

import '../../tenant_payments/tenant_payments_controller.dart';
import '../tenant_dashboard_get_data_controller.dart';

class TenantDashboardTabsController extends GetxController {
  RxInt selectedIndex = 0.obs;
  @override
  void onInit() {
    Get.lazyPut(() => TenantDashboardGetDataController());
    Get.lazyPut(() => GetTenantNotificationsController());
    Get.lazyPut(() => GetContractsController());
    Get.lazyPut(() => TenantPaymentsController());
    super.onInit();
  }

  void setIndex(int index) {
    selectedIndex.value = index;
  }
}
