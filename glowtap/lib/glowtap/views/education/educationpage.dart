import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/views/education/educationdetailpage.dart';

class EdukasiPage extends StatelessWidget {
  const EdukasiPage({super.key});

  final List<Map<String, String>> edukasiList = const [
    {
      
      "title": "Tips Menjaga Skin Barier Tetap Kuat?",
      "content":
          "Skin barrier adalah pelindung utama kulit. Kalau rusak, kulit akan mudah kusam, kering, dan muncul jerawat."
          "Cara memperbaiki & menjaganya:\n"
          "1. Gunakan pembersih wajah yang lembut dan hindari sabun keras.\n"
          "2. Rutin pakai pelembap yang mengandung ceramide dan hyaluronic acid.\n"
          "3. Selalu aplikasikan sunscreen setiap hari, minimal SPF 30.\n",
    },
    {
      "title": "Manfaat DNA Salmon",
      "content":
          "DNA Salmon membantu regenerasi sel kulit, memperbaiki tekstur, dan membuat kulit glowing...",
    },
    {
      "title": "Perawatan Setelah Treatment",
      "content":
          "Setelah treatment, hindari make up berat, sunscreen wajib, dan jangan sentuh area suntikan...",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        centerTitle: true,
        title: const Text(
          "Edukasi Perawatan ✨",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: edukasiList.length,
        itemBuilder: (context, index) {
          final item = edukasiList[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EdukasiDetailPage(
                    title: item["title"]!,
                    content: item["content"]!,
                  ),
                ),
              );
            },
            child: Container(
              height: 150,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(.06),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.menu_book_rounded,
                    color: Appcolor.button1,
                    size: 28,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      item["title"]!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Appcolor.textBrownSoft,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
