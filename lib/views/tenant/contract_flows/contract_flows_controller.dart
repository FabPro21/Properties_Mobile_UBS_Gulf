import 'package:get/get.dart';

class ContractFlowsTabsController extends GetxController {
  RxInt tabIndex = 0.obs;
  var loadingContract = true.obs;
  RxString errorLoadingContract = "".obs;
  RxBool isEnableScreen = true.obs;

  @override
  void onInit() {
    super.onInit();
  }
}
