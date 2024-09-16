import 'package:flutter/material.dart';
import 'package:kelompok5_a2/helper/theme.dart';

// ignore: must_be_immutable
class TextFiledIcon extends StatelessWidget {
  TextFiledIcon({
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
        color: Colors.white, // Ubah sesuai kebutuhan
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(50),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(50)),
      ),
      child: TextFormField(
        readOnly: readOnly ?? false,
        keyboardType: keyboardType ?? TextInputType.text,
        validator: validate,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          hintText: "Masukan Kode Promo",
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          suffixIcon: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: bg6color,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ),
        onChanged: onChanged,
        controller: controller,
      ),
    );
  }
}
