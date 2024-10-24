import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/backbround_concave.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/tenant/tenant_profile/tenant_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class TenantProfile extends StatefulWidget {
  TenantProfile({Key? key}) : super(key: key);

  @override
  State<TenantProfile> createState() => _TenantProfileState();
}

class _TenantProfileState extends State<TenantProfile> {
  final tenantProfileController = Get.put(TenantProfileController());

  @override
  void initState() {
    super.initState();
  }

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
  Widget build(BuildContext context) {
    _getName();

    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            const AppBackgroundConcave(),
            SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 1.0.h, top: 1.0.h),
                      child: SizedBox(
                        height: 6.5.h,
                        child: Row(
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: AppColors.whiteColor,
                              ),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 11.0.h),
                              child: Text(
                                AppMetaLabels().myProfileTenant,
                                style: AppTextStyle.semiBoldWhite14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Obx(() {
                    return tenantProfileController.loadingData.value == true
                        ? Padding(
                            padding: EdgeInsets.only(top: 50.0.h),
                            child: LoadingIndicatorBlue(),
                          )
                        : tenantProfileController.error.value != ''
                            ? Padding(
                                padding: EdgeInsets.only(top: 30.0.h),
                                child: AppErrorWidget(
                                  errorText:
                                      tenantProfileController.error.value,
                                ),
                              )
                            : Column(
                                children: [
                                  SizedBox(
                                    height: 12.5.h,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 2.0.h,
                                              left: 5.0.h,
                                              right: 5.0.h),
                                          child: Text(
                                            SessionController().getUserName() ??
                                                "",
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
                                    height: 15.h,
                                    padding: EdgeInsets.all(2.0.h),
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
                                  Padding(
                                    padding: EdgeInsets.all(3.0.h),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 3.0.h),
                                      child: Container(
                                        width: 94.0.w,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 0.5.h,
                                              spreadRadius: 0.3.h,
                                              offset: Offset(0.1.h, 0.1.h),
                                            ),
                                          ],
                                          borderRadius: BorderRadius.circular(
                                            1.0.h,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(2.0.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                AppMetaLabels().personalInfo,
                                                style: AppTextStyle
                                                    .semiBoldBlack12,
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 2.5.h),
                                                child: Text(
                                                  AppMetaLabels().mobileNumber,
                                                  style:
                                                      AppTextStyle.normalGrey10,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 0.5.h),
                                                child: Directionality(
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  child: Text(
                                                    tenantProfileController
                                                            .tenantProfile
                                                            .value
                                                            .profile!
                                                            .mobile ??
                                                        "",
                                                    style: AppTextStyle
                                                        .semiBoldBlack11,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 2.0.h),
                                                child: Text(
                                                  AppMetaLabels().email,
                                                  style:
                                                      AppTextStyle.normalGrey10,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 0.5.h),
                                                child: Text(
                                                  tenantProfileController
                                                          .tenantProfile
                                                          .value
                                                          .profile!
                                                          .email ??
                                                      "",
                                                  style: AppTextStyle
                                                      .semiBoldBlack11,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 2.0.h),
                                                child: Text(
                                                  AppMetaLabels().address,
                                                  style:
                                                      AppTextStyle.normalGrey10,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 0.5.h),
                                                child: Text(
                                                  SessionController()
                                                              .getLanguage() ==
                                                          1
                                                      ? tenantProfileController
                                                              .tenantProfile
                                                              .value
                                                              .profile!
                                                              .address ??
                                                          ""
                                                      : tenantProfileController
                                                              .tenantProfile
                                                              .value
                                                              .profile!
                                                              .addressAr ??
                                                          "",
                                                  // SessionController(). ?? "",
                                                  style: AppTextStyle
                                                      .semiBoldBlack11,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0.h,
                                  ),
                                  // if (!tenantProfileController.loadingCanEdit.value)
                                  //   tenantProfileController.caseNo == null ||
                                  //           tenantProfileController.caseNo == 0
                                  //       ? Container(
                                  //           height: 6.0.h,
                                  //           width: 47.0.w,
                                  //           child: ElevatedButton(
                                  //             onPressed: () {
                                  //               Get.to(() => TenantUpdatesProfile(
                                  //                     profile:
                                  //                         tenantProfileController
                                  //                             .tenantProfile
                                  //                             .value
                                  //                             .profile,
                                  //                   ));
                                  //             },
                                  //             child: Text(
                                  //               AppMetaLabels().editProfile,
                                  //               style: AppTextStyle.semiBoldBlue12,
                                  //             ),
                                  //             style: ButtonStyle(
                                  //                 elevation: MaterialStateProperty
                                  //                     .all<double>(0.0.h),
                                  //                 backgroundColor:
                                  //                     MaterialStateProperty.all<
                                  //                             Color>(
                                  //                         AppColors.whiteColor),
                                  //                 shape: MaterialStateProperty.all<
                                  //                     RoundedRectangleBorder>(
                                  //                   RoundedRectangleBorder(
                                  //                       borderRadius:
                                  //                           BorderRadius.circular(
                                  //                               2.0.w),
                                  //                       side: BorderSide(
                                  //                         color:
                                  //                             AppColors.blueColor,
                                  //                         width: 1.0,
                                  //                       )),
                                  //                 )),
                                  //           ),
                                  //         )
                                  //       : Padding(
                                  //           padding: const EdgeInsets.all(8.0),
                                  //           child: Text(
                                  //             '${AppMetaLabels().reqtAlreadySubmitted} ${tenantProfileController.caseNo}',
                                  //             style: AppTextStyle.semiBoldBlack13,
                                  //             textAlign: TextAlign.center,
                                  //           ),
                                  //         )
                                ],
                              );
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
