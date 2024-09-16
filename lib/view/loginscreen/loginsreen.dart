// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kelompok5_a2/helper/icons.dart';
import 'package:kelompok5_a2/navigator/navigator_screen.dart';
import 'package:kelompok5_a2/helper/theme.dart';

import 'package:kelompok5_a2/view/regisscreen/register.dart';
import 'package:kelompok5_a2/widget/button_custom.dart';
import 'package:kelompok5_a2/widget/button_logo.dart';
import 'package:kelompok5_a2/widget/custom_textfiled.dart';
import 'package:kelompok5_a2/widget/password_textfiled.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late String email;
  late String password;
  bool isLoading = false;

  void validation() async {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      try {
        setState(() {
          isLoading = true;
        });

        QuerySnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('user')
            .where('email', isEqualTo: email)
            .get();

        if (userSnapshot.size > 0) {
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NavigatorScreen(),
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Email Tidak Terdaftar'),
              content: const Text('Email yang Anda masukkan Sudah DI Banned.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Password Salah'),
              content: const Text('Password yang Anda masukkan salah.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else if (e.code == 'user-not-found') {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('User Tidak Ditemukan'),
              content: const Text('Tidak ada user dengan email tersebut.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: Text(e.message ?? 'An error occurred.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: bg1Color,
      appBar: AppBar(
        backgroundColor: bg1Color,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(
              MediaQuery.of(context).size.width * 5 / 100,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Login",
                    style: primaryTextStyle3.copyWith(fontSize: 45),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 10 / 100,
                  ),
                  Row(
                    children: [
                      Text(
                        "Alamat Email",
                        style: primaryTextStyle2.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  CustomTextFil(
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2 / 100,
                  ),
                  Row(
                    children: [
                      Text(
                        "Kata Sandi",
                        style: primaryTextStyle2.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  PasswordTextField(
                    hintText: '******',
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1 / 100,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 3 / 100,
                  ),
                  ButtonCus(
                    textButton: "Masuk",
                    onPressed: validation,
                    buttomcolor: bg6color,
                    textcolor: bg1Color,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 3 / 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 5 / 100,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Tidak Memiliki Akun? ",
              style:
                  primaryTextStyle2.copyWith(fontSize: 12, color: Colors.grey),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) => const Register(),
                  ),
                );
              },
              child: Text(
                "Daftar di sini Gratis",
                style:
                    primaryTextStyle2.copyWith(fontSize: 12, color: bg3Color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
