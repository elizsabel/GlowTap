import 'package:flutter/material.dart';
import 'package:glowtap/constant/appcolor.dart';

class EdukasiPage extends StatelessWidget {
  const EdukasiPage({super.key});

  final List<Map<String, String>> articles = const [
    {
      "title": "Kenapa Skin Barrier Penting?",
      "subtitle": "Kunci kulit sehat dan glowing alami.",
      "image": "assets/images/artikel.png",
    },
    {
      "title": "Perbedaan Skinbooster vs Serum",
      "subtitle": "Kapan perlu treatment? Kapan cukup skincare?",
      "image": "assets/images/artikel.png"
    },
    {
      "title": "Cara Rawat Kulit Sensitif",
      "subtitle": "Soft skincare routine yang aman & lembut.",
      "image": "assets/images/artikel.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        title: const Text("Edukasi & Artikel", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          // Banner Ilustrasi
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Image.asset(
              "assets/images/artikel.png", // gunakan gambar soft aesthetic
              height: 170,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 20),

          // List Artikel
          ...articles.map((article) {
            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Appcolor.textBrownLight.withOpacity(.2)),
              ),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(article["image"]!, width: 55, height: 55, fit: BoxFit.cover),
                ),
                title: Text(article["title"]!, style: TextStyle(color: Appcolor.textBrownSoft, fontWeight: FontWeight.bold)),
                subtitle: Text(article["subtitle"]!, style: TextStyle(color: Appcolor.textBrownSoft.withOpacity(.7))),
                onTap: () {
                  // lanjut buat halaman detail artikel
                },
              ),
            );
          }).toList(),

        ],
      ),
    );
  }
}
