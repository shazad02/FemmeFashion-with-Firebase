// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kelompok5_a2/helper/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CekCard extends StatelessWidget {
  final String userName;
  final double totalPrice;
  final String kodeOrder;
  final String UserUid;
  final String lengkapUser;
  final String status;
  final DateTime time;
  final String docId;
  final String pengiriman;
  final VoidCallback onStatusUpdated;

  const CekCard({
    super.key,
    required this.userName,
    required this.totalPrice,
    required this.kodeOrder,
    required this.UserUid,
    required this.lengkapUser,
    required this.status,
    required this.time,
    required this.docId,
    required this.onStatusUpdated,
    required this.pengiriman,
  });

  Future<void> _updateStatus(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection('order')
        .doc(docId)
        .update({'status': 'Selesai'});
    onStatusUpdated();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('The status has been changed to completed.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    String truncatedKodeOrder =
        kodeOrder.length > 6 ? kodeOrder.substring(0, 6) : kodeOrder;

    String displayStatus = status;
    if (status == 'Dalam Perjalanan') {
      displayStatus = 'Dalam Perjalanan';
    } else if (status == 'Tunggu') {
      displayStatus = 'Proses Konfirmasi';
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
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
          child: Card(
            color: bg1Color,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            elevation: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            DateFormat('dd-MM-yyyy ').format(time),
                            style: primaryTextStyle2.copyWith(
                              color: bg6color,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "kode pesan",
                            style: primaryTextStyle2.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: bg5color,
                            ),
                          ),
                          Text(
                            truncatedKodeOrder,
                            style: primaryTextStyle2.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: bg6color,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nama : $userName",
                            style: primaryTextStyle2.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: bg6color,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Total Pembayaran : Rp.${totalPrice.toInt()}",
                        style: primaryTextStyle2.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: bg6color,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        lengkapUser,
                        style: primaryTextStyle2.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: bg6color,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (status ==
                              'Dalam Perjalanan') // Hanya tampilkan tombol jika status bukan "sudah selesai"
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 29 / 100,
                              height:
                                  MediaQuery.of(context).size.height * 5 / 100,
                              decoration: BoxDecoration(
                                border: Border.all(color: bg6color),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: TextButton(
                                onPressed: () => _updateStatus(context),
                                child: Text(
                                  "Success",
                                  style: primaryTextStyle3.copyWith(
                                      color: bg5color),
                                ),
                              ),
                            ),
                          Text(
                            displayStatus,
                            style: primaryTextStyle3.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: bg6color,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
