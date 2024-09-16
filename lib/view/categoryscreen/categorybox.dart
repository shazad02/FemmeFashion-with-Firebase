import 'package:flutter/material.dart';
import 'package:kelompok5_a2/helper/theme.dart';

class CatrgoryBox extends StatelessWidget {
  final String image;
  final String text;
  const CatrgoryBox({
    super.key,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 20 / 100,
          width: MediaQuery.of(context).size.width * 30 / 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: bg3Color,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              image,
              width: 1000,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          text,
          style: primaryTextStyle3.copyWith(fontSize: 15),
        )
      ],
    );
  }
}
