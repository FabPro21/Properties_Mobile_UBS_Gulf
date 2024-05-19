import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:get/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SnakBarWidget {
  static getSnackBarSuccess(
    String title,
    String message,
  ) {
    return Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 4),
        margin: EdgeInsets.only(bottom: 2.h, right: 1.h, left: 1.h),
        backgroundColor: Colors.green[700],
        colorText: Colors.white,
        icon: Icon(
          Icons.check,
          color: Colors.white,
        ));
  }

  static getSnackBarError(
    String title,
    String message,
  ) {
    return Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        margin: EdgeInsets.only(bottom: 2.h, right: 1.h, left: 1.h),
        colorText: Colors.white,
        icon: Icon(
          Icons.error,
          color: Colors.white,
        ));
  }

  static getSnackBarErrorBlue(
    String title,
    String message,
  ) {
    return Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
        backgroundColor: Colors.blue,
        margin: EdgeInsets.only(bottom: 2.h, right: 1.h, left: 1.h),
        colorText: Colors.white,
        icon: Icon(
          Icons.error,
          color: Colors.white,
        ));
  }

  static getSnackBarErrorBlueRichTExt(String title, String message) {
    return Get.snackbar(title, message,
        messageText: RichText(
          text: TextSpan(
            text: '',
            children: <TextSpan>[
              TextSpan(
                  text: AppMetaLabels().pleaseScan,
                  style: AppTextStyle.normalWhite11),
              TextSpan(
                  text: message,
                  style: AppTextStyle.semiBoldWhite12
                      .copyWith(fontWeight: FontWeight.bold)),
              TextSpan(
                  text: AppMetaLabels().validEID,
                  style: AppTextStyle.normalWhite11),
            ],
          ),
        ),
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
        backgroundColor: Colors.blue,
        margin: EdgeInsets.only(bottom: 2.h, right: 1.h, left: 1.h),
        colorText: Colors.white,
        icon: Icon(
          Icons.error,
          color: Colors.white,
        ));
  }

  static getSnackBarTAKEBlueRichTExt() {
    return Get.snackbar('', '',
        messageText: RichText(
          text: TextSpan(
            text: '',
            children: <TextSpan>[
              TextSpan(
                  text: AppMetaLabels().pleasetakeOtherSide,
                  style: AppTextStyle.normalWhite11),
              TextSpan(text: '', style: AppTextStyle.normalWhite11),
            ],
          ),
        ),
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
        backgroundColor: Colors.blue,
        margin: EdgeInsets.only(bottom: 2.h, right: 1.h, left: 1.h),
        colorText: Colors.white,
        icon: Icon(
          Icons.error,
          color: Colors.white,
        ));
  }

  static getSnackBarErrorBlueRichTExtForPrepareData(
      String title, String message) {
    return Get.snackbar(title, message,
        messageText: RichText(
          text: TextSpan(
            text: '',
            children: <TextSpan>[
              TextSpan(
                  text: AppMetaLabels().pleaseWait,
                  style: AppTextStyle.normalWhite11),
              TextSpan(
                  text: message,
                  style: AppTextStyle.semiBoldWhite12
                      .copyWith(fontWeight: FontWeight.bold)),
              TextSpan(
                  text: AppMetaLabels().dataISPreparing,
                  style: AppTextStyle.normalWhite11),
            ],
          ),
        ),
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
        backgroundColor: Colors.blue,
        margin: EdgeInsets.only(bottom: 2.h, right: 1.h, left: 1.h),
        colorText: Colors.white,
        icon: Icon(
          Icons.error,
          color: Colors.white,
        ));
  }

  static getSnackBarErrorBlueRichTExtForPrepareDataAr() {
    return Get.snackbar('', '',
        messageText: RichText(
          text: TextSpan(
            text: '',
            children: <TextSpan>[
              TextSpan(
                  text: '',
                  style: AppTextStyle.normalWhite11),
              TextSpan(
                  text: AppMetaLabels().dataISPreparingAR,
                  style: AppTextStyle.semiBoldWhite12
                      .copyWith(fontWeight: FontWeight.bold)),
              TextSpan(
                  text: '',
                  style: AppTextStyle.normalWhite11),
            ],
          ),
        ),
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
        backgroundColor: Colors.blue,
        margin: EdgeInsets.only(bottom: 2.h, right: 1.h, left: 1.h),
        colorText: Colors.white,
        icon: Icon(
          Icons.error,
          color: Colors.white,
        ));
  }

  static getSnackBarErrorBlueWith20Sec(
    String title,
    String message,
  ) {
    return Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 40),
        backgroundColor: Colors.blue,
        margin: EdgeInsets.only(bottom: 2.h, right: 1.h, left: 1.h),
        colorText: Colors.white,
        icon: Icon(
          Icons.error,
          color: Colors.white,
        ));
  }

  static getSnackBarErrorBlueWith5Sec(
    String title,
    String message,
  ) {
    return Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
        backgroundColor: Colors.blue,
        margin: EdgeInsets.only(bottom: 2.h, right: 1.h, left: 1.h),
        colorText: Colors.white,
        icon: Icon(
          Icons.error,
          color: Colors.white,
        ));
  }
  static getSnackBarErrorRedWith5Sec(
    String title,
    String message,
  ) {
    return Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        margin: EdgeInsets.only(bottom: 2.h, right: 1.h, left: 1.h),
        colorText: Colors.white,
        icon: Icon(
          Icons.error,
          color: Colors.white,
        ));
  }

  static getLoading() {
    return Get.dialog(
        const Center(
            child: CircularProgressIndicator(
          backgroundColor: Colors.transparent,
          color: Colors.transparent,
        )),
        barrierDismissible: true);
  }

  static getLoadingWithColor() {
    return Get.dialog(
        const Center(
            child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: Colors.blue,
        )),
        barrierDismissible: false);
  }

  static getLoadingWithColorWithoutbarrierDismissible() {
    return Get.dialog(
        const Center(
            child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: Colors.blue,
        )),
        barrierDismissible: true);
  }
}
