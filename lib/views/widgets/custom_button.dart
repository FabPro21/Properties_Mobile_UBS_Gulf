import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/styles/colors.dart';
import '../../utils/styles/text_styles.dart';

class CustomButton extends StatelessWidget {
  final Function? onPressed;
  final String? text;
  final bool? loading;
  const CustomButton({super.key, this.onPressed, this.text, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loading!
          ? null
          : () {
              onPressed!();
            },
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.0.sp),
          ),
          backgroundColor: AppColors.blueColor2,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 8)),
      child: loading!
          ? AnimatedTextKit(
              isRepeatingAnimation: true,
              repeatForever: true,
              pause: const Duration(milliseconds: 10),
              animatedTexts: [
                ColorizeAnimatedText(text ?? '',
                    textStyle: AppTextStyle.normalBlue11,
                    colors: [
                      AppColors.blueColor,
                      AppColors.blueColor2,
                      AppColors.blueColor
                    ],
                    speed: const Duration(milliseconds: 200)),
              ],
            )
          : Text(
              text ?? '',
              style: AppTextStyle.normalBlue11,
            ),
    );
  }
}

class CustomButtonWithoutBackgroud extends StatelessWidget {
  final Function? onPressed;
  final String? text;
  final Color? borderColor;
  final bool? loading;
  const CustomButtonWithoutBackgroud(
      {super.key,
      this.onPressed,
      this.text,
      this.loading = false,
      @required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loading!
          ? null
          : () {
              onPressed!();
            },
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3.0.sp),
              side: BorderSide(
                color: borderColor!,
                width: 1.0,
              )),
          backgroundColor: AppColors.whiteColor,
          shadowColor: borderColor,
          padding: const EdgeInsets.symmetric(horizontal: 8)),
      child: loading!
          ? AnimatedTextKit(
              isRepeatingAnimation: true,
              repeatForever: true,
              pause: const Duration(milliseconds: 10),
              animatedTexts: [
                ColorizeAnimatedText(text ?? '',
                    textStyle: AppTextStyle.normalBlue11,
                    colors: [
                      AppColors.blueColor,
                      AppColors.blueColor2,
                      AppColors.blueColor
                    ],
                    speed: const Duration(milliseconds: 200)),
              ],
            )
          : Text(
              text ?? '',
              style: AppTextStyle.normalBlue11.copyWith(
                  color: text == 'Vacate'
                      ? const Color.fromARGB(255, 197, 18, 6)
                      : text == 'Offer Letter'
                          ? AppColors.blackColor
                          : AppColors.blueColor),
            ),
    );
  }
}

class CustomButtonRed extends StatelessWidget {
  final Function? onPressed;
  final String? text;
  final bool? loading;
  const CustomButtonRed(
      {super.key, this.onPressed, this.text, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loading!
          ? null
          : () {
              onPressed!();
            },
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.0.sp),
          ),
          backgroundColor: AppColors.redColor2,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 8)),
      child: loading!
          ? AnimatedTextKit(
              isRepeatingAnimation: true,
              repeatForever: true,
              pause: const Duration(milliseconds: 10),
              animatedTexts: [
                ColorizeAnimatedText(text ?? '',
                    textStyle: AppTextStyle.normalWhite11,
                    colors: [
                      AppColors.white54,
                      AppColors.whiteColor,
                      AppColors.white54
                    ],
                    speed: const Duration(milliseconds: 200)),
              ],
            )
          : Text(
              text ?? '',
              style: AppTextStyle.normalWhite11,
            ),
    );
  }
}
