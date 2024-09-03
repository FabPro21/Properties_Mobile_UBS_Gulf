import 'dart:io';
import 'dart:typed_data';
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ContractDownloadController extends GetxController {
  RxBool downloading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<String> downloadContract(String contractNo, bool save) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }

    downloading.value = true;
    var result = await TenantRepository.contractDownload();

    downloading.value = false;
    if (result is Uint8List) {
      // ###1 permission
      // if (await getStoragePermission()) {
      String path = await createPdf(result, contractNo);
      if (save) {
        try {
          OpenFile.open(path);
        } catch (e) {
          print(e);
          Get.snackbar(
            AppMetaLabels().error,
            e.toString(),
            backgroundColor: AppColors.white54,
          );
        }
      } else {
        return path;
      }
      // }
    } else {
      print('::::::::: Result ::::::::::');
      print(result);
      if (result.toString().contains('No data found')) {
        Get.snackbar(
          AppMetaLabels().error,
          result,
          backgroundColor: AppColors.white54,
        );
      } else {
        Get.snackbar(
          AppMetaLabels().error,
          result,
          backgroundColor: AppColors.white54,
        );
      }
    }

    return '';
  }

  Future<String> downloadContractNew(String contractNo, bool save) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }

    downloading.value = true;
    var result = await TenantRepository.contractDownload();
    // var result = await TenantRepository.contractDownloadNew();

    downloading.value = false;
    if (result is Uint8List) {
      // ###1 permission
      // if (await getStoragePermission()) {
      String path = await createPdf(result, contractNo);
      if (save) {
        try {
          OpenFile.open(path);
        } catch (e) {
          print(e);
          Get.snackbar(
            AppMetaLabels().error,
            e.toString(),
            backgroundColor: AppColors.white54,
          );
        }
      } else {
        return path;
      }
      // }
    } else {
      print('::::::::: Result ::::::::::');
      print(result);
      if (result.toString().contains('No data found')) {
        Get.snackbar(
          AppMetaLabels().error,
          result,
          backgroundColor: AppColors.white54,
        );
      } else {
        Get.snackbar(
          AppMetaLabels().error,
          result,
          backgroundColor: AppColors.white54,
        );
      }
    }

    return '';
  }

  Future<bool> downloadSignedContract(String contractNo, int contractId) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    downloading.value = true;
    var result = await TenantRepository.downloadSignedContract(contractId);

    downloading.value = false;
    if (result is Uint8List) {
      // ###1 permission
      // if (await getStoragePermission()) {
      String path = await createPdf(result, contractNo);
      try {
        OpenFile.open(path);
      } catch (e) {
        print(e);
        Get.snackbar(
          AppMetaLabels().error,
          e.toString(),
          backgroundColor: AppColors.white54,
        );
      }
      // }
      return true;
    } else {
      Get.snackbar(
        AppMetaLabels().error,
        AppMetaLabels().noFileReceived,
        backgroundColor: AppColors.white54,
      );
      return false;
    }
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

  Future<String> createPdf(Uint8List data, String contractNo) async {
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/contract$contractNo.pdf");
    await file.writeAsBytes(data.buffer.asUint8List());
    return "${output.path}/contract$contractNo.pdf";
  }
}
