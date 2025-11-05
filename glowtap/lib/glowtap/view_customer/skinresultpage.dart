import 'package:flutter/material.dart';
import 'package:glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/view_customer/bookingpage.dart';

class SkinResultPage extends StatelessWidget {
  final List<int> answers;
  const SkinResultPage({super.key, required this.answers});

  // Menentukan hasil berdasarkan jawaban terbanyak
  Map<String, String> analyzeResult() {
    int a = answers.where((e) => e == 0).length;
    int b = answers.where((e) => e == 1).length;
    int c = answers.where((e) => e == 2).length;
    int d = answers.where((e) => e == 3).length;

    if (a > b && a > c && a > d) {
      return {
        "title": "Kulit Kusam & Kurang Glow ✨",
        "desc":
            "Kulitmu terlihat kurang bercahaya dan butuh booster untuk memaksimalkan healthy skin glow.",
        "recommend": "Profhilo Skin Booster",
        "price": "Rp 3.200.000",
      };
    } else if (b > a && b > c && b > d) {
      return {
        "title": "Kulit Kering & Dehidrasi 💧",
        "desc":
            "Kulitmu kehilangan kelembapan alami. Kamu butuh treatment hidrasi mendalam.",
        "recommend": "DNA Salmon Injection",
        "price": "Rp 850.000",
      };
    } else if (c > a && c > b && c > d) {
      return {
        "title": "Kulit Berjerawat / Bekas Jerawat 🌱",
        "desc":
            "Kulitmu sedang dalam fase pemulihan dan perbaikan barrier. Perlu bantuan healing & regenerasi.",
        "recommend": "Rejuran Healing",
        "price": "Rp 1.950.000",
      };
    } else {
      return {
        "title": "Anti Aging & Garis Halus 🎀",
        "desc":
            "Kulitmu menunjukkan tanda penuaan dini. Kamu butuh treatment yang mengencangkan & meratakan tekstur.",
        "recommend": "Botox + Profhilo Combo",
        "price": "Mulai Rp 1.200.000",
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final result = analyzeResult();

    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        title: const Text(
          "Hasil Analisa Kulit 💗",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Judul hasil
            Text(
              result["title"]!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Appcolor.textBrownSoft,
              ),
            ),

            const SizedBox(height: 16),

            // Deskripsi masalah kulit
            Text(
              result["desc"]!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Appcolor.textBrownSoft.withOpacity(.8),
              ),
            ),

            const SizedBox(height: 32),

            // Rekomendasi Treatment Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Appcolor.textBrownLight.withOpacity(.25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    result["recommend"]!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Appcolor.button1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    result["price"]!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Appcolor.textBrownSoft,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Tombol Book Now
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Bookingpage(
                      treatmentName: result["recommend"]!,
                      treatmentPrice: result["price"]!,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolor.button1,
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                "Book Treatment Sekarang ✨",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
