import 'dart:io';
import 'dart:typed_data';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../data/models/tenant_models/contract_payment_model.dart';
import '../../../../data/helpers/session_controller.dart';

class PaymentDownloadReceiptController extends GetxController {
  RxBool permissionGranted = false.obs;
  RxString savePath = "".obs;
  RxString url = "".obs;
  RxString completeUrl = "".obs;

  @override
  void onInit() {
    // getData();
    super.onInit();
  }

  // SessionController().setUrl(paymentDownloadReceipt.value.path);

  void downloadReceipt(Payment payment) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    payment.downloadingReceipt!.value = true;
    SessionController().setTransactionId(payment.transactionId.toString());
    var result = await TenantRepository.paymentsDownloadReceipt();
    print('Condition ::::====>>>>>:::::::=> ${(result is Uint8List)}');
    if (result is Uint8List) {
      // ###1 permission
      // if (await getStoragePermission()) {
      String path = await createPdf(result, payment.receiptNo ?? "");
      print('path ::::====>>>>>:::::::=> $path');
      try {
        print('path ::TRY::====>>>>>:::::::=> $path');
        OpenFile.open(path)
            .then((value) => print('path ::TRY::====>>>>>:::::::=> Done'));
      } catch (e) {
        print(e);
        print('path ::Catch::====>>>>>:::::::=> $e');
        Get.snackbar(
          AppMetaLabels().error,
          e.toString(),
          backgroundColor: AppColors.white54,
        );
        // }
      }
    } else {
      Get.snackbar(
        AppMetaLabels().error,
        result.toString(),
        backgroundColor: AppColors.white54,
      );
    }
    payment.downloadingReceipt!.value = false;
  }

  Future<bool> getStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      return true;
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      return await openAppSettings();
    } else if (await Permission.storage.request().isDenied) {
      return false;
    }
    return false;
  }

  Future<String> createPdf(Uint8List data, String receiptNo) async {
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/receipt$receiptNo.pdf");
    await file.writeAsBytes(data.buffer.asUint8List());
    return "${output.path}/receipt$receiptNo.pdf";
  }
}
