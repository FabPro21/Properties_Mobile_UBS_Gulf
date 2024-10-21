import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.0.w,
      height: 10.0.h,
      child: Image.asset(
        AppImagesPath.appLogo,
        fit: BoxFit.contain,
      ),
    );
  }
}

class AppLogoCollier extends StatelessWidget {
  const AppLogoCollier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 80.0.w,
        height: 15.0.h,
        child: Image.asset(
          AppImagesPath.appLogo_Colliers,
          // AppImagesPath.colliersLogoType,
          fit: BoxFit.fill,
        ));
  }
}

class AppLogoCollierDashboard extends StatelessWidget {
  const AppLogoCollierDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 40.0.w,
        height: 5.0.h,
        child: Image.asset(
          AppImagesPath.appLogo_Colliers,
          // AppImagesPath.colliersLogoType,
          fit: BoxFit.fill,
        ));
  }
}
// class AppLogoMena extends StatelessWidget {
//   const AppLogoMena({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         width: 75.0.w,
//         height: 10.0.h,
//         child: SvgPicture.asset(AppImagesPath.menaAppLogo,
//             semanticsLabel: 'Acme Logo'));
//   }
// }
