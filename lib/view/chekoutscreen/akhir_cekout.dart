// ignore_for_file: avoid_print, unused_local_variable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kelompok5_a2/helper/images.dart';
// ignore: unused_import
import 'package:kelompok5_a2/navigator/navigator_screen.dart';
import 'package:kelompok5_a2/provider/product_provider.dart';
import 'package:kelompok5_a2/view/alamat/cekoutcard.dart';
import 'package:kelompok5_a2/view/alamat/select_alamat.dart';
import 'package:kelompok5_a2/view/bukti/pilihpembayaran.dart';
import 'package:kelompok5_a2/view/chekoutscreen/deleveribox.dart';
import 'package:kelompok5_a2/widget/button_custom.dart';
import 'package:provider/provider.dart';

import '../../helper/theme.dart';

class HasilCekout extends StatefulWidget {
  final Map<String, dynamic> addressData;

  const HasilCekout({required this.addressData, super.key});

  @override
  State<HasilCekout> createState() => _HasilCekoutState();
}

class _HasilCekoutState extends State<HasilCekout> {
  late ProductProvider productProvider;
  String userAddress = '';
  String userName = '';
  String lengkapUser = '';
  String address = '';
  String status = 'Belum Bayar';
  double ongkirPrice = 0.0;
  int index = 0;
  double totalPrice = 0.0;
  String selectedDeliveryMethod = 'jne';
  int uniqueCode = 0;

  @override
  void initState() {
    super.initState();
    getUserAddress();
    _generateUniqueCode();
  }

  void _generateUniqueCode() {
    final random = Random();
    // Menghasilkan angka acak antara 10 dan 999 (termasuk 2 dan 3 digit)
    uniqueCode = random.nextInt(990) + 10;
  }

  void getUserAddress() async {
    userAddress = widget.addressData['ongkir'];
    address = widget.addressData['address'];
    setState(() {
      userName = widget.addressData['name'];
    });
    getOngkirPrice();
  }

  void getOngkirPrice() async {
    QuerySnapshot ongkirSnapshot = await FirebaseFirestore.instance
        .collection('ongkir')
        .where('name', isEqualTo: userAddress)
        .get();

    if (ongkirSnapshot.size > 0) {
      setState(() {
        ongkirPrice = double.parse(ongkirSnapshot.docs[0]['jarak']);
      });
    }
  }

  Widget _buildBottomSingleDetail(
      {required String startName, required String endName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          startName,
          style: primaryTextStyle2.copyWith(
            fontSize: 18,
            color: bg5color,
          ),
        ),
        Text(
          endName,
          style: primaryTextStyle3.copyWith(
            fontSize: 18,
            color: bg6color,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSingle(
      {required String startName, required String endName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          startName,
          style: primaryTextStyle3.copyWith(
            fontSize: 18,
            color: bg5color,
          ),
        ),
        Text(
          endName,
          style: primaryTextStyle3.copyWith(
            fontSize: 18,
            color: bg6color,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    double totalPrice = 0.0;
    double totalProductQuent = 0.0;
    for (var cardModel in productProvider.getCardModelList) {
      totalPrice += cardModel.price * cardModel.quenty;
    }
    for (var cardModel in productProvider.getCardModelList) {
      totalProductQuent += cardModel.quenty;
    }

    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.grey.withOpacity(0.5),
        centerTitle: true,
        title: Text(
          "Pesan Sekarang",
          style: primaryTextStyle3.copyWith(color: Colors.white),
        ),
        backgroundColor: bg5color,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 24.0,
            color: Colors.black87,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 15, top: 8),
              child: Text(
                "Alamat Tujuan",
                style:
                    primaryTextStyle3.copyWith(fontSize: 23, color: bg6color),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: bg1Color,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.addressData['name']}',
                            style: primaryTextStyle3.copyWith(
                                fontSize: 17, color: bg6color),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (c) => const SelectAlamat(),
                                ),
                              );
                            },
                            child: Text(
                              'Ganti',
                              style: primaryTextStyle3.copyWith(
                                  fontSize: 17,
                                  color: bg6color,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${widget.addressData['address']}',
                        style: primaryTextStyle2.copyWith(
                            fontSize: 15, color: bg5color),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Nomer Hp: ${widget.addressData['phone']}',
                        style: primaryTextStyle2.copyWith(
                            fontSize: 15, color: bg5color),
                      ),
                      Text(
                        'Kabupaten: ${widget.addressData['ongkir']}',
                        style: primaryTextStyle2.copyWith(
                            fontSize: 15, color: bg5color),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: ListView.builder(
                itemCount: productProvider.getCardModelListLength,
                itemBuilder: (context, myIndex) {
                  index = myIndex;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CekOutCardd(
                      imageUrl: productProvider.getCardModelList[myIndex].image,
                      title: productProvider.getCardModelList[myIndex].name,
                      price: productProvider.getCardModelList[myIndex].price,
                      count: productProvider.getCardModelList[myIndex].quenty,
                      totalPrice: totalPrice,
                      index: myIndex,
                      category:
                          productProvider.getCardModelList[index].category,
                      selectedSize:
                          productProvider.getCardModelList[myIndex].size,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 4 / 100,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: bg1Color,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Pesanan",
                          style: primaryTextStyle3.copyWith(
                              fontSize: 18, color: bg6color),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        _buildBottomSingleDetail(
                          startName: "Total Barang:",
                          endName:
                              "${totalProductQuent.toStringAsFixed(0)} Items",
                        ),
                        _buildBottomSingleDetail(
                          startName: "Biaya Pengiriman:",
                          endName: productProvider.getCardModelListLength > 0
                              ? "Rp ${ongkirPrice.toInt() * 100}"
                              : "Rp 0",
                        ),
                        _buildBottomSingleDetail(
                          startName: "Pesanan:",
                          endName: "Rp ${totalPrice.toInt()}",
                        ),
                        _buildBottomSingleDetail(
                          startName: "Kode Unik",
                          endName: "$uniqueCode",
                        ),
                        _buildBottomSingle(
                          startName: "Total Keseluruhan:",
                          endName: productProvider.getCardModelListLength > 0
                              ? "Rp ${totalPrice.toInt() + ongkirPrice.toInt() * 100 + uniqueCode}"
                              : "Rp 0",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 5 / 100,
                  ),
                  ButtonCus(
                      textButton: "Buat Pesanan",
                      onPressed: () async {
                        if (productProvider.cartModelList.isNotEmpty) {
                          print("Button clicked");
                          User? user = FirebaseAuth.instance.currentUser;
                          String? userId = user?.uid;
                          String? userEmail = user?.email;
                          double totalProductPrice = 0.0;
                          for (var cardModel
                              in productProvider.getCardModelList) {
                            totalProductPrice +=
                                cardModel.price * cardModel.quenty;
                          }
                          String kodeOrder = FirebaseFirestore.instance
                              .collection("order")
                              .doc()
                              .id;

                          FirebaseFirestore.instance.collection("order").add({
                            "produk": productProvider.cartModelList
                                .map((c) => {
                                      "produkName": c.name,
                                      "produkPrice": c.price,
                                      "produkSize": c.size,
                                      "produkQuantity": c.quenty,
                                    })
                                .toList(),
                            "kodeOrder": kodeOrder,
                            "totalPrice": totalPrice.toInt() +
                                ongkirPrice.toInt() * 100 +
                                uniqueCode,
                            "userName": userName,
                            "userEmail": userEmail,
                            "userAlamat": userAddress,
                            "lengkapUser": widget.addressData,
                            "UserUid": userId,
                            "status": status,
                            "ongkir": ongkirPrice.toInt() * 100,
                            'time': FieldValue.serverTimestamp(),
                            "address": address,
                            "pengiriman": selectedDeliveryMethod,
                          });

                          productProvider.clearCartProduk();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => PayScreen(
                                kodeOrder: kodeOrder,
                                userId: userId!,
                                username: userName,
                                address: address,
                                lengkapUser: lengkapUser,
                                total: (totalPrice.toInt() +
                                        ongkirPrice.toInt() * 100 +
                                        uniqueCode)
                                    .toStringAsFixed(0),
                                jumlah: totalProductQuent.toInt().toString(),
                              ),
                            ),
                          );
                        } else {
                          // Handle case when cart is empty
                        }
                      },
                      buttomcolor: bg6color,
                      textcolor: bg1Color),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 4 / 100,
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
