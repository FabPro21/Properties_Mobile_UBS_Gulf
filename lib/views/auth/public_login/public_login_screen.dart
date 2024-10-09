import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_white.dart';
import 'package:fap_properties/views/public_views/search_properties_dashboard_tabs/search_properties_dashboard_tabs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/meta_labels.dart';
import '../../../utils/styles/colors.dart';
import '../../../utils/styles/text_styles.dart';
import '../../widgets/common_widgets/app_logo_widget.dart';
import '../../widgets/common_widgets/background_image_widget.dart';

import 'package:sizer/sizer.dart';

import '../../widgets/common_widgets/button_widget.dart';
import 'public_login_controller.dart';

class PublicLoginScreen extends GetView<PublicLoginController> {
  PublicLoginScreen({Key? key}) : super(key: key) {
    Get.put(PublicLoginController());
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // resizeToAvoidBottomInset: false,
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
                        padding: EdgeInsets.only(top: 7.0.h),
                        child: Text(
                          AppMetaLabels().login,
                          style: AppTextStyle.semiBoldWhite13,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 9.0.h),
                        child: const AppLogoCollier(),
                      ),
                      Obx(() {
                        return controller.loadingProfile.value
                            ? Padding(
                                padding: EdgeInsets.only(top: 20.h),
                                child: LoadingIndicatorWhite(),
                              )
                            : controller.errorLoadingProfile != ''
                                ? Padding(
                                    padding: EdgeInsets.only(top: 20.h),
                                    child: AppErrorWidget(
                                      errorText: controller.errorLoadingProfile,
                                      onRetry: () {
                                        controller.getPublicProfile();
                                      },
                                    ),
                                  )
                                : Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 6.0.h, bottom: 1.h),
                                          child: Text(
                                            controller.profileData!
                                                    .profileDetail!.mobile ??
                                                "",
                                            style: AppTextStyle.normalWhite12,
                                          ),
                                        ),
                                        Text(
                                          AppMetaLabels().updateYourProfile,
                                          style: AppTextStyle.normalWhite12,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: 5.0.h,
                                            bottom: 5.h,
                                          ),
                                          child: Form(
                                            key: formKey,
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  controller: controller
                                                      .nameTextController,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.length < 3)
                                                      return AppMetaLabels()
                                                          .pleaseEnterName;
                                                    else
                                                      return null;
                                                  },
                                                  onChanged: (value) {
                                                    if (value !=
                                                            controller
                                                                .profileData!
                                                                .profileDetail!
                                                                .fullName ||
                                                        value !=
                                                            controller
                                                                .profileData!
                                                                .profileDetail!
                                                                .fullNameAr)
                                                      controller.updateEnabled
                                                          .value = true;
                                                  },
                                                  style: AppTextStyle
                                                      .normalWhite12,
                                                  decoration: InputDecoration(
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      borderSide: BorderSide(
                                                        color: AppColors
                                                            .whiteColor,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      borderSide: BorderSide(
                                                        color: AppColors
                                                            .whiteColor,
                                                      ),
                                                    ),
                                                    labelText:
                                                        AppMetaLabels().name,
                                                    labelStyle: AppTextStyle
                                                        .normalWhite12,
                                                    errorStyle:
                                                        TextStyle(fontSize: 0),
                                                    contentPadding:
                                                        EdgeInsets.all(4.w),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                TextFormField(
                                                  controller: controller
                                                      .emailTextController,
                                                  onChanged: (value) {
                                                    if (value !=
                                                        controller
                                                            .profileData!
                                                            .profileDetail!
                                                            .email)
                                                      controller.updateEnabled
                                                          .value = true;
                                                  },
                                                  style: AppTextStyle
                                                      .normalWhite12,
                                                  decoration: InputDecoration(
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      borderSide: BorderSide(
                                                        color: AppColors
                                                            .whiteColor,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      borderSide: BorderSide(
                                                        color: AppColors
                                                            .whiteColor,
                                                      ),
                                                    ),
                                                    labelText:
                                                        AppMetaLabels().email,
                                                    labelStyle: AppTextStyle
                                                        .normalWhite12,
                                                    errorStyle:
                                                        TextStyle(fontSize: 0),
                                                    contentPadding:
                                                        EdgeInsets.all(4.w),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        controller.updatingProfile.value
                                            ? LoadingIndicatorWhite()
                                            : ButtonWidget(
                                                buttonText: AppMetaLabels()
                                                    .updateProfile,
                                                onPress: controller
                                                        .updateEnabled.value
                                                    ? () {
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                        if (formKey
                                                            .currentState!
                                                            .validate())
                                                          controller
                                                              .updateProfile();
                                                      }
                                                    : null,
                                              ),
                                        if (controller.canSkip &&
                                            !controller.updatingProfile.value)
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 2.h,
                                            ),
                                            child: ButtonWidget(
                                              buttonText: AppMetaLabels().skip,
                                              onPress: () {
                                                Get.offAll(() =>
                                                    SearchPropertiesDashboardTabs());
                                              },
                                            ),
                                          ),
                                      ],
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
