import 'package:flutter/material.dart';
import 'package:glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/database/page_transition.dart';
import 'package:glowtap/glowtap/model/customer_model.dart';
import 'package:glowtap/glowtap/preferences/preference_handler.dart';
import 'package:glowtap/glowtap/view_customer/bookingpage.dart';
import 'package:glowtap/glowtap/view_customer/detailtreatmentpage.dart';
import 'package:glowtap/glowtap/view_customer/journalpage.dart';
import 'package:glowtap/glowtap/view_customer/skinanalyzer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CustomerModel? user; // Menyimpan data user yang sedang login

  @override
  void initState() {
    super.initState();
    loadUser(); // Memanggil fungsi untuk mengambil data user tersimpan
  }

  void loadUser() async {
    // Mengambil data user dari SharedPreferences
    user = await PreferenceHandler.getUser();
    setState(() {}); // Update UI ketika data user sudah didapat
  }

  // Data dummy treatment yang ditampilkan di homepage
  final List<Map<String, dynamic>> treatmentData = [
    {
      "emoji": "🧬",
      "title": "DNA Salmon Injection",
      "description": "Regenerasi kulit untuk wajah kenyal & cerah",
      "detail": "DNA Salmon Injection menggunakan ekstrak DNA salmon.",
      "price": "Rp 850.000",
    },
    {
      "emoji": "💧",
      "title": "Profhilo Skin Booster",
      "description": "Hidrasi mendalam yang bikin glowing maksimal",
      "detail": "Profhilo mengandung HA konsentrasi tinggi.",
      "price": "Rp 3.200.000",
    },
    {
      "emoji": "🌱",
      "title": "Rejuran Healing",
      "description": "Memperbaiki tekstur & memperkuat skin barrier",
      "detail": "Rejuran menggunakan polynucleotide.",
      "price": "Rp 1.950.000",
    },
    {
      "emoji": "🎀",
      "title": "Botox Anti-Wrinkle",
      "description": "Kurangi garis halus & kerutan",
      "detail": "Botox merilekskan otot penyebab kerutan.",
      "price": "Rp 1.200.000 / area",
    },
  ];

  // Navigasi ke halaman detail treatment
  void goToDetail(Map<String, dynamic> t) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailTreatmentPage(data: t)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero, // Agar konten mulai dari paling atas
          children: [
            // Bagian Header (sapaan user)
            Container(
              padding: const EdgeInsets.fromLTRB(24, 30, 24, 28),
              decoration: BoxDecoration(
                color: Appcolor.button1, // Warna soft pink
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Selamat Datang 💗",
                    style: TextStyle(color: Colors.white.withOpacity(.9)),
                  ),
                  const SizedBox(height: 6),
                  // Jika user login → tampilkan nama, jika tidak → tampilkan "Glowers"
                  Text(
                    user != null ? "Hai, ${user!.name} ✨" : "Hai, Glowers ✨",
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "Siap glowing hari ini?",
                    style: TextStyle(color: Colors.white.withOpacity(.9)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Menu Skin Analyzer & Journal Skin
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: _featureCard(
                      icon: "🔍",
                      label: "Skin Analyzer",
                      onTap: () => Navigator.push(
                        context,
                        softTransition(const SkinAnalyzerPage()),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _featureCard(
                      icon: "📔",
                      label: "Journal Skin",
                      onTap: () => Navigator.push(
                        context,
                        softTransition(const JournalPage()),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Judul Section Treatment
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Treatment Populer ✨",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Appcolor.textBrownSoft,
                ),
              ),
            ),

            const SizedBox(height: 14),

            // List treatment berbentuk kartu scroll horizontal
            SizedBox(
              height: 300, // Tinggi list card
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(), // Scroll lebih lembut
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: treatmentData.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: 16), // Jarak antar card
                itemBuilder: (_, i) => TreatmentCard(
                  data: treatmentData[i],
                  onDetail: () => goToDetail(treatmentData[i]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget kecil untuk tombol fitur
  Widget _featureCard({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap, // Klik → pindah halaman
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Appcolor.textBrownLight.withOpacity(.25)),
        ),
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 36)),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Appcolor.textBrownSoft,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget Card Treatment
class TreatmentCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onDetail;

  const TreatmentCard({super.key, required this.data, required this.onDetail});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230, // Lebar card
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
          Text(
            data["emoji"],
            style: const TextStyle(fontSize: 48),
          ), // Emoji icon besar
          const SizedBox(height: 14),

          Text(
            data["title"], // Nama treatment
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Appcolor.textBrownSoft,
            ),
          ),

          const SizedBox(height: 8),

          // Deskripsi treatment maksimal 3 baris
          Text(
            data["description"],
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              color: Appcolor.textBrownSoft.withOpacity(.75),
              height: 1.3,
            ),
          ),

          const Spacer(),

          // Harga + tombol detail
          Row(
            children: [
              Expanded(
                child: Text(
                  data["price"],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Appcolor.textBrownSoft,
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: onDetail,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  foregroundColor: Appcolor.button1,
                  side: BorderSide(color: Appcolor.button1),
                  minimumSize: const Size(0, 32),
                ),
                child: const Text("Detail", style: TextStyle(fontSize: 13)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


