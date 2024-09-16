import 'package:flutter/material.dart';
import 'package:kelompok5_a2/helper/theme.dart';
import 'package:kelompok5_a2/models/pay_model.dart';
import 'package:kelompok5_a2/provider/product_provider.dart';
import 'package:kelompok5_a2/view/bukti/detail_pay.dart';
import 'package:kelompok5_a2/view/bukti/detail_paycod.dart';
import 'package:kelompok5_a2/view/bukti/pay_cart.dart';
import 'package:kelompok5_a2/widget/button_custom.dart';
import 'package:provider/provider.dart';

class PayScreen extends StatefulWidget {
  final String kodeOrder;
  final String userId;
  final String lengkapUser;
  final String total;
  final String username;
  final String address;
  final String jumlah;

  const PayScreen({
    super.key,
    required this.kodeOrder,
    required this.userId,
    required this.lengkapUser,
    required this.total,
    required this.username,
    required this.address,
    required this.jumlah,
  });

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  bool _isLoading = true;
  String? _selectedPaymentMethod;
  PayModel? _selectedPayModel;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    await Provider.of<ProductProvider>(context, listen: false)
        .fetchPayProducts();
    setState(() {
      _isLoading = false;
    });
  }

  Widget _payProduct() {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, _) {
        final List<PayModel> paymodels = productProvider.payProducts;

        if (_isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (paymodels.isEmpty) {
          return Center(
            child: Text(
              'Tidak ada metode pembayaran.',
              style: primaryTextStyle2.copyWith(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        }

        return SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.7,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: paymodels.length,
            itemBuilder: (context, index) {
              PayModel payModel = paymodels[index];
              return PayCard(
                image: payModel.image,
                nama: payModel.nama,
                nomor: payModel.nomor,
                penerima: payModel.penerima,
                orderId: payModel.id,
                kodeOrder: widget.kodeOrder,
                userId: widget.userId,
                lengkapUser: widget.lengkapUser,
                total: widget.total,
                username: widget.username,
                address: widget.address,
                jumlah: widget.jumlah,
                selectedPaymentMethod: _selectedPaymentMethod ?? '',
                onSelected: (String value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                    _selectedPayModel = payModel;
                  });
                },
              );
            },
          ),
        );
      },
    );
  }

  void _navigateToDetailPage() {
    if (_selectedPayModel == null) return;

    if (_selectedPayModel!.nama == 'COD') {
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => DetailPayCOD(
            nomor: _selectedPayModel!.nomor,
            image: _selectedPayModel!.image,
            name: _selectedPayModel!.nama,
            penerima: _selectedPayModel!.penerima,
            orderId: _selectedPayModel!.id,
            kodeOrder: widget.kodeOrder,
            userId: widget.userId,
            lengkapUser: widget.lengkapUser,
            total: widget.total,
            username: widget.username,
            address: widget.address,
            jumlah: widget.jumlah,
          ),
        ),
      );
    } else {
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => DetailPay(
            nomor: _selectedPayModel!.nomor,
            image: _selectedPayModel!.image,
            name: _selectedPayModel!.nama,
            penerima: _selectedPayModel!.penerima,
            orderId: _selectedPayModel!.id,
            kodeOrder: widget.kodeOrder,
            userId: widget.userId,
            lengkapUser: widget.lengkapUser,
            total: widget.total,
            username: widget.username,
            address: widget.address,
            jumlah: widget.jumlah,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        backgroundColor: bg5color,
        title: Text(
          "Pembayaran",
          style: primaryTextStyle3.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              _payProduct(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ButtonCus(
          textButton: "Pilih Metode Pembayarnan",
          onPressed: _navigateToDetailPage,
          buttomcolor: bg6color,
          textcolor: bg1Color,
        ),
      ),
    );
  }
}
