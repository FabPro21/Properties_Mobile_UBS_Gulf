import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/encription.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/auth_models/compare_dev_token_resp.dart';
import 'package:fap_properties/data/models/auth_models/get_user_roles_model.dart';
import 'package:fap_properties/data/models/auth_models/refresh_token_model.dart';
import 'package:fap_properties/data/models/auth_models/session_token_model.dart';
import 'package:fap_properties/data/repository/auth_repository.dart';
import 'package:fap_properties/utils/constants/global_preferences.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/auth/login_mpin/login_mpin_screen.dart';
import 'package:fap_properties/views/auth/otp_firebase/validate_user_fb.dart';
import 'package:fap_properties/views/auth/select_role/select_role_screen.dart';
import 'package:fap_properties/views/auth/splash_screen/splash_screen.dart';
import 'package:fap_properties/views/auth/validate_user/validate_user_screen.dart';
import 'package:fap_properties/views/public_views/search_properties_dashboard_tabs/search_properties_dashboard_tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import '../../../data/models/auth_models/getNew_token_model.dart';
import '../../../utils/constants/app_config.dart';
import '../../common/no_internet_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as ui;

class SelectRoloesController extends GetxController {
  RxBool loadingData = false.obs;
  var response;
  List<Role> userRoles = [];
  RefreshTokenModel refreshtoken = RefreshTokenModel();
  int roleLength = 0;
  RxString name = "".obs;
  RxString error = "".obs;
  bool redirect = true;
  String devToken = '';

  @override
  void onInit() {
    super.onInit();
  }

  void initialize() async {
    if (ui.Platform.isAndroid) {
      print(':::: Without app update ::::');
    }

    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    // RefreshToken
    loadingData.value = true;
    await getNewTokenfun().then((value) {
      name.value = SessionController().getUserName() ?? '';
      getUserRoles();
    });
    loadingData.value = false;
  }

  Future<void> compareToken(num) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    try {
      error.value = '';
      loadingData.value = true;
      await _getDeviceTokken();
      print(devToken);
      final resp = await CommonRepository.compareDevToken(devToken, num);
      if (resp is CompareDevTokenModel) {
        if (resp.tokenValid == 1) {
          // await   getNewTokenfun().then((value) => getUserRoles());
          // await getUserRoles();
          Get.offAll(() => SelectRoleScreen());
        } else {
          logout();
          return;
        }
      } else {
        logout();
        error.value = resp;
      }
      loadingData.value = false;
    } catch (e) {
      error.value = AppMetaLabels().someThingWentWrong;
      loadingData.value = false;
    }
  }

  // Not moving toward the public side
  Future getUserRoles() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    loadingData.value = true;
    var response = await CommonRepository.getUserRoles();
    if (response is GetUserRoleModel) {
      loadingData.value = false;
      SessionController().setUserRoles(response.data);
      if (redirect == true) {
        if (response.data.length == 1 &&
            response.data[0].roleId == 4 &&
            redirect) {
          validatePublicRole();
        } else {
          userRoles = response.data;
        }
      } else {
        userRoles = response.data;
      }
    } else {
      loadingData.value = false;
      if (response == '501') {
        resetApp();
      }
      error.value = response;
    }
  }
  // Auto moving toward the public side
  // Future getUserRoles() async {
  //   bool _isInternetConnected = await BaseClientClass.isInternetConnected();
  //   if (!_isInternetConnected) {
  //     await Get.to(() => NoInternetScreen());
  //   }
  //   loadingData.value = true;
  //   var response = await CommonRepository.getUserRoles();
  //   if (response is GetUserRoleModel) {
  //     loadingData.value = false;
  //     SessionController().setUserRoles(response.data);
  //     if (response.data.length == 1 &&
  //         response.data[0].roleId == 4 &&
  //         redirect) {
  //       validatePublicRole();
  //     } else {
  //       userRoles = response.data;
  //     }
  //   } else {
  //     loadingData.value = false;
  //     if (response == '501') {
  //       resetApp();
  //     }
  //     error.value = response;
  //   }
  // }

  Future<void> setUserName(String name, nameAr) async {
    GlobalPreferencesEncrypted.setString(
      GlobalPreferencesLabels.userName,
      name ?? "",
    );
    SessionController().setUserName(name);
    GlobalPreferencesEncrypted.setString(
      GlobalPreferencesLabels.userNameAr,
      nameAr ?? "",
    );
    SessionController().setUserNameAr(nameAr);
  }

  Future validatePublicRole() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    var resp;
    loadingData.value = true;
    resp = await CommonRepository.validatePublicRole();
    if (resp is SessionTokenModel) {
      SessionController().setSelectedRoleId(4);
      SessionController().setPublicToken(resp.token);

      Get.offAll(() => SearchPropertiesDashboardTabs());
      loadingData.value = false;
    } else {
      loadingData.value = false;
    }
  }

  Future updateLang() async {
    var data = {"LangId": SessionController().getLanguage()};
    await BaseClientClass.postwithheader(AppConfig().updateLang, data);
  }

  Future<void> _getDeviceTokken() async {
    FirebaseMessaging.instance.requestPermission();
    await FirebaseMessaging.instance.getToken().then(
      (String token) {
        assert(token != null);
        devToken = token;
      },
    );
  }

  void resetApp() async {
    Get.offAll(() => SplashScreen());
    await FirebaseAuth.instance.signOut();
    GlobalPreferences.setbool(GlobalPreferencesLabels.isLoginBool, false);
    bool isEnglish = SessionController().getLanguage() == 1;
    GlobalPreferences.setbool(GlobalPreferencesLabels.isEnglish, isEnglish);
  }

  void logout() async {
    GlobalPreferences.setbool(GlobalPreferencesLabels.isLoginBool, false);
    FirebaseAuth.instance.signOut();
    Get.offAll(() => SessionController().enableFireBaseOTP
        ? ValidateUserScreenFB()
        : ValidateUserScreen());
  }

  Future<void> refreshtokenFunc(String userid) async {
    var data = {"UserRole": userid};
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    try {
      loadingData.value = true;
      var url = AppConfig().proceedToLogin;
      var result = await BaseClientClass.postwithheader(url, data,
          token: SessionController().getLoginToken());
      if (result is http.Response) {
        var resp = refreshTokenModelFromJson(result.body);
        print(resp.token);
        print('User userid ::::: ID $userid');
        print('User userid ::::: ID ${userRoles.length}');
        var userType = '';
        for (int i = 0; i < userRoles.length; i++) {
          print('User Role ::::: ID  at $i ${userRoles[i].roleId}');
          print(
              'User Role ::::: user type ${(userRoles[i].roleId.toString() == userid)}');
          if (userRoles[i].roleId.toString() == userid) {
            print('User Role ::::: user type ${userRoles[i].userType}');
            userType = userRoles[i].userType;
          }
        }
        print('User Type From code $userType');
        SessionController().vendorUserType = userType;
        print('User Type From Session ${SessionController().vendorUserType}');
        SessionController().setToken(resp.token);
        if (userid == "4") {
          validatePublicRole();
        } else {
          Get.to(
            () => LoginMpinScreen(),
          );
        }
        loadingData.value = false;
      } else {
        error.value = result;
        loadingData.value = false;
      }
    } catch (e) {
      print("This is the error from controller $e");
      loadingData.value = false;
    }
  }

  Future<void> getNewTokenfun() async {
    loadingData.value = true;
    print("phone num is=====${SessionController().getPhone()}");
    var data = {
      "mobile": SessionController().getPhone(),
    };
    encriptdata(data);
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    try {
      var url = AppConfig().getNewToken;
      var result = await BaseClientClass.postwithheaderwithouttoken(
        url,
        data,
      );
      if (result is http.Response) {
        var resp = getNewTokenModelFromJson(result.body);
        SessionController().setToken(resp.token);
        SessionController().setLoginToken(resp.token);
        SessionController().setUserName(resp.user.name);
        SessionController().setUserNameAr(resp.user.fullNameAr);
        update();
        loadingData.value = false;
      } else {
        var error;
        error.value = result;
        print('new token iss **** =====$result');
        loadingData.value = false;
      }
    } catch (e) {
      loadingData.value = false;
      print("This is the error from controller $e");
    }
  }
}
