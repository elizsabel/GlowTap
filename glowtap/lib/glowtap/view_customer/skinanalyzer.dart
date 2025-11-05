import 'package:flutter/material.dart';
import 'package:glowtap/constant/appcolor.dart';

class SkinAnalyzerPage extends StatefulWidget {
  const SkinAnalyzerPage({super.key});

  @override
  State<SkinAnalyzerPage> createState() => _SkinAnalyzerPageState();
}

class _SkinAnalyzerPageState extends State<SkinAnalyzerPage> {
  int currentQuestion = 0;
  String? selectedAnswer;

  final List<Map<String, dynamic>> questions = [
    {
      "q": "Bagaimana kondisi kulitmu saat bangun pagi?",
      "a": [
        "Cenderung berminyak",
        "Kering & terasa ketarik",
        "Normal & lembut",
        "Zona T berminyak, pipi kering"
      ]
    },
    {
      "q": "Bagaimana kulitmu bereaksi setelah memakai skincare baru?",
      "a": [
        "Mudah jerawatan",
        "Cepat kering/iritasi",
        "Tidak ada reaksi berarti",
        "T-zone berminyak tapi pipi baik"
      ]
    },
    {
      "q": "Bagaimana tampilan pori-pori wajahmu?",
      "a": [
        "Besar & terlihat jelas",
        "Sangat kecil hampir tidak terlihat",
        "Normal & tidak mengganggu",
        "Besar hanya di area hidung/dahi"
      ]
    }
  ];

  Map<String, String> skinResults = {
    "Cenderung berminyak": "Kulit Berminyak 🍩",
    "Kering & terasa ketarik": "Kulit Kering 🧁",
    "Normal & lembut": "Kulit Normal 🍑",
    "Zona T berminyak, pipi kering": "Kulit Kombinasi 🍓",
  };

  void submit() {
    if (selectedAnswer == null) return;
    String result = skinResults[selectedAnswer!] ?? "Kulit Normal 🍑";

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SkinResultPage(result: result)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = questions[currentQuestion];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Skin Analyzer 🧸✨",
          style: TextStyle(
            color: Appcolor.textBrownSoft,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Pertanyaan
            Text(
              now["q"],
              style: TextStyle(
                color: Appcolor.textBrownSoft,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 22),

            // Pilihan Jawaban
            ...now["a"].map<Widget>((option) {
              return GestureDetector(
                onTap: () => setState(() => selectedAnswer = option),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  decoration: BoxDecoration(
                    color: selectedAnswer == option
                        ? const Color(0xFFFFC6D9)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: selectedAnswer == option
                          ? const Color(0xFFFF8CB8)
                          : Colors.pink.shade100,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.shade100.withOpacity(.4),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    "💕 $option",
                    style: TextStyle(
                      color: Appcolor.textBrownSoft,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }).toList(),

            const Spacer(),

            // Tombol lanjut
            ElevatedButton(
              onPressed: submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF8CB8),
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                "Lihat Hasil ✨",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======== HALAMAN HASIL ========

class SkinResultPage extends StatelessWidget {
  final String result;
  const SkinResultPage({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    Map<String, String> tips = {
      "Kulit Berminyak 🍩":
          "Gunakan moisturizer gel + sunscreen matte 🍃\nHindari scrub berlebihan yaa 💗",
      "Kulit Kering 🧁":
          "Prioritaskan hydrating toner + ceramide 💧\nGunakan sunscreen creamy 🤍",
      "Kulit Normal 🍑":
          "Pertahankan rutinitas skincare, cukup hidrasi ✨",
      "Kulit Kombinasi 🍓":
          "Gunakan moisturizer berbeda untuk T-zone & pipi 🌸",
    };

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Hasil Analisa 🪞"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              result,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Color(0xFFFF8CB8),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.pink.shade100),
              ),
              child: Text(
                tips[result]!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Appcolor.textBrownSoft,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
