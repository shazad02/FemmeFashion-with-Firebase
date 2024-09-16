import 'package:flutter/material.dart';
import 'package:kelompok5_a2/helper/theme.dart';

class PayCard extends StatelessWidget {
  final String image;
  final String nama;
  final String nomor;
  final String penerima;
  final String orderId;
  final String kodeOrder;
  final String userId;
  final String lengkapUser;
  final String total;
  final VoidCallback? onAdd;
  final String username;
  final String address;
  final String jumlah;
  final String selectedPaymentMethod;
  final Function(String) onSelected;

  const PayCard({
    super.key,
    required this.image,
    required this.nama,
    this.onAdd,
    required this.nomor,
    required this.penerima,
    required this.orderId,
    required this.kodeOrder,
    required this.userId,
    required this.lengkapUser,
    required this.total,
    required this.username,
    required this.address,
    required this.jumlah,
    required this.selectedPaymentMethod,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(nama),
      child: Container(
        height: 70,
        margin: const EdgeInsets.symmetric(vertical: 0.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
        ),
        child: Column(
          children: [
            Center(
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    image,
                    fit: BoxFit.fill,
                    width: 60,
                    height: 30,
                  ),
                ),
                title: Text(
                  nama,
                  style: primaryTextStyle3.copyWith(
                    color: bg6color,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                trailing: Radio<String>(
                  focusColor: bg6color,
                  hoverColor: bg5color,
                  value: nama,
                  groupValue: selectedPaymentMethod,
                  onChanged: (String? value) {
                    if (value != null) {
                      onSelected(value);
                    }
                  },
                ),
              ),
            ),
            const Divider(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
