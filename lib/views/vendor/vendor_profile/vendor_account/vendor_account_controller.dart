import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/repository/vendor_repository.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:flutter/material.dart';

import 'package:fap_properties/data/models/vendor_models/get_vendor_accounts_model.dart';
import 'package:get/get.dart';

class VendorAccountController extends GetxController {
  Rx<GetVendorAccountsModel> getVendorAccountsModel =
      GetVendorAccountsModel().obs;
  RxBool loading = false.obs;
  RxString error = ''.obs;

  List<Color> colors = [
    Colors.blue,
    Colors.purple,
    Colors.red,
    Colors.yellow,
    Colors.green
  ];

  @override
  void onInit() {
    getVendorAccounts();
    super.onInit();
  }

  void getVendorAccounts() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    error.value = '';
    loading.value = true;
    var resp = await VendorRepository.getVendorAccounts();
    loading.value = false;
    if (resp is GetVendorAccountsModel) {
      getVendorAccountsModel.value = resp;
    } else
      error.value = resp;
  }

  String getMaskedString(String text) {
    if (text == null) return '';
    String mask = '';
    for (int i = 4; i < text.length - 4; i++) mask = mask + '*';
    return text.substring(0, 4) +
        mask +
        text.substring(text.length - 4, text.length);
  }
}
