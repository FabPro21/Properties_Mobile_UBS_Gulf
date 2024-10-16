import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/global_preferences.dart';
import 'package:fap_properties/views/auth/otp_firebase/validate_user_fb.dart';
import 'package:fap_properties/views/auth/select_role/select_roles_controller.dart';
import 'package:fap_properties/views/choose_language/choose_language.dart';
import 'package:fap_properties/views/auth/blocked_device/blocked_device_screen.dart';
import 'package:fap_properties/views/auth/validate_user/validate_user_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

class SplashScreenController extends GetxController {
  bool isLoginBool = false;
  bool isBlocked = false;
  RxString secText = "".obs;
  RxString phone = "".obs;
  bool setLanguage = false;
  //bool setLanguage = false;
  bool? isEnglish;

  SelectRoloesController obj = Get.put(SelectRoloesController());
  @override
  void onInit() async {
    await setUserMobile();
    // want to set for the name latest
    // 12*
    await setUserName();
    print(SessionController().getUserMobile());
    //await getNewToken();
    super.onInit();
  }

  // void setSessionData() async {}

  prefsData() async {
    isBlocked =
        await GlobalPreferences.getBool(GlobalPreferencesLabels.isBlocked) ??
            false;
    setLanguage =
        await GlobalPreferences.getBool(GlobalPreferencesLabels.setLanguage) ??
            false;
    print('Set Language : $setLanguage');

    if (!setLanguage) {
      SessionController().setLanguage(1);
      GlobalPreferences.setbool(GlobalPreferencesLabels.isEnglish, true);
    }
    isLoginBool =
        await GlobalPreferences.getBool(GlobalPreferencesLabels.isLoginBool) ??
            false;
    isEnglish =
        await GlobalPreferences.getBool(GlobalPreferencesLabels.isEnglish) ??
            true;

    SessionController().setLanguage(isEnglish! ? 1 : 2);

    phone.value = await GlobalPreferencesEncrypted.getString(
        GlobalPreferencesLabels.phoneNumber);
  }

  Future<void> isSetupMpin() async {
    await prefsData();
    setSessionToken();
    setUserName();
    getfp();
    await setUserMobile();

    // For video Tutorial START
    String path = await GlobalPreferencesEncrypted.getString(
        GlobalPreferencesLabels.videoTutorail);
    print('Path ::: From Preference ::: $path');
    if (path == '' || path.isEmpty) {
      var videoPath = await getVideoFileFromAssets();
      SessionController().videoPath = videoPath;
      print('Video path getting First time : ${SessionController().videoPath}');
    } else {
      SessionController().videoPath = path;
      print('Video path from  Preference : ${SessionController().videoPath}');
    }
    // For video Tutorial START

    Future.delayed(const Duration(seconds: kDebugMode ? 0 : 7), () async {
      if (isBlocked) {
        Get.to(() => BlockedDeviceScreen());
      } else {
        if (!setLanguage) {
          await Get.to(() => ChooseLanguage(
                cont: true,
                loggedIn: false,
              ));
        }
        print("Is Login ::::: $isLoginBool");
        print("Is phone.value ::::: ${phone.value}");
        if (isLoginBool) {
          print(phone.value);
          obj.compareToken(phone.value).then((value) {
            // Get.to(() => SelectRoleScreen());
          });
          // Get.to(() => SelectRoleScreen());
        } else {
          Get.to(() => SessionController().enableFireBaseOTP
              ? ValidateUserScreenFB()
              : ValidateUserScreen());
        }

        // isLoginBool.value == true
        //     ? Get.to(() => SelectRoleScreen())
        //     // : Get.to(() => ChooseLanguage());
        //     : Get.to(() => ValidateUserScreen());
      }
      // isBlocked
      //     ? Get.to(() => BlockedDeviceScreen())
      //     : isLoginBool.value == true
      //         ? Get.to(() => SelectRoleScreen())
      //         // : Get.to(() => ChooseLanguage());
      //         : Get.to(() => ValidateUserScreen());
    });
  }

  // For video Tutorial START
  // createFile
  // getVideoFileFromAssets
  // both func for the video tutorial
  // saving file in the cache
  // getting file from asset and convert it into bas64 and save it in cache and return path
  Future<String> getVideoFileFromAssets() async {
    // ByteData bytes = await rootBundle.load('');
    ByteData bytes = await rootBundle.load('assets/video/FAB_8.mp4');
    var buffer = bytes.buffer;
    var base64String = base64.encode(Uint8List.view(buffer));
    var uint8List = base64Decode(base64String.replaceAll('\n', ''));
    String path = await createFile(uint8List, 'FABRenewalTutorail.mp4');
    GlobalPreferencesEncrypted.setString(
        GlobalPreferencesLabels.videoTutorail, path);
    return path;
  }

  Future<String> createFile(Uint8List data, String fileName) async {
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/$fileName");
    File("${output.path}/$fileName").exists();
    await file.writeAsBytes(data.buffer.asUint8List());
    return "${output.path}/$fileName";
  }
  // For video Tutorial END

  void setSessionToken() async {
    String logintoken = await GlobalPreferencesEncrypted.getString(
        GlobalPreferencesLabels.loginToken);
    SessionController().setLoginToken(logintoken);
  }

// 12*
  Future<void> setUserName() async {
    String name = await GlobalPreferencesEncrypted.getString(
        GlobalPreferencesLabels.userName);
    SessionController().setUserName(name);
    String nameAr = await GlobalPreferencesEncrypted.getString(
        GlobalPreferencesLabels.userNameAr);

    SessionController().setUserNameAr(nameAr);
    // String userId = await GlobalPreferencesEncrypted.getString(
    //     GlobalPreferencesLabels.userID);
    // print('user IDDD ::::: $userId');
    // if (userId != null || userId != '') {
    //   SessionController().setUserID(userId);
    // }
  }

  Future<void> setUserMobile() async {
    String phone = await GlobalPreferencesEncrypted.getString(
        GlobalPreferencesLabels.phoneNumber);
    SessionController().setPhone(phone);
  }

  getfp() async {
    bool fp =
        await GlobalPreferences.getBool(GlobalPreferencesLabels.fingerPrint);
    SessionController().setfingerprint(fp);
  }
}
