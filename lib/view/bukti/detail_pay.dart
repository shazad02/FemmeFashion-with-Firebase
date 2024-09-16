// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kelompok5_a2/helper/theme.dart';
import 'package:kelompok5_a2/navigator/navigator_screen.dart';
import 'package:kelompok5_a2/view/bukti/data.dart';

class DetailPay extends StatefulWidget {
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

  const DetailPay({
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
  State<DetailPay> createState() => _DetailPayState();
}

class _DetailPayState extends State<DetailPay> {
  Uint8List? _image;
  bool _uploading = false;

  Future<Uint8List?> pickImageFromGallery() async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      return await file.readAsBytes();
    }
    return null;
  }

  Future<Uint8List?> pickImageFromCamera() async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
    if (file != null) {
      return await file.readAsBytes();
    }
    return null;
  }

  Future<void> saveData() async {
    setState(() {
      _uploading = true;
    });

    if (_image != null) {
      try {
        String resp = await StoreData().saveData(
          kodeOrder: widget.kodeOrder,
          file: _image!,
          name: widget.name,
          orderId: widget.orderId,
          userId: widget.userId,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(resp)),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('gagal upload gambar')),
        );
      } finally {
        setState(() {
          _uploading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak ada gambar di pilih')),
      );
    }
  }

  Future<void> selectImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Pilih Gambar"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: const Text("Gallery"),
                  onTap: () async {
                    Navigator.pop(context);
                    Uint8List? img = await pickImageFromGallery();
                    setState(() {
                      _image = img;
                    });
                  },
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  child: const Text("Camera"),
                  onTap: () async {
                    Navigator.pop(context);
                    Uint8List? img = await pickImageFromCamera();
                    setState(() {
                      _image = img;
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
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
              Text("Loading gambar sedang di upload"),
            ],
          ),
        );
      },
    );

    await saveData();

    if (!_uploading) {
      Navigator.of(context).pop(); // Dismiss the loading dialog
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) =>
                const NavigatorScreen()), // Replace with your next screen
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            widget.name,
            style: primaryTextStyle3.copyWith(color: Colors.white),
          ),
          backgroundColor: bg5color,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: selectImage,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                    image: _image != null
                        ? DecorationImage(
                            image: MemoryImage(_image!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _image == null
                      ? Center(
                          child: Text(
                            "Upload Bukti Transfer",
                            style: primaryTextStyle2.copyWith(
                              color: bg6color,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : null,
                ),
              ),
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
                          Icons.payment, "Nama Rekening", widget.name),
                      const SizedBox(height: 10),
                      _buildInfoRow(
                          Icons.attach_money, "Nomer Rekening", widget.nomor),
                      const SizedBox(height: 10),
                      _buildInfoRow(Icons.house, "Atas Nama", widget.penerima),
                      const SizedBox(height: 10),
                      _buildInfoRow(
                          Icons.person, "Nama Penerima", widget.username),
                      const SizedBox(height: 10),
                      _buildInfoRow(
                          Icons.attach_money, "Total Pembayaran", widget.total),
                      const SizedBox(height: 10),
                      _buildInfoRow(
                          Icons.shopping_basket, "Total Barang", widget.jumlah),
                      const SizedBox(height: 10),
                      _buildInfoRow(
                          Icons.location_on, "Alamat", widget.address),
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: bg5color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Harap Mengrimkan Sesuai dengan Total Pembayaran dan Nomer rekeing  yang sesuai seperti di tampilkan",
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
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 5.5 / 100,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
                backgroundColor: bg6color,
              ),
              onPressed:
                  (_uploading || _image == null) ? null : showLoadingDialog,
              child: Text(
                "Buat Pesanan",
                style: primaryTextStyle2.copyWith(
                  fontSize: 16,
                  color: bg1Color,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ));
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: bg6color),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: primaryTextStyle2.copyWith(
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
            style: primaryTextStyle2.copyWith(
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
