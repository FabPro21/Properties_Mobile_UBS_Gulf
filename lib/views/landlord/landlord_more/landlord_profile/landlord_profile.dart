import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/landlord/landlord_more/landlord_profile/landlord_profile_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/backbround_concave.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LandLordProfile extends StatefulWidget {
  const LandLordProfile({Key? key}) : super(key: key);

  @override
  _LandLordProfileState createState() => _LandLordProfileState();
}

class _LandLordProfileState extends State<LandLordProfile> {
  final landlordProfileController = Get.put(LandLordProfileController());

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      landlordProfileController.getData();
      landlordProfileController.canEditProfile();
    });
    super.initState();
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
                      padding: EdgeInsets.only(left: 1.0.h, top: 2.0.h),
                      child: SizedBox(
                        height: 8.h,
                        child: Row(
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
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
                    return landlordProfileController.loadingData.value == true
                        ? Padding(
                            padding: EdgeInsets.only(top: 50.0.h),
                            child: LoadingIndicatorBlue(),
                          )
                        : Column(
                            children: [
                              // Name
                              // Landlord
                              // Circle with Name first Character
                              SizedBox(
                                height: 10.5.h,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 2.0.h,
                                          left: 5.0.h,
                                          right: 5.0.h),
                                      child: Text(
                                        SessionController().getUserName() ?? "",
                                        style: AppTextStyle.semiBoldWhite15,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 1.0.h),
                                      child: Text(
                                        AppMetaLabels().landlord,
                                        style: AppTextStyle.normalWhite10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 16.h,
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
                                        name[0],
                                        // landlordProfileController.error.value !=
                                        //         ''
                                        //     ? '-'
                                        //     : SessionController()
                                        //                 .getLanguage() ==
                                        //             1
                                        //         ? landlordProfileController
                                        //                 .landLordProfile
                                        //                 .value
                                        //                 .data![0]
                                        //                 .landlordName[0] ??
                                        //             ""
                                        //         : landlordProfileController
                                        //                 .landLordProfile
                                        //                 .value
                                        //                 .data![0]
                                        //                 .landlordNameAR[0] ??
                                        //             "",
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
                                            style: AppTextStyle.semiBoldBlack12,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(top: 2.5.h),
                                            child: Text(
                                              AppMetaLabels().mobileNumber,
                                              style: AppTextStyle.normalGrey10,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(top: 0.5.h),
                                            child: Text(
                                              landlordProfileController
                                                          .error.value !=
                                                      ''
                                                  ? '-'
                                                  : landlordProfileController
                                                          .landLordProfile
                                                          .value
                                                          .data?[0]
                                                          .mobile ??
                                                      "",
                                              style:
                                                  AppTextStyle.semiBoldBlack11,
                                            ),
                                          ),
                                          landlordProfileController
                                                          .landLordProfile
                                                          .value
                                                          .data?[0]
                                                          .email ==
                                                      '' ||
                                                  landlordProfileController
                                                          .landLordProfile
                                                          .value
                                                          .data?[0]
                                                          .email ==
                                                      null
                                              ? SizedBox()
                                              : Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 2.0.h),
                                                  child: Text(
                                                    AppMetaLabels().email,
                                                    style: AppTextStyle
                                                        .normalGrey10,
                                                  ),
                                                ),
                                          landlordProfileController
                                                          .landLordProfile
                                                          .value
                                                          .data?[0]
                                                          .email ==
                                                      '' ||
                                                  landlordProfileController
                                                          .landLordProfile
                                                          .value
                                                          .data?[0]
                                                          .email ==
                                                      null
                                              ? SizedBox()
                                              : Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 0.5.h),
                                                  child: Text(
                                                    landlordProfileController
                                                                .error.value !=
                                                            ''
                                                        ? '-'
                                                        : landlordProfileController
                                                                .landLordProfile
                                                                .value
                                                                .data?[0]
                                                                .email ??
                                                            'N/A',
                                                    style: AppTextStyle
                                                        .semiBoldBlack11,
                                                  ),
                                                ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(top: 2.0.h),
                                            child: Text(
                                              AppMetaLabels().address,
                                              style: AppTextStyle.normalGrey10,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(top: 0.5.h),
                                            child: Text(
                                              landlordProfileController.error.value !=
                                                      ''
                                                  ? '-'
                                                  : landlordProfileController
                                                              .landLordProfile
                                                              .value
                                                              .data ==
                                                          null
                                                      ? ''
                                                      : SessionController()
                                                                  .getLanguage() ==
                                                              1
                                                          ? landlordProfileController
                                                                          .landLordProfile
                                                                          .value
                                                                          .data![
                                                                              0]
                                                                          .address ==
                                                                      '' ||
                                                                  landlordProfileController
                                                                          .landLordProfile
                                                                          .value
                                                                          .data![
                                                                              0]
                                                                          .address ==
                                                                      null
                                                              ? AppMetaLabels()
                                                                  .pleaseEnter
                                                              : landlordProfileController
                                                                      .landLordProfile
                                                                      .value
                                                                      .data![0]
                                                                      .address ??
                                                                  ''
                                                          : landlordProfileController
                                                                          .landLordProfile
                                                                          .value
                                                                          .data![
                                                                              0]
                                                                          .addressAR ==
                                                                      '' ||
                                                                  landlordProfileController
                                                                          .landLordProfile
                                                                          .value
                                                                          .data![
                                                                              0]
                                                                          .addressAR ==
                                                                      null
                                                              ? AppMetaLabels()
                                                                  .pleaseEnter
                                                              : landlordProfileController
                                                                      .landLordProfile
                                                                      .value
                                                                      .data![0]
                                                                      .addressAR ??
                                                                  '',
                                              style:
                                                  AppTextStyle.semiBoldBlack11,
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
                              // if (!landlordProfileController
                              //     .loadingCanEdit.value)
                              //   landlordProfileController.caseNo == null ||
                              //           landlordProfileController.caseNo == 0
                              //       ? Container(
                              //           height: 6.0.h,
                              //           width: 47.0.w,
                              //           child: ElevatedButton(
                              //             onPressed: landlordProfileController
                              //                         .landLordProfile
                              //                         .value
                              //                         .data ==
                              //                     null
                              //                 ? null
                              //                 : () {
                              //                     print(
                              //                         landlordProfileController
                              //                                 .landLordProfile
                              //                                 .value
                              //                                 .data ==
                              //                             null);
                              //                     if (landlordProfileController
                              //                             .landLordProfile
                              //                             .value
                              //                             .data
                              //                             .length !=
                              //                         0) {
                              //                       Get.to(() =>
                              //                           LandlordUpdatesProfile(
                              //                             profile:
                              //                                 landlordProfileController
                              //                                     .landLordProfile
                              //                                     .value
                              //                                     .data![0],
                              //                           ));
                              //                     } else {
                              //                       print('00000000000');
                              //                     }
                              //                   },
                              //             child: Text(
                              //               AppMetaLabels().editProfile,
                              //               style:landlordProfileController
                              //                         .landLordProfile
                              //                         .value
                              //                         .data ==
                              //                     null
                              //                 ? AppTextStyle.semiBoldBlack12
                              //                 : AppTextStyle.semiBoldBlue12,
                              //             ),
                              //             style: landlordProfileController
                              //                         .landLordProfile
                              //                         .value
                              //                         .data ==
                              //                     null
                              //                 ? null
                              //                 : ButtonStyle(
                              //                     elevation:
                              //                         MaterialStateProperty.all<
                              //                             double>(0.0.h),
                              //                     backgroundColor:
                              //                         MaterialStateProperty.all<
                              //                                 Color>(
                              //                             AppColors.whiteColor),
                              //                     shape:
                              //                         MaterialStateProperty.all<
                              //                             RoundedRectangleBorder>(
                              //                       RoundedRectangleBorder(
                              //                           borderRadius:
                              //                               BorderRadius
                              //                                   .circular(
                              //                                       2.0.w),
                              //                           side: BorderSide(
                              //                             color: AppColors
                              //                                 .blueColor,
                              //                             width: 1.0,
                              //                           )),
                              //                     )),
                              //           ),
                              //         )
                              //       : Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: Text(
                              //             '${AppMetaLabels().reqtAlreadySubmitted} ${landlordProfileController.caseNo}',
                              //             style: AppTextStyle.semiBoldBlack13,
                              //             textAlign: TextAlign.center,
                              //           ),
                              //         ),
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
