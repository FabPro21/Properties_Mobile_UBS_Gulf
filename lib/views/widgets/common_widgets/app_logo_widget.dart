import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5.5.h,
      width: double.infinity,
      child: Image.asset(
        AppImagesPath.appLogoPropt,
        fit: BoxFit.contain,
        ),
      );
  }
}
