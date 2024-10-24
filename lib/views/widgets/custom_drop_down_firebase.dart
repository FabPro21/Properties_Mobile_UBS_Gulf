import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomDropDown extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? icon;
  final String? selectedValue;
  const CustomDropDown(
      {Key? key, this.onPressed, this.icon, this.selectedValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            side: BorderSide(color: AppColors.greyColor2, width: 0.3)),
        onPressed: onPressed!,
        child: Padding(
          padding: EdgeInsets.all(2.w),
          child: Row(
            children: [
              Icon(
                Icons.flag,
                size: 6.w,
              ),
              SizedBox(
                width: 2.w,
              ),
              Text(
                selectedValue!,
                style: AppTextStyle.normalGrey12,
              ),
              Spacer(),
              Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 20,
              )
            ],
          ),
        ));
  }
}
