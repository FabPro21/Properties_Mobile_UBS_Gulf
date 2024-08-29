// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class TenantCancelRequest extends StatefulWidget {
  const TenantCancelRequest({Key? key}) : super(key: key);

  @override
  _TenantCancelRequestState createState() => _TenantCancelRequestState();
}

class _TenantCancelRequestState extends State<TenantCancelRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          iconSize: 2.0.h,
          onPressed: () {
            Get.back();
          },
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage(
                AppImagesPath.appbarimg,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          AppMetaLabels().serviceRequest,
          style: AppTextStyle.semiBoldWhite14,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(2.0.h),
        child: Column(
          children: [
            Container(
              width: 100.0.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2.0.h),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 0.5.h,
                    spreadRadius: 0.1.h,
                    offset: Offset(0.1.h, 0.1.h),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(2.0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppMetaLabels().addRequest,
                          style: AppTextStyle.semiBoldBlack12,
                        ),
                        Spacer(),
                        Text(
                          "SR456678",
                          style: AppTextStyle.semiBoldBlack10,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.0.h,
                    ),
                    Text(
                      "Carpenter",
                      style: AppTextStyle.normalBlack10,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      "Discovery Gardens - DG_179_Studio",
                      style: AppTextStyle.normalBlack10,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "06:030 PM",
                          style: AppTextStyle.normalBlack10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4.0.h),
                          child: Text(
                            "18 Nov 2021",
                            style: AppTextStyle.normalBlack10,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Kitchen",
                          style: AppTextStyle.normalBlack10,
                        ),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(238, 248, 241, 1),
                            borderRadius: BorderRadius.circular(0.3.h),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.0.h, vertical: 1.0.h),
                            child: Text(
                              "Resolved",
                              style: AppTextStyle.semiBoldBlack10.copyWith(
                                color: Color.fromRGBO(36, 161, 72, 1),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5.0.h,
            ),
            Container(
              width: 100.0.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2.0.h),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 0.5.h,
                    spreadRadius: 0.1.h,
                    offset: Offset(0.1.h, 0.1.h),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(2.0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppMetaLabels().yourMessage,
                      style: AppTextStyle.semiBoldBlack12,
                    ),
                    SizedBox(
                      height: 1.0.h,
                    ),
                    Text(
                      AppMetaLabels().describeTheService,
                      style: AppTextStyle.normalBlack10,
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Container(
                      width: 100.0.w,
                      height: 8.0.h,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(246, 248, 249, 1),
                        borderRadius: BorderRadius.circular(1.0.h),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(1.0.h),
                        child: Text(
                          "",
                          style: AppTextStyle.normalBlack10,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      AppMetaLabels().addPhotos,
                      style: AppTextStyle.normalBlack10,
                    ),
                    SizedBox(
                      height: 1.0.h,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 20.0.w,
                          height: 9.0.h,
                          color: Colors.red,
                          child: Image.asset(
                            AppImagesPath.building1,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 1.0.h),
                          child: Container(
                            width: 20.0.w,
                            height: 9.0.h,
                            color: Colors.red,
                            child: Image.asset(
                              AppImagesPath.building1,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 1.0.h),
                          child: Container(
                            width: 20.0.w,
                            height: 9.0.h,
                            color: Colors.red,
                            child: Image.asset(
                              AppImagesPath.building1,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0.h,
                    ),
                    SizedBox(
                      width: 90.0.w,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1.3.h),
                          ), backgroundColor: Color.fromRGBO(255, 36, 27, 1),
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.0.h, vertical: 1.8.h),
                        ),
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.scale,
                            dialogType: DialogType.noHeader,
                            body: Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(2.0.h),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(255, 36, 27, 0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(1.7.h),
                                        child: Icon(
                                          Icons.info_outline,
                                          color: Colors.red,
                                          size: 3.5.h,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(2.0.h),
                                    child: Text(
                                      "Resend OTP Limit Exceeded",
                                      style: AppTextStyle.semiBoldBlack12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            dialogBorderRadius: BorderRadius.circular(2.0.h),
                            btnOk: Center(
                              child: Padding(
                                padding: EdgeInsets.all(1.0.h),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(1.3.h),
                                    ), backgroundColor: Color.fromRGBO(0, 61, 166, 1),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 11.0.h, vertical: 1.8.h),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Dismiss",
                                    style: AppTextStyle.semiBoldWhite11,
                                  ),
                                ),
                              ),
                            ),
                          )..show();
                          // Get.to(() => TenantFeedback());
                        },
                        child: Text(
                          AppMetaLabels().cancelRequest,
                          style: AppTextStyle.semiBoldWhite12,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.0.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
