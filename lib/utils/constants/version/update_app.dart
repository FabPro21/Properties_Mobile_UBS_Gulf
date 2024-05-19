import 'dart:io';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/external/platform_check/platform_check.dart';
import 'package:launch_review/launch_review.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;

class AppUpdate extends StatefulWidget {
  final String appVersion;
  final String availableVersion;
  const AppUpdate(
      {Key key, @required this.appVersion, @required this.availableVersion})
      : super(key: key);

  @override
  State<AppUpdate> createState() => _AppUpdateState();
}

class _AppUpdateState extends State<AppUpdate> {
  @override
  Widget build(BuildContext context) {
    print(AppImagesPath.appStore);
    print(AppImagesPath.playStore);
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? ui.TextDirection.ltr
          : ui.TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImagesPath.splashGif),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: SafeArea(
                child: Container(
                    width: 90.0.w,
                    height: PlatformCheck.isAndroid == true ? 55.h : 60.h,
                    padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2.0.h),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 0.5.h,
                          spreadRadius: 0.3.h,
                          offset: Offset(0.1.h, 0.1.h),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 2.w,
                        right: 2.w,
                      ),
                      child: SingleChildScrollView(
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Cancel Button Icons.cross
                            InkWell(
                              onTap: () {
                                exit(0);
                              },
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 80.0.w,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(
                                      Icons.clear,
                                      size: 4.h,
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.5.h,
                            ),
                            // update text
                            Text(
                              AppMetaLabels().updateApp,
                              style: AppTextStyle.semiBoldBlack16.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                              ),
                            ),
                            SizedBox(
                              height: 2.5.h,
                            ),
                            // available version description
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: AppMetaLabels().aNewVersion,
                                    style: AppTextStyle.normalBlack12
                                        .copyWith(height: 1.2),
                                  ),
                                  TextSpan(
                                    text:
                                        AppMetaLabels().isAvailableAndFeatures,
                                    style: AppTextStyle.normalBlack12
                                        .copyWith(height: 1.2),
                                  ),
                                  TextSpan(
                                    text: AppMetaLabels().menaRealEstate,
                                    style: AppTextStyle.semiBoldBlack12
                                        .copyWith(height: 1.2),
                                  ),
                                  TextSpan(
                                    text:
                                        AppMetaLabels().updateThelatestVersion,
                                    style: AppTextStyle.normalBlack12
                                        .copyWith(height: 1.2),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height:
                                  PlatformCheck.isAndroid == true ? 1.h : 2.5.h,
                            ),
                            // available version
                            PlatformCheck.isAndroid == true
                                ? SizedBox()
                                : RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              AppMetaLabels().availableVersion,
                                          style: AppTextStyle.semiBoldBlack12
                                              .copyWith(height: 1.2),
                                        ),
                                        TextSpan(
                                          text: widget.availableVersion,
                                          style: AppTextStyle.normalBlack12
                                              .copyWith(height: 1.2),
                                        ),
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            // app version
                            PlatformCheck.isAndroid == true
                                ? SizedBox()
                                : RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: AppMetaLabels().appVersion,
                                          style: AppTextStyle.semiBoldBlack12
                                              .copyWith(height: 1.2),
                                        ),
                                        TextSpan(
                                          text: widget.appVersion,
                                          style: AppTextStyle.normalBlack12
                                              .copyWith(height: 1.2),
                                        ),
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              height: 5.h,
                            ),
                            // update button
                            InkWell(
                              onTap: () async {
                                if (PlatformCheck.isIOS) {
                                  print('iOS');
                                  try {
                                    // Must Add iosAppID
                                    LaunchReview.launch(
                                      androidAppId: "com.mena.realestate",
                                      writeReview: false,
                                      isiOSBeta: false,
                                      iOSAppId: '1588897544',
                                    );
                                  } catch (e) {
                                    print('Exception ::: $e');
                                    SnakBarWidget.getSnackBarErrorBlue(
                                        AppMetaLabels().error,
                                        AppMetaLabels().someThingWentWrong);
                                  }
                                } else {
                                  try {
                                    print('Android');

                                    LaunchReview.launch(
                                      androidAppId: "com.mena.realestate",
                                    );
                                  } catch (e) {
                                    print('Exception ::: $e');
                                    SnakBarWidget.getSnackBarErrorBlue(
                                        AppMetaLabels().error,
                                        AppMetaLabels().someThingWentWrong);
                                  }
                                }
                              },
                              child: Container(
                                height: 6.h,
                                width: 60.w,
                                decoration: BoxDecoration(
                                  color: AppColors.greenColor,
                                  borderRadius: BorderRadius.circular(2.0.h),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 0.5.h,
                                      spreadRadius: 0.3.h,
                                      offset: Offset(0.1.h, 0.1.h),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(AppMetaLabels().update,
                                      style: AppTextStyle.semiBoldWhite14),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            AppDivider(),
                            SizedBox(
                              height: 2.h,
                            ),
                            PlatformCheck.isIOS == true
                                ? Row(
                                    children: [
                                      SizedBox(
                                        height: 4.h,
                                        width: 4.h,
                                        child: Image.asset(
                                          'assets/images/common_images/app_icon/appStore.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(AppMetaLabels().appStore,
                                          style: AppTextStyle.semiBoldBlack16
                                              .copyWith(
                                            color: Colors.black54,
                                          ))
                                    ],
                                  )
                                : Row(
                                    children: [
                                      SizedBox(
                                        height: 4.h,
                                        width: 4.h,
                                        child: Image.asset(
                                          'assets/images/common_images/app_icon/playStore.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(AppMetaLabels().googlePlay,
                                          style: AppTextStyle.semiBoldBlack16
                                              .copyWith(
                                            color: Colors.black54,
                                          ))
                                    ],
                                  ),
                            SizedBox(
                              height: 3.h,
                            ),
                          ],
                        )),
                      ),
                    ))),
          ),
        ),
      ),
    );
  }
}
