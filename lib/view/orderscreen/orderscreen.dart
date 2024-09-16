// ignore_for_file: unused_import, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kelompok5_a2/provider/category_provider.dart';
import 'package:kelompok5_a2/provider/product_provider.dart';
import 'package:kelompok5_a2/view/orderscreen/ceko_card.dart';
import 'package:kelompok5_a2/view/orderscreen/cek_card.dart';
import 'package:kelompok5_a2/view/orderscreen/component/delivery.dart';
import 'package:kelompok5_a2/widget/profile_textfill.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/cek_model.dart';
import '../../helper/theme.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _selectedIndex = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<CekModel>> _fetchOrders(String status) async {
    User? currentUser = _auth.currentUser;

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection("order")
        .where("UserUid", isEqualTo: currentUser?.uid)
        .where("status", isEqualTo: status)
        .get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
        querySnapshot.docs;

    List<CekModel> cekmodels = documents
        .map((document) => CekModel.fromJson(document.data(), document.id))
        .toList();

    cekmodels.sort((a, b) => b.time.compareTo(a.time));

    return cekmodels;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: bg5color,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios),
          ),
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            isScrollable: true,
            indicator: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(text: "Belum Bayar"),
              Tab(text: "Menunggu"),
              Tab(text: "Perjalanan"),
              Tab(text: "Berhasil"),
              Tab(text: "Batal"),
            ],
            unselectedLabelColor: Colors.white, // Warna teks tab tidak aktif
            labelColor: bg5color, // Warna teks tab aktif
          ),
        ),
        body: TabBarView(
          children: [
            _buildOrderList("Belum Bayar"),
            _buildOrderList("Tunggu"),
            _buildOrderList("Dalam Perjalanan"),
            _buildOrderList("Selesai"),
            _buildOrderList("Tolak"),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderList(String status) {
    return FutureBuilder<List<CekModel>>(
      future: _fetchOrders(status),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'Pesanan Tidak Di temukan',
              style: primaryTextStyle2.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: bg6color,
              ),
            ),
          );
        } else {
          List<CekModel> cekmodels = snapshot.data!;
          return ListView.builder(
            itemCount: cekmodels.length,
            itemBuilder: (context, index) {
              CekModel cekModel = cekmodels[index];
              if (cekModel.status == "Belum Bayar") {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CekoCar(
                    UserUid: cekModel.UserUid,
                    kodeOrder: cekModel.kodeOrder,
                    totalPrice: cekModel.totalPrice,
                    userName: cekModel.userName,
                    lengkapUser: cekModel.address,
                    status: cekModel.status,
                    time: cekModel.time,
                    jumlah: '',
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CekCard(
                    UserUid: cekModel.UserUid,
                    kodeOrder: cekModel.kodeOrder,
                    totalPrice: cekModel.totalPrice,
                    userName: cekModel.userName,
                    lengkapUser: cekModel.address,
                    status: cekModel.status,
                    time: cekModel.time,
                    docId: cekModel.docId,
                    onStatusUpdated: _refreshData,
                    pengiriman: cekModel.pengiriman,
                  ),
                );
              }
            },
          );
        }
      },
    );
  }

  Future<void> _refreshData() async {
    setState(() {});
  }
}
