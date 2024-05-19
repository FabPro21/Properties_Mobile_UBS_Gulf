import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/auth/otp_firebase/otp_firebase_controller.dart';
import 'package:fap_properties/views/auth/verify_user_otp/verify_user_otp_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_white.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ResendOtp extends StatelessWidget {
  ResendOtp({Key key}) : super(key: key);
  final VerifyUserOtpController vUOController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SizedBox(
        width: 90.0.w,
        child: vUOController.resending.value
            ? LoadingIndicatorWhite()
            : OutlinedButton(
                onPressed: () async {
                  vUOController.resendOtpBtn();
                  vUOController.resendCounter.value++;
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    width: 0.1.w,
                    color: AppColors.whiteColor,
                    style: BorderStyle.solid,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(1.3.h),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: Text(
                    AppMetaLabels().resentOtp,
                    style: AppTextStyle.semiBoldWhite13,
                  ),
                ),
              ),
      );
    });
  }
}

class ResendOtpFB extends StatefulWidget {
  ResendOtpFB({Key key}) : super(key: key);

  @override
  State<ResendOtpFB> createState() => _ResendOtpFBState();
}

class _ResendOtpFBState extends State<ResendOtpFB> {
  final FirebaseAuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SizedBox(
        width: 90.0.w,
        child: authController.resending.value
            ? LoadingIndicatorWhite()
            : OutlinedButton(
                onPressed: () async {
                  setState(() {
                    authController.resendProgressBar.value = false;
                    authController.resendProgressBarLoading.value = true;
                  });
                  await authController
                      .resendingOtp(SessionController().getPhone());
                  print('After ::::: func call ::::');
                  setState(() {
                    authController.resendCounter++;
                  });
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    width: 0.1.w,
                    color: AppColors.whiteColor,
                    style: BorderStyle.solid,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(1.3.h),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: Text(
                    AppMetaLabels().resentOtp,
                    style: AppTextStyle.semiBoldWhite13,
                  ),
                ),
              ),
      );
    });
  }
}
