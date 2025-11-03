import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/view_customer/educationpage.dart';
import 'package:glowtap/glowtap/view_customer/homepage.dart';
import 'package:glowtap/glowtap/view_customer/akunpage.dart';
import 'package:glowtap/glowtap/view_customer/trackingpage.dart';

class BottomCustGlow extends StatefulWidget {
  const BottomCustGlow({super.key});

  @override
  State<BottomCustGlow> createState() => _BottomCustGlowState();
}

class _BottomCustGlowState extends State<BottomCustGlow> {
  int _selected = 0;

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

      // ===== ANIMATED PAGE TRANSITION =====
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        switchInCurve: Curves.easeOutQuad,
        switchOutCurve: Curves.easeInQuad,
        transitionBuilder: (child, animation) =>
            FadeTransition(opacity: animation, child: child),
        child: _pages[_selected],
      ),

      // ===== BOTTOM NAV =====
      bottomNavigationBar: CurvedNavigationBar(
        index: _selected,
        height: 60,
        backgroundColor: Appcolor.softPinkPastel,
        color: Appcolor.button1,
        buttonBackgroundColor: Appcolor.button1,
        animationDuration: const Duration(milliseconds: 250),

        items: [
          Icon(Icons.home_rounded,
              size: 28,
              color: _selected == 0 ? Colors.white : Colors.white.withOpacity(0.7)),
          Icon(Icons.map_rounded,
              size: 28,
              color: _selected == 1 ? Colors.white : Colors.white.withOpacity(0.7)),
          Icon(Icons.article_rounded,
              size: 28,
              color: _selected == 2 ? Colors.white : Colors.white.withOpacity(0.7)),
          Icon(Icons.person_rounded,
              size: 28,
              color: _selected == 3 ? Colors.white : Colors.white.withOpacity(0.7)),
        ],

        onTap: (index) {
          setState(() => _selected = index);
        },
      ),
    );
  }
}


