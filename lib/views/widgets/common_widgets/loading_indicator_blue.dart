import 'package:fap_properties/utils/styles/colors.dart';
import 'package:flutter/material.dart';

class LoadingIndicatorBlue extends StatelessWidget {
  final double strokeWidth;
  final double size;

  const LoadingIndicatorBlue({Key? key, this.strokeWidth = 4, this.size = 40})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          color: AppColors.blueColor,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}
class LoadingIndicatorRed extends StatelessWidget {
  final double strokeWidth;
  final double size;

  const LoadingIndicatorRed({Key? key, this.strokeWidth = 4, this.size = 40})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          color: AppColors.redColor,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}
