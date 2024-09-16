import 'package:flutter/material.dart';
import 'package:kelompok5_a2/provider/product_provider.dart';
import 'package:kelompok5_a2/helper/theme.dart';
import 'package:kelompok5_a2/view/alamat/select_alamat.dart';
import 'package:kelompok5_a2/view/bagscreen/cekout_box.dart';
import 'package:kelompok5_a2/widget/button_custom.dart';
import 'package:kelompok5_a2/widget/textfiled_icon.dart';
import 'package:provider/provider.dart';

class Bag extends StatefulWidget {
  const Bag({super.key});

  @override
  State<Bag> createState() => _BagState();
}

class _BagState extends State<Bag> {
  late ProductProvider productProvider;
  bool isEmpty = false;
  double totalPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    for (var cardModel in productProvider.getCardModelList) {
      totalPrice += cardModel.price * cardModel.quenty;
    }

    if (productProvider.getCardModelListLength == 0) {
      isEmpty = true;
    } else {
      isEmpty = false;
    }

    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        title: Text(
          "Tas Belanja",
          style: primaryTextStyle3.copyWith(color: Colors.white),
        ),
        backgroundColor: bg5color,
        centerTitle: true,
      ),
      body: isEmpty
          ? Center(
              child: Text(
                "Tidak ada item di sini, belanja sekarang",
                style:
                    primaryTextStyle2.copyWith(fontSize: 18, color: bg6color),
              ),
            )
          : Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: productProvider.getCardModelListLength,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(10),
                      child: ChekOutBox(
                        index: index,
                        imageUrl: productProvider.getCardModelList[index].image,
                        title: productProvider.getCardModelList[index].name,
                        price: productProvider.getCardModelList[index].price,
                        count: productProvider.getCardModelList[index].quenty,
                        category:
                            productProvider.getCardModelList[index].category,
                        selectedSize:
                            productProvider.getCardModelList[index].size,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      // TextFiledIcon(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 4 / 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Pembayaran:",
                            style: primaryTextStyle2.copyWith(
                                fontSize: 18, color: Colors.grey),
                          ),
                          Text(
                            "Rp ${totalPrice.toInt()}",
                            style: primaryTextStyle3.copyWith(
                                fontSize: 18, color: bg6color),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 4 / 100,
                      ),
                      ButtonCus(
                          textButton: "Pesan",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (c) => const SelectAlamat(),
                              ),
                            );
                          },
                          buttomcolor: bg6color,
                          textcolor: bg2Color),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 4 / 100,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
