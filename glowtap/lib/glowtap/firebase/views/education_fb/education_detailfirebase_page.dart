import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/firebase/constant/appcolor.dart';
import 'package:glowtap/glowtap/firebase/models_firebase/educationmodel.dart';

class EducationDetailFirebasePage extends StatelessWidget {
  final EducationModel item;

  const EducationDetailFirebasePage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        title: Text(item.title, style: const TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Appcolor.textBrownSoft,
                  ),
                ),
                const SizedBox(height: 14),

                Text(
                  item.content,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.55,
                    color: Appcolor.textBrownSoft,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
