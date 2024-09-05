// ignore_for_file: unnecessary_null_comparison

import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class StatusWidget extends StatelessWidget {
  final String? text;
  final String? valueToCompare;
  const StatusWidget(
      {Key? key, @required this.text, @required this.valueToCompare})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (valueToCompare! != null) {
      valueToCompare!.trim();
    }
    return Container(
      decoration: BoxDecoration(
        color: valueToCompare!.contains('Posted') ||
                valueToCompare!.contains('Active')
            // valueToCompare!.contains('Posted') ||
            //         valueToCompare!.contains('Active') ||
            //         valueToCompare!.contains("Closed")
            ? AppColors.greenColor.withOpacity(0.35)
            : valueToCompare!.contains("Cancelled") ||
                    valueToCompare!.contains("Rejected")
                ? Colors.red.withOpacity(0.35)
                : valueToCompare!.contains('Ended') ||
                        valueToCompare!.contains('Terminated') ||
                        valueToCompare!.contains('Closed')
                    ? Colors.grey.withOpacity(0.35)
                    : valueToCompare!.contains('Draft') ||
                            valueToCompare!.contains('Received')
                        ? AppColors.amber.withOpacity(0.35)
                        : AppColors.amber.withOpacity(0.35),
        // color: valueToCompare!.contains('Posted') ||
        //         valueToCompare!.contains('Active') ||
        //         valueToCompare!.contains("Closed")
        //     ? AppColors.greenColor2
        //     : valueToCompare!.contains("Cancelled") ||
        //             valueToCompare!.contains("Rejected")
        //         ? Colors.red[100]
        //         : valueToCompare!.contains('Ended') ||
        //                 valueToCompare!.contains('Terminated')
        //             ? AppColors.greyBG
        //             : valueToCompare!.contains('Draft') ||
        //                     valueToCompare!.contains('Received')
        //                 ? AppColors.blueColor2
        //                 : AppColors.amber2,
        borderRadius: BorderRadius.circular(0.5.h),
      ),
      child: Padding(
        // padding: EdgeInsets.fromLTRB(2.0.h, 0.8.h, 2.0.h, 0.8.h),
        padding: EdgeInsets.fromLTRB(
          valueToCompare!.contains('Under Approval') ? 1.h : 2.0.h,
          valueToCompare!.contains('Under Approval') ? 1.4.h : 0.8.h,
          valueToCompare!.contains('Under Approval') ? 1.h : 2.0.h,
          valueToCompare!.contains('Under Approval') ? 1.4.h : 0.8.h,
        ),
        child: Text(
          text!,
          style: AppTextStyle.statusStyle(valueToCompare!.contains('Active') ||
                      valueToCompare!.contains('Posted') ||
                      valueToCompare!.contains("Closed")
                  ? AppColors.blackColor
                  : valueToCompare!.contains("Cancelled") ||
                          valueToCompare!.contains("Rejected")
                      ? AppColors.blackColor
                      : valueToCompare!.contains('Ended') ||
                              valueToCompare!.contains('Terminated')
                          ? AppColors.blackColor
                          : valueToCompare!.contains('Draft') ||
                                  valueToCompare!.contains('Received')
                              ? AppColors.blackColor
                              : AppColors.blackColor)
              .copyWith(
            fontWeight: valueToCompare!.contains('Under Approval')
                ? SessionController().getLanguage() == 1
                    ? FontWeight.bold
                    : null
                : null,
            fontSize: valueToCompare!.contains('Under Approval')
                ? SessionController().getLanguage() == 1
                    ? 14.sp
                    : null
                : null,
          ),
          // style: AppTextStyle.statusStyle(valueToCompare!.contains('Active') ||
          //         valueToCompare!.contains('Posted') ||
          //         valueToCompare!.contains("Closed")
          //     ? AppColors.greenColor
          //     : valueToCompare!.contains("Cancelled") ||
          //             valueToCompare!.contains("Rejected")
          //         ? Colors.red[700]
          //         : valueToCompare!.contains('Ended') ||
          //                 valueToCompare!.contains('Terminated')
          //             ? AppColors.greyColor
          //             : valueToCompare!.contains('Draft') ||
          //                     valueToCompare!.contains('Received')
          //                 ? AppColors.blueColor
          //                 : AppColors.amber),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }
}

class StatusWidgetVendor extends StatelessWidget {
  final String? text;
  final String? valueToCompare;
  const StatusWidgetVendor(
      {Key? key, @required this.text, @required this.valueToCompare})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    valueToCompare!.trim();
    return Container(
      decoration: BoxDecoration(
        color: valueToCompare!.contains('Posted') ||
                valueToCompare!.contains('Active')
            // valueToCompare!.contains('Posted') ||
            //         valueToCompare!.contains('Active') ||
            //         valueToCompare!.contains("Closed")
            ? AppColors.greenColor.withOpacity(0.35)
            : valueToCompare!.contains("Cancelled") ||
                    valueToCompare!.contains("Rejected")
                ? Colors.red.withOpacity(0.35)
                : valueToCompare!.contains('Ended') ||
                        valueToCompare!.contains('Terminated') ||
                        valueToCompare!.contains('Closed')
                    ? Colors.grey.withOpacity(0.35)
                    : valueToCompare!.contains('Draft') ||
                            valueToCompare!.contains('Received')
                        ? AppColors.amber.withOpacity(0.35)
                        : AppColors.amber.withOpacity(0.35),
        // color: valueToCompare!.contains('Posted') ||
        //         valueToCompare!.contains('Active') ||
        //         valueToCompare!.contains("Closed")
        //     ? AppColors.greenColor2
        //     : valueToCompare!.contains("Cancelled") ||
        //             valueToCompare!.contains("Rejected")
        //         ? Colors.red[100]
        //         : valueToCompare!.contains('Ended') ||
        //                 valueToCompare!.contains('Terminated')
        //             ? AppColors.greyBG
        //             : valueToCompare!.contains('Draft') ||
        //                     valueToCompare!.contains('Received')
        //                 ? AppColors.blueColor2
        //                 : AppColors.amber2,
        borderRadius: BorderRadius.circular(0.5.h),
      ),
      child: Padding(
        // padding: EdgeInsets.fromLTRB(2.0.h, 0.8.h, 2.0.h, 0.8.h),
        padding: EdgeInsets.fromLTRB(
          valueToCompare!.contains('Under Approval') ? 1.h : 2.0.h,
          valueToCompare!.contains('Under Approval') ? 1.4.h : 0.8.h,
          valueToCompare!.contains('Under Approval') ? 1.h : 2.0.h,
          valueToCompare!.contains('Under Approval') ? 1.4.h : 0.8.h,
        ),
        child: Text(
          text!,
          style: AppTextStyle.statusStyle(valueToCompare!.contains('Active') ||
                      valueToCompare!.contains('Posted') ||
                      valueToCompare!.contains("Closed")
                  ? AppColors.blackColor
                  : valueToCompare!.contains("Cancelled") ||
                          valueToCompare!.contains("Rejected")
                      ? AppColors.blackColor
                      : valueToCompare!.contains('Ended') ||
                              valueToCompare!.contains('Terminated')
                          ? AppColors.blackColor
                          : valueToCompare!.contains('Draft') ||
                                  valueToCompare!.contains('Received')
                              ? AppColors.blackColor
                              : AppColors.blackColor)
              .copyWith(
            fontWeight: valueToCompare!.contains('Under Approval')
                ? FontWeight.bold
                : null,
            fontSize: valueToCompare!.contains('Under Approval') ? 10.sp : null,
          ),
          // style: AppTextStyle.statusStyle(valueToCompare!.contains('Active') ||
          //         valueToCompare!.contains('Posted') ||
          //         valueToCompare!.contains("Closed")
          //     ? AppColors.greenColor
          //     : valueToCompare!.contains("Cancelled") ||
          //             valueToCompare!.contains("Rejected")
          //         ? Colors.red[700]
          //         : valueToCompare!.contains('Ended') ||
          //                 valueToCompare!.contains('Terminated')
          //             ? AppColors.greyColor
          //             : valueToCompare!.contains('Draft') ||
          //                     valueToCompare!.contains('Received')
          //                 ? AppColors.blueColor
          //                 : AppColors.amber),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }
}
