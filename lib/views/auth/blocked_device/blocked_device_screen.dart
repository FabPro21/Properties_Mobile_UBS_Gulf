import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/app_logo_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/background_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:sizer/sizer.dart';

import '../../../data/helpers/session_controller.dart';
import 'blocked_device_controller.dart';

class BlockedDeviceScreen extends StatelessWidget {
  BlockedDeviceScreen({Key? key}) : super(key: key);

  final btController = Get.put(BlockedDeviceController());
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
                        child: const AppLogoMena(),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 15.h),
                          child: Icon(
                            Icons.error,
                            size: 45.w,
                            color: Colors.white30,
                          )),
                      Obx(() {
                        return Padding(
                          padding: EdgeInsets.only(top: 2.h),
                          child: Container(
                            // width: 40.0.w,
                            // color: AppColors.redColor,
                            child: Column(
                              children: [
                                Text(
                                  AppMetaLabels().deviceBlocked,
                                  style: AppTextStyle.semiBoldWhite10,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 2.0.h,
                                ),
                                Text(
                                  '${btController.secText} ${AppMetaLabels().seconds}',
                                  style: AppTextStyle.semiBoldWhite14,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
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
