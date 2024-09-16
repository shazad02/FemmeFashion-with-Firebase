import 'package:flutter/material.dart';

import '../helper/theme.dart';

// ignore: must_be_immutable
class ProfileTextFil extends StatelessWidget {
  ProfileTextFil({
    this.readOnly,
    this.labelText,
    this.obscureText,
    this.validate,
    this.keyboardType,
    required this.hintttext,
    super.key,
    this.onChanged,
    this.controller,
  });

  String? labelText;
  String hintttext;
  bool? readOnly;
  bool? obscureText;
  TextInputType? keyboardType;
  FormFieldValidator<String>? validate;
  void Function(String)? onChanged;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 8 / 100,
      margin: const EdgeInsets.only(),
      decoration: BoxDecoration(
        color: bg2Color,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        readOnly: readOnly ?? false,
        keyboardType: keyboardType ?? TextInputType.text,
        validator: validate,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          hintText: hintttext,
          hintStyle: primaryTextStyle2.copyWith(color: Colors.grey),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        ),
        onChanged: onChanged,
        controller: controller,
      ),
    );
  }
}
