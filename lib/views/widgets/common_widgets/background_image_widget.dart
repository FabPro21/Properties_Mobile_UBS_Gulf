import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:flutter/material.dart';

class AppBackgroundImage extends StatelessWidget {
  const AppBackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        AppImagesPath.backroud_Colliers,
        // AppImagesPath.backgroundImage,
        fit: BoxFit.fill,
      ),
    );
  }
}
