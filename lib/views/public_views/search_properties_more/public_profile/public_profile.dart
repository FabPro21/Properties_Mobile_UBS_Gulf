// import 'package:fap_properties/data/helpers/session_controller.dart';
// import 'package:fap_properties/utils/constants/meta_labels.dart';
// import 'package:fap_properties/utils/styles/colors.dart';
// import 'package:fap_properties/utils/styles/text_styles.dart';
// import 'package:fap_properties/utils/text_validator.dart';
// import 'package:fap_properties/views/widgets/common_widgets/backbround_concave.dart';
// import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
// import 'package:fap_properties/views/public_views/search_properties_more/public_profile/public_profile_controller.dart';
// import 'package:fap_properties/views/widgets/custom_text1.dart';
// // import 'package:fap_properties/views/widgets/custom_text1.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';

// class PublicProfile extends StatefulWidget {
//   const PublicProfile({Key? key}) : super(key: key);

//   @override
//   _PublicProfileState createState() => _PublicProfileState();
// }

// class _PublicProfileState extends State<PublicProfile> {
//   PublicProfileController _controller = Get.put(PublicProfileController());
//   final formKey = GlobalKey<FormState>();
//   final nameTextEditingController = TextEditingController();
//   final emailTextEditingController = TextEditingController();
//   bool emailValidation(String emailStr) {
//     var email = emailStr;
//     bool emailValid = RegExp(
//             r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//         .hasMatch(email);
//     if (emailValid == true) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: Directionality(
//           textDirection: SessionController().getLanguage() == 1
//               ? TextDirection.ltr
//               : TextDirection.rtl,
//           child: Stack(children: [
//             const AppBackgroundConcave(),
//             SafeArea(
//                 child: Column(children: [
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 1.0.h, top: 2.0.h),
//                   child: SizedBox(
//                     height: 8.h,
//                     child: Row(
//                       children: [
//                         IconButton(
//                           padding: EdgeInsets.zero,
//                           icon: const Icon(
//                             Icons.arrow_back_ios,
//                             color: Colors.white,
//                           ),
//                           onPressed: () {
//                             Get.back();
//                           },
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 11.0.h),
//                           child: Text(
//                             AppMetaLabels().myProfile,
//                             style: AppTextStyle.semiBoldWhite14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Obx(() {
//                 return _controller.profileLoading.value
//                     ? Padding(
//                         padding: EdgeInsets.only(top: 50.0.h),
//                         child: LoadingIndicatorBlue(),
//                       )
//                     : Expanded(
//                       child: SingleChildScrollView(
//                           child: Column(
//                             children: [
//                               SizedBox(
//                                 height: 10.h,
//                                 child: Column(
//                                   children: [
//                                     Padding(
//                                       padding: EdgeInsets.only(
//                                           top: 2.0.h, left: 5.0.h, right: 5.0.h),
//                                       child: Text(
//                                         AppMetaLabels().updatePublicProfile,
//                                         style: AppTextStyle.semiBoldWhite13,
//                                         textAlign: TextAlign.center,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 height: 16.h,
//                                 padding: EdgeInsets.all(1.5.h),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     color: AppColors.chartBlueColor,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: Center(
//                                     child: Padding(
//                                       padding: EdgeInsets.all(3.0.h),
//                                       child: Icon(
//                                         Icons.edit,
//                                         color: AppColors.whiteColor,
//                                         size: 3.h,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     left: 2.h, right: 2.h, top: 3.h),
//                                 child: Form(
//                                   key: formKey,
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     children: [
//                                       CustomeTextField(
//                                         validator: (value) {
//                                           {
//                                             if (value.isEmpty)
//                                               return AppMetaLabels().requireData;
//                                             else if (!nameValidator
//                                                 .hasMatch(value)) {
//                                               return AppMetaLabels().invalidName;
//                                             } else
//                                               return null;
//                                           }
//                                         },
//                                         label: AppMetaLabels().nameStarick,
//                                         controller: nameTextEditingController,
//                                       ),
//                                       SizedBox(
//                                         height: 4.h,
//                                       ),
//                                       CustomeTextField(
//                                         label: AppMetaLabels().emailWithStarick,
//                                         controller: emailTextEditingController,
//                                         validator: (value) {
//                                           {
//                                             if (value.isEmpty)
//                                               return AppMetaLabels().requireData;
//                                             else if (!emailValidation(value)) {
//                                               return AppMetaLabels().invalidEmail;
//                                             } else
//                                               return null;
//                                           }
//                                         },
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                             left: 1, top: 24, right: 1),
//                                         child: Obx(() {
//                                           return _controller.profileLoading.value
//                                               ? LoadingIndicatorBlue()
//                                               : Padding(
//                                                   padding: EdgeInsets.all(3.5.h),
//                                                   child: ElevatedButton(
//                                                     style:
//                                                         ElevatedButton.styleFrom(
//                                                       shape:
//                                                           RoundedRectangleBorder(
//                                                         borderRadius:
//                                                             BorderRadius.circular(
//                                                                 1.3.h),
//                                                       ),
//                                                       backgroundColor:
//                                                           Color.fromRGBO(
//                                                               0, 61, 166, 1),
//                                                     ),
//                                                     onPressed: () async {
//                                                       if (!formKey.currentState
//                                                           .validate()) {
//                                                         return;
//                                                       }
//                                                       FocusScope.of(context)
//                                                           .unfocus();
//                                                       print(
//                                                           'Email :::: ${emailTextEditingController.text}');
//                                                       print(
//                                                           'Name :::: ${nameTextEditingController.text}');
//                                                       _controller.profileLoading
//                                                           .value = true;
//                                                       await Future.delayed(
//                                                           Duration(seconds: 3));
//                                                       _controller.profileLoading
//                                                           .value = false;
//                                                     },
//                                                     child: SizedBox(
//                                                       width: 80.w,
//                                                       height: 6.h,
//                                                       child: Center(
//                                                         child: Text(
//                                                           AppMetaLabels()
//                                                               .updateProfile,
//                                                           style: AppTextStyle
//                                                               .semiBoldWhite12,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 );
//                                         }),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                     );
//               })
//             ]))
//           ]),
//         ));
//   }
// }

// Before New Code of Public Profile Update
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/backbround_concave.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/public_views/search_properties_more/public_profile/public_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PublicProfile extends StatefulWidget {
  const PublicProfile({Key? key}) : super(key: key);

  @override
  _PublicProfileState createState() => _PublicProfileState();
}

class _PublicProfileState extends State<PublicProfile> {
  PublicProfileController _controller = Get.put(PublicProfileController());
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
    _controller.getPublicProfile();
    _controller.canEditProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getName();

    return Scaffold(
        backgroundColor: Colors.white,
        body: Directionality(
          textDirection: SessionController().getLanguage() == 1
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: Stack(children: [
            const AppBackgroundConcave(),
            SafeArea(
                child: Column(children: [
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
                            AppMetaLabels().myProfile,
                            style: AppTextStyle.semiBoldWhite14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Obx(() {
                return _controller.profileLoading.value
                    ? Padding(
                        padding: EdgeInsets.only(top: 50.0.h),
                        child: LoadingIndicatorBlue(),
                      )
                    : Column(
                        children: [
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
                                    AppMetaLabels().public,
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
                                    name ,
                                    style: AppTextStyle.semiBoldWhite16
                                        .copyWith(fontSize: 24.sp),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 88.w,
                            margin: EdgeInsets.symmetric(
                                vertical: 6.h, horizontal: 6.w),
                            padding: EdgeInsets.all(2.0.h),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 2.0.h,
                                ),
                                Text(
                                  AppMetaLabels().personalInfo,
                                  style: AppTextStyle.semiBoldBlack12,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 2.5.h),
                                  child: Text(
                                    AppMetaLabels().mobileNumber,
                                    style: AppTextStyle.normalGrey10,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 0.5.h),
                                  child: Text(
                                    _controller.getProfiledata.value
                                            .profileDetail?.mobile ??
                                        "_",
                                    style: AppTextStyle.semiBoldBlack11,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 2.0.h),
                                  child: Text(
                                    AppMetaLabels().email,
                                    style: AppTextStyle.normalGrey10,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 0.5.h, bottom: 2.5.h),
                                  child: Text(
                                    _controller.getProfiledata.value
                                            .profileDetail?.email ??
                                        "_",
                                    style: AppTextStyle.semiBoldBlack11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Edit by Sir just in public
                          // Edit Public
                          // Obx(() {
                          //   return _controller.loadingUpdate.value
                          //       ? LoadingIndicatorBlue()
                          //       : _controller.caseNo == 0 ||
                          //               _controller.caseNo == null
                          //           ? Container(
                          //               height: 6.0.h,
                          //               width: 47.0.w,
                          //               child: ElevatedButton(
                          //                 onPressed: () {
                          //                   Get.to(() => PublicUpdateProfile(
                          //                       profile: _controller
                          //                           .getProfiledata
                          //                           .value
                          //                           .profileDetail));
                          //                 },
                          //                 child: Text(
                          //                   AppMetaLabels().editProfile,
                          //                   style: AppTextStyle.semiBoldBlue12,
                          //                 ),
                          //                 style: ButtonStyle(
                          //                     elevation: MaterialStateProperty
                          //                         .all<double>(0.0.h),
                          //                     backgroundColor:
                          //                         MaterialStateProperty.all<
                          //                                 Color>(
                          //                             AppColors.whiteColor),
                          //                     shape: MaterialStateProperty.all<
                          //                         RoundedRectangleBorder>(
                          //                       RoundedRectangleBorder(
                          //                           borderRadius:
                          //                               BorderRadius.circular(
                          //                                   2.0.w),
                          //                           side: BorderSide(
                          //                             color:
                          //                                 AppColors.blueColor,
                          //                             width: 1.0,
                          //                           )),
                          //                     )),
                          //               ),
                          //             )
                          //           : Padding(
                          //               padding: EdgeInsets.symmetric(
                          //                   horizontal: 6.0.w),
                          //               child: Text(
                          //                 "${AppMetaLabels().reqtAlreadySubmitted} ${_controller.caseNo}",
                          //                 style: AppTextStyle.semiBoldBlack13,
                          //                 textAlign: TextAlign.center,
                          //               ),
                          //             );
                          // })
                        ],
                      );
              })
            ]))
          ]),
        ));
  }
}
