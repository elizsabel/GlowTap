import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/model/customermodelpage.dart';
import 'package:glowtap/glowtap/views/booking/detailtreatmentpage.dart';
import 'package:glowtap/glowtap/views/journal/journalpage.dart';
import 'package:glowtap/glowtap/views/analyzer/skinanalyzer.dart';
import 'package:glowtap/glowtap/preferences/preference_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CustomerModel? user;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    user = await PreferenceHandler.getUser();
    if (mounted) setState(() {});
  }

  final List<Map<String, dynamic>> treatmentData = [
    {
      "emoji": "🧬",
      "title": "DNA Salmon Injection",
      "description": "Regenerasi kulit untuk wajah kenyal & cerah",
      "detail":
          "DNA Salmon Injection adalah treatment regenerasi kulit yang menggunakan ekstrak DNA ikan salmon yang kaya polinukleotida. "
          "Membantu memperbaiki jaringan kulit, meningkatkan kolagen, memperbaiki tekstur, dan mengatasi bekas jerawat.",
      "price": "Rp 850.000",
    },
    {
      "emoji": "💧",
      "title": "Profhilo Skin Booster",
      "description": "Hidrasi mendalam yang bikin glowing maksimal",
      "detail":
          "Profhilo adalah skin booster premium dengan Hyaluronic Acid konsentrasi tinggi — hidrasi, tightening, dan glass skin effect.",
      "price": "Rp 3.200.000",
    },
    {
      "emoji": "🌱",
      "title": "Rejuran Healing",
      "description": "Memperbaiki tekstur kulit & barrier",
      "detail":
          "Rejuran menggunakan PN dari DNA salmon, membantu regenerasi kulit, memperbaiki pori, dan mengurangi redness.",
      "price": "Rp 1.950.000",
    },
    {
      "emoji": "🎀",
      "title": "Botox Anti-Wrinkle",
      "description": "Kurangi garis halus & kerutan",
      "detail":
          "Botox merilekskan otot wajah sehingga garis ekspresi berkurang namun tetap terlihat natural.",
      "price": "Rp 1.200.000 / area",
    },
  ];

  void goToDetail(Map<String, dynamic> t) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailTreatmentPage(data: t)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFFFF6FA),
        body: const Center(
          child: CircularProgressIndicator(color: Colors.pink),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // -----------------------------
            // HEADER
            // -----------------------------
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
                  Text(
                    "Selamat Datang 💗",
                    style: TextStyle(color: Colors.white.withOpacity(.9)),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Hai, ${user!.name} ✨",
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

            // -----------------------------
            // FITUR CEPAT
            // -----------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: _featureCard(
                      icon: "🔍",
                      label: "Analisis Kulit",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SkinAnalyzerPage(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _featureCard(
                      icon: "📔",
                      label: "Jurnal Kulit",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const JournalPage(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // -----------------------------
            // TREATMENT POPULER
            // -----------------------------
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

            SizedBox(
              height: 300,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: treatmentData.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (_, i) {
                  return TreatmentCard(
                    data: treatmentData[i],
                    onDetail: () => goToDetail(treatmentData[i]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _featureCard({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
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

class TreatmentCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onDetail;

  const TreatmentCard({super.key, required this.data, required this.onDetail});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
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
          Text(data["emoji"], style: const TextStyle(fontSize: 48)),
          const SizedBox(height: 14),
          Text(
            data["title"],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Appcolor.textBrownSoft,
            ),
          ),
          const SizedBox(height: 8),
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
