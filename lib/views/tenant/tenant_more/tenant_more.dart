import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/video/renewal_tutorial.dart';
import 'package:fap_properties/views/auth/select_role/select_role_screen.dart';
import 'package:fap_properties/views/common/about_app.dart/about_app.dart';
import 'package:fap_properties/views/public_views/search_properties_dashboard_tabs/search_properties_dashboard_tabs.dart';
import 'package:fap_properties/views/tenant/tenant_dashboard/tenant_dashboard_get_data_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/tenant/tenant_more/tenant_faqs/tenant_faqs.dart';
import 'package:fap_properties/views/tenant/tenant_more/tenant_offers/tenant_offers.dart';
import 'package:fap_properties/views/tenant/tenant_more/tenant_settings/tenant_settings.dart';
import 'package:fap_properties/views/tenant/tenant_notifications/tenant_notifications.dart';
import 'package:fap_properties/views/tenant/tenant_profile/tenant_profile.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/models/auth_models/session_token_model.dart';
import '../../../data/repository/auth_repository.dart';
import 'dart:ui' as ui;

class TenantMoreScreen extends StatefulWidget {
  const TenantMoreScreen({Key key}) : super(key: key);

  @override
  State<TenantMoreScreen> createState() => _TenantMoreScreenState();
}

class _TenantMoreScreenState extends State<TenantMoreScreen> {
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

  final TenantDashboardGetDataController tDGDController =
      Get.put(TenantDashboardGetDataController());
  @override
  void initState() {
    _getName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                            tDGDController.getDashboardData();
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
                          Get.offAll(() => SelectRoleScreen());
                        },
                      ),
                      InkWell(
                        onTap: () {
                          SessionController().resetSession();
                          Get.offAll(() => SelectRoleScreen());
                        },
                        child: Text(
                          AppMetaLabels().logout + '  ',
                          style: AppTextStyle.semiBoldWhite12
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 1.w,
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
                            SessionController().getUserName() ?? '',
                            style: AppTextStyle.semiBoldWhite15,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 1.0.h),
                          child: Text(
                            AppMetaLabels().tenant,
                            style: AppTextStyle.normalWhite10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 16.h,
                    padding: EdgeInsets.all(2.5.h),
                    child: InkWell(
                      onTap: () {
                        Get.off(() => TenantProfile());
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
                    child: Padding(
                      padding: EdgeInsets.only(top: 3.h),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.0.h),
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  Get.off(() => TenantProfile());
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
                              Obx(() {
                                return gettingPublicToken.value
                                    ? LoadingIndicatorBlue(size: 3.h)
                                    : ListTile(
                                        onTap: () {
                                          selectNewUnit();
                                        },
                                        leading: Icon(
                                          Icons.add,
                                          size: 3.0.h,
                                          color: AppColors.blackColor,
                                        ),
                                        title: Text(
                                          AppMetaLabels().addNewUnit,
                                          style: AppTextStyle.normalBlack12,
                                        ),
                                      );
                              }),
                              ListTile(
                                onTap: () {
                                  Get.off(() => TenantNotifications());
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
                              //  ListTile(
                              //             onTap: () async {
                              //               await showDialog(
                              //                   context: context,
                              //                   barrierDismissible: false,
                              //                   builder: (BuildContext context) {
                              //                     return AlertDialog(
                              //                       contentPadding: EdgeInsets.zero,
                              //                       backgroundColor:
                              //                           Colors.transparent,
                              //                       content: showDialogForVideo(),
                              //                     );
                              //                   });
                              //             },
                              //             leading: Icon(
                              //               Icons.play_arrow,
                              //               size: 3.3.h,
                              //               color: AppColors.blackColor,
                              //             ),
                              //             title: Text(
                              //               AppMetaLabels().renewalFlowMore,
                              //               style: AppTextStyle.normalBlack12,
                              //             ),
                              //           )
                              //  ,
                              ListTile(
                                onTap: () {
                                  Get.off(() => TenantSettings());
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
                                  Get.off(() => TenantOffers());
                                },
                                leading: Icon(
                                  Icons.tag,
                                  size: 3.0.h,
                                  color: AppColors.blackColor,
                                ),
                                title: Text(
                                  AppMetaLabels().offers,
                                  style: AppTextStyle.normalBlack12,
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  Get.off(() => TenantFaqs());
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

  RxBool gettingPublicToken = false.obs;
  void selectNewUnit() async {
    gettingPublicToken.value = true;
    final resp = await CommonRepository.validatePublicRole();
    gettingPublicToken.value = false;
    if (resp is SessionTokenModel) {
      SessionController().setPublicToken(resp.token);
      // update the search page 4 Nov 22
      // Get.off(() => SearchVacantUnits());
      Get.off(() => SearchPropertiesDashboardTabs());
    }
  }

  Widget showDialogForVideo() {
    return Container(
      padding: EdgeInsets.all(3.0.w),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 2.0.h,
          ),
          Icon(
            Icons.play_arrow,
            size: 9.0.h,
          ),
          SizedBox(
            height: 2.0.h,
          ),
          Text(
            AppMetaLabels().renewalFlowTutorial,
            textAlign: TextAlign.center,
            style: AppTextStyle.semiBoldBlack14,
          ),
          SizedBox(
            height: 4.0.h,
          ),
          // InkWell(
          //   onTap: () async {
          //     setState(() {
          //       SessionController().videoURl =
          //           'https://vimeo.com/829325127/401ee0eebf';
          //       SessionController().videoPathFromAsset =
          //           'assets/video/WithMunciplity.mp4';
          //     });
          //     // launchUrl(Uri.parse(SessionController().videoURl),
          //     //     mode: LaunchMode.externalApplication);
          //     await Get.to(() => RenewalTutorialVideo(
          //         path: SessionController()
          //             .videoPathFromAsset //SessionController().videoPath,
          //         ));
          //   },
          //   child: Text(
          //     'Contract Renewal Process For Abu Dhabi & Al Ain',
          //     textAlign: TextAlign.center,
          //     style: AppTextStyle.semiBoldBlack13.copyWith(
          //       color: Color.fromRGBO(0, 61, 166, 1),
          //       decoration: TextDecoration.underline,
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 1.5.h,
          ),
          InkWell(
            onTap: () async {
              setState(() {
                SessionController().videoURl =
                    'https://vimeo.com/829328299/8b66d7dc3f';
                SessionController().videoPathFromAsset =
                    'assets/video/FAB_8.mp4';
              });
              // launchUrl(Uri.parse(SessionController().videoURl),
              //     mode: LaunchMode.externalApplication);
              await Get.to(() => RenewalTutorialVideo(
                  path: SessionController()
                      .videoPathFromAsset //SessionController().videoPath,
                  ));
            },
            child: Text(
              AppMetaLabels().renewalFlowTutorialUrl,
              textAlign: TextAlign.center,
              style: AppTextStyle.semiBoldBlack13.copyWith(
                color: Color.fromRGBO(0, 61, 166, 1),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0.h, bottom: 2.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 2.w,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 5.0.h,
                    width: 30.0.w,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3.0.w),
                                    side: BorderSide(color: Colors.blue))),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppMetaLabels().cancel,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.semiBoldBlack10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
        ],
      ),
    );
  }
}
