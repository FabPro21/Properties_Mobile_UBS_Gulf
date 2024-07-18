import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/auth/otp_firebase/otp_firebase_controller.dart';
import 'package:fap_properties/views/auth/verify_user_otp/verify_user_otp_controller.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';

class PinCodeField extends StatelessWidget {
  final TextEditingController smsController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final String otpCodeForVerifyOTP;
  PinCodeField({Key key, this.otpCodeForVerifyOTP}) : super(key: key);
  final VerifyUserOtpController vUOController =
      Get.find<VerifyUserOtpController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    return Form(
      key: formKey,
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.1.h, horizontal: 1.0.w),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: PinCodeTextField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              appContext: context,
              pastedTextStyle: AppTextStyle.normalWhite12,
              length: 6,

              obscureText: true,
              animationType: AnimationType.fade,
              autoFocus: false,

              validator: (v) {
                if (v.length < 6) {
                  return null;
                } else {
                  return null;
                }
              },
              pinTheme: PinTheme(
                selectedColor: Colors.white,
                disabledColor: Colors.red,
                errorBorderColor: Colors.red,
                selectedFillColor: Colors.transparent,
                activeColor: Colors.white,
                inactiveColor: vUOController.validOTP.value == false
                    ? vUOController.changeColor
                    : Colors.white54,
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(1.0.h),
                fieldHeight: 6.0.h,
                fieldWidth: 12.0.w,
                activeFillColor: Colors.transparent,
                inactiveFillColor: Colors.transparent,
              ),
              cursorColor: Colors.white,
              animationDuration: const Duration(milliseconds: 300),
              textStyle: AppTextStyle.normalWhite12,
              backgroundColor: Colors.transparent,
              enableActiveFill: true,
              // errorAnimationController: errorController,
              controller: smsController,
              keyboardType:
                  TextInputType.numberWithOptions(signed: true, decimal: true),
              onCompleted: (v) async {
                FocusScope.of(context).unfocus();
                vUOController.validOTP.value = true;
                await vUOController.verifyOtpBtn(
                    smsController.text, otpCodeForVerifyOTP);
              },
              onChanged: (value) {
                // vUOController.currentText.value = value;
              },
              beforeTextPaste: (text) {
                return true;
              },
            ),
          )),
    );
  }
}

// ignore: must_be_immutable
class PinCodeFieldFB extends StatefulWidget {
  final String otpCodeForVerifyOTP;
  final bool isForgotMpin;
  FirebaseAuthController controller;
  PinCodeFieldFB(
      {Key key, this.otpCodeForVerifyOTP, this.controller, this.isForgotMpin})
      : super(key: key);

  @override
  State<PinCodeFieldFB> createState() => _PinCodeFieldFBState();
}

class _PinCodeFieldFBState extends State<PinCodeFieldFB> {
  final TextEditingController smsController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    return Form(
      key: formKey,
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.1.h, horizontal: 1.0.w),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: PinCodeTextField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              appContext: context,
              pastedTextStyle: AppTextStyle.normalWhite12,
              length: 6,
              obscureText: true,
              animationType: AnimationType.fade,
              autoFocus: false,
              validator: (v) {
                if (v.length < 6) {
                  return null;
                } else {
                  return null;
                }
              },
              pinTheme: PinTheme(
                selectedColor: Colors.white,
                disabledColor: Colors.red,
                errorBorderColor: Colors.red,
                selectedFillColor: Colors.transparent,
                activeColor: Colors.white,
                inactiveColor: widget.controller.error.value != ''
                    ? Colors.red
                    : widget.controller.validOTP.value == false
                        ? Colors.grey
                        : Colors.white54,
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(1.0.h),
                fieldHeight: 6.0.h,
                fieldWidth: 12.0.w,
                activeFillColor: Colors.transparent,
                inactiveFillColor: Colors.transparent,
              ),
              cursorColor: Colors.white,
              animationDuration: const Duration(milliseconds: 300),
              textStyle: AppTextStyle.normalWhite12,
              backgroundColor: Colors.transparent,
              enableActiveFill: true,
              // errorAnimationController: errorController,
              controller: smsController,
              keyboardType:
                  TextInputType.numberWithOptions(signed: true, decimal: true),
              onCompleted: (v) async {
                FocusScope.of(context).unfocus();
                setState(() {
                  widget.controller.validOTP.value = true;
                  widget.controller.error.value = '';
                });

                if (widget.isForgotMpin == true) {
                  widget.controller.signInWithPhoneNumberForgotMpin(v);
                  widget.controller.otpManuallyVerified = true;
                } else {
                  widget.controller.signInWithPhoneNumber(v);
                  widget.controller.otpManuallyVerified = true;
                }
                // before forgot mpin
                // widget.controller.signInWithPhoneNumber(v);
              },
              onChanged: (value) {
                // vUOController.currentText.value = value;
              },
              beforeTextPaste: (text) {
                return false;
              },
            ),
          )),
    );
  }
  // before handle the issue of copy paste
// // ignore: must_be_immutable
// class PinCodeFieldFB extends StatefulWidget {
//   final String otpCodeForVerifyOTP;
//   final bool isForgotMpin;
//   FirebaseAuthController controller;
//   PinCodeFieldFB(
//       {Key key, this.otpCodeForVerifyOTP, this.controller, this.isForgotMpin})
//       : super(key: key);

//   @override
//   State<PinCodeFieldFB> createState() => _PinCodeFieldFBState();
// }

// class _PinCodeFieldFBState extends State<PinCodeFieldFB> {
//   final TextEditingController smsController = TextEditingController();

//   final formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {});
//     return Form(
//       key: formKey,
//       child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 0.1.h, horizontal: 1.0.w),
//           child: Directionality(
//             textDirection: TextDirection.ltr,
//             child: PinCodeTextField(
//               inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//               appContext: context,
//               pastedTextStyle: AppTextStyle.normalWhite12,
//               length: 6,
//               obscureText: true,
//               animationType: AnimationType.fade,
//               autoFocus: false,
//               validator: (v) {
//                 if (v.length < 6) {
//                   return null;
//                 } else {
//                   return null;
//                 }
//               },
//               pinTheme: PinTheme(
//                 selectedColor: Colors.white,
//                 disabledColor: Colors.red,
//                 errorBorderColor: Colors.red,
//                 selectedFillColor: Colors.transparent,
//                 activeColor: Colors.white,
//                 inactiveColor: widget.controller.error.value != ''
//                     ? Colors.red
//                     : widget.controller.validOTP.value == false
//                         ? Colors.grey
//                         : Colors.white54,
//                 shape: PinCodeFieldShape.box,
//                 borderRadius: BorderRadius.circular(1.0.h),
//                 fieldHeight: 6.0.h,
//                 fieldWidth: 12.0.w,
//                 activeFillColor: Colors.transparent,
//                 inactiveFillColor: Colors.transparent,
//               ),
//               cursorColor: Colors.white,
//               animationDuration: const Duration(milliseconds: 300),
//               textStyle: AppTextStyle.normalWhite12,
//               backgroundColor: Colors.transparent,
//               enableActiveFill: true,
//               // errorAnimationController: errorController,
//               controller: smsController,
//               keyboardType:
//                   TextInputType.numberWithOptions(signed: true, decimal: true),
//               onCompleted: (v) async {
//                 FocusScope.of(context).unfocus();
//                 setState(() {
//                   widget.controller.validOTP.value = true;
//                   widget.controller.error.value = '';
//                 });
//                 if (widget.isForgotMpin == true) {
//                   widget.controller.signInWithPhoneNumberForgotMpin(v);
//                 } else {
//                   widget.controller.signInWithPhoneNumber(v);
//                 }
//                 // before forgot mpin
//                 // widget.controller.signInWithPhoneNumber(v);
//               },
//               onChanged: (value) {
//                 // vUOController.currentText.value = value;
//               },
//               beforeTextPaste: (text) {
//                 return false;
//               },
//             ),
//           )),
//     );
//   }
}
