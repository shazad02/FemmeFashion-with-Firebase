import 'package:flutter/material.dart';
import 'package:kelompok5_a2/helper/theme.dart';

class OpsiDetail extends StatelessWidget {
  final String text;
  final Function onPressed;
  const OpsiDetail({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed as void Function(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: primaryTextStyle2,
            ),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
