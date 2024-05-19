import 'package:fap_properties/data/models/tenant_models/tenant_profile/tenant_profile_model.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/backbround_concave.dart';
import 'package:fap_properties/views/tenant/tenant_profile/tenant_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../data/helpers/session_controller.dart';

class TenantUpdatesProfile extends StatefulWidget {
  final Profile profile;
  const TenantUpdatesProfile({Key key, this.profile}) : super(key: key);

  @override
  _TenantUpdatesProfileState createState() => _TenantUpdatesProfileState();
}

class _TenantUpdatesProfileState extends State<TenantUpdatesProfile> {
  final tenantProfileController = Get.put(TenantProfileController());
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    _nameController.text = SessionController().getLanguage() == 1
        ? widget.profile.name
        : widget.profile.nameAr;
    _emailController.text = widget.profile.email;
    _phoneController.text = widget.profile.mobile;
    _addressController.text = SessionController().getLanguage() == 1
        ? widget.profile.address
        : widget.profile.addressAr;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.white,
          // resizeToAvoidBottomInset: false,
          body: Column(children: [
            Stack(children: [
              SizedBox(
                  height: 35.0.h,
                  width: 100.0.w,
                  child: const AppBackgroundConcave()),
              SafeArea(
                  child: Column(children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 1.0.h, top: 2.0.h),
                    child: SizedBox(
                      height: 7.h,
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
                            padding: EdgeInsets.only(left: 10.0.h),
                            child: Text(
                              AppMetaLabels().editProfile,
                              style: AppTextStyle.semiBoldWhite14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(children: [
                  SizedBox(
                    height: 12.5.h,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 2.0.h, left: 5.0.h, right: 5.0.h),
                          child: Text(
                            SessionController().getLanguage() == 1
                                ? widget.profile.name
                                : widget.profile.nameAr,
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
                ])
              ]))
            ]),
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 4.0.w, top: 2.0.h, right: 4.0.w),
                    child: Align(
                        alignment: SessionController().getLanguage() == 1
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Text(
                          AppMetaLabels().name,
                          style: AppTextStyle.normalGrey10,
                        )),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 0.5.h, left: 3.0.w, right: 3.0.w),
                    child: TextFormField(
                      controller: _nameController,
                      style: AppTextStyle.normalBlack10,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: AppColors.blueColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: AppColors.bordercolornew,
                            width: 0.2.w,
                          ),
                        ),
                        fillColor: AppColors.greyBG,
                        filled: true,
                        hintText: AppMetaLabels().name,
                        hintStyle: AppTextStyle.normalBlack10
                            .copyWith(color: AppColors.textFieldBGColor),
                        errorStyle: TextStyle(fontSize: 0),
                        contentPadding: EdgeInsets.all(4.w),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 4.0.w, top: 2.0.h, right: 4.0.w),
                    child: Align(
                        alignment: SessionController().getLanguage() == 1
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Text(
                          AppMetaLabels().email,
                          style: AppTextStyle.normalGrey10,
                        )),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 0.5.h, left: 3.0.w, right: 3.0.w),
                    child: TextFormField(
                      controller: _emailController,
                      style: AppTextStyle.normalBlack10,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: AppColors.blueColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: AppColors.bordercolornew,
                            width: 0.2.w,
                          ),
                        ),
                        fillColor: AppColors.greyBG,
                        filled: true,
                        hintText: AppMetaLabels().email,
                        hintStyle: AppTextStyle.normalBlack10
                            .copyWith(color: AppColors.textFieldBGColor),
                        errorStyle: TextStyle(fontSize: 0),
                        contentPadding: EdgeInsets.all(4.w),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 4.0.w, top: 2.0.h, right: 4.0.w),
                    child: Align(
                        alignment: SessionController().getLanguage() == 1
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Text(
                          AppMetaLabels().mobileNumber,
                          style: AppTextStyle.normalGrey10,
                        )),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 0.5.h, left: 3.0.w, right: 3.0.w),
                    child: Directionality(
                      textDirection: SessionController().getLanguage() == 1
                          ? TextDirection.ltr
                          : TextDirection.rtl,
                      child: TextFormField(
                        controller: _phoneController,
                        style: AppTextStyle.normalBlack10,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(color: AppColors.blueColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: AppColors.bordercolornew,
                              width: 0.2.w,
                            ),
                          ),
                          fillColor: AppColors.greyBG,
                          filled: true,
                          hintText: AppMetaLabels().mobileNumber,
                          hintStyle: AppTextStyle.normalBlack10
                              .copyWith(color: AppColors.textFieldBGColor),
                          errorStyle: TextStyle(fontSize: 0),
                          contentPadding: EdgeInsets.all(4.w),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 4.0.w, top: 2.0.h, right: 4.0.w),
                    child: Align(
                        alignment: SessionController().getLanguage() == 1
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Text(
                          AppMetaLabels().address,
                          style: AppTextStyle.normalGrey10,
                        )),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 0.5.h, left: 3.0.w, right: 3.0.w),
                    child: TextFormField(
                      controller: _addressController,
                      style: AppTextStyle.normalBlack10,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: AppColors.blueColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: AppColors.bordercolornew,
                            width: 0.2.w,
                          ),
                        ),
                        fillColor: AppColors.greyBG,
                        filled: true,
                        // ),
                        hintText: AppMetaLabels().address,
                        hintStyle: AppTextStyle.normalBlack10
                            .copyWith(color: AppColors.textFieldBGColor),
                        errorStyle: TextStyle(fontSize: 0),
                        contentPadding: EdgeInsets.all(4.w),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6.0.h,
                  ),
                  Obx(() {
                    return tenantProfileController.loadingUpdate.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.blueColor,
                            ),
                          )
                        : Container(
                            height: 6.0.h,
                            width: 49.0.w,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_nameController.text !=
                                        widget.profile.name ||
                                    _emailController.text !=
                                        widget.profile.email ||
                                    _phoneController.text !=
                                        widget.profile.mobile ||
                                    _addressController.text !=
                                        widget.profile.address) {
                                  if (await tenantProfileController
                                      .updateProfile(
                                          _nameController.text,
                                          _phoneController.text,
                                          _emailController.text,
                                          _addressController.text))
                                    // get profile
                                    // await tenantProfileController.getData();
                                    // 12*
                                    // await tenantProfileController.setUserName();
                                    // print('Name ::A update::: => ${SessionController().getUserName()}');
                                    // print('Name Ar :A update: => ${SessionController().getUserNameAr()}');
                                    // session update
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(1.0.w,
                                                      1.0.h, 1.0.w, 1.0.h),
                                              backgroundColor:
                                                  Colors.transparent,
                                              content: SizedBox(
                                                  width: 100.w,
                                                  child: showDialogData()));
                                        });
                                } else {
                                  Get.snackbar(
                                    AppMetaLabels().error,
                                    AppMetaLabels().serviceReqNotUpdated,
                                    backgroundColor: Colors.white54,
                                  );
                                }
                              },
                              child: Text(
                                AppMetaLabels().updateProfile,
                                style: AppTextStyle.semiBoldBlue12,
                              ),
                              style: ButtonStyle(
                                  elevation:
                                      MaterialStateProperty.all<double>(0.0),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          AppColors.whiteColor),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(2.0.w),
                                        side: BorderSide(
                                          color: AppColors.blueColor,
                                          width: 1.0,
                                        )),
                                  )),
                            ),
                          );
                  })
                ],
              )),
            )
          ])),
    );
  }

  Widget showDialogData() {
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
                height: 5.0.h,
              ),
              Image.asset(
                AppImagesPath.bluttickimg,
                height: 8.0.h,
              ),
              SizedBox(
                height: 6.0.h,
              ),
              Text(
                '${AppMetaLabels().requestAddedSuccessfully}\n${AppMetaLabels().requestno} ${tenantProfileController.updateProfiledata.value.addServiceRequest.caseNo}',
                style: AppTextStyle.semiBoldBlack12,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(top: 4.0.h, bottom: 2.0.h),
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 6.0.h,
                    width: 30.0.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1.3.h),
                        ),
                        backgroundColor: Color.fromRGBO(0, 61, 166, 1),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Get.back();
                      },
                      child: Text(
                        AppMetaLabels().ok,
                        style: AppTextStyle.semiBoldWhite12,
                      ),
                    ),
                  ),
                ),
              )
            ]));
  }
}
