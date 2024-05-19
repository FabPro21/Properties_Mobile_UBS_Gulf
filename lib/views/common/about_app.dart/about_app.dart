import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/common/about_app.dart/about_app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;
import '../../widgets/custom_app_bar2.dart';

class AboutApp extends StatelessWidget {
  AboutApp({Key key}) : super(key: key);

  final controller = Get.put(AboutAppController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? ui.TextDirection.ltr
          : ui.TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Obx(() {
            return Column(
              children: [
                CustomAppBar2(
                  title: AppMetaLabels().about,
                ),
                Spacer(),
                //  Text('App Name: ${controller.version}'),
                SessionController().getLanguage() == 1
                    ? Text('App Version: ${controller.version}',
                        style: AppTextStyle.normalBlack14)
                    : Text('نسخة التطبيق:  ${controller.version}',
                        style: AppTextStyle.normalBlack14),
                SizedBox(height: 8),
                SessionController().getLanguage() == 1
                    ? Text('Build Number: ${controller.buildNo}',
                        style: AppTextStyle.normalBlack14)
                    : Text('اكمل العدد:  ${controller.buildNo}',
                        style: AppTextStyle.normalBlack14),
                 Text('Package:  ${controller.packageName.value }',
                    style: AppTextStyle.normalBlack14),
                Spacer(),
              ],
            );
          })),
    );
  }
}
