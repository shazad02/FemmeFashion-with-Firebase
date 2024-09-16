// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:kelompok5_a2/helper/icons.dart';
import 'package:kelompok5_a2/helper/theme.dart';

class ButtonLogo extends StatelessWidget {
  final Function onPressed;
  final String textButton;
  final Color buttomcolor;
  final Color textcolor;

  const ButtonLogo(
      {super.key,
      required this.textButton,
      required this.onPressed,
      required this.buttomcolor,
      required this.textcolor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 5.5 / 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60),
            ),
            backgroundColor: bg2Color,
            elevation: 0),
        onPressed: onPressed as void Function(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Iconss.google),
            Text(
              textButton,
              style: primaryTextStyle3.copyWith(
                fontSize: 18,
                color: textcolor,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
