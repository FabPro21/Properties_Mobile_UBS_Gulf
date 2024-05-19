import 'package:fap_properties/utils/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomDropDown extends StatelessWidget {
  final Function onPressed;
  final String icon;
  final String selectedValue;
  const CustomDropDown({Key key, this.onPressed, this.icon, this.selectedValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            side: BorderSide(color: AppColors.greyColor2, width: 0.3)),
        onPressed: onPressed,
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
                selectedValue,
                style: TextStyle(
                    color: AppColors.greyColor2,
                    fontSize: 14.sp,
                    fontFamily: "NexaLight",
                    fontWeight: FontWeight.normal),
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
