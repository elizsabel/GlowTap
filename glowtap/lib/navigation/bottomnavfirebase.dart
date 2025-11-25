import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/views/booking/historyfirebasepage.dart';
import 'package:glowtap/glowtap/views/education/educationpage.dart';
import 'package:glowtap/glowtap/views/booking/historypage.dart';
import 'package:glowtap/glowtap/views/home/homepage.dart';
import 'package:glowtap/glowtap/views/home/homepage_firebase.dart';
import 'package:glowtap/glowtap/views/profile/akunpage.dart';

class BottomNavFirebase extends StatefulWidget {
  const BottomNavFirebase({super.key});

  @override
  State<BottomNavFirebase> createState() => _BottomNavFirebaseState();
}

class _BottomNavFirebaseState extends State<BottomNavFirebase> {
  int currentIndex = 0;

  final List<Widget> pages = [
    HomePageFirebase(),
    HistoryFirebasePage(),
    EducationPage(),
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
