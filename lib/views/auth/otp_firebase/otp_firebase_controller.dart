import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/auth_models/validate_user_model.dart';
import 'package:fap_properties/data/repository/auth_repository.dart';
import 'package:fap_properties/utils/constants/app_const.dart';
import 'package:fap_properties/utils/constants/global_preferences.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/auth/blocked_device/blocked_device_screen.dart';
import 'package:fap_properties/views/auth/otp_firebase/verify_user_otp_fb.dart';
import 'package:fap_properties/views/auth/otp_firebase/verify_user_otp_fb_controller.dart';
import 'package:fap_properties/views/auth/setup_mpin/setup_mpin.dart';
import 'package:fap_properties/views/auth/validate_user/phone_no_field.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:fap_properties/views/common/safe_device_check.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthController extends GetxController {
  static String verificationId;
  bool otpManuallyVerified = false;
  RxBool isCodeSent = false.obs;
  RxBool verifying = false.obs;
  RxBool validOTP = true.obs;
  RxBool resending = false.obs;
  // bool isUserSignedIn = false;
  int resendToken;
  var error = "".obs;
  RxBool isError = false.obs;
  RxBool isPhoneValid = false.obs;

  RxBool checkRooted = false.obs;
  RxBool enableSSL = true.obs;

  bool resendEnabled = true;

  FirebaseAuth auth = FirebaseAuth.instance;

  RxBool jailbroken = false.obs;
  RxBool developerMode = false.obs;

  @override
  void onInit() {
    // FirebaseAuth.instance.userChanges().listen((User user) {
    //   if (user == null) {
    //     if (kDebugMode) {
    //       print('User is currently signed out!');
    //     }
    //     isUserSignedIn = false;
    //   } else {
    //     if (kDebugMode) {
    //       print('User is signed in!');
    //     }
    //     isUserSignedIn = true;
    //   }
    // });
    validOTP.value = true;
    otpAttemptsCounter.value = 0;
    super.onInit();
  }

  Future<void> rootCheck() async {
    try {
      jailbroken.value = await FlutterJailbreakDetection.jailbroken;
      developerMode.value = await FlutterJailbreakDetection.developerMode;
    } catch (e) {
      isUpdating.value = false;
      loadingData.value = false;
      Get.to(() => SafeDeviceCheck());
    }
  }

  String validateMobile(String value) {
    if (isError.value) {
      isError.value = false;
      isPhoneValid.value = false;
      return AppMetaLabels().someThingWentWrong;
    }
    String patttern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
    RegExp regExp = RegExp(patttern);
    if (!regExp.hasMatch(value)) {
      isPhoneValid.value = false;
      return AppMetaLabels().invalidPhoneNumber;
    } else {
      isPhoneValid.value = true;
      error.value = '';
      return null;
    }
  }

  verifyPhone(String phone) {
    try {
      resendCounter.value = 0;
      resendEnabled = true;
      if (kDebugMode) {
        print("verfiying Phone Test $phone");
      }
      loadingData.value = true;
      verifying.value = true;
      isCodeSent.value = false;

      FirebaseAuth.instance.verifyPhoneNumber(
        timeout: const Duration(seconds: 120),
        phoneNumber: phone,
        verificationCompleted: _onVerificationCompleted,
        verificationFailed: _onVerificationFailed,
        codeSent: _onCodeSent,
        codeAutoRetrievalTimeout: _onCodeAutoRetrievalTimeout,
      );
    } catch (e) {
      print("Firebase Authentication Error: $e  ${e.toString()}");
      // Additional logging or inspection of the error object
    }
  }

  verifyPhoneForgotMpin(String phone) {
    resendCounter.value = 0;
    resendEnabled = true;
    if (kDebugMode) {
      print("verfiying Phone $phone");
    }
    isCodeSent.value = false;
    loadingData.value = true;
    isLoadingForForgotButton.value = true;
    verifying.value = true;
    FirebaseAuth.instance.verifyPhoneNumber(
      timeout: const Duration(seconds: 120),
      phoneNumber: phone,
      verificationCompleted: _onVerificationCompleted,
      verificationFailed: _onVerificationFailed,
      codeSent: _onCodeSentForgotMpin,
      codeAutoRetrievalTimeout: _onCodeAutoRetrievalTimeout,
    );
  }

  RxInt resendCounter = 0.obs;
  RxInt otpAttemptsCounter = 0.obs;
  RxBool resendProgressBar = true.obs;
  RxBool resendProgressBarLoading = false.obs;
  Future<void> resendingOtp(String phone) async {
    if (resendCounter <= 5) {
      if (kDebugMode) {
        print("verfiying Phone");
        print("Phone $phone");
      }

      error.value = '';
      validOTP.value = true;
      resending.value = true;

      FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 120),
        verificationCompleted: _onVerificationCompleted,
        verificationFailed: _onVerificationFailed,
        codeSent: _onCodeResent,
        codeAutoRetrievalTimeout: _onCodeAutoRetrievalTimeout,
      );

      resending.value = false;
    } else {
      if (kDebugMode) {
        print("verfiying Phone Failed");
      }
      error.value = '';
      resendCounter.value = 0;
      resendProgressBar.value = true;
      isCodeSent.value = false;
      Get.offAll(() => BlockedDeviceScreen());
      GlobalPreferences.setInt(
          GlobalPreferencesLabels.blockTime, AppConst.blockTime);
      GlobalPreferences.setbool(GlobalPreferencesLabels.isBlocked, true);
    }
  }

// in this func we will update the public profile for new user
  VerifyUserOtpControllerFB controller = Get.put(VerifyUserOtpControllerFB());
  void signInWithPhoneNumber(String code) async {
    if (resending.value == true) {
    } else {
      verifying.value = true;
      loadingData.value = true;
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: code);
        await FirebaseAuth.instance.signInWithCredential(credential);
        if (kDebugMode) {
          print('otp verified');
        }
        otpManuallyVerified = true;
        error.value = '';
        isCodeSent.value = false;
        controller.verifyOtpBtn(code, verificationId, true);
        // next logic
      } on FirebaseAuthException catch (e) {
        verifying.value = false;
        loadingData.value = false;
        otpAttemptsCounter++;
        verifying.value = false;
        loadingData.value = false;
        if (otpAttemptsCounter.value >= 5) {
          isCodeSent.value = false;
          Get.offAll(() => BlockedDeviceScreen());
          GlobalPreferences.setInt(
              GlobalPreferencesLabels.blockTime, AppConst.blockTime);
          GlobalPreferences.setbool(GlobalPreferencesLabels.isBlocked, true);
          return;
        }
        // SnakBarWidget.getSnackBarError(e.message, e.message);
        if (kDebugMode) {
          print(e.message);
        }
        print('Error Msg from the Firebase ::: ${e.message}');
        if (e.message.contains("The sms code has expired.")) {
          error.value = AppMetaLabels().otpExpired;
        } else if (e.message.contains(
            "The multifactor verification code used to create the auth credential is invalid.Re-collect the verification code and be sure to use the verification code provided by the user")) {
          error.value = AppMetaLabels().incorrectCode;
        } else if (e.message.contains(
            "The SMS verification code used to create the phone auth credential is invalid. Please resend the verification code SMS and be sure to use the verification code provided by the user")) {
          error.value = AppMetaLabels().incorrectCode;
        } else if (e.message.contains(
            "The sms verification code used to create the phone auth credential is invalid. Please resend the verification code sms and be sure use the verification code provided by the user")) {
          error.value = AppMetaLabels().incorrectCode;
        } else if (e.message
            .contains("We have blocked all requests from this device")) {
          error.value = AppMetaLabels().tooManyReqtryLater;
        } else {
          error.value = e.message;
        }
        controller.verifyOtpBtn(code, verificationId, false);
      } catch (e) {
        loadingData.value = false;
        if (kDebugMode) {
          print('Exception ::::: ${e.message}');
        }
      }
    }
  }

  void signInWithPhoneNumberForgotMpin(String code) async {
    if (resending.value == true) {
    } else {
      verifying.value = true;
      loadingData.value = true;
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: code);
        await FirebaseAuth.instance.signInWithCredential(credential);
        if (kDebugMode) {
          print('otp verified');
        }
        otpManuallyVerified = true;
        error.value = '';
        isCodeSent.value = false;
        Get.offAll(() => SetupMpinScreen());
        // next logic
      } on FirebaseAuthException catch (e) {
        verifying.value = false;
        loadingData.value = false;
        otpAttemptsCounter++;
        verifying.value = false;
        loadingData.value = false;
        isCodeSent.value = false;
        if (otpAttemptsCounter.value >= 5) {
          Get.offAll(() => BlockedDeviceScreen());
          GlobalPreferences.setInt(
              GlobalPreferencesLabels.blockTime, AppConst.blockTime);
          GlobalPreferences.setbool(GlobalPreferencesLabels.isBlocked, true);
          return;
        }
        if (kDebugMode) {
          print(e.message);
        }
        print('Error Msg from the Firebase ::: ${e.message}');
        if (e.message.contains("The sms code has expired.")) {
          error.value = AppMetaLabels().otpExpired;
        } else if (e.message.contains(
            "The SMS verification code used to create the phone auth credential is invalid. Please resend the verification code SMS and be sure to use the verification code provided by the user")) {
          error.value = AppMetaLabels().incorrectCode;
        } else if (e.message.contains(
            "The sms verification code used to create the phone auth credential is invalid. Please resend the verification code sms and be sure use the verification code provided by the user")) {
          error.value = AppMetaLabels().incorrectCode;
        } else if (e.message
            .contains("We have blocked all requests from this device")) {
          error.value = AppMetaLabels().tooManyReqtryLater;
        } else {
          error.value = e.message;
        }
      } catch (e) {
        loadingData.value = false;
        if (kDebugMode) {
          print('Exception ::::: ${e.message}');
        }
      }
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  void _onVerificationCompleted(PhoneAuthCredential credential) {
    if (resending.value == true) {
    } else {
      verifying.value = false;
      resending.value = false;
      if (kDebugMode) {
        print('VerificationCompleted New $credential');
      }
      // FirebaseAuth.instance.signInWithCredential(credential);
      if (kDebugMode) {
        print('otp verified');
      }
    }
  }

  void _onVerificationFailed(FirebaseAuthException exception) {
    if (kDebugMode) {
      print('_onVerificationFailed ');
    }
    resendProgressBarLoading.value = false; //1122
    if (kDebugMode) {
      print(exception);
      print(exception.message);
    }
    if (exception.message.contains(
        'The format of the phone number provided is incorrect. Please enter the phone number in a format that can be parsed into E.164 format. E.164 phone numbers are written in the format [+][country code][subscriber number including area code].')) {
      error.value = AppMetaLabels().invalidPhoneNumber;
      errorValidateUser.value = AppMetaLabels().invalidPhoneNumber;
    } else if (exception.message ==
        'A network error (such as timeout, interrupted connection or unreachable host) has occurred.') {
      error.value = AppMetaLabels().connectionTimedOut;
      errorValidateUser.value = AppMetaLabels().connectionTimedOut;
    } else if (exception.message ==
        'An internal error has occurred, print and inspect the error details for more information.') {
      error.value = AppMetaLabels().someThingWentWrong;
      errorValidateUser.value = AppMetaLabels().someThingWentWrong;
    } else {
      error.value = exception.message;
      errorValidateUser.value = exception.message;
    }
    verifying.value = false;
    resending.value = false;
    if (kDebugMode) {
      print('Verification Failed');
    }
  }

  void _onCodeSent(String vId, int resendToken) {
    loadingData.value = false;
    verifying.value = false;
    resending.value = false;
    verificationId = vId;
    this.resendToken = resendToken;
    if (kDebugMode) {
      print('Code Sent');
    }

    isCodeSent.value = true;
    resendProgressBarLoading.value = false;
    PhoneNoFieldFB.phoneController.clear();

    Get.to(() => VerifyUserOtpScreenFB(
          otpCodeForVerifyOTP: model.value.otpCode,
          isForgotMpin: false,
        ));

    SnakBarWidget.getSnackBarErrorBlue(
        AppMetaLabels().alert, AppMetaLabels().codeSent);
  }

  void _onCodeSentForgotMpin(String vId, int resendToken) {
    if (kDebugMode) {
      print('Code Sending');
    }
    loadingData.value = false;
    verifying.value = false;
    resending.value = false;
    verificationId = vId;
    isCodeSent.value = true;
    isLoadingForForgotButton.value = false;
    this.resendToken = resendToken;
    if (kDebugMode) {
      print('Code Sent');
    }
    resendProgressBarLoading.value = false;
    PhoneNoFieldFB.phoneController.clear();
    Get.to(() => VerifyUserOtpScreenFB(
          otpCodeForVerifyOTP: model.value.otpCode,
          isForgotMpin: true,
        ));
    SnakBarWidget.getSnackBarErrorBlue(
        AppMetaLabels().alert, AppMetaLabels().codeSent);
  }

  void _onCodeResent(String vId, int resendToken) {
    verifying.value = false;
    resending.value = false;
    verificationId = vId;
    isCodeSent.value = false;
    error.value = '';
    this.resendToken = resendToken;
    if (kDebugMode) {
      print('Code Resent');
    }
    print(resendCounter.value);
    if (resendCounter.value >= 1) {
      resendProgressBar.value = true;
      resendProgressBarLoading.value = false;
    }
    SnakBarWidget.getSnackBarErrorBlue(
        AppMetaLabels().alert, AppMetaLabels().codeSent);
  }

  void _onCodeAutoRetrievalTimeout(String verificationId) {
    validOTP.value = false;
    resending.value = false;
    loadingData.value = false;
    resendProgressBarLoading.value = false;
    isLoadingForForgotButton.value = false;
    isUpdating.value = false;
    verifying.value = false;
    // if (isCodeSent.value != true) {
    //   SnakBarWidget.getSnackBarErrorBlue(
    //       AppMetaLabels().alert, AppMetaLabels().codeAutoRetrievalTimeout);
    // }
  }

//Validate  email
  bool emailValidation(String emailStr) {
    var email = emailStr;
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid == true) {
      return true;
    } else {
      return false;
    }
  }

  var model = ValidateUserModel().obs;
  RxBool isUpdating = false.obs;
  RxBool loadingData = false.obs;
  RxBool textFieldTap = false.obs;
  RxBool validNo = false.obs;
  RxString errorValidateUser = "".obs;

  Future<void> validateMobileUser() async {
    isUpdating.value = true;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      Get.to(() => NoInternetScreen());
    }
    errorValidateUser.value = '';
    try {
      loadingData.value = true;
      var result = await CommonRepository.validateUserFB();
      if (result is ValidateUserModel) {
        model.value = result;

        await verifyPhone(
          SessionController().getPhone(),
        );
        loadingData.value = false;
      } else {
        errorValidateUser.value = result;
        loadingData.value = false;
      }
    } catch (e) {
      loadingData.value = false;
    }
    isUpdating.value = false;
  }

  RxBool isLoadingForForgotButton = false.obs;
  forgotMPin() async {
    isLoadingForForgotButton.value = true;
    await verifyPhoneForgotMpin(
      SessionController().getPhone(),
    );
  }
}
