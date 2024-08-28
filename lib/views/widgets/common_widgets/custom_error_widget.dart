// ignore_for_file: unnecessary_null_comparison

import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorText;
  final String errorImage;
  final VoidCallback? onRetry;
  const CustomErrorWidget(
      {Key? key,
      this.errorText = '',
      this.errorImage = AppImagesPath.noDataFound,
      this.onRetry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          Align(
              alignment: Alignment.center,
              child:
                  Image.asset(errorImage, fit: BoxFit.contain, width: 45.0.w)),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: 1.h),
              child: Text(
                errorText,
                style: AppTextStyle.semiBoldGrey16,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          if (onRetry != null)
            Align(
                alignment: Alignment.center,
                child: IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: onRetry,
                )),
        ],
      ),
    );
  }
}
