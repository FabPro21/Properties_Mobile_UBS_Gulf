import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/auth/select_role/select_role_screen.dart';
import 'package:fap_properties/views/public_views/search_properties_more/public_faqs/public_faqs_categories.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/about_app.dart/about_app.dart';
import '../public_notifications/public_notifications.dart';
import '../search_properties_properties/search_properties_properties.dart';
import '../search_properties_services/search_properties_services.dart';
import 'public_profile/public_profile.dart';
import 'public_settings/public_settings.dart';

class SearchPropertiesMore extends StatefulWidget {
  const SearchPropertiesMore({Key key}) : super(key: key);

  @override
  _SearchPropertiesMoreState createState() => _SearchPropertiesMoreState();
}

class _SearchPropertiesMoreState extends State<SearchPropertiesMore> {
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
    _getName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Directionality(
          textDirection: SessionController().getLanguage() == 1
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: Stack(
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
                            size: 3.h,
                          ),
                          onPressed: () {
                            SessionController().resetSession();
                            // Sending redirect false because we ant to stop the user in the role screen
                            // even if there is only one role
                            Get.offAll(() => SelectRoleScreen(
                                  redirect: false,
                                ));
                            // Get.offAll(() => SelectRoleScreen());
                          },
                        ),
                        InkWell(
                          onTap: () {
                            SessionController().resetSession();
                            // Sending redirect false because we ant to stop the user in the role screen
                            // even if there is only one role
                            Get.offAll(() => SelectRoleScreen(
                                  redirect: false,
                                ));
                            // Get.offAll(() => SelectRoleScreen());
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
                    Padding(
                      padding: EdgeInsets.only(
                        top: 2.0.h,
                      ),
                      child: Center(
                        child: SizedBox(
                          width: 90.w,
                          child: Text(
                            SessionController().getUserName() ?? "",
                            style: AppTextStyle.semiBoldWhite15,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.0.w),
                      child: Text(
                        AppMetaLabels().public,
                        style: AppTextStyle.normalWhite10,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0.h),
                      child: InkWell(
                        onTap: () {
                          Get.off(() => PublicProfile());
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
                                name ?? "",
                                style: AppTextStyle.semiBoldWhite16
                                    .copyWith(fontSize: 24.sp),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.0.h, top: 2.0.h),
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  Get.off(() => PublicProfile());
                                },
                                leading: Image.asset(
                                  AppImagesPath.myProfileLand,
                                  width: 3.0.h,
                                  color: AppColors.blackColor,
                                ),
                                title: Text(
                                  AppMetaLabels().myProfile,
                                  style: AppTextStyle.normalBlack12,
                                ),
                              ),
                              // ListTile(
                              //   onTap: () {
                              //     SessionController().resetSession();
                              //     Get.offAll(() => SelectRoleScreen(
                              //           redirect: false,
                              //         ));
                              //   },
                              //   leading: Icon(
                              //     Icons.logout,
                              //     size: 3.0.h,
                              //     color: AppColors.blackColor,
                              //   ),
                              //   title: Text(
                              //     AppMetaLabels().logout,
                              //     style: AppTextStyle.normalBlack12,
                              //   ),
                              // ),

                              ListTile(
                                onTap: () {
                                  Get.off(() => PublicNotification());
                                },
                                leading: Icon(
                                  Icons.notifications_outlined,
                                  size: 3.0.h,
                                  color: AppColors.blackColor,
                                ),
                                title: Text(
                                  AppMetaLabels().notifications,
                                  style: AppTextStyle.normalBlack12,
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  Get.off(() => SearchPropertiesProperties());
                                },
                                leading: Image.asset(
                                  AppImagesPath.contracts3,
                                  width: 3.0.h,
                                  color: AppColors.blackColor,
                                ),
                                title: Text(
                                  AppMetaLabels().fabProps,
                                  style: AppTextStyle.normalBlack12,
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  Get.off(() => SearchPropertiesServices());
                                },
                                leading: Image.asset(
                                  AppImagesPath.services3,
                                  width: 3.0.h,
                                  color: AppColors.blackColor,
                                ),
                                title: Text(
                                  AppMetaLabels().ourServices,
                                  style: AppTextStyle.normalBlack12,
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  Get.off(() => PublicSettings());
                                },
                                leading: Icon(
                                  Icons.settings_outlined,
                                  size: 3.0.h,
                                  color: AppColors.blackColor,
                                ),
                                title: Text(
                                  AppMetaLabels().settings,
                                  style: AppTextStyle.normalBlack12,
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  Get.off(() => PublicFaqsCategories());
                                },
                                leading: Icon(
                                  Icons.help_outline,
                                  size: 3.0.h,
                                  color: AppColors.blackColor,
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
                                                ? TextDirection.ltr
                                                : TextDirection.rtl,
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
                                                        return Container(
                                                          height: 25.h,
                                                          width:
                                                              double.infinity,
                                                          margin: EdgeInsets
                                                              .fromLTRB(2.w, 0,
                                                                  2.w, 1.h),
                                                          child: Column(
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  Container(
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .grey
                                                                              .shade300,
                                                                          borderRadius: BorderRadius.circular(1
                                                                              .h)),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsets.fromLTRB(
                                                                                1.h,
                                                                                2.h,
                                                                                1.h,
                                                                                1.h),
                                                                            child:
                                                                                Text(
                                                                              AppMetaLabels().contactCenter,
                                                                              style: AppTextStyle.semiBoldGrey10,
                                                                            ),
                                                                          ),
                                                                          AppDivider(),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              var phone = AppMetaLabels().within.split('(')[0].removeAllWhitespace.trim();

                                                                              launchUrl(Uri.parse("tel://$phone"));
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.all(1.h),
                                                                              child: Text(
                                                                                AppMetaLabels().within,
                                                                                style: AppTextStyle.normalBlue14,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          AppDivider(),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              String phone = AppMetaLabels().outside.split('(')[0].removeAllWhitespace.trim();

                                                                              launchUrl(Uri.parse("tel://$phone"));
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Padding(
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
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      margin: EdgeInsets.only(
                                                                          top: 1
                                                                              .h),
                                                                      width: double
                                                                          .infinity,
                                                                      decoration: BoxDecoration(
                                                                          color: AppColors
                                                                              .whiteColor,
                                                                          borderRadius:
                                                                              BorderRadius.circular(1.h)),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(1.h),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            AppMetaLabels().cancel,
                                                                            style:
                                                                                AppTextStyle.semiBoldBlue14,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
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
                                                        "mailto:${AppMetaLabels().fabEmail}"));
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      left: 3.0.h,
                                                      right: 3.0.h,
                                                    ),
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
                                leading: Image.asset(
                                  AppImagesPath.faqsLand,
                                  width: 3.0.h,
                                  fit: BoxFit.cover,
                                  // color: AppColors.blackColor,
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
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
