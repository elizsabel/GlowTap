import 'package:flutter/material.dart';
import 'package:glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/database/page_transition.dart';
import 'package:glowtap/glowtap/view_customer/bookingpage.dart';
import 'package:glowtap/glowtap/view_customer/detailtreatmentpage.dart';
import 'package:glowtap/glowtap/view_customer/pililokasipage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedLocation;

  final List<Map<String, dynamic>> treatmentData = [
    {
      "emoji": "🧬",
      "title": "DNA Salmon Injection",
      "description": "Regenerasi kulit dengan DNA salmon untuk wajah kenyal & cerah",
      "detail":
      "DNA Salmon Injection adalah treatment peremajaan kulit yang menggunakan ekstrak DNA dari ikan salmon. Kandungan ini membantu mempercepat regenerasi sel, meningkatkan kelembapan, dan memperbaiki tekstur kulit secara alami. Hasil yang dirasakan adalah kulit yang lebih halus, glowing, dan sehat dari dalam.",
      "benefit": [
      "Meningkatkan kelembapan kulit",
      "Mencerahkan warna kulit yang kusam",
      "Meregenerasi jaringan kulit",
      "Membantu meratakan tekstur & pori-pori"
      ],
      "duration": "45 - 60 menit",
      "painLevel": "2/5 (Rasa ringan, ditangani dengan anestesi)",
      "price": "Rp 850.000",
    },
    {
      "emoji": "💧",
      "title": "Profhilo Skin Booster",
      "description": "Hidrasi mendalam dengan HA untuk kulit glowing maksimal",
      "detail":
      "Profhilo adalah skin booster premium yang mengandung konsentrasi tinggi Hyaluronic Acid. Treatment ini memberikan hidrasi intens yang menyebar ke seluruh lapisan kulit, sehingga meningkatkan elastisitas dan memberikan efek plumpy glow yang alami.",
      "benefit": [
      "Kulit tampak glowing alami",
      "Meningkatkan elastisitas & kekencangan kulit",
      "Mengurangi garis halus",
      "Membuat kulit terasa lebih lembut dan kenyal"
      ],
      "duration": "45 menit",
      "painLevel": "3/5 (Nyeri ringan pada beberapa titik suntikan)",
      "price": "Rp 3.200.000",
    },
    {
      "emoji": "🌱",
      "title": "Rejuran Healing",
      "description": "Perbaiki tekstur & pori-pori dengan PN (Polynucleotide)",
      "detail":
      "Rejuran Healing menggunakan polynucleotide yang berfungsi memperbaiki sel-sel kulit dan memperkuat skin barrier. Sangat cocok untuk kulit yang rusak akibat jerawat atau iritasi. Hasilnya adalah kulit yang lebih halus, bersih, dan sehat.",
      "benefit": [
      "Memperbaiki bekas jerawat dan bopeng",
      "Menghaluskan tekstur kulit",
      "Memperkecil tampilan pori-pori",
      "Mengurangi inflamasi dan memperkuat skin barrier"
      ],
      "duration": "45 - 60 menit",
      "painLevel": "3/5 (Nyeri ringan – sedang, tergantung sensitivitas kulit)",
      "price": "Rp 1.950.000",
    },
    {
      "emoji": "🎀",
      "title": "Botox Anti-Wrinkle",
      "description": "Kurangi garis halus & kerutan untuk tampilan awet muda",
      "detail":
      "Botox bekerja dengan merilekskan otot yang menyebabkan kerutan pada wajah. Treatment ini memberikan tampilan yang lebih halus, muda, dan segar tanpa mengubah bentuk alami wajah.",
      "benefit": [
      "Mengurangi kerutan & garis senyum",
      "Wajah tampak lebih muda & segar",
      "Mencegah kerutan bertambah dalam",
      "Hasil terlihat cepat dalam beberapa hari"
      ],
      "duration": "20 - 30 menit",
      "painLevel": "1/5 (Sangat ringan, hampir tidak terasa)",
      "price": "Rp 1.200.000 / area",
    },
  ];

  void goToBooking(Map<String, dynamic> t) {
    Navigator.push(
      context,
      softTransition(BookingPage(
          treatmentName: t["title"],
          treatmentPrice: t["price"],
        ),
      ),
    );
  }

  void goToDetail(Map<String, dynamic> t) {
    Navigator.push(
      context,
      softTransition(DetailTreatmentPage(data: t),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [

            // ===== HEADER =====
            Container(
              padding: const EdgeInsets.fromLTRB(24, 30, 24, 28),
              decoration: BoxDecoration(
                color: Appcolor.button1,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Selamat Datang 💗", style: TextStyle(color: Colors.white.withOpacity(0.9))),
                  const SizedBox(height: 4),
                  const Text("Hai, Elizsabel ✨", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700)),
                  Text("Siap glowing hari ini?", style: TextStyle(color: Colors.white.withOpacity(0.9))),
                  const SizedBox(height: 18),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Cari treatment yang kamu inginkan...",
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                      prefixIcon: const Icon(Icons.search, color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // ===== PILIH LOKASI =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: InkWell(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    softTransition(PilihLokasiPage()),
                  );
                  if (result != null) setState(() => selectedLocation = result);
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Appcolor.textBrownLight.withOpacity(.3)),
                  ),
                  child: Row(
                    children: [
                      const Text("📍", style: TextStyle(fontSize: 20)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          selectedLocation ?? "Pilih lokasi rumah Anda",
                          style: TextStyle(color: Appcolor.textBrownSoft, fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ===== TITLE =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text("Treatment Populer ✨",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Appcolor.textBrownSoft)),
            ),

            const SizedBox(height: 14),

            // ===== CARD LIST =====
            SizedBox(
              height: 330,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: treatmentData.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (_, i) {
                  final t = treatmentData[i];
                  return TreatmentCard(
                    data: t,
                    onDetail: () => goToDetail(t),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // ===== EDUKASI =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text("Tips Kecantikan Hari Ini 🌷",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Appcolor.textBrownSoft)),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Appcolor.textBrownLight.withOpacity(.25)),
                ),
                child: const Text(
                  "✨ Minum air putih cukup & jangan lupa sunscreen setiap hari!\nSkincare bukan keajaiban, tapi kebiasaan 💕",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// ===== CARD COMPONENT =====
class TreatmentCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onDetail;
  
  const TreatmentCard({
    super.key,
    required this.data,
    required this.onDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Appcolor.textBrownLight.withOpacity(.25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data["emoji"], style: const TextStyle(fontSize: 52)),
          const SizedBox(height: 14),
          Text(data["title"], style: TextStyle(color: Appcolor.textBrownSoft, fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text(data["description"], maxLines: 3, overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Appcolor.textBrownSoft.withOpacity(.7))),
          const Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(data["price"], style: TextStyle(color: Appcolor.textBrownSoft, fontWeight: FontWeight.w700)),

              Column(
                children: [
                  OutlinedButton(
                    onPressed: onDetail,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Appcolor.button1,
                      side: BorderSide(color: Appcolor.button1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    ),
                    child: const Text("Detail"),
                  ),
                  const SizedBox(height: 6),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
