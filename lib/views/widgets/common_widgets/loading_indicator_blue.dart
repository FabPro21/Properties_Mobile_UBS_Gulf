import 'package:fap_properties/utils/styles/colors.dart';
import 'package:flutter/material.dart';

class LoadingIndicatorBlue extends StatelessWidget {
  final double strokeWidth;
  final double size;

  const LoadingIndicatorBlue({super.key, this.strokeWidth = 4, this.size = 40});
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

  const LoadingIndicatorRed({super.key, this.strokeWidth = 4, this.size = 40});
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
