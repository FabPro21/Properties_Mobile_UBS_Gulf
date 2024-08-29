import 'package:flutter/material.dart';
class ScreenDisableWidget extends StatelessWidget {
  const ScreenDisableWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.009),
            borderRadius: BorderRadius.circular(20)),
      );
  }
}