import 'dart:io';
import 'dart:typed_data';
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/contract_with_due_action.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class ContractEndActionsController extends GetxController {
  List<ContractWithDueAction> contractsList = [];
  RxBool loadingContracts = false.obs;
  String errorLoadingContracts = '';
  RxBool isEnableScreen = true.obs;

  void getContractsNew() async {
    print('Calling new flow :: getContractsNew');
    loadingContracts.value = true;
    errorLoadingContracts = '';
    // final response = await TenantRepository.getNewActions();
    final response = await TenantRepository.getRenewalActions();
    if (response is List<ContractWithDueAction>) {
      contractsList = response;
      makingFalsForToolTip();
    } else
      errorLoadingContracts = response;
    loadingContracts.value = false;
  }

  RxBool isShowCustomToolTip = true.obs;
  makingFalsForToolTip() async {
    await Future.delayed(Duration(seconds: 5));
    isShowCustomToolTip.value = false;
  }

  downloadOfferLetter(ContractWithDueAction contract) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    contract.downloading!.value = true;
    var result =
        await TenantRepository.downloadOfferLetter(contract.contractid??0);

    contract.downloading!.value = false;
    if (result is Uint8List) {
      if (await getStoragePermission()) {
        String path = await createPdf(result, contract.contractno??'');
        try {
          Get.back();
          OpenFile.open(path);
        } catch (e) {
          Get.back();
          print(e);
          Get.snackbar(
            AppMetaLabels().error,
            e.toString(),
            backgroundColor: AppColors.white54,
          );
        }
      }
    } else {
      Get.snackbar(
        AppMetaLabels().error,
        AppMetaLabels().noFileReceived,
        backgroundColor: AppColors.white54,
      );
    }

    return null;
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
