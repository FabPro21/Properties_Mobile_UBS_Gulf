
// ignore_for_file: library_private_types_in_public_api

import 'package:fap_properties/utils/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignaturePad extends StatefulWidget {
  final double? height;
  final SignatureController? controller;
  const SignaturePad({super.key, this.height, this.controller});

  @override
  _SignaturePadState createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Signature(
          controller: widget.controller!,
          height: widget.height,
          backgroundColor: AppColors.greyBG,
        ),
        Container(
          decoration: BoxDecoration(color: AppColors.greyBG),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              //SHOW EXPORTED IMAGE IN NEW ROUTE

              // IconButton(
              //   icon: const Icon(Icons.undo),
              //   color: AppColors.blueColor,
              //   onPressed: () {
              //     // setState(() => widget.controller!.undo());
              //     widget.controller!.clear();
              //   },
              // ),
              // IconButton(
              //   icon: const Icon(Icons.redo),
              //   color: AppColors.blueColor,
              //   onPressed: () {
              //     // setState(() => widget.controller!.redo());
              //   },
              // ),
              //CLEAR CANVAS
              IconButton(
                icon: const Icon(Icons.clear),
                color: AppColors.blueColor,
                onPressed: () {
                  setState(() => widget.controller!.clear());
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
