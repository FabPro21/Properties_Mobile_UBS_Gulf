import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_profile/tenant_profile_model.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_profile/tenant_profile_update_model.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/utils/constants/global_preferences.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class TenantProfileController extends GetxController {
  var tenantProfile = TenantProfileModel().obs;
  var updateProfiledata = TenantUpdateProfileModel().obs;

  var loadingData = true.obs;
  RxString error = "".obs;
  var loadingUpdate = false.obs;
  RxString errorUpdate = "".obs;

  RxBool loadingCanEdit = true.obs;
  int caseNo;

  @override
  void onInit() {
    getData();
    canEditProfile();
    super.onInit();
  }

  getData() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      loadingData.value = true;
      var result = await TenantRepository.tenantProfile();
      if (result is TenantProfileModel) {
        if (tenantProfile.value.status == AppMetaLabels().notFound) {
          error.value = AppMetaLabels().noDatafound;
          loadingData.value = false;
        } else {
          tenantProfile.value = result;
          // saveUserNameLocally(tenantProfile.value);
          update();
          loadingData.value = false;
        }
      } else {
        // error.value = AppMetaLabels().noDatafound;
        error.value = result;
        loadingData.value = false;
      }
    } catch (e) {
      loadingData.value = false;
      print("this is the error from controller= $e");
    }
  }

  void saveUserNameLocally(TenantProfileModel tenantProfile) async {
    GlobalPreferencesEncrypted.setString(
      GlobalPreferencesLabels.userName,
      tenantProfile.profile.name ?? "",
    );

    GlobalPreferencesEncrypted.setString(
      GlobalPreferencesLabels.userNameAr,
      tenantProfile.profile.nameAr ?? "",
    );
  }

  Future<void> setUserName() async {
    String name = await GlobalPreferencesEncrypted.getString(
        GlobalPreferencesLabels.userName);
    SessionController().setUserName(name);
    String nameAr = await GlobalPreferencesEncrypted.getString(
        GlobalPreferencesLabels.userNameAr);
    SessionController().setUserNameAr(nameAr);
  }

  void canEditProfile() async {
    loadingCanEdit.value = true;
    var resp = await TenantRepository.canEditProfile();
    if (resp is int) {
      caseNo = resp;
    }
    loadingCanEdit.value = false;
    // canUpdateProfile=false;
  }

  Future<bool> updateProfile(
      String name, String mobileNo, String email, String address) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      loadingUpdate.value = true;
      var result =
          await TenantRepository.updateProfile(name, mobileNo, email, address);

      loadingUpdate.value = false;
      if (result is TenantUpdateProfileModel) {
        if (result.status == "Ok") {
          updateProfiledata.value = result;
          caseNo = result.addServiceRequest.caseNo;
          loadingCanEdit.value = true;
          loadingCanEdit.value = false;
          return true;
        } else {
          Get.snackbar(AppMetaLabels().error, result.message);
          return false;
        }
      } else {
        Get.snackbar(AppMetaLabels().error, AppMetaLabels().someThingWentWrong);
        errorUpdate.value = AppMetaLabels().noDatafound;
        return false;
      }
    } catch (e) {
      loadingUpdate.value = false;
      print("this is the error from controller= $e");
      return false;
    }
  }
}
