// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:kelompok5_a2/helper/theme.dart';
import 'package:kelompok5_a2/view/detailscreen/detail_screen_fix.dart';

// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  final String image;
  final String text;
  final double price;
  late final String category;
  String? description;
  final VoidCallback? onAdd;

  ProductCard({
    super.key,
    required this.image,
    required this.text,
    required this.price,
    required this.category,
    this.onAdd,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => DetailScreennn(
              category: category,
              description: description ?? '',
              image: image,
              name: text,
              price: price,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              color: bg2Color,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 22 / 100,
                    width: MediaQuery.of(context).size.width * 40 / 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: bg3Color,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: image != null
                          ? Image.network(
                              image,
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height *
                                  22 /
                                  100, // Height adjusted
                              width: MediaQuery.of(context).size.width *
                                  40 /
                                  100, // Width adjusted
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width *
                                  40 /
                                  100, // Width adjusted
                              height: MediaQuery.of(context).size.height *
                                  22 /
                                  100, // Height adjusted
                              color: Colors.grey[300],
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Rp ',
                        style: primaryTextStyle2.copyWith(
                          fontSize: 15,
                          color: bg5color,
                        ),
                      ),
                      Text(
                        price.toInt().toString(),
                        style: primaryTextStyle2.copyWith(
                          fontSize: 15,
                          color: bg5color,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    text,
                    style: primaryTextStyle3.copyWith(
                      fontSize: 15,
                      color: bg6color,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
