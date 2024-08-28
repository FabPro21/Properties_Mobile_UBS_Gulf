import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CustomAppBar2 extends StatelessWidget {
  final String? title;
  final Function? onBackPressed;
  const CustomAppBar2({
    Key? key,
    @required this.title,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12.h,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0.5.h,
            spreadRadius: 0.8.h,
            offset: Offset(0.1.h, 0.1.h),
          ),
        ],
      ),
      child: Stack(
        children: [
          Image.asset(
            AppImagesPath.appbarimg,
            width: double.infinity,
            height: 12.h,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0.h),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 3.h,
                    ),
                    onPressed: () {
                      if (onBackPressed != null)
                        onBackPressed!();
                      else
                        Get.back();
                    },
                  ),
                  Expanded(
                    child: Text(
                      title!,
                      style: AppTextStyle.semiBoldWhite14,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(
                    width: 5.h,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAppBar2ForVendorTechniance extends StatelessWidget {
  final String? title;
  final Function? onBackPressed;
  const CustomAppBar2ForVendorTechniance({
    Key? key,
    @required this.title,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7.h,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0.5.h,
            spreadRadius: 0.8.h,
            offset: Offset(0.1.h, 0.1.h),
          ),
        ],
      ),
      child: Stack(
        children: [
          Image.asset(
            AppImagesPath.appbarimg,
            width: double.infinity,
            height: 8.h,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.0.h),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SessionController().vendorUserType == 'Technician'
                      ? SizedBox()
                      : IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 3.h,
                          ),
                          onPressed: () {
                            if (onBackPressed != null)
                              onBackPressed!();
                            else
                              Get.back();
                          },
                        ),
                  Text(title!, style: AppTextStyle.semiBoldWhite14),
                  SizedBox(
                    width: 5.h,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
