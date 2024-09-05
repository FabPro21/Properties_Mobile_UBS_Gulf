import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/global_preferences.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/choose_language/choose_language.dart';
import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'dart:ui' as ui;

class LandLordSettings extends StatefulWidget {
  const LandLordSettings({Key? key}) : super(key: key);

  @override
  _LandLordSettingsState createState() => _LandLordSettingsState();
}

class _LandLordSettingsState extends State<LandLordSettings> {
  int fPOption = 0;
  @override
  void initState() {
    getFingerPrintOption();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? ui.TextDirection.ltr
          : ui.TextDirection.rtl,
      child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomAppBar2(
              title: AppMetaLabels().settings,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 3.0.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.fingerprint,
                        size: 3.0.h,
                        color: AppColors.blackColor,
                      ),
                      SizedBox(width: 2.0.h),
                      Text(
                        AppMetaLabels().biometric,
                        style: AppTextStyle.semiBoldBlack13,
                      ),
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(3.0.h),
                        ),
                        child: ToggleSwitch(
                          minWidth: 15.0.w,
                          minHeight: 4.0.h,
                          cornerRadius: 3.0.h,
                          borderColor: [
                            AppColors.borderColor,
                            AppColors.borderColor
                          ],
                          activeBgColors: [
                            [AppColors.blueColor],
                            [Colors.white]
                          ],
                          inactiveBgColor: Colors.grey[200],
                          initialLabelIndex: fPOption,
                          totalSwitches: 2,
                          labels: [AppMetaLabels().on, AppMetaLabels().off],
                          customTextStyles: [
                            fPOption == 0
                                ? AppTextStyle.semiBoldWhite10
                                : AppTextStyle.semiBoldBlack10,
                            AppTextStyle.semiBoldBlack10,
                          ],
                          radiusStyle: true,
                          onToggle: (option) {
                            setFingerPrintOption(option!);
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => ChooseLanguage(loggedIn: true));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.language_sharp,
                          size: 3.0.h,
                          color: AppColors.blackColor,
                        ),
                        SizedBox(width: 2.0.h),
                        Text(
                          AppMetaLabels().language,
                          style: AppTextStyle.semiBoldBlack13,
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 2.5.h,
                          color: AppColors.blackColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ])),
    );
  }

  void getFingerPrintOption() async {
    bool enableFP =
        await GlobalPreferences.getBool(GlobalPreferencesLabels.fingerPrint) ??
            false;
    setState(() {
      if (enableFP) {
        fPOption = 0;
      } else {
        fPOption = 1;
      }
    });
  }

  void setFingerPrintOption(int option) async {
    if (option == 0) {
      SessionController().setfingerprint(true);
      await GlobalPreferences.setbool(
          GlobalPreferencesLabels.fingerPrint, true);
    } else {
      SessionController().setfingerprint(false);
      await GlobalPreferences.setbool(
          GlobalPreferencesLabels.fingerPrint, false);
    }
    setState(() {
      fPOption = option;
    });
  }
}
