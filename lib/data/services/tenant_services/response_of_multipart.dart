import 'dart:developer';

import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ResponseInText extends StatefulWidget {
  final String? respose;
  ResponseInText({Key? key, this.respose}) : super(key: key);

  @override
  State<ResponseInText> createState() => _ResponseInTextState();
}

class _ResponseInTextState extends State<ResponseInText> {
  @override
  Widget build(BuildContext context) {
    log(widget.respose!);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white54,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            iconSize: 2.0.h,
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            AppMetaLabels().error,
            style: AppTextStyle.semiBoldBlack10,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.zero,
              margin:
                  EdgeInsets.only(top: 1.h, left: 2.w, right: 2.w, bottom: 2.h),
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
              child: Center(
                child: Html(
                  data: widget.respose,
                  // padding: EdgeInsets.zero,
                ),
              )),
        ),
      ),
    );
  }
}
