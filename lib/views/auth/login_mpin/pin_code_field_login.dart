import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/auth/login_mpin/login_mpin_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeFieldLoginMpin extends StatelessWidget {
  final TextEditingController smsController = TextEditingController();
  // static StreamController<ErrorAnimationType> errorController;
  final formKey = GlobalKey<FormState>();

  PinCodeFieldLoginMpin({Key? key}) : super(key: key);
  final LoginMpinController loginMpinController =
      Get.find<LoginMpinController>();

  @override
  Widget build(BuildContext context) {
    print('********************* LoginMpin *****************');
    return Obx(() {
      return Form(
        key: formKey,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0.1.h, horizontal: 12.0.w),
            child: PinCodeTextField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              appContext: context,
              pastedTextStyle: AppTextStyle.normalWhite12,
              length: 6,
              obscureText: true,
              animationType: AnimationType.fade,
              // autoFocus: true,
              validator: (v) {
                if (v!.length < 6) {
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
                inactiveColor: loginMpinController.validMpin.value == false
                    ? Colors.red
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
                loginMpinController.validateRoleByMpin();
                // smsController.clear();
              },
              onChanged: (value) {
                loginMpinController.currentText.value = value;
              },
              beforeTextPaste: (text) {
                return true;
              },
            )),
      );
    });
  }
}
