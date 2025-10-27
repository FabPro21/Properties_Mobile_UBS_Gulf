import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ClearButton extends StatelessWidget {
  final Function clear;
  const ClearButton({super.key, required this.clear});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        clear();
      },
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromRGBO(118, 118, 128, 0.12),
        ),
        child: Padding(
          padding: EdgeInsets.all(0.5.h),
          child: Icon(Icons.close,
              size: 2.0.h, color: const Color.fromRGBO(158, 158, 158, 1)),
        ),
      ),
    );
  }
}
