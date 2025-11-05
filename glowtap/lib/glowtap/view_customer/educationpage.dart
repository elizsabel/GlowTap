import 'package:flutter/material.dart';
import 'package:glowtap/constant/appcolor.dart';

class EdukasiDetailPage extends StatelessWidget {
  final String title;
  final String content;

  const EdukasiDetailPage({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        title: Text(title, style: const TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          content,
          style: TextStyle(
            color: Appcolor.textBrownSoft,
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}
