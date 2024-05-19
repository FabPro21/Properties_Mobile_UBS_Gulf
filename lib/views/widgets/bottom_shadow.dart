import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BottomShadow extends StatelessWidget {
  const BottomShadow({
    Key key,
  }) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 0,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 0.5.h,
          spreadRadius: 0.8.h,
          offset: Offset(0.1.h, 0.1.h),
        ),
        BoxShadow(),
        BoxShadow(),
        BoxShadow()
      ]),
    );
  }
}
