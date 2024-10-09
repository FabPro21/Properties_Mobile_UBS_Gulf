import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/auth/splash_screen/splash_screen_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/app_logo_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/background_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../data/helpers/session_controller.dart';

// ignore: must_be_immutable
class SSLPinningScreen extends StatefulWidget {
  @override
  State<SSLPinningScreen> createState() => _SSLPinningScreenState();
}

class _SSLPinningScreenState extends State<SSLPinningScreen> {
  final splashScreenController = Get.put(SplashScreenController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Directionality(
        textDirection: SessionController().getLanguage() == 1
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: Stack(
          children: [
            const AppBackgroundImage(),
            SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 9.0.h),
                        child: const AppLogoCollier(),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 15.h),
                          child: Icon(
                            Icons.error,
                            size: 45.w,
                            color: Colors.white30,
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: Text(AppMetaLabels().connectionNotSecure,
                            style: AppTextStyle.semiBoldWhite14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
