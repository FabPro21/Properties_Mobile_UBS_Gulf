// ignore_for_file: deprecated_member_use

import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onPress;
  final String buttonText;

  const ButtonWidget({Key key, this.buttonText, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.0.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1.3.h),
          ),
          primary: AppColors.whiteColor,
          padding: EdgeInsets.symmetric(horizontal: 6.0.h, vertical: 1.5.h),
          // textStyle: AppTextStyle.buttonTextStyle,
        ),
        onPressed: onPress,
        child: Text(
          buttonText,
          style: AppTextStyle.buttonTextStyle,
        ),
      ),
    );
  }
}

class ButtonWidgetBlue extends StatelessWidget {
  final VoidCallback onPress;
  final String buttonText;

  const ButtonWidgetBlue({Key key, this.buttonText, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.0.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1.3.h),
          ),
          primary: AppColors.blueColor,
          padding: EdgeInsets.symmetric(horizontal: 6.0.h, vertical: 1.5.h),
          // textStyle: AppTextStyle.buttonTextStyle,
        ),
        onPressed: onPress,
        child: Text(
          buttonText,
          style: AppTextStyle.buttonTextStyle.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
