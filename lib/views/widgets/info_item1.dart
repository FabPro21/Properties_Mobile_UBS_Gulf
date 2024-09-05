import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class InfoItem1 extends StatelessWidget {
  final String? title;
  final String? text;
  const InfoItem1({
    Key? key,@required this.title,@required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title!,style: AppTextStyle.normalBlack10,),
          Text(text!,style: AppTextStyle.normalBlack10,)
        ],
      ),
    );
  }
}