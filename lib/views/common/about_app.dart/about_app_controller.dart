import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutAppController extends GetxController {
  RxString version = ''.obs;
  RxString buildNo = ''.obs;
  RxString packageName = ''.obs;

  @override
  void onInit() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      version.value = packageInfo.version;
      buildNo.value = packageInfo.buildNumber;
      packageName.value = packageInfo.packageName;
    });
    super.onInit();
  }
}
