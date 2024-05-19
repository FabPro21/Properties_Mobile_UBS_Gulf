import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/app_const.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/auth/validate_user/validate_user_controller.dart';
import 'package:fap_properties/views/auth/verify_user_otp/pin_code_field_otp.dart';
import 'package:fap_properties/views/auth/verify_user_otp/resend_otp.dart';
import 'package:fap_properties/views/auth/verify_user_otp/verify_user_otp_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/background_image_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/button_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_white.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class VerifyUserOtpScreen extends StatefulWidget {
  final String otpCodeForVerifyOTP;
  VerifyUserOtpScreen({Key key, this.otpCodeForVerifyOTP}) : super(key: key);

  @override
  State<VerifyUserOtpScreen> createState() => _VerifyUserOtpScreenState();
}

class _VerifyUserOtpScreenState extends State<VerifyUserOtpScreen> {
  final vUController = Get.put(ValidateUserController());
  final vUOController = Get.put(VerifyUserOtpController());

  String getPhone() {
    var p = SessionController().getPhone();
    var l = p.length;
    var first = p.substring(0, 5);
    var last = p.substring(l - 3, l);
    return first + "****" + last;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
                        // Padding(
                        //   padding: EdgeInsets.only(top: 2.0.h),
                        //   child: Text(
                        //     AppMetaLabels().login,
                        //     style: AppTextStyle.normalWhite10,
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.only(top: 3.0.h),
                          child: Text(
                            AppMetaLabels().otpVerification,
                            style: AppTextStyle.semiBoldWhite13,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 10.0.h),
                          child: vUOController.loadingData.value
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
                          child: vUOController.loadingData.value
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
                            child: vUOController.loadingData.value
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
                                            style: AppTextStyle.semiBoldWhite10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    width: 85.0.w,
                                    child: PinCodeField(
                                        otpCodeForVerifyOTP:
                                            widget.otpCodeForVerifyOTP),
                                  ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 7.0.h),
                          child: vUOController.loadingData.value ||
                                  vUOController.resending.value ||
                                  vUOController.resendProgressBar.value
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

                        if (!vUOController.loadingData.value)
                          Padding(
                            padding: EdgeInsets.only(
                                top: 5.0.h, left: 5.0.h, right: 5.0.h),
                            child: vUOController.resendProgressBar.value
                                // ? Container(
                                //     decoration: BoxDecoration(
                                //       color: Colors.transparent,
                                //       borderRadius:
                                //           BorderRadius.circular(1.0.h),
                                //     ),
                                //     clipBehavior: Clip.hardEdge,
                                //     child: TweenAnimationBuilder<double>(
                                //         tween:
                                //             Tween<double>(begin: 1.0, end: 0.0),
                                //         duration: const Duration(
                                //             seconds: AppConst.resendOtpTime),
                                //         onEnd: () {
                                //           vUOController
                                //               .resendProgressBar.value = false;
                                //         },
                                //         builder: (context, value, _) {
                                //           return TweenAnimationBuilder(
                                //             tween: Tween(begin: 1.0, end: 0.0),
                                //             duration: Duration(minutes: 2),
                                //             builder: (BuildContext context,
                                //                 double value, Widget child) {
                                //               return LinearProgressIndicator(
                                //                 backgroundColor:
                                //                     AppColors.grey1,
                                //                 color: AppColors.whiteColor,
                                //                 minHeight: 0.6.h,
                                //                 value: value,
                                //               );
                                //             },
                                //             // child: LinearProgressIndicator(
                                //             //   backgroundColor: AppColors.grey1,
                                //             //   color: AppColors.whiteColor,
                                //             //   minHeight: 0.6.h,
                                //             //   value: value,
                                //             // ),
                                //           );
                                //         }))
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius:
                                          BorderRadius.circular(1.0.h),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: TweenAnimationBuilder<double>(
                                        tween:
                                            Tween<double>(begin: 1.0, end: 0.0),
                                        // setting the time for Progress
                                        duration: const Duration(
                                            seconds: AppConst.resendOtpTime),
                                        onEnd: () {
                                          vUOController
                                              .resendProgressBar.value = false;
                                        },
                                        builder: (context, value, _) {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback(
                                                  (timeStamp) {});
                                          return LinearProgressIndicator(
                                            backgroundColor: AppColors.grey1,
                                            color: AppColors.whiteColor,
                                            minHeight: 0.6.h,
                                            value: value,
                                          );
                                        }))
                                : vUOController.loadingData.value
                                    ? Container(
                                        height: 6.0.h,
                                      )
                                    : ResendOtp(),
                          ),

                        //////////////////////////////////////
                        /// Error Message
                        //////////////////////////////////////
                        Padding(
                          padding: EdgeInsets.only(
                            top: 2.0.h,
                          ),
                          child: vUOController.validOTP.value
                              ? Container()
                              : Container(
                                  width: 85.0.w,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 59, 48, 0.6),
                                    borderRadius: BorderRadius.circular(1.0.h),
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
                                          padding: EdgeInsets.only(left: 1.0.h),
                                          child: Container(
                                            width: 72.0.w,
                                            child: Text(
                                              AppMetaLabels().incorrectCode,
                                              style:
                                                  AppTextStyle.semiBoldWhite11,
                                              overflow: TextOverflow.ellipsis,
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
                          child: vUOController.loadingData.value ||
                                  vUOController.resending.value
                              ? Container()
                              : ButtonWidget(
                                  buttonText: AppMetaLabels().verify,
                                  onPress: () {
                                    // vUOController.verifyOtpBtn();
                                  },
                                ),
                        ),
                        if (!vUOController.loadingData.value)
                          TextButton(
                            onPressed: () {
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
    });
  }
}
