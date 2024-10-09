import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/app_logo_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/background_image_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../data/helpers/session_controller.dart';
import '../auth/splash_screen/splash_screen.dart';

// ignore: must_be_immutable
class NoServiceScreen extends StatefulWidget {
  @override
  State<NoServiceScreen> createState() => _NoServiceScreenState();
}

class _NoServiceScreenState extends State<NoServiceScreen> {
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
                        child: Text(AppMetaLabels().noService,
                            style: AppTextStyle.semiBoldWhite14),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 10.0.h),
                          child: ButtonWidget(
                            buttonText: AppMetaLabels().retry,
                            onPress: () async {
                              bool _isInternetConnected =
                                  await BaseClientClass.isInternetConnected();
                              if (_isInternetConnected) {
                                Get.offAll(() => SplashScreen());
                              }
                            },
                          ))
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
