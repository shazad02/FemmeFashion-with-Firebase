import 'package:flutter/material.dart';
import 'package:kelompok5_a2/view/bagscreen/bag.dart';
import 'package:kelompok5_a2/view/dashboardscreen/semua_produk.dart';
import 'package:kelompok5_a2/view/dashboardscreen/dashboardscreen.dart';
import 'package:kelompok5_a2/view/profile/profilescreen.dart';

import '../helper/theme.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({super.key});

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const AllProduct(),
    const Bag(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    Widget customButtomNav() {
      return BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: bg1Color,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(
                  Icons.home,
                  size: 40,
                ),
              ],
            ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 40,
                ),
              ],
            ),
            label: 'All Produk',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [Icon(Icons.shopping_bag_outlined, size: 40)],
            ),
            label: 'Tas',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.person_2_outlined, size: 40),
              ],
            ),
            label: 'profile',
          ),
        ],
        selectedItemColor: bg6color,
        unselectedItemColor: Colors.grey.withOpacity(0.6),
      );
    }

    return Scaffold(
      backgroundColor: Colors.amber,
      body: _screens[_currentIndex],
      bottomNavigationBar: ClipRRect(
        child: customButtomNav(),
      ),
    );
  }
}
