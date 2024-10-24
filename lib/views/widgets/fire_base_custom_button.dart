// ignore: must_be_immutable
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final text;
  final onPressed;
  bool enabled = true;
  bool loading = false;

  CustomButton({
    Key? key,
    @required this.text,
    @required this.onPressed,
    this.enabled = true,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return loading
        ? CircularProgressIndicator(
            color: AppColors.white54,
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: enabled ? Colors.white : AppColors.greyBG,
            ),
            child: SizedBox(
                height: 50,
                width: double.infinity,
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                        color: enabled
                            ? AppColors.blueColor
                            : AppColors.blackColor,
                        fontFamily: "MerriweatherBold",
                        fontSize: 15.4.sp),
                  ),
                )));
  }
}
