import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:flutter/material.dart';

class CustomText1 extends StatelessWidget {
  final String? text;
  const CustomText1({
    super.key,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: AppTextStyle.semiBoldBlack11,
    );
  }
}

class CustomeTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String Function(String)? validator;
  final int? maxLines;

  const CustomeTextField(
      {super.key, this.controller, this.label, this.validator, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        return validator!(value??"");
      },
      controller: controller,
      maxLines: maxLines,
      style: AppTextStyle.normalBlack14,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyle.normalBlack14,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderGrey, width: 1.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderGrey, width: 1.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.bgBlue1, width: 1.0),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorColor, width: 1.0),
        ),
      ),
    );
  }
}
