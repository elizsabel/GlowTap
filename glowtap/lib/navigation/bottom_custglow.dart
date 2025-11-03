import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/view_customer/educationpage.dart';
import 'package:glowtap/glowtap/view_customer/homepage.dart';
import 'package:glowtap/glowtap/view_customer/akunpage.dart';
import 'package:glowtap/glowtap/view_customer/trackingpage.dart';

class BottomCustGlow extends StatefulWidget {
  final int index;
  const BottomCustGlow({super.key, this.index = 0});

  @override
  State<BottomCustGlow> createState() => _BottomCustGlowState();
}

class _BottomCustGlowState extends State<BottomCustGlow> {
  late int _selected; // <- gunakan late agar mengikuti index dari luar

  @override
  void initState() {
    super.initState();
    _selected = widget.index; // ✅ ini kuncinya
  }

  final List<Widget> _pages = [
    HomePage(),
    TrackingPage(),
    EdukasiPage(),
    AkunPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,

      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[_selected],
      ),

      bottomNavigationBar: CurvedNavigationBar(
        index: _selected,
        height: 60,
        backgroundColor: Colors.transparent,
        color: Appcolor.button1,
        buttonBackgroundColor: Appcolor.button1,
        animationDuration: const Duration(milliseconds: 250),

        items: [
          Icon(Icons.home_rounded, size: 28, color: Colors.white),
          Icon(Icons.map_rounded, size: 28, color: Colors.white),
          Icon(Icons.article_rounded, size: 28, color: Colors.white),
          Icon(Icons.person_rounded, size: 28, color: Colors.white),
        ],

        onTap: (index) {
          setState(() => _selected = index);
        },
      ),
    );
  }
}
