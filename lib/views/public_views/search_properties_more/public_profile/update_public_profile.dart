import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/auth_models/verify_user_otp_model.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/utils/text_validator.dart';
import 'package:fap_properties/views/widgets/common_widgets/backbround_concave.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/public_views/search_properties_more/public_profile/public_profile_controller.dart';
import 'package:fap_properties/views/widgets/custom_text1.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class UpdatePublicProfile extends StatefulWidget {
  final VerifyUserOtpModel? model;
  const UpdatePublicProfile({Key? key, this.model}) : super(key: key);

  @override
  _UpdatePublicProfileState createState() => _UpdatePublicProfileState();
}

class _UpdatePublicProfileState extends State<UpdatePublicProfile> {
  PublicProfileController _controller = Get.put(PublicProfileController());
  final formKey = GlobalKey<FormState>();
  final nameTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  bool emailValidation(String emailStr) {
    var email = emailStr;
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Directionality(
            textDirection: SessionController().getLanguage() == 1
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: Stack(children: [
              const AppBackgroundConcave(),
              SafeArea(
                  child: Column(children: [
                Padding(
                  padding: EdgeInsets.only(left: 1.0.h, top: 2.0.h),
                  child: SizedBox(
                    height: 8.h,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 2.0.h, left: 5.0.h, right: 5.0.h),
                                child: Text(
                                  AppMetaLabels().updateProfile,
                                  style: AppTextStyle.semiBoldWhite13,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 16.h,
                          padding: EdgeInsets.all(1.5.h),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.chartBlueColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(3.0.h),
                                child: Icon(
                                  Icons.edit,
                                  color: AppColors.whiteColor,
                                  size: 3.h,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 2.h, right: 2.h, top: 3.h),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomeTextField(
                                  validator: (value) {
                                    {
                                      if (value.isEmpty)
                                        return AppMetaLabels().requireData;
                                      else if (!nameValidator.hasMatch(value)) {
                                        return AppMetaLabels().invalidName;
                                      } else if (nameTextEditingController
                                              .text.length <
                                          6) {
                                        return AppMetaLabels()
                                            .pleaseEnterValidName;
                                      } else
                                        return '';
                                    }
                                  },
                                  label: AppMetaLabels().fullNameWithStaric,
                                  controller: nameTextEditingController,
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                CustomeTextField(
                                  label: AppMetaLabels().emailWithStarick,
                                  controller: emailTextEditingController,
                                  validator: (value) {
                                    {
                                      if (value.isEmpty)
                                        return AppMetaLabels().requireData;
                                      else if (!emailValidation(value)) {
                                        return AppMetaLabels().invalidEmail;
                                      } else
                                        return '';
                                    }
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 1, top: 24, right: 1),
                                  child: Obx(() {
                                    return Padding(
                                      padding: EdgeInsets.all(3.5.h),
                                      child: _controller
                                              .loadingUpdatePublicProfile.value
                                          ? LoadingIndicatorBlue()
                                          : _controller.errorUpdatePublicProfile
                                                      .value !=
                                                  ''
                                              ? IconButton(
                                                  icon: Icon(
                                                    Icons.refresh,
                                                    color: AppColors.redColor,
                                                    size: 4.h,
                                                  ),
                                                  onPressed: () {
                                                    print('Retry');
                                                    if (!formKey.currentState!
                                                        .validate()) {
                                                      return;
                                                    }
                                                    _controller.updatePublicProfile(
                                                        nameTextEditingController
                                                            .text,
                                                        widget.model!.user!.userId
                                                            .toString(),
                                                        emailTextEditingController
                                                            .text);
                                                  },
                                                )
                                              : ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              1.3.h),
                                                    ),
                                                    backgroundColor:
                                                        Color.fromRGBO(
                                                            0, 61, 166, 1),
                                                  ),
                                                  onPressed: () async {
                                                    if (!formKey.currentState!
                                                        .validate()) {
                                                      return;
                                                    }
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    print(
                                                        'Email:${emailTextEditingController.text}');
                                                    print(
                                                        'Name:${nameTextEditingController.text}');
                                                    print(
                                                        'UserID:${widget.model!.user!.userId}');
                                                    var result = await _controller
                                                        .updatePublicProfile(
                                                            nameTextEditingController
                                                                .text,
                                                            widget.model!.user!
                                                                .userId
                                                                .toString(),
                                                            emailTextEditingController
                                                                .text);
                                                    if (result is User) {
                                                      Get.back(result: result);
                                                    } else {
                                                      SnakBarWidget
                                                          .getSnackBarErrorBlue(
                                                              AppMetaLabels()
                                                                  .alert,
                                                              AppMetaLabels()
                                                                  .someThingWentWrong);
                                                    }
                                                  },
                                                  child: SizedBox(
                                                    width: 80.w,
                                                    height: 6.h,
                                                    child: Center(
                                                      child: Text(
                                                        AppMetaLabels().update,
                                                        style: AppTextStyle
                                                            .semiBoldWhite12,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ]))
            ]),
          )),
    );
  }
}
