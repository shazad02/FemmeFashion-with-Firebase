// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kelompok5_a2/helper/theme.dart';
import 'package:kelompok5_a2/navigator/navigator_screen.dart';
import 'package:kelompok5_a2/provider/product_provider.dart';
import 'package:kelompok5_a2/widget/button_custom.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class StoreData {
  Future<void> updateDocument(
      String kodeOrder, String newStatus, String name) async {
    QuerySnapshot snapshot = await _firestore
        .collection('order')
        .where('kodeOrder', isEqualTo: kodeOrder)
        .get();

    if (snapshot.docs.isNotEmpty) {
      String documentId = snapshot.docs.first.id;
      await _firestore.collection('order').doc(documentId).update({
        'status': newStatus,
        'pembayaran': name,
      });
    }
  }

  Future<String> saveData({
    required String name,
    required String orderId,
    String bayar = 'Dalam Perjalanan',
    required String kodeOrder,
    required String userId,
  }) async {
    String resp = "error";
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('buktii').add({
          'name': name,
          'orderId': orderId,
          'userId': userId,
          'kodeOrder': kodeOrder,
          'userGmail': user.email,
          'status': bayar,
          'time': FieldValue.serverTimestamp(),
          'imageLink': 'default_image',
        });
        await updateDocument(kodeOrder, bayar, name);
        resp = 'Berhasil Membuat Pesanan';
      } else {
        resp = 'User tidak ditemukan.';
      }
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}

class DetailPayCOD extends StatefulWidget {
  final String image;
  final String name;
  final String penerima;
  final String orderId;
  final String nomor;
  final String kodeOrder;
  final String userId;
  final String lengkapUser;
  final String total;
  final String username;
  final String address;
  final String jumlah;

  const DetailPayCOD({
    super.key,
    required this.image,
    required this.name,
    required this.penerima,
    required this.orderId,
    required this.kodeOrder,
    required this.userId,
    required this.nomor,
    required this.lengkapUser,
    required this.total,
    required this.username,
    required this.address,
    required this.jumlah,
  });

  @override
  State<DetailPayCOD> createState() => _DetailPayCODState();
}

class _DetailPayCODState extends State<DetailPayCOD> {
  int count = 1;
  String userName = '';
  late ProductProvider productProvider;
  bool _uploading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> saveData() async {
    setState(() {
      _uploading = true;
    });

    try {
      String resp = await StoreData().saveData(
        kodeOrder: widget.kodeOrder,
        name: widget.name,
        orderId: widget.orderId,
        userId: widget.userId,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resp)),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to Upload Proof')),
      );
    } finally {
      setState(() {
        _uploading = false;
      });
    }
  }

  Future<void> showLoadingDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("COrderan Dibuat"),
            ],
          ),
        );
      },
    );

    await saveData();

    if (!_uploading) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const NavigatorScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Cash On Delivery",
          style: primaryTextStyle3.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: bg5color,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildInfoRow(
                          Icons.payment, "Metode Pembayaran", widget.name),
                      const SizedBox(height: 10),
                      _buildInfoRow(
                          Icons.person, "Nama Penerima", widget.nomor),
                      const SizedBox(height: 10),
                      _buildInfoRow(
                          Icons.attach_money, "Total Pembayaran", widget.total),
                      const SizedBox(height: 10),
                      _buildInfoRow(
                          Icons.shopping_basket, "Total Barang", widget.jumlah),
                      const SizedBox(height: 10),
                      _buildInfoRow(
                          Icons.location_on, "Alamat Penerima", widget.address),
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: bg5color.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Tolong bayar sesuai jumlah pesanan, harap bayar terlebih dahulu sebelum membuka",
                          textAlign: TextAlign.center,
                          style: primaryTextStyle2.copyWith(
                            color: bg6color,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ButtonCus(
            textButton: "Buat Pesanan",
            onPressed: showLoadingDialog,
            buttomcolor: bg6color,
            textcolor: bg1Color),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: bg6color),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: primaryTextStyle3.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: bg5color,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: primaryTextStyle3.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: bg6color,
            ),
          ),
        ),
      ],
    );
  }
}
