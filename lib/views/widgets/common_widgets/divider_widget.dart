import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Color.fromRGBO(99, 116, 135, 0.2),
      thickness: 0.2.h,
      height: 1.0.h,
    );
  }
}
