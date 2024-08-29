import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/auth/otp_firebase/otp_firebase_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'validate_user_controller.dart';

class PhoneNoField extends StatelessWidget {
  PhoneNoField({Key? key}) : super(key: key);
  static final TextEditingController phoneController = TextEditingController();
  final tooltipKey = GlobalKey<State<Tooltip>>();
  final vUController = Get.put(ValidateUserController());

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: phoneController,
      onTap: () {
        vUController.textFieldTap.value = true;
      },
      cursorHeight: 3.0.h,
      style: AppTextStyle.normalWhite13,
      keyboardType:
          TextInputType.numberWithOptions(signed: true, decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(12),
      ],
      onSubmitted: (a) {
        FocusScope.of(context).unfocus();

        vUController.textFieldTap.value = false;
      },
      onEditingComplete: () async {
        await vUController.getOtpBtn();
        FocusScope.of(context).unfocus();

        vUController.textFieldTap.value = false;
      },
      decoration: InputDecoration(
        suffixIcon: Tooltip(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          textStyle: AppTextStyle.normalBlack10,
          key: tooltipKey,
          message: AppMetaLabels().validPhoneNo,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _onTap(tooltipKey),
            child: Icon(
              Icons.info_outline,
              color: AppColors.whiteColor,
            ),
          ),
        ),
        contentPadding: EdgeInsets.zero,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1.3.h),
          borderSide: BorderSide(color: Colors.transparent, width: 0.1.h),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1.3.h),
          borderSide: BorderSide(color: Colors.transparent, width: 0.1.h),
        ),
      ),
      cursorColor: Colors.white,
    );
  }

  void _onTap(GlobalKey key) {
    final dynamic tooltip = key.currentState;
    tooltip?.ensureTooltipVisible();
  }
}

class PhoneNoFieldFB extends StatelessWidget {
  PhoneNoFieldFB({Key? key}) : super(key: key);
  static final TextEditingController phoneController = TextEditingController();
  final tooltipKey = GlobalKey<State<Tooltip>>();
  final vUController = Get.put(FirebaseAuthController());

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: phoneController,
      onTap: () {
        vUController.textFieldTap.value = true;
      },
      cursorHeight: 3.0.h,
      style: AppTextStyle.normalWhite13,
      keyboardType:
          TextInputType.numberWithOptions(signed: true, decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(12),
      ],
      onSubmitted: (a) {
        FocusScope.of(context).unfocus();

        vUController.textFieldTap.value = false;
      },
      onEditingComplete: () async {
        await vUController.validateMobileUser();
        FocusScope.of(context).unfocus();
        vUController.textFieldTap.value = false;
      },
      decoration: InputDecoration(
        suffixIcon: Tooltip(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          textStyle: AppTextStyle.normalBlack10,
          key: tooltipKey,
          message: AppMetaLabels().validPhoneNo,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _onTap(tooltipKey),
            child: Icon(
              Icons.info_outline,
              color: vUController.error.value != '' ||
                      vUController.errorValidateUser.value != ""
                  ? AppColors.redColor
                  : AppColors.whiteColor,
            ),
          ),
        ),
        contentPadding: EdgeInsets.zero,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1.3.h),
          borderSide: BorderSide(color: Colors.transparent, width: 0.1.h),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1.3.h),
          borderSide: BorderSide(color: Colors.transparent, width: 0.1.h),
        ),
      ),
      cursorColor: Colors.white,
    );
  }

  void _onTap(GlobalKey key) {
    final dynamic tooltip = key.currentState;
    tooltip?.ensureTooltipVisible();
  }
}
