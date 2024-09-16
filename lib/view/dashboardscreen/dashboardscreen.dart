// ignore_for_file: unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kelompok5_a2/helper/icons.dart';
import 'package:kelompok5_a2/helper/images.dart';
import 'package:kelompok5_a2/models/produck_model.dart';
import 'package:kelompok5_a2/provider/category_provider.dart';
import 'package:kelompok5_a2/helper/theme.dart';
import 'package:kelompok5_a2/view/categoryscreen/produk_card.dart';
import 'package:kelompok5_a2/view/dashboardscreen/circle_image.dart';
import 'package:kelompok5_a2/view/dashboardscreen/semua_produk.dart';
import 'package:kelompok5_a2/view/dashboardscreen/component/caruso.dart';
import 'package:kelompok5_a2/view/categoryscreen/categorybox.dart';
import 'package:kelompok5_a2/view/categoryscreen/category_screen.dart';
import 'package:kelompok5_a2/view/splashscreen/splashscreen.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _logout() async {
    await _auth.signOut();
    // ignore: deprecated_member_use, use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      ),
      (route) => false,
    );
  }

  Widget _categoryButton() {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, _) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  categoryProvider.setCategory('Baju');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListProduct(
                        isEqualTo: 'Baju',
                        namescreen: "Baju",
                      ),
                    ),
                  );
                },
                child: const CatrgoryBox(
                  image: Images.women,
                  text: "Baju",
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  categoryProvider.setCategory('rok');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListProduct(
                        isEqualTo: 'rok',
                        namescreen: "Rok",
                      ),
                    ),
                  );
                },
                child: const CatrgoryBox(
                  image: Images.rok,
                  text: "Rok",
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  categoryProvider.setCategory('Dress');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListProduct(
                        isEqualTo: 'Dress',
                        namescreen: "Dress",
                      ),
                    ),
                  );
                },
                child: const CatrgoryBox(
                  image: Images.dress,
                  text: "Dress",
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget allItem() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 9 / 10,
      child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection("products").get(),
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
        body: ChangeNotifierProvider<CategoryProvider>(
            create: (_) => CategoryProvider(),
            child: Consumer<CategoryProvider>(
                builder: (context, categoryProvider, _) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // gambar gerak
                    const MyCarousel(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Kategori Produk",
                                style: primaryTextStyle3.copyWith(
                                    fontSize: 25, color: bg6color),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (c) => const AllProduct(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Lihat Semua",
                                  style: primaryTextStyle3.copyWith(
                                      fontSize: 15, color: bg5color),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 2 / 100,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                color: bg5color,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      1 /
                                      100,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      child: const CircleImage(
                                          image: Iconss.shirt, text: "Baju"),
                                      onTap: () {
                                        categoryProvider.setCategory('baju');
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ListProduct(
                                              isEqualTo: 'baju',
                                              namescreen: 'baju',
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        categoryProvider.setCategory('dress');
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ListProduct(
                                              isEqualTo: 'dress',
                                              namescreen: 'dress',
                                            ),
                                          ),
                                        );
                                      },
                                      child: const CircleImage(
                                          image: Iconss.dress, text: "Dress"),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        categoryProvider.setCategory('rok');
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ListProduct(
                                              isEqualTo: 'rok',
                                              namescreen: 'rok',
                                            ),
                                          ),
                                        );
                                      },
                                      child: const CircleImage(
                                          image: Iconss.skirt, text: "Rok"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 1 / 100,
                          ),
                          Text(
                            "Semua Produk",
                            style: primaryTextStyle3.copyWith(
                                fontSize: 25, color: bg6color),
                          ),
                          SingleChildScrollView(
                            child: allItem(),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            })));
  }
}
