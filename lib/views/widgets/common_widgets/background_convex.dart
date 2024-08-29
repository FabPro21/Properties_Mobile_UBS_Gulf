import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppBackgroundConvex extends StatelessWidget {
  const AppBackgroundConvex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0.w,
      // height: 100.0.h,
      child: Image.asset(
        AppImagesPath.convex,
        fit: BoxFit.contain,
      ),
    );
  }
}
