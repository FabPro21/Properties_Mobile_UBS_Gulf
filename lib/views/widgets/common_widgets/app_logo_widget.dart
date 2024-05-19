import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key key}) : super(key: key);

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

class AppLogoMenaRealEstateDB extends StatelessWidget {
  final TextStyle menaFontSize;
  final TextStyle menaRealEstateSolFont;
  final double height;
  const AppLogoMenaRealEstateDB(
      {Key key,
      this.menaFontSize,
      this.menaRealEstateSolFont,
      @required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  AppMetaLabels().mena.toUpperCase(),
                  style: menaFontSize,
                ),
                SizedBox(
                  width: 3.w,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    AppMetaLabels()
                        .menaRealEstateSol
                        .replaceAll('MENA', '')
                        .replaceAll('مينا', '')
                        .trim()
                        .toUpperCase(),
                    style: menaRealEstateSolFont,
                  ),
                )
              ]),
        ],
      ),
    );
  }
}

class AppLogoMenaRealEstate extends StatelessWidget {
  final TextStyle menaFontSize;
  final TextStyle menaReaEstateEnglishFont;
  final double height;
  const AppLogoMenaRealEstate(
      {Key key,
      this.menaFontSize,
      this.menaReaEstateEnglishFont,
      @required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.0.w,
      height: height,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppMetaLabels().mena.toUpperCase(),
              style: menaFontSize,
            ),
            SizedBox(
              width: 3.w,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: SizedBox(
                width: 32.0.w,
                child: Text(
                  AppMetaLabels()
                      .menaRealEstateSol
                      .toUpperCase()
                      .replaceFirst('MENA', '')
                      .replaceAll('مينا', '')
                      .trim(),
                  style: menaReaEstateEnglishFont.copyWith(
                    height: 1.3,
                  ),
                  maxLines: 2,
                ),
              ),
            )
          ]),
    );
  }
}
