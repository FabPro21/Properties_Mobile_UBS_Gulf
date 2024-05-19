import 'package:flutter/services.dart';

class TextInputFormatter {
  dynamic searchPropertyNameContractNoIF = [
    FilteringTextInputFormatter.allow(RegExp(r"^[a-zA-Z0-9]*$"))
  ];
}
