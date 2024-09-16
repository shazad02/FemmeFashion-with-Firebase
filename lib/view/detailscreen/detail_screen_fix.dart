import 'package:flutter/material.dart';
import 'package:kelompok5_a2/provider/product_provider.dart';
import 'package:kelompok5_a2/helper/theme.dart';
import 'package:kelompok5_a2/view/bagscreen/bag.dart';

import 'package:kelompok5_a2/view/detailscreen/opsidetail.dart';
import 'package:kelompok5_a2/widget/button_custom.dart';

import 'package:provider/provider.dart';

class DetailScreennn extends StatefulWidget {
  final String image;
  final String name;
  final double price;
  final String category;
  final String description;

  const DetailScreennn({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.category,
    required this.description,
  });

  @override
  State<DetailScreennn> createState() => _DetailScreennnState();
}

class _DetailScreennnState extends State<DetailScreennn> {
  int count = 1;
  String selectedSize = 'L'; // Default size
  late ProductProvider productProvider;

  final List<String> sizes = ['L', 'M', 'XL', 'XXL'];

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        backgroundColor: bg5color,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 40 / 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                color: bg3Color,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.network(
                  widget.image,
                  width: 1000,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 6 / 100,
                  width: MediaQuery.of(context).size.height * 17 / 100,
                  decoration: BoxDecoration(
                    color: bg2Color,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: bg6color,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedSize,
                              icon: const Icon(Icons.arrow_drop_down, size: 25),
                              iconSize: 24,
                              elevation: 16,
                              style: primaryTextStyle2.copyWith(fontSize: 16),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedSize = newValue!;
                                });
                              },
                              items: sizes.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: primaryTextStyle3.copyWith(
                                        color: bg5color, fontSize: 20),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 6 / 100,
                  width: MediaQuery.of(context).size.height * 17 / 100,
                  decoration: BoxDecoration(
                    color: bg2Color,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: bg6color,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (count > 1) {
                              count--;
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: bg6color,
                        ),
                      ),
                      Text(
                        count.toString(),
                        style: primaryTextStyle3.copyWith(
                            fontSize: 15,
                            fontWeight: extrabold,
                            color: bg5color),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            count++;
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                          color: bg6color,
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey.withOpacity(0.5),
                //         spreadRadius: 2,
                //         blurRadius: 5,
                //         offset:
                //             const Offset(0, 3), // changes position of shadow
                //       ),
                //     ],
                //   ),
                //   child: const CircleAvatar(
                //     backgroundColor: bg2Color,
                //     child: Icon(
                //       Icons.favorite_border_outlined,
                //       color: Colors.grey,
                //     ),
                //   ),
                // )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        children: [
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 2 / 100,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.name,
                                    style: primaryTextStyle3.copyWith(
                                        fontSize: 22, color: bg6color),
                                  ),
                                  Text(
                                    widget.category,
                                    style: primaryTextStyle2.copyWith(
                                        fontSize: 18, color: bg5color),
                                  )
                                ],
                              ),
                              Text(
                                widget.price.toInt().toString(),
                                style: primaryTextStyle2.copyWith(
                                    fontSize: 22,
                                    color: bg6color,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 2 / 100,
                          ),
                          Text(
                            widget.description,
                            style: primaryTextStyle2.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Column(
                      children: [
                        OpsiDetail(
                          text: 'Detail Barang',
                          onPressed: () {},
                        ),
                        const Divider(),
                        OpsiDetail(
                          text: 'Alamat Penjual',
                          onPressed: () {},
                        ),
                        const Divider(),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: ButtonCus(
                          textButton: "Tambah Ke Tas",
                          onPressed: () {
                            productProvider.getCardData(
                              name: widget.name,
                              image: widget.image,
                              quenty: count,
                              price: widget.price,
                              category: widget.category,
                              size: selectedSize, // Add size to the data
                            );
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const Bag(),
                              ),
                            );
                          },
                          buttomcolor: bg6color,
                          textcolor: bg2Color),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
