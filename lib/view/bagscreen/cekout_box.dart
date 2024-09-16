// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:kelompok5_a2/provider/product_provider.dart';
import 'package:kelompok5_a2/helper/theme.dart';
import 'package:provider/provider.dart';

class ChekOutBox extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double price;
  int index;
  int count;
  final String category;
  final String selectedSize;

  ChekOutBox({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.count,
    required this.index,
    required this.category,
    required this.selectedSize,
  });

  @override
  State<ChekOutBox> createState() => _ChekOutBoxState();
}

class _ChekOutBoxState extends State<ChekOutBox> {
  late ProductProvider productProvider;

  @override
  void initState() {
    super.initState();
    productProvider = Provider.of<ProductProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
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
                  child: Image.network(
                    widget.imageUrl,
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
                    height: MediaQuery.of(context).size.height * 16 / 100,
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
                                  widget.title,
                                  style: primaryTextStyle3.copyWith(
                                      fontSize: 20, color: bg6color),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      1 /
                                      100,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Kategori: ",
                                      style: primaryTextStyle2.copyWith(
                                          fontSize: 15, color: bg5color),
                                    ),
                                    Text(
                                      widget.category,
                                      style: primaryTextStyle3.copyWith(
                                          fontSize: 15, color: bg6color),
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
                                      "Ukuran: ",
                                      style: primaryTextStyle2.copyWith(
                                          fontSize: 15, color: bg5color),
                                    ),
                                    Text(
                                      widget.selectedSize,
                                      style: primaryTextStyle3.copyWith(
                                          fontSize: 15, color: bg6color),
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
                                  child: Text(
                                    "Barang ${widget.count.toString()}",
                                    style: primaryTextStyle2.copyWith(
                                        fontSize: 20, color: bg5color),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Rp ${widget.price.toInt().toString()}",
                              style: primaryTextStyle3.copyWith(
                                  fontSize: 17, color: bg6color),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                productProvider.deleteCartProduk(widget.index);
                              },
                              icon: const Icon(
                                Icons.delete,
                                size: 26,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
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
