import 'dart:io';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/views/auth/otp_firebase/otp_firebase_controller.dart';
import 'package:fap_properties/utils/constants/global_preferences.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/auth/country_picker/country_picker_controller.dart';
import 'package:fap_properties/views/choose_language/choose_language.dart';
import 'package:fap_properties/views/auth/validate_user/phone_no_field.dart';
import 'package:fap_properties/views/widgets/common_widgets/app_logo_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/background_image_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/button_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_white.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../country_picker/country_picker.dart';

// ValidateUserScreenFB = >ValidateUserScreenFirebase
class ValidateUserScreenFB extends StatefulWidget {
  ValidateUserScreenFB({Key key}) : super(key: key);

  @override
  State<ValidateUserScreenFB> createState() => _ValidateUserScreenFBState();
}

class _ValidateUserScreenFBState extends State<ValidateUserScreenFB> {
  final CountryPickerController countryController =
      Get.put(CountryPickerController());
  FirebaseAuthController authController = Get.put(FirebaseAuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            authController.textFieldTap.value = false;
          },
          child: Scaffold(
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 3.0.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 32,
                                ),
                                Text(
                                  AppMetaLabels().login,
                                  style: AppTextStyle.semiBoldWhite13,
                                ),
                                IconButton(
                                    onPressed: () {
                                      Get.to(() => ChooseLanguage(
                                            cont: false,
                                            loggedIn: false,
                                          ));
                                    },
                                    icon: Icon(
                                      Icons.language,
                                      color: Colors.white,
                                      size: 3.h,
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: authController.textFieldTap.value == true
                                ? 2.0.h
                                : 7.0.h,
                          ),
                          // const AppLogo(),
                          AppLogoMenaRealEstate(
                            menaFontSize: AppTextStyle.semiBoldWhite36,
                            menaReaEstateEnglishFont:
                                AppTextStyle.semiBoldWhite12,
                            height: 10.0.h,
                          ),
                          SizedBox(
                            height: authController.textFieldTap.value == true
                                ? 2.0.h
                                : 10.0.h,
                          ),
                          Text(
                            AppMetaLabels().oneTimePassword,
                            textAlign: TextAlign.center,
                            // style: AppTextStyle.semiBoldWhite10,
                            style: AppTextStyle.normalWhite10,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 5.0.h, left: 5.0.w, right: 5.0.w),
                            child: Align(
                              alignment: SessionController().getLanguage() == 1
                                  ? Alignment.topLeft
                                  : Alignment.topRight,
                              child: Text(
                                AppMetaLabels().mobileNumber,
                                textAlign: TextAlign.center,
                                style: AppTextStyle.normalWhite10,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 1.0.h),
                            child: Container(
                              width: 90.0.w,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(70, 82, 95, 0.2),
                                border: Border.all(
                                  color: Colors.white30,
                                ),
                                borderRadius: BorderRadius.circular(0.5.h),
                              ),
                              child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        Get.to(() => CountryPicker());
                                      },
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 2.0.h),
                                            child: Obx(() {
                                              return Text(
                                                countryController
                                                    .selectedDialingCode.value,
                                                style:
                                                    AppTextStyle.normalWhite12,
                                              );
                                            }),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 1.0.h),
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.white,
                                              size: 3.0.h,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: PhoneNoFieldFB(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          authController.error.value != '' ||
                                  authController.errorValidateUser.value != ''
                              ? Padding(
                                  padding: EdgeInsets.only(top: 1.0.h),
                                  child: Container(
                                    width: 85.0.w,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(255, 59, 48, 0.6),
                                      borderRadius:
                                          BorderRadius.circular(1.0.h),
                                      border: Border.all(
                                        color: Color.fromRGBO(255, 59, 48, 1),
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
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 1.0.h),
                                              child: Text(
                                                authController.errorValidateUser
                                                            .value ==
                                                        ''
                                                    ? authController.error.value
                                                    : authController
                                                        .errorValidateUser
                                                        .value,
                                                style: AppTextStyle
                                                    .semiBoldWhite11,
                                                maxLines: 3,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            height: authController.textFieldTap.value == true
                                ? 2.0.h
                                : 15.0.h,
                          ),
                          authController.isUpdating.value == true ||
                                  authController.verifying.value == true
                              ? Column(
                                  children: [
                                    LoadingIndicatorWhite(),
                                    SizedBox(
                                      height: 2.0.h,
                                    ),
                                    Text(
                                      AppMetaLabels().validatingUser,
                                      style: AppTextStyle.semiBoldWhite10,
                                    ),
                                  ],
                                )
                              : ButtonWidget(
                                  buttonText: AppMetaLabels().getOTP,
                                  onPress: () async {
                                    FocusScope.of(context).unfocus();
                                    authController.textFieldTap.value = false;
                                    print(PhoneNoFieldFB.phoneController.text ==
                                        '');
                                    print(PhoneNoFieldFB.phoneController.text ==
                                        null);
                                    print(PhoneNoFieldFB.phoneController.text
                                        .contains(' '));
                                    // checking weather user entered mobile no or not
                                    if (PhoneNoFieldFB.phoneController.text ==
                                            '' ||
                                        PhoneNoFieldFB.phoneController.text ==
                                            null ||
                                        PhoneNoFieldFB.phoneController.text
                                            .contains(' ')) {
                                      SnakBarWidget.getSnackBarErrorBlue(
                                        AppMetaLabels().error,
                                        AppMetaLabels().pleaseEnterMobileNo,
                                      );
                                      return;
                                    }
                                    // checking weather user started enter mobile no with 0 or not
                                    if (PhoneNoFieldFB.phoneController.text
                                            .toString()[0] ==
                                        '0') {
                                      Get.snackbar(
                                          AppMetaLabels().error,
                                          AppMetaLabels()
                                              .pleaseEnterMobileNoWithoutZero,
                                          backgroundColor: AppColors.redColor,
                                          colorText: AppColors.whiteColor);
                                    } else {
                                      final String phone = SessionController()
                                              .getDialingCode() +
                                          PhoneNoFieldFB.phoneController.text;
                                      SessionController().setPhone(phone);
                                      var phoneNbrValidation =
                                          authController.validateMobile(phone);
                                      print(
                                          'Phone Validation ::: $phoneNbrValidation');

                                      await authController.validateMobileUser();
                                    }
                                  },
                                ),
                          // 112233 comment the Rooted Device,UAT,cancel etc button
                          // for some time
                          // 101
                          // authController.isUpdating.value == true
                          //     ? Container()
                          //     : Column(
                          //         children: [
                          //           SizedBox(
                          //             height: 1.0.h,
                          //           ),
                          //           Container(
                          //             width: 88.0.w,
                          //             child: Row(
                          //               children: [
                          //                 Text(
                          //                   AppMetaLabels().enableRooted,
                          //                   style: AppTextStyle.semiBoldWhite11,
                          //                 ),
                          //                 const Spacer(),
                          //                 Obx(() {
                          //                   return FlutterSwitch(
                          //                     inactiveColor: Color.fromRGBO(
                          //                         188, 190, 192, 1),
                          //                     activeColor: Colors.blue[600],
                          //                     // toggleColor: Color.fromRGBO(76, 78, 84, 1),
                          //                     activeToggleColor: Colors.white,
                          //                     inactiveToggleColor:
                          //                         Color.fromRGBO(76, 78, 84, 1),
                          //                     width: 11.0.w,
                          //                     height: 3.0.h,
                          //                     toggleSize: 3.0.h,
                          //                     value: authController
                          //                         .checkRooted.value,
                          //                     borderRadius: 2.0.h,
                          //                     padding: 0.2.h,
                          //                     onToggle: (val) {
                          //                       authController.checkRooted.value =
                          //                           val;
                          //                     },
                          //                   );
                          //                 }),
                          //               ],
                          //             ),
                          //           ),
                          //           SizedBox(
                          //             height: 2.0.h,
                          //           ),
                          //           Container(
                          //             width: 88.0.w,
                          //             child: Row(
                          //               children: [
                          //                 Text(
                          //                   AppMetaLabels().enableSSL,
                          //                   style: AppTextStyle.semiBoldWhite11,
                          //                 ),
                          //                 const Spacer(),
                          //                 Obx(() {
                          //                   return FlutterSwitch(
                          //                     inactiveColor: Color.fromRGBO(
                          //                         188, 190, 192, 1),
                          //                     activeColor: Colors.blue[600],
                          //                     // toggleColor: Color.fromRGBO(76, 78, 84, 1),
                          //                     activeToggleColor: Colors.white,
                          //                     inactiveToggleColor:
                          //                         Color.fromRGBO(76, 78, 84, 1),
                          //                     width: 11.0.w,
                          //                     height: 3.0.h,
                          //                     toggleSize: 3.0.h,
                          //                     value:
                          //                         authController.enableSSL.value,
                          //                     borderRadius: 2.0.h,
                          //                     padding: 0.2.h,
                          //                     onToggle: (val) {
                          //                       if (!SessionController()
                          //                           .enableSSL) {
                          //                         Phoenix.rebirth(context);
                          //                       }
                          //                       SessionController().enableSSL =
                          //                           val;
                          //                       authController.enableSSL.value =
                          //                           val;
                          //                     },
                          //                   );
                          //                 }),
                          //               ],
                          //             ),
                          //           ),
                          Padding(
                            padding: EdgeInsets.only(top: 2.0.h),
                            child: TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 11.5.h,
                                      width: 100.0.w,
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                            height: 1.0.h,
                                          ),
                                          Text(
                                            AppMetaLabels().sureToExit,
                                            style: AppTextStyle.semiBoldBlack12,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.grey[300],
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  AppMetaLabels().no,
                                                  style: AppTextStyle
                                                      .semiBoldBlack12,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 2.0.h),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    GlobalPreferences.setbool(
                                                        GlobalPreferencesLabels
                                                            .isLoginBool,
                                                        false);
                                                    exit(0);
                                                  },
                                                  child: Text(
                                                    AppMetaLabels().yes,
                                                    style: AppTextStyle
                                                        .semiBoldWhite12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Column(
                                children: [
                                  Text(
                                    AppMetaLabels().cancel,
                                    style: AppTextStyle.normalWhite11,
                                  ),
                                  Container(
                                    color: AppColors.whiteColor,
                                    height: 0.1.h,
                                    width: 12.0.w,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //           InkWell(
                          //             onLongPress: () {
                          //               // Get.to(() => LandlordHome());
                          //             },
                          //             child: Text(
                          //               AppConfig().isUat ? "UAT" : "SIT",
                          //               style: AppTextStyle.normalWhite11,
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
