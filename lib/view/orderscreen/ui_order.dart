import 'package:flutter/material.dart';
import 'package:kelompok5_a2/helper/theme.dart';
import 'package:kelompok5_a2/view/orderscreen/component/delivery.dart';

class OrderScreenUi extends StatefulWidget {
  const OrderScreenUi({super.key});

  @override
  State<OrderScreenUi> createState() => _OrderScreenUiState();
}

class _OrderScreenUiState extends State<OrderScreenUi> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: bg1Color,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios),
          ),
          actions: [
            const Icon(Icons.search),
            SizedBox(
              width: MediaQuery.of(context).size.width * 4 / 100,
            ),
          ],
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            isScrollable: true,
            indicator: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(text: "Delivered"),
              Tab(text: "Processing"),
              Tab(text: "cancelled"),
            ],
            unselectedLabelColor: Colors.black, // Warna teks tab tidak aktif
            labelColor: Colors.white, // Warna teks tab aktif
          ),
        ),
        body: TabBarView(
          children: [
            _selectedIndex == 0
                ? const Center(child: IsiDelevery())
                : const SizedBox.shrink(),
            _selectedIndex == 1
                ? const Center(child: Text("Content for 121 tab"))
                : const SizedBox.shrink(),
            _selectedIndex == 2
                ? const Center(child: Text("Content for fass tab"))
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
