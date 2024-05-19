import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/app_logo_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/background_image_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../data/helpers/session_controller.dart';

// ignore: must_be_immutable
class NoInternetScreen extends StatefulWidget {
  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
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
                        child: const AppLogo(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15.h),
                        child: Image.asset(
                          AppImagesPath.noInternet,
                          width: 45.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: Text(AppMetaLabels().noInternetConnection,
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
                                Get.back(result: true);
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
