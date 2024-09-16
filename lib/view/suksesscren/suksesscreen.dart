import 'package:flutter/material.dart';
import 'package:kelompok5_a2/helper/images.dart';
import 'package:kelompok5_a2/navigator/navigator_screen.dart';
import 'package:kelompok5_a2/helper/theme.dart';
import 'package:kelompok5_a2/widget/button_custom.dart';

class SuksesScreen extends StatefulWidget {
  const SuksesScreen({super.key});

  @override
  State<SuksesScreen> createState() => _SuksesScreenState();
}

class _SuksesScreenState extends State<SuksesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Images.bags),
            Text(
              "Success!",
              style: primaryTextStyle3.copyWith(fontSize: 25),
            ),
            Text(
              "Your order will be delivered soon.",
              style: primaryTextStyle2.copyWith(fontSize: 15),
            ),
            Text(
              "Thank you for choosing our app!!",
              style: primaryTextStyle2.copyWith(fontSize: 15),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ButtonCus(
            textButton: "CONTINUE SHOPING",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => const NavigatorScreen(),
                ),
              );
            },
            buttomcolor: Colors.red,
            textcolor: bg1Color),
      ),
    );
  }
}
