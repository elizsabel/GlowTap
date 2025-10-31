import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/view_customer/homepage.dart';
import 'package:glowtap/main.dart';

class Bottom_CustGlow extends StatefulWidget {
  const Bottom_CustGlow({super.key});

  @override
  State<Bottom_CustGlow> createState() => _Bottom_CustGlowState();
}

class _Bottom_CustGlowState extends State<Bottom_CustGlow> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = [HomePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xFFE8A8A1),
        items: <Widget>[
          Icon(Icons.home, size: 30),
          // Icon(Icons.chat, size: 30),
          // Icon(Icons.history, size: 30),
        ],
        onTap: (index) {
          print(index);
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
