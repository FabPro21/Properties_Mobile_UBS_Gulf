import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
import 'package:flutter/material.dart';

class UnderDevelopment extends StatefulWidget {
  final String? title;
  UnderDevelopment({Key? key, @required this.title}) : super(key: key);

  @override
  State<UnderDevelopment> createState() => _UnderDevelopmentState();
}

class _UnderDevelopmentState extends State<UnderDevelopment> {
  String? label;
  double? value;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomAppBar2(
              title: widget.title??"",
            ),
            Spacer(),
            AppErrorWidget(
              errorText: 'Coming Soon',
            ),
            Spacer()
          ],
        ));
  }
}
