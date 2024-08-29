import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/auth/otp_firebase/validate_user_fb.dart';
import 'package:fap_properties/views/auth/validate_user/validate_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AlertWidget extends StatelessWidget {
  final String t1;
  final String t2;
  AlertWidget(this.t1, this.t2, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 30.0.h,
        width: 80.0.w,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2.0.h),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 0.5.h,
                spreadRadius: 0.8.h,
                offset: Offset(0.1.h, 0.1.h),
              ),
            ]),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(2.0.h),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 36, 27, 0.1),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(1.7.h),
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.red,
                    size: 3.5.h,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(2.0.h),
              child: Text(
                t1,
                style: AppTextStyle.semiBoldBlack12,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(1.0.h),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1.3.h),
                  ),
                  backgroundColor: Color.fromRGBO(0, 61, 166, 1),
                  padding:
                      EdgeInsets.symmetric(horizontal: 11.0.h, vertical: 1.8.h),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Get.offAll(() => SessionController().enableFireBaseOTP
                      ? ValidateUserScreenFB()
                      : ValidateUserScreen());
                  // vUOController.otpAttemptsCounter.value = 0;
                },
                child: Text(
                  t2,
                  style: AppTextStyle.semiBoldWhite11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
