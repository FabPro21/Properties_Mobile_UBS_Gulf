import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/global_preferences.dart';
import 'package:fap_properties/views/auth/otp_firebase/validate_user_fb.dart';
import 'package:fap_properties/views/auth/select_role/select_role_screen.dart';
import 'package:fap_properties/views/auth/validate_user/validate_user_screen.dart';
import 'package:fap_properties/views/choose_language/update_user_language_controller.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:fap_properties/views/landlord/landlord_home.dart';
import 'package:fap_properties/views/tenant/tenant_dashboard/tenant_dashboard_tabs/tenant_dashboard_tabs.dart';
import 'package:fap_properties/views/vendor/vendor_dashboard/vendor_dashboard_tabs/vendor_dashboard_tabs.dart';
import 'package:get/get.dart';

import '../../data/models/auth_models/get_languages_model.dart';
import '../../data/repository/auth_repository.dart';
import '../auth/select_role/select_roles_controller.dart';
import '../public_views/search_properties_dashboard_tabs/search_properties_dashboard_tabs.dart';

class GetLanguageController extends GetxController {
  var model = GetLanguagesModel().obs;
  var loadingData = true.obs;
  RxString error = "".obs;
  RxInt selectedLang = 1.obs;
  RxBool isLoginBool = false.obs;
  bool _langSelected = false;

  final uULController = Get.put(UpdateUserLanguageController());
  final changeLang = Get.put(SelectRoloesController());

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    try {
      isLoginBool.value =
          await GlobalPreferences.getBool(GlobalPreferencesLabels.isLoginBool);
      bool _isInternetConnected = await BaseClientClass.isInternetConnected();
      if (!_isInternetConnected) {
        await Get.to(() => NoInternetScreen());
      }
      loadingData.value = true;
      var result = await CommonRepository.getLanguage();
      loadingData.value = false;
      if (result is GetLanguagesModel) {
        _langSelected = true;
        model.value = result;
        selectedLang.value =
            await GlobalPreferences.getInt(GlobalPreferencesLabels.langId) ??
                model.value.language.first.langId;
        update();
      } else {
        error.value = result;
      }
    } catch (e) {
      print('inside Catch');
    }
  }

  void changeLanguage(int langId, bool isLoggedIn, bool cont) async {
    _langSelected = true;
    loadingData.value = true;
    selectedLang.value = langId;
    SessionController().setLanguage(selectedLang.value);
    GlobalPreferences.setbool(GlobalPreferencesLabels.setLanguage, true);
    int _prevLang =
        await GlobalPreferences.getInt(GlobalPreferencesLabels.langId) ?? 1;
    GlobalPreferences.setInt(GlobalPreferencesLabels.langId, langId);
    if (langId == 1) {
      GlobalPreferences.setbool(GlobalPreferencesLabels.isEnglish, true);
    } else {
      GlobalPreferences.setbool(GlobalPreferencesLabels.isEnglish, false);
    }

    if (!isLoggedIn)
      Get.offAll(() => SessionController().enableFireBaseOTP
          ? ValidateUserScreenFB()
          : ValidateUserScreen());
    else if (!cont && _prevLang != langId) {
      await changeLang.updateLang();
      if (SessionController().getSelectedRoleId() == 1) {
        Get.offAll(() => TenantDashboardTabs());
      } else if (SessionController().getSelectedRoleId() == 3) {
        Get.offAll(() => VendorDashboardTabs());
      } else if (SessionController().getSelectedRoleId() == 2) {
        Get.offAll(() => LandlordHome());
      } else if (SessionController().getSelectedRoleId() == 4) {
        Get.offAll(() => SearchPropertiesDashboardTabs());
      }
    }
    loadingData.value = false;
  }

  Future<void> countinueBtn() async {
    SessionController().setLanguage(selectedLang.value);
    if (_langSelected) {
      GlobalPreferences.setbool(GlobalPreferencesLabels.setLanguage, true);
      GlobalPreferences.setInt(
          GlobalPreferencesLabels.langId, selectedLang.value);
      if (selectedLang.value == 1) {
        GlobalPreferences.setbool(GlobalPreferencesLabels.isEnglish, true);
      } else {
        GlobalPreferences.setbool(GlobalPreferencesLabels.isEnglish, false);
      }
    }
    isLoginBool.value == true
        ? Get.to(() => SelectRoleScreen())
        : Get.to(() => SessionController().enableFireBaseOTP
            ? ValidateUserScreenFB()
            : ValidateUserScreen());
  }
}
