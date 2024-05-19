import 'package:fap_properties/utils/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoadingIndicatorWhite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.whiteColor,
        strokeWidth: 0.5.h,
      ),
    );
  }
}
