import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:flutter/material.dart';

class SrNoWidget extends StatelessWidget {
  final dynamic text;
  final Color? background;
  final double? size;
  final Color? textColor;
  const SrNoWidget(
      {Key? key,
      this.text = '',
      this.background = AppColors.chartlightBlueColor,
      this.size,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: background,
      ),
      child: Text(
        text.toString(),
          style: AppTextStyle.semiBoldGrey12.copyWith(color: textColor),
        // style: AppTextStyle.semiBoldGrey11.copyWith(color: textColor),
      ),
    );
  }
}
