import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../data/helpers/base_client.dart';
import '../../../data/models/public_models/public_profile/public_get_profile_model.dart';
import '../../../data/repository/public_repository.dart';
import '../../../utils/constants/meta_labels.dart';
import '../../public_views/search_properties_dashboard_tabs/search_properties_dashboard_tabs.dart';
import '../../common/no_internet_screen.dart';

class PublicLoginController extends GetxController {
  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();

  @override
  void onInit() {
    getPublicProfile();
    super.onInit();
  }

  RxBool loadingProfile = false.obs;
  String errorLoadingProfile = '';
  PublicGetProfileModel profileData;
  bool canSkip = true;
  RxBool updateEnabled = false.obs;

  getPublicProfile() async {
    loadingProfile.value = true;
    errorLoadingProfile = '';
    bool _isIntenetConnected = await BaseClientClass.isInternetConnected();
    if (!_isIntenetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    try {
      var resp = await PublicRepositoryDrop2.getProfile();
      if (resp is PublicGetProfileModel) {
        profileData = resp;
        nameTextController.text = resp.profileDetail.fullName;
        emailTextController.text = resp.profileDetail.email;
        profileData.profileDetail.mobile =
            getPhone(profileData.profileDetail.mobile);
        if (profileData.profileDetail.fullName == null &&
            profileData.profileDetail.fullNameAr == null) {
          canSkip = false;
        }
      } else {
        errorLoadingProfile = resp;
      }
    } finally {
      loadingProfile.value = false;
    }
  }

  RxBool updatingProfile = false.obs;

  // 112233 updateProfile with updateProfile2 api
  Future<void> updateProfile() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      updatingProfile.value = true;
      var result = await PublicRepositoryDrop2.updateProfile2(
        nameTextController.text,
        emailTextController.text,
      );

      updatingProfile.value = false;
      if (result == "Ok") {
        Get.snackbar(
            AppMetaLabels().success, AppMetaLabels().updatedSuccessfully,
            backgroundColor: AppColors.white54);
        SessionController().setUserName(nameTextController.text);
        Get.offAll(() => SearchPropertiesDashboardTabs());
      } else {
        Get.snackbar(AppMetaLabels().error, result);
      }
    } catch (e) {}
  }

  String getPhone(String phone) {
    var length = phone.length;
    var first = phone.substring(0, 5);
    var last = phone.substring(length - 3, length);
    return first + "****" + last;
  }
}
