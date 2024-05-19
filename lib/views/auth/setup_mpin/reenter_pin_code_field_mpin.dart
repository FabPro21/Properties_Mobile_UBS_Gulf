import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/auth/setup_mpin/setup_mpin_controller.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';

class ReEnterPinCodeFieldMpin extends StatelessWidget {
  final TextEditingController reEnterMpinController = TextEditingController();
  // static StreamController<ErrorAnimationType> errorController;
  final formKey = GlobalKey<FormState>();

  ReEnterPinCodeFieldMpin({Key key}) : super(key: key);
  final SetupMpinController setupMpinController =
      Get.find<SetupMpinController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: PinCodeTextField(
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        appContext: context,
        pastedTextStyle: AppTextStyle.normalWhite12,
        length: 6,
        obscureText: true,

        animationType: AnimationType.fade,
        // autoFocus: true,
        validator: (v) {
          if (v.length < 6 ||
              !setupMpinController.mpinMatch.value ||
              !setupMpinController.difficulty.value) {
            return '';
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
          inactiveColor: setupMpinController.mpinLength.value == false
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
        controller: reEnterMpinController,
        keyboardType:
            TextInputType.numberWithOptions(signed: true, decimal: true),
        onCompleted: (v) async {
          FocusScope.of(context).unfocus();
        },
        onChanged: (value) {
          setupMpinController.reEnterMpinController.value = value;
        },
        beforeTextPaste: (text) {
          return true;
        },
      ),
    );
  }
}
