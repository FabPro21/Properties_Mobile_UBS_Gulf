import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/global_preferences.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/auth/select_role/select_role_screen.dart';
import 'package:fap_properties/views/auth/setup_mpin/pin_code_field_mpin.dart';
import 'package:fap_properties/views/auth/setup_mpin/reenter_pin_code_field_mpin.dart';
import 'package:fap_properties/views/auth/setup_mpin/setup_mpin_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/app_logo_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/background_image_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/button_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_white.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

class SetupMpinScreen extends StatefulWidget {
  SetupMpinScreen({Key? key}) : super(key: key);

  @override
  State<SetupMpinScreen> createState() => _SetupMpinScreenState();
}

class _SetupMpinScreenState extends State<SetupMpinScreen> {
  final setupMpinController = Get.put(SetupMpinController());

  @override
  void initState() {
    setFingerPrintOption();
    super.initState();
  }

  void setFingerPrintOption() async {
    if (setupMpinController.fingerprintValue.value == true) {
      SessionController().setfingerprint(true);
      await GlobalPreferences.setbool(
          GlobalPreferencesLabels.fingerPrint, true);
    } else {
      SessionController().setfingerprint(false);
      await GlobalPreferences.setbool(
          GlobalPreferencesLabels.fingerPrint, false);
    }
    // setState(() {
    //   if (setupMpinController.fingerprintValue.value == true) {
    //     setupMpinController.fingerprintValue.value = true;
    //   } else {
    //     setupMpinController.fingerprintValue.value = false;
    //   }
    // });
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
                        padding: EdgeInsets.only(top: 2.0.h),
                        child: Text(
                          AppMetaLabels().setup,
                          style: AppTextStyle.normalWhite10,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 1.0.h),
                        child: Text(
                          AppMetaLabels().mpin,
                          style: AppTextStyle.semiBoldWhite13,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0.h),
                        child: const AppLogo(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 4.0.h, left: 10.w, right: 10.w),
                        child: Text(
                          SessionController().getUserName() ?? "",
                          style: AppTextStyle.semiBoldWhite16
                              .copyWith(fontSize: 20.0.sp),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 1.0.h),
                        child: Text(
                          AppMetaLabels().setupMPIN,
                          style: AppTextStyle.normalWhite8,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(12.w, 8.0.h, 12.w, 0.2.h),
                        child: Align(
                          alignment: SessionController().getLanguage() == 1
                              ? Alignment.topLeft
                              : Alignment.topRight,
                          child: Text(
                            AppMetaLabels().enterMpin,
                            style: AppTextStyle.normalWhite10,
                          ),
                        ),
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Padding(
                          padding:
                              EdgeInsets.fromLTRB(12.w, 1.0.h, 12.w, 0.2.h),
                          child: Center(
                            child: SizedBox(
                              width: 76.w,
                              child: PinCodeFieldMpin(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(12.w, 0.0.h, 12.w, 0.2.h),
                        child: Align(
                          alignment: SessionController().getLanguage() == 1
                              ? Alignment.topLeft
                              : Alignment.topRight,
                          child: Text(
                            AppMetaLabels().reenterMpin,
                            style: AppTextStyle.normalWhite10,
                          ),
                        ),
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Padding(
                          padding:
                              EdgeInsets.fromLTRB(12.w, 1.0.h, 12.w, 0.2.h),
                          child: Center(
                            child: SizedBox(
                              width: 76.w,
                              child: ReEnterPinCodeFieldMpin(),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(12.w, 0.0.h, 12.w, 0.2.h),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Text(
                                    AppMetaLabels().enableFaceID,
                                    style: AppTextStyle.semiBoldWhite11,
                                  ),
                                  const Spacer(),
                                  Obx(() {
                                    return FlutterSwitch(
                                      inactiveColor:
                                          Color.fromRGBO(188, 190, 192, 1),
                                      activeColor: Colors.blue[600]??Colors.lightBlue,
                                      activeToggleColor: Colors.white,
                                      inactiveToggleColor:
                                          Color.fromRGBO(76, 78, 84, 1),
                                      width: 11.0.w,
                                      height: 3.0.h,
                                      toggleSize: 3.0.h,
                                      value: setupMpinController
                                          .fingerprintValue.value,
                                      borderRadius: 2.0.h,
                                      padding: 0.2.h,
                                      onToggle: (val) {
                                        setupMpinController
                                            .fingerprintValue.value = val;
                                        setFingerPrintOption();
                                        // setState(() {});
                                      },
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                          Obx(() {
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      2.0.h, 1.0.h, 2.0.h, 0.2.h),
                                  child: setupMpinController.error.value == ''
                                      ? Container()
                                      : Container(
                                          // width: 85.0.w,
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                255, 59, 48, 0.6),
                                            borderRadius:
                                                BorderRadius.circular(1.0.h),
                                            border: Border.all(
                                              color: Color.fromRGBO(
                                                  255, 59, 48, 1),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(0.7.h),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.info_outline,
                                                  color: Colors.white,
                                                  size: 3.5.h,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 1.0.h),
                                                  child: Text(
                                                    setupMpinController
                                                        .error.value,
                                                    style: AppTextStyle
                                                        .semiBoldWhite11,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5.0.h),
                                  child: setupMpinController.isUpdating.value ==
                                          true
                                      ? LoadingIndicatorWhite()
                                      : ButtonWidget(
                                          buttonText: AppMetaLabels().saveMPIN,
                                          onPress: () async {
                                            await setupMpinController
                                                .saveMpinBtn();
                                            // setState(() {});
                                          },
                                        ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.offAll(() => SelectRoleScreen());
                                  },
                                  child: Text(
                                    AppMetaLabels().cancel,
                                    style: AppTextStyle.semiBoldWhite12,
                                  ),
                                )
                              ],
                            );
                          }),
                        ],
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
/// 09-03-2023
// import 'package:fap_properties/data/helpers/session_controller.dart';
// import 'package:fap_properties/utils/constants/meta_labels.dart';
// import 'package:fap_properties/utils/styles/text_styles.dart';
// import 'package:fap_properties/views/auth/select_role/select_role_screen.dart';
// import 'package:fap_properties/views/auth/setup_mpin/pin_code_field_mpin.dart';
// import 'package:fap_properties/views/auth/setup_mpin/reenter_pin_code_field_mpin.dart';
// import 'package:fap_properties/views/auth/setup_mpin/setup_mpin_controller.dart';
// import 'package:fap_properties/views/widgets/common_widgets/app_logo_widget.dart';
// import 'package:fap_properties/views/widgets/common_widgets/background_image_widget.dart';
// import 'package:fap_properties/views/widgets/common_widgets/button_widget.dart';
// import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_white.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import 'package:flutter_switch/flutter_switch.dart';
// import 'package:get/get.dart';

// class SetupMpinScreen extends StatefulWidget {
//   SetupMpinScreen({Key? key}) : super(key: key);

//   @override
//   State<SetupMpinScreen> createState() => _SetupMpinScreenState();
// }

// class _SetupMpinScreenState extends State<SetupMpinScreen> {
//   final setupMpinController = Get.put(SetupMpinController());

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       resizeToAvoidBottomInset: false,
//       body: Directionality(
//         textDirection: SessionController().getLanguage() == 1
//             ? TextDirection.ltr
//             : TextDirection.rtl,
//         child: Stack(
//           children: [
//             const AppBackgroundImage(),
//             SafeArea(
//               child: SingleChildScrollView(
//                 child: Center(
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(top: 2.0.h),
//                         child: Text(
//                           AppMetaLabels().setup,
//                           style: AppTextStyle.normalWhite10,
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(top: 1.0.h),
//                         child: Text(
//                           AppMetaLabels().mpin,
//                           style: AppTextStyle.semiBoldWhite13,
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(top: 8.0.h),
//                         child: const AppLogo(),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: 4.0.h, left: 10.w, right: 10.w),
//                         child: Text(
//                           SessionController().getUserName(),
//                           style: AppTextStyle.semiBoldWhite16
//                               .copyWith(fontSize: 20.0.sp),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(top: 1.0.h),
//                         child: Text(
//                           AppMetaLabels().setupMPIN,
//                           style: AppTextStyle.normalWhite8,
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(12.w, 8.0.h, 12.w, 0.2.h),
//                         child: Align(
//                           alignment: Alignment.topLeft,
//                           child: Text(
//                             AppMetaLabels().enterMpin,
//                             style: AppTextStyle.normalWhite10,
//                           ),
//                         ),
//                       ),
//                       Directionality(
//                         textDirection: TextDirection.ltr,
//                         child: Padding(
//                           padding:
//                               EdgeInsets.fromLTRB(12.w, 1.0.h, 12.w, 0.2.h),
//                           child: Center(
//                             child: SizedBox(
//                               width: 76.w,
//                               child: PinCodeFieldMpin(),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(12.w, 0.0.h, 12.w, 0.2.h),
//                         child: Align(
//                           alignment: Alignment.topLeft,
//                           child: Text(
//                             AppMetaLabels().reenterMpin,
//                             style: AppTextStyle.normalWhite10,
//                           ),
//                         ),
//                       ),
//                       Directionality(
//                         textDirection: TextDirection.ltr,
//                         child: Padding(
//                           padding:
//                               EdgeInsets.fromLTRB(12.w, 1.0.h, 12.w, 0.2.h),
//                           child: Center(
//                             child: SizedBox(
//                               width: 76.w,
//                               child: ReEnterPinCodeFieldMpin(),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Column(
//                         children: [
//                           Padding(
//                             padding:
//                                 EdgeInsets.fromLTRB(12.w, 0.0.h, 12.w, 0.2.h),
//                             child: Align(
//                               alignment: Alignment.topLeft,
//                               child: Row(
//                                 children: [
//                                   Text(
//                                     AppMetaLabels().enableFaceID,
//                                     style: AppTextStyle.semiBoldWhite11,
//                                   ),
//                                   const Spacer(),
//                                   Obx(() {
//                                     return FlutterSwitch(
//                                       inactiveColor:
//                                           Color.fromRGBO(188, 190, 192, 1),
//                                       activeColor: Colors.blue[600],
//                                       activeToggleColor: Colors.white,
//                                       inactiveToggleColor:
//                                           Color.fromRGBO(76, 78, 84, 1),
//                                       width: 11.0.w,
//                                       height: 3.0.h,
//                                       toggleSize: 3.0.h,
//                                       value: setupMpinController
//                                           .fingerprintValue.value,
//                                       borderRadius: 2.0.h,
//                                       padding: 0.2.h,
//                                       onToggle: (val) {
//                                         setupMpinController
//                                             .fingerprintValue.value = val;
//                                       },
//                                     );
//                                   }),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Obx(() {
//                             return Column(
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.fromLTRB(
//                                       2.0.h, 1.0.h, 2.0.h, 0.2.h),
//                                   child: setupMpinController.error.value == ''
//                                       ? Container()
//                                       : Container(
//                                           // width: 85.0.w,
//                                           decoration: BoxDecoration(
//                                             color: Color.fromRGBO(
//                                                 255, 59, 48, 0.6),
//                                             borderRadius:
//                                                 BorderRadius.circular(1.0.h),
//                                             border: Border.all(
//                                               color: Color.fromRGBO(
//                                                   255, 59, 48, 1),
//                                             ),
//                                           ),
//                                           child: Padding(
//                                             padding: EdgeInsets.all(0.7.h),
//                                             child: Row(
//                                               children: [
//                                                 Icon(
//                                                   Icons.info_outline,
//                                                   color: Colors.white,
//                                                   size: 3.5.h,
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(
//                                                       left: 1.0.h),
//                                                   child: Text(
//                                                     setupMpinController
//                                                         .error.value,
//                                                     style: AppTextStyle
//                                                         .semiBoldWhite11,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(top: 5.0.h),
//                                   child: setupMpinController.isUpdating.value ==
//                                           true
//                                       ? LoadingIndicatorWhite()
//                                       : ButtonWidget(
//                                           buttonText: AppMetaLabels().saveMPIN,
//                                           onPress: () async {
//                                             await setupMpinController
//                                                 .saveMpinBtn();
//                                             // setState(() {});
//                                           },
//                                         ),
//                                 ),
//                                 TextButton(
//                                   onPressed: () {
//                                     Get.offAll(() => SelectRoleScreen());
//                                   },
//                                   child: Text(
//                                     AppMetaLabels().cancel,
//                                     style: AppTextStyle.semiBoldWhite12,
//                                   ),
//                                 )
//                               ],
//                             );
//                           }),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
