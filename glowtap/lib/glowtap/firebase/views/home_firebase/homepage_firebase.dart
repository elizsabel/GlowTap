import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/firebase/constant/appcolor.dart';
import 'package:glowtap/glowtap/firebase/models_firebase/userfirebasemodelpage.dart';
import 'package:glowtap/glowtap/firebase/preference_firebase/preference_handler_firebase.dart';
import 'package:glowtap/glowtap/firebase/views/booking_firebase/detail_firebasepage.dart';
import 'package:glowtap/glowtap/firebase/views/analyzer/skinanalyzer.dart';
import 'package:glowtap/glowtap/firebase/views/journal_firebase/journalfirebasepage.dart';

class HomePageFirebase extends StatefulWidget {
  const HomePageFirebase({super.key});

  @override
  State<HomePageFirebase> createState() => _HomePageFirebaseState();
}

class _HomePageFirebaseState extends State<HomePageFirebase> {
  UserFirebaseModel? user;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    user = await PreferenceHandlerFirebase.getUserFirebase();
    if (mounted) setState(() {});
  }

  final List<Map<String, dynamic>> treatmentData = [
    {
      "emoji": "🧬",
      "title": "DNA Salmon Injection",
      "description": "Regenerasi kulit untuk wajah kenyal & cerah",
      "detail":
          "DNA Salmon Injection adalah treatment regenerasi kulit yang menggunakan ekstrak DNA ikan salmon...",
      "duration": "±45 menit",
      "painLevel": "Ringan",
      "price": "Rp 850.000",
    },
    {
      "emoji": "💧",
      "title": "Profhilo Skin Booster",
      "description": "Hidrasi mendalam yang bikin glowing maksimal",
      "detail":
          "Profhilo adalah skin booster premium dengan Hyaluronic Acid...",
      "duration": "±45 menit",
      "painLevel": "Ringan",
      "price": "Rp 3.200.000",
    },
    {
      "emoji": "🌱",
      "title": "Rejuran Healing",
      "description": "Memperbaiki tekstur kulit & barrier",
      "detail":
          "Rejuran menggunakan PN dari DNA salmon, membantu regenerasi kulit...",
      "duration": "±40 menit",
      "painLevel": "Ringan – Sedang",
      "price": "Rp 1.950.000",
    },
    {
      "emoji": "🎀",
      "title": "Botox Anti-Wrinkle",
      "description": "Kurangi garis halus & kerutan",
      "detail":
          "Botox merilekskan otot wajah sehingga garis ekspresi berkurang...",
      "duration": "±20 menit",
      "painLevel": "Ringan",
      "price": "Rp 1.200.000 / area",
    },
  ];

  void goToDetail(Map<String, dynamic> t) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailFirebaseTreatmentPage(data: t),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        backgroundColor: Color(0xFFFFF6FA),
        body: Center(
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
                  Text(
                    "Selamat Datang 💗",
                    style: TextStyle(color: Colors.white.withOpacity(.9)),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Hai, ${user!.name ?? "GlowTap User"} ✨",
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

            // MENU CEPAT
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
                            builder: (_) => JournalFirebasePage(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // TITLE TREATMENT
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

            // LIST TREATMENT
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  foregroundColor: Appcolor.button1,
                  side: BorderSide(color: Appcolor.button1),
                  minimumSize: const Size(0, 32),
                ),
                child: const Text(
                  "Detail",
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
