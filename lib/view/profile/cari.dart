// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kelompok5_a2/provider/category_provider.dart';
import 'package:kelompok5_a2/view/categoryscreen/produk_card.dart';
import 'package:provider/provider.dart';
import '../../../../../../models/produck_model.dart';
import '../../helper/theme.dart';

class CariScreen extends StatefulWidget {
  final String namescreen;

  const CariScreen({
    super.key,
    required this.namescreen,
  });

  @override
  State<CariScreen> createState() => _CariScreenState();
}

class _CariScreenState extends State<CariScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _updateSearchQuery(String newQuery) {
    setState(() {
      _searchQuery = newQuery;
    });
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: const BoxDecoration(color: bg5color),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Cari Barang...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.white),
            ),
            prefixIcon: const Icon(Icons.search),
          ),
          onChanged: _updateSearchQuery,
        ),
      ),
    );
  }

  Widget dashboardPopuler() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 9 / 10,
      child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: _searchQuery.isEmpty
            ? FirebaseFirestore.instance.collection("products").get()
            : FirebaseFirestore.instance
                .collection("products")
                .where("name", isGreaterThanOrEqualTo: _searchQuery)
                .where("name", isLessThanOrEqualTo: '$_searchQuery\uf8ff')
                .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            QuerySnapshot<Map<String, dynamic>> querySnapshot = snapshot.data!;
            List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
                querySnapshot.docs;

            List<Product> products = documents
                .map((document) => Product.fromJson(document.data()))
                .toList();

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];
                return Column(
                  children: [
                    ProductCard(
                      image: product.image,
                      text: product.name,
                      price: product.price,
                      onAdd: () {
                        print('Tombol tambah diklik');
                      },
                      category: product.category,
                      description: product.description,
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg1Color,
      body: SafeArea(
        child: ChangeNotifierProvider<CategoryProvider>(
          create: (_) => CategoryProvider(),
          child: Consumer<CategoryProvider>(
            builder: (context, categoryProvider, _) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    _buildSearchBar(),
                    dashboardPopuler(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
