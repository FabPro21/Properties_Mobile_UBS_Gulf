// import 'dart:io';

// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io' as ui;
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/app_update_manually/app_version.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/constants/version/update_app.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/auth/select_role/select_roles_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/app_logo_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/background_image_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_white.dart';
import 'package:flutter/services.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:keyboard_actions/external/platform_check/platform_check.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectRoleScreen extends StatefulWidget {
  final bool? redirect;
  SelectRoleScreen({Key? key, this.redirect = true}) : super(key: key);

  @override
  _SelectRoleScreenState createState() => _SelectRoleScreenState();
}

class _SelectRoleScreenState extends State<SelectRoleScreen> {
  final selectRoloesController = Get.put(SelectRoloesController());

  @override
  void initState() {
    selectRoloesController.redirect = widget.redirect ?? false;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // int userID = SessionController().getUserID();
      // print('User ID ::::: $userID');
      // without app update
      // selectRoloesController.initialize();
      // with app update only for android
      // if (PlatformCheck.isAndroid == true) {
      //   await checkForUpdateAndroid();
      // }
      checkinUpdate();
    });
    super.initState();
  }

  AppUpdateInfo? updateInfo;
  Future<bool> checkForUpdateAndroid() async {
    await InAppUpdate.checkForUpdate().then((info) {
      print('Info : $info');
      setState(() {
        updateInfo = info;
      });
      print('updateInfo : $updateInfo');
      return true;
    }).catchError((e) {
      // SnakBarWidget.getSnackBarError(AppMetaLabels().alert, e.toString());
      return false;
    });
    return false;
  }

  String appVersion = '';
  Future checkinUpdate() async {
    if (ui.Platform.isAndroid) {
      print(':::: With app update ::::');
    }
    await PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      appVersion = packageInfo.version;
    });

    // Android & // iOS
    if (PlatformCheck.isAndroid == true) {
      print(':::: Android ::::');
      selectRoloesController.loadingData.value = true;
      await checkForUpdateAndroid();
      selectRoloesController.loadingData.value = false;

      // for without App update
      // selectRoloesController.initialize();

      // for app update
      // should uncomment the below lines
      if (updateInfo?.updateAvailability ==
          UpdateAvailability.updateAvailable) {
        Get.off(() => AppUpdate(
              appVersion: updateInfo!.availableVersionCode.toString(),
              availableVersion: SessionController().storeAppVerison,
            ));
      } else {
        selectRoloesController.initialize();
      }
    } else {
      print(':::: iOS ::::');
      selectRoloesController.loadingData.value = true;
      await CheckVerion().fetchAppVersion();
      selectRoloesController.loadingData.value = false;
      // IF storeAppVersion & appVersion are same
      // then will call normal func
      // & IF storeAppVersion & appVersion are not same
      // then will move toward AppUpdate where we define the
      // the deatil and update update button set
      // this this this

      // for without App update
      // selectRoloesController.initialize();

      // for app update
      // should uncomment the below lines
      // must correct the condition of the Appversion


      if (SessionController().storeAppVerison?.trim() == appVersion.trim()) {
        selectRoloesController.initialize();
      } else {
        Get.off(() => AppUpdate(
              appVersion: appVersion,
              availableVersion: SessionController().storeAppVerison,
            ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          await SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
      child: Scaffold(
        backgroundColor: Colors.white,
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
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 25.h,
                                  width: 100.0.w,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0.h),
                                        topRight: Radius.circular(4.0.h),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 4.0.h,
                                        ),
                                        Text(
                                          AppMetaLabels().needHelp,
                                          style: AppTextStyle.semiBoldBlack12,
                                        ),
                                        SizedBox(
                                          height: 3.0.h,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  height: 28.h,
                                                  width: double.infinity,
                                                  margin: EdgeInsets.fromLTRB(
                                                      2.w, 0, 2.w, 1.h),
                                                  child: Column(
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade300,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              1.h)),
                                                              child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            1.h,
                                                                            2.h,
                                                                            1.h,
                                                                            1.h),
                                                                    child: Text(
                                                                      AppMetaLabels()
                                                                          .contactCenter,
                                                                      style: AppTextStyle
                                                                          .semiBoldGrey10,
                                                                    ),
                                                                  ),
                                                                  AppDivider(),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      var phone = AppMetaLabels()
                                                                          .within
                                                                          .split(
                                                                              '(')[0]
                                                                          .removeAllWhitespace
                                                                          .trim();

                                                                      launchUrl(
                                                                          Uri.parse(
                                                                              "tel://$phone"));
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets
                                                                          .all(1
                                                                              .h),
                                                                      child:
                                                                          Text(
                                                                        AppMetaLabels()
                                                                            .within,
                                                                        style: AppTextStyle
                                                                            .normalBlue14,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  AppDivider(),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      String phone = AppMetaLabels()
                                                                          .outside
                                                                          .split(
                                                                              '(')[0]
                                                                          .removeAllWhitespace
                                                                          .trim();

                                                                      launchUrl(
                                                                          Uri.parse(
                                                                              "tel://$phone"));
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.fromLTRB(
                                                                          1.h,
                                                                          1.h,
                                                                          1.h,
                                                                          2.h),
                                                                      child:
                                                                          Text(
                                                                        AppMetaLabels()
                                                                            .outside,
                                                                        style: AppTextStyle
                                                                            .normalBlue14,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              )),
                                                          InkWell(
                                                            onTap: () {
                                                              Get.back();
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 1.h),
                                                              width: double
                                                                  .infinity,
                                                              decoration: BoxDecoration(
                                                                  color: AppColors
                                                                      .whiteColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              1.h)),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(1
                                                                            .h),
                                                                child: Center(
                                                                  child: Text(
                                                                    AppMetaLabels()
                                                                        .cancel,
                                                                    style: AppTextStyle
                                                                        .semiBoldBlue14,
                                                                  ),
                                                                ),
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
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 3.0.h, right: 3.0.h),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.call_outlined,
                                                  color: Colors.black,
                                                  size: 3.0.h,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 3.0.h,
                                                  ),
                                                  child: Text(
                                                    AppMetaLabels().callUs,
                                                    style: AppTextStyle
                                                        .semiBoldBlack12,
                                                  ),
                                                ),
                                                Spacer(),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: AppColors.blackColor,
                                                  size: 2.0.h,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.5.h,
                                        ),
                                        AppDivider(),
                                        SizedBox(
                                          height: 3.0.h,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                            print(
                                                'Email ::::: ++++> ${Uri.parse("mailto:${AppMetaLabels().fabEmail}")}');
                                            launchUrl(Uri.parse(
                                                "mailto:${AppMetaLabels().fabEmail}"));
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 3.0.h, right: 3.0.h),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.email_outlined,
                                                  color: Colors.black,
                                                  size: 3.0.h,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 3.0.h,
                                                  ),
                                                  child: Text(
                                                    AppMetaLabels().emailUs,
                                                    style: AppTextStyle
                                                        .semiBoldBlack12,
                                                  ),
                                                ),
                                                Spacer(),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: AppColors.blackColor,
                                                  size: 2.0.h,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Wrap(
                            children: [
                              Icon(
                                Icons.help_outline_rounded,
                                color: Colors.white,
                                size: 14.sp,
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              Text(
                                AppMetaLabels().help,
                                style: AppTextStyle.semiBoldWhite12,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2.0.h),
                        child: Text(
                          AppMetaLabels().login,
                          style: AppTextStyle.semiBoldWhite12,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 6.0.h),
                        child: const AppLogo(),
                      ),
                      Obx(() {
                        return selectRoloesController.loadingData.value == true
                            ? Padding(
                                padding: EdgeInsets.only(top: 25.h),
                                child: LoadingIndicatorWhite(),
                              )
                            :
                            // return selectRoloesController.loadingData.value == true
                            //     ? Padding(
                            //         padding: EdgeInsets.only(top: 25.h),
                            //         child: LoadingIndicatorWhite(),
                            //       )
                            //     :
                            Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 6.0.h,
                                        left: 10.0.w,
                                        right: 10.0.w),
                                    child: Text(
                                      selectRoloesController.name.value,
                                      textScaleFactor: 1.0,
                                      style: AppTextStyle.semiBoldWhite16,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 0.5.h),
                                    child: Text(
                                      AppMetaLabels().selectRole,
                                      style: AppTextStyle.normalWhite10,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        2.0.h, 6.0.h, 2.0.h, 2.0.h),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: selectRoloesController
                                          .userRoles.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                SessionController()
                                                    .setSelectedRoleId(
                                                        selectRoloesController
                                                            .userRoles[index]
                                                            .roleId);
                                                await selectRoloesController
                                                    .refreshtokenFunc(
                                                        selectRoloesController
                                                            .userRoles[index]
                                                            .roleId
                                                            .toString());
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 1.0.h),
                                                child: ListTile(
                                                  leading:
                                                      selectRoloesController
                                                          .userRoles[index]
                                                          .icon,
                                                  // 112233 set static name of role
                                                  title: Text(
                                                    SessionController()
                                                                .getLanguage() ==
                                                            1
                                                        ? (selectRoloesController
                                                                    .userRoles[
                                                                        index]
                                                                    .role
                                                                    ?.contains(
                                                                        'Public') ??
                                                                false
                                                            ? AppMetaLabels()
                                                                .public
                                                            : selectRoloesController
                                                                    .userRoles[
                                                                        index]
                                                                    .role ??
                                                                '')
                                                        : (selectRoloesController
                                                                    .userRoles[
                                                                        index]
                                                                    .role
                                                                    ?.contains(
                                                                        'Tenant') ??
                                                                false
                                                            ? 'مستاجر'
                                                            : selectRoloesController
                                                                        .userRoles[index]
                                                                        .role
                                                                        ?.contains('Vendor') ??
                                                                    false
                                                                ? 'مقاول'
                                                                : selectRoloesController.userRoles[index].role?.contains('Public') ?? false
                                                                    ? 'زائر'
                                                                    : selectRoloesController.userRoles[index].role?.contains('Landlord') ?? false
                                                                        ? 'مالك'
                                                                        : ''),
                                                    style: AppTextStyle
                                                        .normalWhite12,
                                                  ),

                                                  // Text(
                                                  //   SessionController()
                                                  //               .getLanguage() ==
                                                  //           1
                                                  //       ? selectRoloesController
                                                  //               .userRoles[
                                                  //                   index]
                                                  //               .role!
                                                  //               .contains(
                                                  //                   'Public')
                                                  //           // ? 'Guest'
                                                  //           ? AppMetaLabels()
                                                  //               .public
                                                  //           : selectRoloesController
                                                  //               .userRoles[
                                                  //                   index]
                                                  //               .role
                                                  //       : selectRoloesController
                                                  //               .userRoles[
                                                  //                   index]
                                                  //               .role!
                                                  //               .contains(
                                                  //                   'Tenant')
                                                  //           ? 'مستاجر'
                                                  //           : selectRoloesController
                                                  //                   .userRoles[
                                                  //                       index]
                                                  //                   .role!
                                                  //                   .contains(
                                                  //                       'Vendor')
                                                  //               ? 'مقاول'
                                                  //               : selectRoloesController
                                                  //                       .userRoles[
                                                  //                           index]
                                                  //                       .role!
                                                  //                       .contains(
                                                  //                           'Public')
                                                  //                   ? 'زائر'
                                                  //                   : selectRoloesController
                                                  //                           .userRoles[
                                                  //                               index]
                                                  //                           .role!
                                                  //                           .contains(
                                                  //                               'Landlord')
                                                  //                       ? 'مالك'
                                                  //                       :'',
                                                  //   style: AppTextStyle
                                                  //       .normalWhite12,
                                                  // ),

                                                  trailing: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 1.0.h),
                                                    child: Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 2.0.h,
                                                      color:
                                                          AppColors.whiteColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            index ==
                                                    selectRoloesController
                                                            .userRoles.length -
                                                        1
                                                ? Container()
                                                : Padding(
                                                    padding:
                                                        EdgeInsets.all(0.1.h),
                                                    child: Divider(
                                                      color: Colors.white
                                                          .withOpacity(0.20),
                                                    ),
                                                  ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 8.0.h, bottom: 1.h),
                                      child: SizedBox(
                                        width: 80.w,
                                        height: 5.h,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                              elevation: MaterialStateProperty
                                                  .all<double>(0.0.h),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      AppColors.redColor
                                                          .withOpacity(0.75)),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.0.w),
                                                    side: BorderSide(
                                                      color:
                                                          AppColors.blueColor,
                                                      width: 1.0,
                                                    )),
                                              )),
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
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      SizedBox(
                                                        height: 1.0.h,
                                                      ),
                                                      Text(
                                                        AppMetaLabels()
                                                            .sureToReset,
                                                        style: AppTextStyle
                                                            .semiBoldBlack12,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  Colors.grey[
                                                                      300],
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                              AppMetaLabels()
                                                                  .no,
                                                              style: AppTextStyle
                                                                  .semiBoldBlack12,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left:
                                                                        2.0.h),
                                                            child:
                                                                ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    Colors.red,
                                                              ),
                                                              onPressed: () {
                                                                SessionController()
                                                                    .setDialingCode(
                                                                  '+971',
                                                                );
                                                                selectRoloesController
                                                                    .resetApp();
                                                              },
                                                              child: Text(
                                                                AppMetaLabels()
                                                                    .yes,
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
                                          // Reset App
                                          child: Text(
                                            AppMetaLabels().reset,
                                            style: AppTextStyle.normalWhite12
                                                .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // This is the temporary feature,
                                  // Text(
                                  //   AppMetaLabels().thisIsTemporaryFeature,
                                  //   style: AppTextStyle.normalWhite11,
                                  // ),
                                  // SelectableText(
                                  //     selectRoloesController.devToken ?? '')
                                ],
                              );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
