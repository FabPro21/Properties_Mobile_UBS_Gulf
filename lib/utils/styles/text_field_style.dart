import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:flutter/material.dart';

final textFieldDecoration = InputDecoration(
    filled: true,
    fillColor: Color.fromRGBO(246, 248, 249, 1),
    errorStyle: AppTextStyle.normalErrorText2,
    border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(8)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(8)),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(8)),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(8)),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(8)),
    disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(8)));
