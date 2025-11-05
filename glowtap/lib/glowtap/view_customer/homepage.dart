import 'package:flutter/material.dart';
import 'package:glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/database/page_transition.dart';
import 'package:glowtap/glowtap/view_customer/bookingpage.dart';
import 'package:glowtap/glowtap/view_customer/detailtreatmentpage.dart';
import 'package:glowtap/glowtap/view_customer/pililokasipage.dart';
import 'package:glowtap/glowtap/preferences/preference_handler.dart';
import 'package:glowtap/glowtap/model/customer_model.dart';
import 'package:glowtap/glowtap/view_customer/skinanalyzer.dart';
import 'package:glowtap/glowtap/view_customer/journalpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CustomerModel? user;
  String? selectedLocation;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    user = await PreferenceHandler.getUser();
    setState(() {});
  }

  final List<Map<String, dynamic>> treatmentData = [
    {
      "emoji": "🧬",
      "title": "DNA Salmon Injection",
      "description":
          "Regenerasi kulit dengan DNA salmon untuk wajah kenyal & cerah",
      "detail":
          "DNA Salmon Injection menggunakan ekstrak DNA salmon untuk regenerasi kulit.",
      "price": "Rp 850.000",
    },
    {
      "emoji": "💧",
      "title": "Profhilo Skin Booster",
      "description":
          "Hidrasi mendalam dengan HA untuk kulit glowing maksimal",
      "detail":
          "Profhilo mengandung HA konsentrasi tinggi untuk hidrasi intens.",
      "price": "Rp 3.200.000",
    },
    {
      "emoji": "🌱",
      "title": "Rejuran Healing",
      "description": "Memperbaiki tekstur & memperkuat skin barrier",
      "detail":
          "Rejuran menggunakan polynucleotide untuk memperbaiki struktur kulit.",
      "price": "Rp 1.950.000",
    },
    {
      "emoji": "🎀",
      "title": "Botox Anti-Wrinkle",
      "description":
          "Kurangi garis halus & kerutan untuk tampilan awet muda",
      "detail":
          "Botox bekerja merilekskan otot penyebab kerutan di wajah.",
      "price": "Rp 1.200.000 / area",
    },
  ];

  void goToBooking(Map<String, dynamic> t) {
    Navigator.push(
      context,
      softTransition(
        BookingPage(treatmentName: t["title"], treatmentPrice: t["price"]),
      ),
    );
  }

  void goToDetail(Map<String, dynamic> t) {
    Navigator.push(
      context,
      softTransition(
        DetailTreatmentPage(data: t),
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
            // HEADER
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
                  Text("Selamat Datang 💗",
                      style: TextStyle(
                        color: Colors.white.withOpacity(.9),
                      )),
                  const SizedBox(height: 6),
                  Text(
                    user != null ? "Hai, ${user!.name} ✨" : "Hai, Glowers ✨",
                    style: const TextStyle(
                        fontSize: 24, color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  Text("Siap glowing hari ini?",
                      style: TextStyle(color: Colors.white.withOpacity(.9))),
                  const SizedBox(height: 18),

                  TextField(
                    decoration: InputDecoration(
                      hintText: "Cari treatment yang kamu inginkan...",
                      hintStyle: TextStyle(color: Colors.white.withOpacity(.8)),
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

            const SizedBox(height: 20),

            // SKIN ANALYZER & JOURNAL
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: _featureCard(
                      icon: "🔍",
                      label: "Skin Analyzer",
                      onTap: () => Navigator.push(context, softTransition(const SkinAnalyzerPage())),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _featureCard(
                      icon: "📔",
                      label: "Journal Skin",
                      onTap: () => Navigator.push(context, softTransition(const JournalPage())),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // PILIH LOKASI
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: InkWell(
                onTap: () async {
                  final result = await Navigator.push(context, softTransition(const PilihLokasiPage()));
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
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Appcolor.textBrownSoft),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // TITLE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text("Treatment Populer ✨",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Appcolor.textBrownSoft)),
            ),

            const SizedBox(height: 14),

            // CARD LIST
            SizedBox(
              height: 320,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: treatmentData.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (_, i) => TreatmentCard(
                  data: treatmentData[i],
                  onDetail: () => goToDetail(treatmentData[i]),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // EDUKASI
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  "✨ Minum air putih cukup & jangan lupa sunscreen setiap hari!\nSkincare bukan keajaiban, tapi kebiasaan 💕",
                  style: TextStyle(fontSize: 14, color: Appcolor.textBrownSoft),
                ),
              ),
            ),

            const SizedBox(height: 42),
          ],
        ),
      ),
    );
  }

  Widget _featureCard({required String icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
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
            Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Appcolor.textBrownSoft)),
          ],
        ),
      ),
    );
  }
}

// CARD COMPONENT
class TreatmentCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onDetail;

  const TreatmentCard({super.key, required this.data, required this.onDetail});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
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
          Text(data["emoji"], style: const TextStyle(fontSize: 50)),
          const SizedBox(height: 14),
          Text(data["title"],
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Appcolor.textBrownSoft)),
          const SizedBox(height: 6),
          Text(
            data["description"],
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Appcolor.textBrownSoft.withOpacity(.7),
                height: 1.3),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(data["price"],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Appcolor.textBrownSoft)),
              OutlinedButton(
                onPressed: onDetail,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Appcolor.button1,
                  side: BorderSide(color: Appcolor.button1),
                ),
                child: const Text("Detail"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
