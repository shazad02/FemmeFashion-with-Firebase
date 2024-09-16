import 'package:flutter/material.dart';

import '../helper/theme.dart';

// ignore: must_be_immutable
class CustomTextFil extends StatelessWidget {
  CustomTextFil({
    this.readOnly,
    this.labelText,
    this.obscureText,
    this.validate,
    this.keyboardType,
    super.key,
    this.onChanged,
    this.controller,
  });

  String? labelText;
  bool? readOnly;
  bool? obscureText;
  TextInputType? keyboardType;
  FormFieldValidator<String>? validate;
  void Function(String)? onChanged;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(),
      decoration: const BoxDecoration(
          color: bg2Color, borderRadius: BorderRadius.all(Radius.circular(50))),
      child: TextFormField(
        readOnly: readOnly ?? false,
        keyboardType: keyboardType ?? TextInputType.text,
        validator: validate,
        obscureText: obscureText ?? false,
        decoration: const InputDecoration(
          hintStyle: TextStyle(color: bg2Color),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
        onChanged: onChanged,
        controller: controller,
      ),
    );
  }
}
