import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/auth_models/verify_user_otp_model.dart';
import 'package:fap_properties/data/repository/public_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

import '../../../../data/models/public_models/public_profile/public_get_profile_model.dart';
import '../../../../data/models/public_models/public_profile/public_update_model.dart';
import '../../../../utils/styles/colors.dart';

class PublicProfileController extends GetxController {
  var getProfiledata = PublicGetProfileModel().obs;
  var updateProfileData = PublicUpdateProfileModel().obs;
  RxBool canEditLoading = false.obs;
  RxString canEditError = "".obs;
  RxBool profileLoading = false.obs;
  RxString profileError = "".obs;
  RxBool loadingUpdate = false.obs;
  RxString errorUpdate = "".obs;
  // bool canUpdateProfile = false;
  int caseNo = 0;

  @override
  void onInit() {
    // getPublicProfile();
    // canEditProfile();
    super.onInit();
  }

  getPublicProfile() async {
    profileLoading.value = true;
    bool _isIntenetConnected = await BaseClientClass.isInternetConnected();
    if (!_isIntenetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    try {
      var resp = await PublicRepositoryDrop2.getProfile();
      if (resp is PublicGetProfileModel) {
        getProfiledata.value = resp;
        profileLoading.value = false;
      } else {
        profileError.value = resp;
        profileLoading.value = false;
      }
    } catch (e) {
      profileLoading.value = false;
      print("this is the error from controller= $e");
    }
  }

  void canEditProfile() async {
    canEditLoading.value = true;
    var resp = await PublicRepositoryDrop2.canEditProfile();

    if (resp is int) {
      caseNo = resp;
      canEditLoading.value = false;
    } else {
      canEditLoading.value = false;
    }
  }

  Future<bool> updateProfile(String name, String mobileNo, String email) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      loadingUpdate.value = true;
      var result = await PublicRepositoryDrop2.updateProfile(
        name,
        mobileNo,
        email,
      );

      loadingUpdate.value = false;
      if (result is PublicUpdateProfileModel) {
        if (result.status == "Ok") {
          updateProfileData.value = result;
          caseNo = result.addServiceRequest!.caseNo??0;
          return true;
        } else {
          Get.snackbar(AppMetaLabels().error, result.message??"",
              backgroundColor: AppColors.white54);
          return false;
        }
      } else {
        // Get.snackbar(AppMetaLabels().error, AppMetaLabels().someThingWentWrong,
        //     backgroundColor: AppColors.white54);
        errorUpdate.value = AppMetaLabels().noDatafound;
        return false;
      }
    } catch (e) {
      loadingUpdate.value = false;
      print("this is the error from controller= $e");
      return false;
    }
  }

  // New
  // updatePublicProfile
  // In this func we are just update user name and email without creating any case
  // It is only for public user(New user)
  // The purpose of this logic is to avoid dumny name & email like Guest(+971***0) or Guest(+971***0)@fablive.com
  // this func will call after GenerateFirebaseUserToken end point
  RxBool loadingUpdatePublicProfile = false.obs;
  RxString errorUpdatePublicProfile = "".obs;
  var updateUserModel = User();
  Future<dynamic> updatePublicProfile(
      String name, String userID, String email) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      errorUpdatePublicProfile.value = '';
      loadingUpdatePublicProfile.value = true;
      var result = await PublicRepositoryDrop2.updatePublicProfile(
        name,
        userID,
        email,
      );
      loadingUpdatePublicProfile.value = false;
      if (result is User) {
        updateUserModel = result;
        return updateUserModel;
      } else {
        errorUpdatePublicProfile.value = AppMetaLabels().noDatafound;
        return false;
      }
    } catch (e) {
      loadingUpdatePublicProfile.value = false;
      errorUpdatePublicProfile.value = AppMetaLabels().someThingWentWrong;
      print("this is the error from controller= $e");
      return false;
    }
  }
}
