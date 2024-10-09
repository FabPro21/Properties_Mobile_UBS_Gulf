import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/auth/login_mpin/login_mpin_controller.dart';
import 'package:fap_properties/views/auth/login_mpin/pin_code_field_login.dart';
import 'package:fap_properties/views/widgets/common_widgets/app_logo_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/background_image_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/button_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_white.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

// ignore: must_be_immutable
class LoginMpinScreen extends StatefulWidget {
  const LoginMpinScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<LoginMpinScreen> createState() => _LoginMpinScreenState();
}

class _LoginMpinScreenState extends State<LoginMpinScreen> {
  final loginMpinController = Get.put(LoginMpinController());

  @override
  void initState() {
    loginMpinController.mpinAttemptsCounter.value = 0;
    loginMpinController.validMpin.value = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? ui.TextDirection.ltr
          : ui.TextDirection.rtl,
      child: Obx(() {
        return Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: Directionality(
            textDirection: TextDirection.ltr,
            child: Stack(
              children: [
                const AppBackgroundImage(),
                SafeArea(
                  child: SingleChildScrollView(
                    child: Center(
                      child: ////////////////////////////
                          /// Loading
                          ////////////////////////////

                          loginMpinController.loadingData.value ||
                                  loginMpinController.resettingMpin.value ||
                                  loginMpinController.authController
                                      .isLoadingForForgotButton.value
                              ? Padding(
                                  padding: EdgeInsets.only(top: 50.0.h),
                                  child: Column(
                                    children: [
                                      LoadingIndicatorWhite(),
                                      SizedBox(
                                        height: 2.0.h,
                                      ),
                                      Text(
                                        AppMetaLabels().verifying,
                                        style: AppTextStyle.semiBoldWhite10,
                                      ),
                                    ],
                                  ),
                                )
                              : Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 9.0.h),
                                      child: const AppLogoCollier(),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 6.0.h),
                                      child: Text(
                                        AppMetaLabels().mpinorbiomatric,
                                        style: AppTextStyle.normalWhite12,
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 12.0.h,
                                        ),
                                        // Padding(
                                        //   padding: EdgeInsets.only(top: 4.0.h),
                                        //   child:
                                        //   loginMpinController
                                        //               .fingerprint.value ==
                                        //           false
                                        //       ? Container()
                                        //       : IconButton(
                                        //           onPressed: () async {
                                        //             loginMpinController
                                        //                 .validateRoleByFP();
                                        //           },
                                        //           icon: Icon(
                                        //             Icons.fingerprint,
                                        //             size: 7.0.h,
                                        //             color: Color.fromRGBO(
                                        //                 142, 185, 255, 1),
                                        //           ),
                                        //         ),
                                        // ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 8.0.h),
                                          child: Center(
                                            child: SizedBox(
                                              child: PinCodeFieldLoginMpin(),
                                            ),
                                          ),
                                        ),

                                        //////////////////////////////////////
                                        /// Error Message
                                        //////////////////////////////////////
                                        loginMpinController.validMpin.value ==
                                                false
                                            ? Padding(
                                                padding: EdgeInsets.only(
                                                  top: 0.5.h,
                                                ),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    width: 85.0.w,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          255, 59, 48, 0.6),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              1.0.h),
                                                      border: Border.all(
                                                        color: Color.fromRGBO(
                                                            255, 59, 48, 1),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(0.7.h),
                                                      child: Directionality(
                                                        textDirection:
                                                            SessionController()
                                                                        .getLanguage() ==
                                                                    1
                                                                ? ui.TextDirection
                                                                    .ltr
                                                                : ui.TextDirection
                                                                    .rtl,
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .info_outline,
                                                              color:
                                                                  Colors.white,
                                                              size: 3.5.h,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 1.0
                                                                          .h),
                                                              child: Container(
                                                                width: 68.0.w,
                                                                child: Text(
                                                                  AppMetaLabels()
                                                                      .incorrectCode,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: AppTextStyle
                                                                      .semiBoldWhite11,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        Padding(
                                          padding: EdgeInsets.only(top: 1.0.h),
                                          child: Center(
                                            child: Column(
                                              children: [
                                                TextButton(
                                                  onPressed: () async {
                                                    if (SessionController()
                                                            .enableFireBaseOTP ==
                                                        true) {
                                                      loginMpinController
                                                          .forgotBtnFB();
                                                    } else {
                                                      print(
                                                          'Firebase is not enable');
                                                      loginMpinController
                                                          .forgotBtn();
                                                    }
                                                  },
                                                  // before firebase
                                                  // onPressed: () async {
                                                  //     loginMpinController
                                                  //         .forgotBtn();

                                                  // },
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        AppMetaLabels()
                                                            .forgotMPIN,
                                                        style: AppTextStyle
                                                            .normalWhite10,
                                                      ),
                                                      Container(
                                                        color: Colors.white,
                                                        width: 21.0.w,
                                                        height: 0.1.h,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2.0.h,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SizedBox(
                                                    width: 90.w,
                                                    child: Text(
                                                      AppMetaLabels()
                                                          .personalDataDisclaimerShare,
                                                      style: AppTextStyle
                                                          .normalWhite10,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                )
                                                // with radio button
                                                // Row(
                                                //   mainAxisAlignment:
                                                //       MainAxisAlignment.center,
                                                //   crossAxisAlignment:
                                                //       CrossAxisAlignment.center,
                                                //   children: [
                                                //     InkWell(
                                                //       onTap: () {
                                                //         loginMpinController
                                                //                 .sharedPersonalDataValue
                                                //                 .value =
                                                //             !loginMpinController
                                                //                 .sharedPersonalDataValue
                                                //                 .value;
                                                //       },
                                                //       child: Text(
                                                //         // AppMetaLabels()
                                                //         //     .personalDataShare,
                                                //         AppMetaLabels()
                                                //             .personalDataDisclaimerShare,
                                                //         style: AppTextStyle
                                                //             .normalWhite10,
                                                //       ),
                                                //     ),
                                                //     SizedBox(
                                                //       width: 3.5.w,
                                                //     ),
                                                //     Obx(() {
                                                //       return FlutterSwitch(
                                                //         inactiveColor:
                                                //             Color.fromRGBO(
                                                //                 188, 190, 192, 1),
                                                //         activeColor:
                                                //             Colors.blue[600],
                                                //         activeToggleColor:
                                                //             Colors.white,
                                                //         inactiveToggleColor:
                                                //             Color.fromRGBO(
                                                //                 76, 78, 84, 1),
                                                //         width: 10.5.w,
                                                //         height: 3.0.h,
                                                //         toggleSize: 3.0.h,
                                                //         value: loginMpinController
                                                //             .sharedPersonalDataValue
                                                //             .value,
                                                //         borderRadius: 2.0.h,
                                                //         padding: 0.2.h,
                                                //         onToggle: (val) {
                                                //           loginMpinController
                                                //               .sharedPersonalDataValue
                                                //               .value = val;
                                                //           print(
                                                //               'Value ::::: ${loginMpinController.sharedPersonalDataValue.value}');
                                                //         },
                                                //       );
                                                //     }),
                                                //   ],
                                                // )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 11.0.h),
                                          child: ButtonWidget(
                                            buttonText: AppMetaLabels().login,
                                            onPress: () async {
                                              loginMpinController
                                                  .validateRoleByMpin();
                                            },
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text(
                                            AppMetaLabels().cancel,
                                            style: AppTextStyle.semiBoldWhite12,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
