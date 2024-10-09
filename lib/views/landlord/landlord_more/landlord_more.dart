import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/auth/select_role/select_role_screen.dart';
import 'package:fap_properties/views/common/about_app.dart/about_app.dart';
import 'package:fap_properties/views/landlord/landlord_notifications/landlord_notifications.dart';
import 'package:fap_properties/views/landlord/landlord_reports/landlord_report.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'landlord_faqs/landlord_faqs.dart';
import 'landlord_profile/landlord_profile.dart';
import 'landlord_settings/landlord_settings.dart';
import 'dart:ui' as ui;

class LandLordMore extends StatefulWidget {
  const LandLordMore({Key? key}) : super(key: key);

  @override
  _LandLordMoreState createState() => _LandLordMoreState();
}

class _LandLordMoreState extends State<LandLordMore> {
  String name = "";
  _getName() {
    String mystring = SessionController().getUserName() ?? "";
    var a = mystring.trim();
    if (a.isEmpty == false) {
      name = a[0];
    } else {
      name = '-';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getName();
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? ui.TextDirection.ltr
          : ui.TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SizedBox(
              width: 100.0.w,
              height: 35.0.h,
              child: Image.asset(
                AppImagesPath.concave,
                fit: BoxFit.fill,
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  // Align(
                  //   alignment: Alignment.topRight,
                  //   child: IconButton(
                  //     padding: EdgeInsets.zero,
                  //     icon: Icon(
                  //       Icons.cancel_outlined,
                  //       color: Colors.white,
                  //       size: 4.h,
                  //     ),
                  //     onPressed: () {
                  //       Get.back();
                  //     },
                  //   ),
                  // ),
                  Row(
                    children: [
                      SizedBox(
                        width: 2.w,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.cancel_outlined,
                            color: Colors.white,
                            size: 3.h,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.logout,
                          color: Colors.white,
                          // color: Colors.red,
                          size: 3.h,
                        ),
                        onPressed: () {
                          SessionController().resetSession();
                          Get.offAll(() => SelectRoleScreen());
                        },
                      ),
                      InkWell(
                        onTap: () {
                          SessionController().resetSession();
                          Get.offAll(() => SelectRoleScreen());
                        },
                        child: Text(
                          AppMetaLabels().logout,
                          style: AppTextStyle.semiBoldWhite12
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 12.5.h,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 2.0.h, left: 5.0.h, right: 5.0.h),
                          child: Text(
                            SessionController().getUserName() ?? "",
                            style: AppTextStyle.semiBoldWhite15,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 1.0.h),
                          child: Text(
                            AppMetaLabels().landLord,
                            style: AppTextStyle.normalWhite10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 16.h,
                    padding: EdgeInsets.all(2.8.h),
                    child: InkWell(
                      onTap: () {
                        Get.off(() => LandLordProfile());
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(72, 88, 106, 1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(3.0.h),
                            child: Text(
                              name,
                              style: AppTextStyle.semiBoldWhite16
                                  .copyWith(fontSize: 24.sp),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.0.h),
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  Get.to(() => LandLordProfile());
                                },
                                leading: Image.asset(
                                  AppImagesPath.myProfileLand,
                                  width: 3.0.h,
                                  fit: BoxFit.cover,
                                  // color: AppColors.blackColor,
                                ),
                                title: Text(
                                  AppMetaLabels().myProfile,
                                  style: AppTextStyle.normalBlack12,
                                ),
                              ),
                              // ListTile(
                              //   onTap: () {
                              //     Get.offAll(() => SelectRoleScreen());
                              //   },
                              //   leading: Image.asset(
                              //     AppImagesPath.logoutLand,
                              //     width: 2.5.h,
                              //     fit: BoxFit.cover,
                              //     // color: AppColors.blackColor,
                              //   ),
                              //   title: Text(
                              //     AppMetaLabels().logout,
                              //     style: AppTextStyle.normalBlack12,
                              //   ),
                              // ),

                              ListTile(
                                onTap: () async {
                                  await Get.to(() => LandlordNotifications());
                                },
                                leading: Image.asset(
                                  AppImagesPath.notificationLand,
                                  width: 3.0.h,
                                  fit: BoxFit.cover,
                                  // color: AppColors.blackColor,
                                ),
                                title: Text(
                                  AppMetaLabels().notifications,
                                  style: AppTextStyle.normalBlack12,
                                ),
                              ),

                              ListTile(
                                onTap: () async {
                                  await Get.to(() => LandLordReports());
                                },
                                leading: Image.asset(
                                  AppImagesPath.reportsLand,
                                  height: 3.5.h,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(
                                  AppMetaLabels().report,
                                  style: AppTextStyle.normalBlack12,
                                ),
                              ),
                              // ListTile(
                              //   onTap: () async {
                              //     await Get.to(() => InvoicesScreenLandlord());
                              //   },
                              //   leading: Image.asset(
                              //     AppImagesPath.payments,
                              //     height: 3.5.h,
                              //     fit: BoxFit.cover,
                              //   ),
                              //   title: Text(
                              //     AppMetaLabels().invoice,
                              //     style: AppTextStyle.normalBlack12,
                              //   ),
                              // ),

                              ListTile(
                                onTap: () {
                                  Get.off(() => LandLordSettings());
                                },
                                leading: Image.asset(
                                  AppImagesPath.settingsLand,
                                  width: 3.0.h,
                                  fit: BoxFit.cover,
                                  // color: AppColors.blackColor,
                                ),
                                title: Text(
                                  AppMetaLabels().settings,
                                  style: AppTextStyle.normalBlack12,
                                ),
                              ),

                              ListTile(
                                onTap: () {
                                  Get.off(() => LandLordFaqs());
                                },
                                leading: Image.asset(
                                  AppImagesPath.faqsLand,
                                  width: 3.0.h,
                                  fit: BoxFit.cover,
                                  // color: AppColors.blackColor,
                                ),
                                title: Text(
                                  AppMetaLabels().faq,
                                  style: AppTextStyle.normalBlack12,
                                ),
                              ),

                              ListTile(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Directionality(
                                        textDirection:
                                            SessionController().getLanguage() ==
                                                    1
                                                ? ui.TextDirection.ltr
                                                : ui.TextDirection.rtl,
                                        child: Container(
                                          height: 25.h,
                                          width: 100.0.w,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4.0.h),
                                                topRight:
                                                    Radius.circular(4.0.h),
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 4.0.h,
                                                ),
                                                Text(
                                                  AppMetaLabels().needHelp,
                                                  style: AppTextStyle
                                                      .semiBoldBlack12,
                                                ),
                                                SizedBox(
                                                  height: 3.0.h,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Directionality(
                                                          textDirection: SessionController()
                                                                      .getLanguage() ==
                                                                  1
                                                              ? ui.TextDirection
                                                                  .ltr
                                                              : ui.TextDirection
                                                                  .rtl,
                                                          child: Container(
                                                            height: 25.h,
                                                            width:
                                                                double.infinity,
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                    2.w,
                                                                    0,
                                                                    2.w,
                                                                    1.h),
                                                            child: Column(
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    Container(
                                                                        decoration: BoxDecoration(
                                                                            color: Colors
                                                                                .grey.shade300,
                                                                            borderRadius: BorderRadius.circular(1
                                                                                .h)),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsets.fromLTRB(1.h, 2.h, 1.h, 1.h),
                                                                              child: Text(
                                                                                AppMetaLabels().contactCenter,
                                                                                style: AppTextStyle.semiBoldGrey10,
                                                                              ),
                                                                            ),
                                                                            AppDivider(),
                                                                            InkWell(
                                                                              onTap: () {
                                                                                var phone = AppMetaLabels().within.split('(')[0].removeAllWhitespace.trim();

                                                                                launchUrl(Uri.parse("tel://$phone"));
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: Padding(
                                                                                padding: EdgeInsets.all(1.h),
                                                                                child: Text(
                                                                                  AppMetaLabels().within,
                                                                                  style: AppTextStyle.normalBlue14,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            AppDivider(),
                                                                            InkWell(
                                                                              onTap: () {
                                                                                String phone = AppMetaLabels().outside.split('(')[0].removeAllWhitespace.trim();

                                                                                launchUrl(Uri.parse("tel://$phone"));
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: Padding(
                                                                                padding: EdgeInsets.fromLTRB(1.h, 1.h, 1.h, 2.h),
                                                                                child: Text(
                                                                                  AppMetaLabels().outside,
                                                                                  style: AppTextStyle.normalBlue14,
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        )),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        margin: EdgeInsets.only(
                                                                            top:
                                                                                1.h),
                                                                        width: double
                                                                            .infinity,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                AppColors.whiteColor,
                                                                            borderRadius: BorderRadius.circular(1.h)),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.all(1.h),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              AppMetaLabels().cancel,
                                                                              style: AppTextStyle.semiBoldBlue14,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 3.0.h,
                                                        right: 3.0.h),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.call_outlined,
                                                          color: Colors.black,
                                                          size: 3.0.h,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 3.0.h,
                                                                  right: 3.0.h),
                                                          child: Text(
                                                            AppMetaLabels()
                                                                .callUs,
                                                            style: AppTextStyle
                                                                .semiBoldBlack12,
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color: AppColors
                                                              .blackColor,
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
                                                    launchUrl(Uri.parse(
                                                        "mailto:${AppMetaLabels().collierEmail}"));
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 3.0.h,
                                                        right: 3.0.h),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.email_outlined,
                                                          color: Colors.black,
                                                          size: 3.0.h,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 3.0.h,
                                                                  right: 3.0.h),
                                                          child: Text(
                                                            AppMetaLabels()
                                                                .emailUs,
                                                            style: AppTextStyle
                                                                .semiBoldBlack12,
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color: AppColors
                                                              .blackColor,
                                                          size: 2.0.h,
                                                        ),
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
                                },
                                leading: Icon(
                                  Icons.help_outline_outlined,
                                  size: 3.0.h,
                                  color: AppColors.blackColor,
                                ),
                                title: Text(
                                  AppMetaLabels().help,
                                  style: AppTextStyle.normalBlack12,
                                ),
                              ),

                              ListTile(
                                onTap: () {
                                  Get.to(() => AboutApp());
                                },
                                leading: Icon(
                                  Icons.info_outline,
                                  size: 3.0.h,
                                  color: AppColors.blackColor,
                                ),
                                title: Text(
                                  AppMetaLabels().about,
                                  style: AppTextStyle.normalBlack12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
