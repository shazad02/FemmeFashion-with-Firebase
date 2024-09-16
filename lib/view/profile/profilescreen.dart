// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kelompok5_a2/provider/product_provider.dart';
import 'package:kelompok5_a2/helper/theme.dart';
import 'package:kelompok5_a2/view/alamat/edit_alamat.dart';

import 'package:kelompok5_a2/view/editprofile/edit_profile.dart';

import 'package:kelompok5_a2/view/orderscreen/listcek.dart';
import 'package:kelompok5_a2/view/orderscreen/orderscreen.dart';
import 'package:kelompok5_a2/view/profile/component/opsiprofile.dart';
import 'package:kelompok5_a2/view/profile/editProfile.dart';
import 'package:kelompok5_a2/view/splashscreen/splashscreen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    late ProductProvider productProvider;
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    final FirebaseAuth auth = FirebaseAuth.instance;
    Future<void> logout() async {
      await auth.signOut();
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

    // Get user data once when the widget is built
    productProvider.getUserData();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ProfileKu",
                      style: primaryTextStyle3.copyWith(
                          fontSize: 35, color: bg6color),
                    ),
                    IconButton(
                        onPressed: logout,
                        icon: const Icon(
                          Icons.logout,
                          color: bg5color,
                        ))
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.account_circle,
                      color: bg5color,
                      size: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Consumer<ProductProvider>(
                            builder: (context, productProvider, child) {
                              if (productProvider.userModelList.isEmpty) {
                                return const CircularProgressIndicator();
                              } else {
                                final userModel =
                                    productProvider.userModelList.first;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userModel.name,
                                      style: primaryTextStyle3.copyWith(
                                        color: bg6color,
                                        fontSize: 24,
                                      ),
                                    ),
                                    Text(
                                      userModel.email,
                                      style: primaryTextStyle2.copyWith(
                                          fontSize: 18, color: bg5color),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 4 / 100,
                ),
                OpsiProfile(
                  text: 'Orderan Ku',
                  notif: 'Cek Orderan Kamu',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => const OrderScreen(),
                      ),
                    );
                  },
                ),
                OpsiProfile(
                  text: 'Alamat Belanja',
                  notif: 'Tampilkan Semua Almat',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => const EditAlamatt(),
                      ),
                    );
                  },
                ),
                OpsiProfile(
                  text: 'Pengaturan',
                  notif: 'Pengaturan akun & Kata Sandi',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => const EditProfile(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
