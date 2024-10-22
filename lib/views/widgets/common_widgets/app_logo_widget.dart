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
        width: 50.w,
        height: 33.6.w,
        child: Image.asset(
          AppImagesPath.colliersLogoType,
          fit: BoxFit.fill,
        ));
  }
}

class AppLogoCollierDashboard extends StatelessWidget {
  const AppLogoCollierDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 18.75.w,
        height: 12.0.w,
        child: Image.asset(
          AppImagesPath.colliersLogoType,
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
