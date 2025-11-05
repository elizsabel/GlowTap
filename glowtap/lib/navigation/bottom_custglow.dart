import 'package:flutter/material.dart';
import 'package:glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/view_customer/educationpage.dart';
import 'package:glowtap/glowtap/view_customer/historypage.dart';

import 'package:glowtap/glowtap/view_customer/homepage.dart';
import 'package:glowtap/glowtap/view_customer/akunpage.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int currentIndex = 0;

  final List<Widget> pages = [
    HomePage(),
    HistoryPage(),
    EdukasiPage(),
    AkunPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() => currentIndex = i),
        selectedItemColor: Appcolor.button1,
        unselectedItemColor: Appcolor.textBrownSoft.withOpacity(.6),
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_rounded),
            label: "Riwayat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: "Edukasi",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: "Akun",
          ),
        ],
      ),
    );
  }
}
