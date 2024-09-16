import 'package:flutter/material.dart';
import 'package:kelompok5_a2/helper/theme.dart';

class DetailProductOpsi extends StatelessWidget {
  final String image;
  final String nama;
  final String kategori;
  final String harga;
  const DetailProductOpsi({
    super.key,
    required this.image,
    required this.nama,
    required this.harga,
    required this.kategori,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              child: Image.asset(
                image,
                width: 1000,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 1 / 100,
          ),
          Text(
            nama,
            style: primaryTextStyle2.copyWith(fontSize: 15, color: Colors.grey),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 1 / 100,
          ),
          Text(
            kategori,
            style: primaryTextStyle3.copyWith(fontSize: 18),
          ),
          Text(
            harga,
            style: primaryTextStyle3.copyWith(fontSize: 18),
          )
        ],
      ),
    );
  }
}
