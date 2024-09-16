import 'package:flutter/material.dart';
import 'package:kelompok5_a2/helper/theme.dart';

class DeleviryBox extends StatelessWidget {
  final String image;
  final String text;
  final bool selected; // Add this parameter

  const DeleviryBox({
    super.key,
    required this.image,
    required this.text,
    required this.selected, // Add this parameter
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 12 / 100,
        width: MediaQuery.of(context).size.width * 35 / 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: bg2Color,
          border: Border.all(
            color: selected
                ? Colors.red
                : Colors.transparent, // Change border color based on selection
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(
              text,
              style: primaryTextStyle2.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
