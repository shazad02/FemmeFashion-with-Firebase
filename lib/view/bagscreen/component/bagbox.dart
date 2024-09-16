import 'package:flutter/material.dart';
import 'package:kelompok5_a2/helper/theme.dart';

class BagBox extends StatelessWidget {
  final String image;
  final String text;
  final String harga;
  final String warna;
  final String ukuran;

  const BagBox({
    super.key,
    required this.image,
    required this.text,
    required this.harga,
    required this.warna,
    required this.ukuran,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: bg2Color, borderRadius: BorderRadius.circular(15)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 16 / 100,
                width: MediaQuery.of(context).size.width * 32 / 100,
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 1 / 100,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 12 / 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  text,
                                  style:
                                      primaryTextStyle3.copyWith(fontSize: 20),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      1 /
                                      100,
                                ),
                                const Icon(Icons.delete)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Color: ",
                                      style: primaryTextStyle2.copyWith(
                                          fontSize: 15),
                                    ),
                                    Text(
                                      warna,
                                      style: primaryTextStyle2.copyWith(
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      3 /
                                      100,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Size: ",
                                      style: primaryTextStyle3.copyWith(
                                          fontSize: 15),
                                    ),
                                    Text(
                                      ukuran,
                                      style: primaryTextStyle3.copyWith(
                                          fontSize: 15),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: const Offset(0,
                                              2), // changes position of shadow
                                        )
                                      ],
                                    ),
                                    child: const CircleAvatar(
                                      backgroundColor: bg1Color,
                                      radius: 15,
                                      child: Icon(Icons.remove),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Text(
                                    "1",
                                    style: primaryTextStyle2.copyWith(
                                        fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: const Offset(0,
                                              2), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: const CircleAvatar(
                                      backgroundColor: bg1Color,
                                      radius: 15,
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              harga,
                              style: primaryTextStyle2.copyWith(fontSize: 17),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 2 / 100,
        ),
      ],
    );
  }
}
