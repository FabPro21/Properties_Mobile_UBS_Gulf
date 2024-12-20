import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class InfoItem2 extends StatelessWidget {
  final String? label;
  final String? text;
  const InfoItem2({
    Key? key, this.label, this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label??'',style: AppTextStyle.normalBlack10,),
          Text(text??'',style: AppTextStyle.semiBoldBlack10,)
        ],
      ),
    );
  }
}