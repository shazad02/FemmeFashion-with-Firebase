// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:kelompok5_a2/provider/product_provider.dart';
import 'package:kelompok5_a2/helper/theme.dart';
import 'package:provider/provider.dart';

class CekOutCardd extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double price;
  int index;
  int count;
  final String category;
  final double totalPrice;
  final String selectedSize;

  CekOutCardd({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.count,
    required this.index,
    required this.category,
    required this.totalPrice,
    required this.selectedSize,
  });

  @override
  State<CekOutCardd> createState() => _CekOutCarddState();
}

class _CekOutCarddState extends State<CekOutCardd> {
  late ProductProvider productProvider;
  @override
  void initState() {
    super.initState();
    productProvider = Provider.of<ProductProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 27 / 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: bg3Color,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: primaryTextStyle3.copyWith(
                                        fontSize: 19,
                                        color: bg6color,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Kategori: ${widget.category}",
                                        style: primaryTextStyle2.copyWith(
                                            fontSize: 15, color: bg5color),
                                      ),
                                    ],
                                  ),

                                  // IconButton(
                                  //   onPressed: () {
                                  //     productProvider
                                  //         .deleteCartProduk(widget.index);
                                  //   },
                                  //   icon: const Icon(
                                  //     Icons.delete,
                                  //     size: 26,
                                  //     color: Colors.red,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            "Ukuran: ${widget.selectedSize}",
                            style: primaryTextStyle2.copyWith(
                                fontSize: 15, color: bg5color),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Jumlah ",
                                    style: primaryTextStyle3.copyWith(
                                        fontSize: 20, color: bg6color),
                                  ),
                                  Text(
                                    widget.count.toString(),
                                    style: primaryTextStyle3.copyWith(
                                        fontSize: 20, color: bg6color),
                                  ),
                                  Text(
                                    "X",
                                    style: primaryTextStyle3.copyWith(
                                        fontSize: 20, color: bg5color),
                                  ),
                                ],
                              ),
                              Text(
                                "Rp ${widget.price.toInt().toString()}",
                                style: primaryTextStyle3.copyWith(
                                    fontSize: 17, color: bg6color),
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
        ],
      ),
    );
  }
}
