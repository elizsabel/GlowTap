import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/firebase/constant/appcolor.dart';
import 'package:glowtap/glowtap/firebase/views/booking_firebase/historyfirebasepage.dart';
import 'package:glowtap/glowtap/firebase/views/education_fb/education_firebase_page.dart';
import 'package:glowtap/glowtap/sql/views/education/educationpage.dart';
import 'package:glowtap/glowtap/firebase/views/home_firebase/homepage_firebase.dart';
import 'package:glowtap/glowtap/firebase/views/profile_firebase/akunfirebasepage.dart';

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
    EducationFirebasePage(),
    AkunFirebasePage(),
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
