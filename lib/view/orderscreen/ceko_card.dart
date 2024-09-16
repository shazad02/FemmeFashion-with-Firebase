// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kelompok5_a2/helper/theme.dart';
import 'package:kelompok5_a2/view/bukti/pilihpembayaran.dart';

class CekoCar extends StatelessWidget {
  final String userName;
  final double totalPrice;
  final String kodeOrder;
  final String UserUid;
  final String lengkapUser;
  final String status;
  final String jumlah;
  final DateTime time;

  const CekoCar({
    super.key,
    required this.userName,
    required this.totalPrice,
    required this.kodeOrder,
    required this.UserUid,
    required this.lengkapUser,
    required this.status,
    required this.time,
    required this.jumlah,
  });

  @override
  Widget build(BuildContext context) {
    String displayStatus = status;
    if (status == 'Belum Bayar') {
      displayStatus = 'Belum Bayar';
    }

    return GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => PayScreen(
                kodeOrder: kodeOrder,
                userId: UserUid,
                lengkapUser: lengkapUser,
                total: totalPrice.toStringAsFixed(0),
                username: userName,
                address: lengkapUser,
                jumlah: jumlah,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name : $userName",
                              style: primaryTextStyle2.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: bg5color,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Total Price : Rp.${totalPrice.toInt()}",
                          style: primaryTextStyle2.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: bg5color,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          lengkapUser,
                          style: primaryTextStyle2.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: bg5color,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          displayStatus,
                          style: primaryTextStyle3.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: bg6color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
