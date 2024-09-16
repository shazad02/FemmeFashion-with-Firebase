// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../helper/theme.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    // Remove super.key since it's not a valid parameter
    required this.hintText,
    this.onChanged,
    this.controller,
  });

  final String hintText;

  final void Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(
            50,
          ),
        ),
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: primaryTextStyle2.copyWith(color: bg3Color),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: bg3Color,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password is required';
          } else if (value.length < 8) {
            return 'Password Terlalu Pendek';
          }
          return null;
        },
        onChanged: widget.onChanged, // Update to widget.onChanged
      ),
    );
  }
}
