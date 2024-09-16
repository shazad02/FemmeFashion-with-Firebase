// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:kelompok5_a2/helper/images.dart';
import 'package:kelompok5_a2/helper/theme.dart';
import 'package:kelompok5_a2/widget/product_box.dart';

class DeleveryScreen extends StatefulWidget {
  const DeleveryScreen({super.key});

  @override
  State<DeleveryScreen> createState() => _DeleveryScreenState();
}

class _DeleveryScreenState extends State<DeleveryScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: bg1Color,
      body: IsiDelevery(),
    );
  }
}

class IsiDelevery extends StatelessWidget {
  const IsiDelevery({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            BoxOrder(),
            BoxOrder(),
            BoxOrder(),
            BoxOrder(),
            BoxOrder(),
          ],
        ),
      ),
    );
  }
}

class BoxOrder extends StatelessWidget {
  const BoxOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 21 / 100,
        decoration: BoxDecoration(
          color: bg2Color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Order: ",
                        style: primaryTextStyle2.copyWith(fontSize: 17),
                      ),
                      Text(
                        "127841291231",
                        style: primaryTextStyle2.copyWith(fontSize: 17),
                      ),
                    ],
                  ),
                  Text(
                    "05-02-2024 ",
                    style: primaryTextStyle2.copyWith(
                        fontSize: 17, color: Colors.grey),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Traking Number: ",
                    style: primaryTextStyle2.copyWith(
                        fontSize: 17, color: Colors.grey),
                  ),
                  Text(
                    "JNE33234234",
                    style: primaryTextStyle2.copyWith(fontSize: 17),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Quantity: ",
                        style: primaryTextStyle2.copyWith(
                            fontSize: 15, color: Colors.grey),
                      ),
                      Text(
                        "3",
                        style: primaryTextStyle2.copyWith(fontSize: 15),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Total: ",
                        style: primaryTextStyle2.copyWith(
                            fontSize: 15, color: Colors.grey),
                      ),
                      Text(
                        "Rp.300.000",
                        style: primaryTextStyle2.copyWith(fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 29 / 100,
                      height: MediaQuery.of(context).size.height * 5 / 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Details",
                          style: primaryTextStyle2,
                        ),
                      ),
                    ),
                    Text(
                      "Delivered ",
                      style: primaryTextStyle2.copyWith(
                          fontSize: 17, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
