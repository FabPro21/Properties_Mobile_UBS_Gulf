// ignore_for_file: deprecated_member_use

import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/app_const.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/auth/country_picker/country_picker_controller.dart';
import 'package:fap_properties/views/auth/otp_firebase/otp_firebase_controller.dart';
import 'package:fap_properties/views/auth/otp_firebase/verify_user_otp_fb_controller.dart';
import 'package:fap_properties/views/auth/verify_user_otp/pin_code_field_otp.dart';
import 'package:fap_properties/views/auth/verify_user_otp/resend_otp.dart';
import 'package:fap_properties/views/widgets/common_widgets/background_image_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/button_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_white.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class VerifyUserOtpScreenFB extends StatefulWidget {
  final String? otpCodeForVerifyOTP;
  final bool? isForgotMpin;
  VerifyUserOtpScreenFB({Key? key, this.otpCodeForVerifyOTP, this.isForgotMpin})
      : super(key: key);

  @override
  State<VerifyUserOtpScreenFB> createState() => _VerifyUserOtpScreenFBState();
}

class _VerifyUserOtpScreenFBState extends State<VerifyUserOtpScreenFB> {
  FirebaseAuthController authController = Get.find();
  VerifyUserOtpControllerFB controller = Get.put(VerifyUserOtpControllerFB());

  String getPhone() {
    var p = SessionController().getPhone();
    var l = p!.length;
    var first = p.substring(0, 5);
    var last = p.substring(l - 3, l);
    return first + "****" + last;
  }

  @override
  void initState() {
    // Adding New Functionality
    FirebaseAuth.instance.authStateChanges().listen((User? user) async{
       print(' user state ============::::::::::::::::: IF === >  $user');
      if (user != null && !authController.otpManuallyVerified) {
        // Navigate the user away from the login screens
        print(' user state ============::::::::::::::::: IF === > ');
        await autoVerifyOtpBtn();
        authController.otpManuallyVerified = true;
      } else {
        print('Resetting user state ============::::::::::::::::: ELSE === > ');
        authController.otpManuallyVerified = false;
      }
    });
 
    setState(() {
      authController.isCodeSent.value = false;
    });
    super.initState();
  }

  autoVerifyOtpBtn() async {
    print(' user state ============::::::::::::::::: autoVerifyOtpBtn === >');
    await controller.verifyOtpBtn('auto Verified', 'auto Verified', true);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      authController.isCodeSent.value = false;
    });
    return WillPopScope(
      onWillPop: () async => false,
      child: Obx(() {
        return Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: Directionality(
            textDirection: SessionController().getLanguage() == 1
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: Stack(
              children: [
                const AppBackgroundImage(),
                SafeArea(
                  child: SingleChildScrollView(
                    child: Center(
                      child:
                          ////////////////////////////
                          /// Loading
                          ////////////////////////////

                          Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 3.0.h),
                            child: Text(
                              AppMetaLabels().otpVerification,
                              style: AppTextStyle.semiBoldWhite13,
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(top: 10.0.h),
                            child: authController.loadingData.value
                                ? Container(
                                    height: 1.5.h,
                                  )
                                : Text(
                                    AppMetaLabels().enterTheCode,
                                    style: AppTextStyle.normalWhite11,
                                  ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0.5.h),
                            child: authController.loadingData.value
                                ? Container(
                                    height: 1.5.h,
                                  )
                                : Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Text(
                                      getPhone(),
                                      style: AppTextStyle.semiBoldWhite11,
                                    ),
                                  ),
                          ),

                          ////////////////////////////
                          /// PinCodeField
                          ////////////////////////////

                          Padding(
                            padding: EdgeInsets.only(top: 5.0.h),
                            child: Center(
                              child: authController.loadingData.value
                                  ? Padding(
                                      padding: EdgeInsets.only(top: 24.0.h),
                                      child: Container(
                                        // height: 8.0.h,
                                        child: Column(
                                          children: [
                                            LoadingIndicatorWhite(),
                                            SizedBox(
                                              height: 2.0.h,
                                            ),
                                            Text(
                                              AppMetaLabels().verifyingOtp,
                                              style:
                                                  AppTextStyle.semiBoldWhite10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      width: 85.0.w,
                                      child: PinCodeFieldFB(
                                        controller: authController,
                                        isForgotMpin:
                                            widget.isForgotMpin ?? false,
                                      ),
                                    ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 7.0.h),
                            child: authController.loadingData.value ||
                                    authController.resending.value ||
                                    authController.resendProgressBar.value
                                ? Container(
                                    height: 2.0.h,
                                  )
                                : Text(
                                    AppMetaLabels().didnotrecieve,
                                    style: AppTextStyle.normalWhite10,
                                  ),
                          ),
                          ////////////////////////////
                          /// ResendOtp Button ///
                          ////////////////////////////

                          if (!authController.loadingData.value)
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 5.0.h, left: 5.0.h, right: 5.0.h),
                              child: authController
                                      .resendProgressBarLoading.value
                                  ? LoadingIndicatorWhite()
                                  : authController.resendProgressBar.value
                                      ? Container(
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(1.0.h),
                                          ),
                                          clipBehavior: Clip.hardEdge,
                                          child: TweenAnimationBuilder<double>(
                                              tween: Tween<double>(
                                                  begin: 1.0, end: 0.0),
                                              // setting the time for Progress
                                              duration: const Duration(
                                                  seconds:
                                                      AppConst.resendOtpTime),
                                              onEnd: () {
                                                authController.resendProgressBar
                                                    .value = false;
                                              },
                                              builder: (context, value, _) {
                                                WidgetsBinding.instance
                                                    .addPostFrameCallback(
                                                        (timeStamp) {});
                                                return LinearProgressIndicator(
                                                  backgroundColor:
                                                      AppColors.grey1,
                                                  color: AppColors.whiteColor,
                                                  minHeight: 0.6.h,
                                                  value: value,
                                                );
                                              }))
                                      : authController
                                              .resendProgressBarLoading.value
                                          ? Container(
                                              height: 6.0.h,
                                            )
                                          : ResendOtpFB(),
                            ),

                          //////////////////////////////////////
                          /// Error Message
                          //////////////////////////////////////
                          Padding(
                            padding: EdgeInsets.only(
                              top: 2.0.h,
                            ),
                            child: authController.error.value == ''
                                ? Container()
                                : Container(
                                    width: 85.0.w,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(255, 59, 48, 0.6),
                                      borderRadius:
                                          BorderRadius.circular(1.0.h),
                                      border: Border.all(
                                        color: Color.fromRGBO(255, 59, 48, 1),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(0.7.h),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.info_outline,
                                            color: Colors.white,
                                            size: 3.0.h,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 1.0.h),
                                            child: Container(
                                              width: 72.0.w,
                                              child: Text(
                                                authController.error.value,
                                                style: AppTextStyle
                                                    .semiBoldWhite11,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 4,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ),

                          //////////////////////////////////////
                          /// verifyOtp Button
                          //////////////////////////////////////
                          Padding(
                            padding: EdgeInsets.only(top: 18.0.h),
                            child: authController.loadingData.value ||
                                    authController.resending.value
                                ? Container()
                                : ButtonWidget(
                                    buttonText: AppMetaLabels().verify,
                                    onPress: () {
                                      // vUOController.verifyOtpBtn();
                                    },
                                  ),
                          ),
                          if (!authController.loadingData.value)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  authController.error.value = '';
                                  authController
                                      .resendProgressBarLoading.value = false;
                                  authController.errorValidateUser.value = '';
                                  authController.resendProgressBar.value = true;
                                });
                                SessionController().setDialingCode(
                                  '+971',
                                );
                                final CountryPickerController
                                    countryController =
                                    Get.put(CountryPickerController());
                                countryController.selectedDialingCode.value =
                                    '+971';
                                Get.back();
                              },
                              child: Text(
                                AppMetaLabels().cancel,
                                style: AppTextStyle.semiBoldWhite12,
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
