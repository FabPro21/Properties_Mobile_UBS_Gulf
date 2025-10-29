import 'package:flutter/material.dart';
class ScreenDisableWidget extends StatelessWidget {
  const ScreenDisableWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, 0.009),
            borderRadius: BorderRadius.circular(20)),
      );
  }
}