import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/styles/colors.dart';
import '../../utils/styles/text_styles.dart';

class CustomButton2 extends StatelessWidget {
  final Function? onPressed;
  final String? text;
  final bool? loading;
  const CustomButton2(
      {Key? key, this.onPressed, this.text, this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: loading!
          ? null
          : () {
              onPressed!();
            },
      child: loading!
          ? AnimatedTextKit(
              isRepeatingAnimation: true,
              repeatForever: true,
              pause: Duration(milliseconds: 10),
              animatedTexts: [
                ColorizeAnimatedText(text ?? '',
                    textStyle: AppTextStyle.normalBlue11,
                    colors: [
                      AppColors.blueColor,
                      AppColors.blueColor2,
                      AppColors.blueColor
                    ],
                    speed: Duration(milliseconds: 200)),
              ],
            )
          : Text(
              text ?? '',
              style: AppTextStyle.normalBlue11,
            ),
      style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.blueColor2, shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.0.sp),
          ),
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 8)),
    );
  }
}
