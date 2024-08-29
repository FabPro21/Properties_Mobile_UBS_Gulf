import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class InfoItem3 extends StatelessWidget {
  final String? label;
  final String? text;
  const InfoItem3({
    Key? key, this.label, this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(1.w),
          child: Text(label??'',style: AppTextStyle.normalBlack10,),
        ),
        Padding(
          padding: EdgeInsets.all(1.w),
          child: Text(text??'',style: AppTextStyle.semiBoldBlack10,),
        )
      ],
    );
  }
}