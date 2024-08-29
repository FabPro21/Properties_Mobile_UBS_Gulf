import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppErrorWidget extends StatelessWidget {
  final String errorText;
  final String errorImage;
  final Function? onRetry;
  final String? color;
  const AppErrorWidget(
      {Key? key,
      this.errorText = '',
      this.errorImage = AppImagesPath.noDataFound,
      this.onRetry,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(errorImage, fit: BoxFit.contain, width: 25.0.w),
          SizedBox(
            height: 3.0.h,
          ),
          Text(
            errorText,
            style: AppTextStyle.semiBoldGrey10,
          ),
          SizedBox(
            height: 1.h,
          ),
          if (onRetry != null)
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: color == '' ? null : AppColors.greyColor,
              ),
              onPressed: () {
                onRetry!();
              },
            )
        ],
      ),
    );
  }
}
