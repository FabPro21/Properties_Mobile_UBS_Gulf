import 'dart:io';
import 'dart:typed_data';

import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_tabs.dart/tenant_contracts_details.dart/tenant_contracts_detail_controller.dart';
import 'package:fap_properties/views/tenant/tenant_New_contract/contracts_new_action/contracts_new_actions_controller.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class AuthenticateNewContractController extends GetxController {
  RxBool gettingCaseNo = false.obs;
  String errorGettingCaseNo = '';
  RxInt emirateId = (-1).obs;
  // int caseNo;
  RxBool savingSignature = false.obs;

  RxBool loadingTerms = false.obs;

  void getTerms(int contractId, String contractNo) async {
    loadingTerms.value = true;
    var resp = await TenantRepository.downloadContractTerms(contractId);
    // var resp = await TenantRepository.downloadContractTermsNew(contractId);
    loadingTerms.value = false;
    if (resp is Uint8List) {
      if (await getStoragePermission()) {
        String path = await createFile(resp, 'TC$contractNo.pdf');
        print(path);
        OpenFile.open(path);
      }
    } else {
      Get.snackbar(
        AppMetaLabels().error,
        resp.toString(),
        backgroundColor: AppColors.white54,
      );
    }
  }

  Future<bool> saveSignature(Uint8List signature, int dueActionId, int stageId,
      String caller, int caseId) async {
    savingSignature.value = true;
    if (await getStoragePermission()) {
      String path = await createFile(signature, 'signature.png');
      if (path != null) {
        var resp = await TenantRepository.uploadFile(
            caseId.toString(), path, 'Signature', '', '0');
        // var resp = await TenantRepository.uploadFileNew(
        //     caseId.toString(), path, 'Signature', '', '0');
        if (resp is int) {
          Get.snackbar(AppMetaLabels().error, AppMetaLabels().anyError,
              backgroundColor: Colors.white54);
        } else {
          savingSignature.value = false;
          return await updateDocStage(dueActionId, 7, caller);
        }
      } else {
        Get.snackbar(AppMetaLabels().error, AppMetaLabels().anyError,
            backgroundColor: Colors.white54);
      }
    } else {
      Get.snackbar(AppMetaLabels().error, AppMetaLabels().storagePermissions,
          backgroundColor: Colors.white54);
    }
    savingSignature.value = false;
    return false;
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

  Future<String> createFile(Uint8List data, String name) async {
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/$name");
    await file.writeAsBytes(data.buffer.asUint8List());
    return file.path;
  }

  RxBool updatingStage = false.obs;
  bool errorUpdatingStage = false;
  Future<bool> updateDocStage(
      int dueActionId, int stageId, String caller) async {
    updatingStage.value = true;
    errorUpdatingStage = false;
    savingSignature.value = true;
    final resp = await TenantRepository.updateContractStageSignContract(
        dueActionId, stageId);
    // final resp = await TenantRepository.updateContractStageSignContractNew(
    //     dueActionId, stageId);
    updatingStage.value = false;
    print('::::::::Data From updateContractStageSignContract ::::::::::');
    print('Response::::: ${resp['message']}');
    print('Response::::: ${resp['status']}');
    print('Response::::: ${resp['emirateId']}');
    print('Response::::: ${resp['statusCode']}');
    print(resp['statusCode'] == 200);
    print(resp['statusCode'].toString().trim() == '200');
    print('::::::::Data From updateContractStageSignContract ::::::::::');
    // if (resp['statusCode'] == 200) {
    if (resp['statusCode'].toString().trim() == '200') {
      emirateId.value = resp['emirateId'];
      print('EmirateId::::: ${resp['emirateId']}');
      if (caller == 'contract') {
        final contractController = Get.find<GetContractsDetailsController>();
        contractController.getData();
      }
      final contractsEndActionsController =
          Get.put(ContractEndActionsController());
      contractsEndActionsController.getContractsNew();
      Get.back();
      savingSignature.value = true;
      // Get.off(() => MunicipalApproval(caller: caller, dueActionId: dueActionId));
      return true;
    } else if (resp is String) {
      savingSignature.value = true;
      Get.snackbar(AppMetaLabels().error, resp,
          backgroundColor: AppColors.white54);
      errorUpdatingStage = true;
      return false;
    }
    return false;
  }
}
