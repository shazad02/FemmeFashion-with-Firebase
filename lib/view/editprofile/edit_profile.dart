// ignore_for_file: unused_import, unused_local_variable, use_build_context_synchronously

import 'package:kelompok5_a2/provider/product_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kelompok5_a2/widget/button_custom.dart';
import 'package:kelompok5_a2/widget/profile_textfill.dart';
import 'package:provider/provider.dart';
import '../../helper/theme.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late ProductProvider productProvider;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    // Set the initial values for the text fields
    nameController.text = productProvider.userModelList.isNotEmpty
        ? productProvider.userModelList.first.name
        : '';
    emailController.text = productProvider.userModelList.isNotEmpty
        ? productProvider.userModelList.first.email
        : '';
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    productProvider.getUserData();
    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        backgroundColor: bg1Color,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ProfileKu",
                style: primaryTextStyle3.copyWith(fontSize: 35),
              ),
              Text(
                "Informasi Data Akun",
                style: primaryTextStyle2.copyWith(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 3 / 100,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nama Pengguna",
                        style: primaryTextStyle2.copyWith(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 5),
                      ProfileTextFil(
                        controller: nameController,
                        hintttext: 'Full Name',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email Pengguna",
                        style: primaryTextStyle2.copyWith(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 5),
                      ProfileTextFil(
                        readOnly: true,
                        controller: emailController,
                        hintttext: 'Email',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Kata Sandi",
                    style: primaryTextStyle2.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 5),
                  ProfileTextFil(
                    controller: passwordController,
                    hintttext: '**************',
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ButtonCus(
                        textButton: "Simpan Profile",
                        onPressed: _updateUserData,
                        buttomcolor: Colors.red,
                        textcolor: bg1Color),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateUserData() async {
    final String newName = nameController.text;
    final String newEmail = emailController.text;
    final String newPassword = passwordController.text;

    if (newPassword.isNotEmpty) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        await user?.updatePassword(newPassword);
        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Password updated successfully"),
          ),
        );
      } catch (e) {
        // Show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to update password: $e"),
          ),
        );
      }
    }

    // Notify listeners of the change
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    productProvider.notifyListeners();
  }
}
