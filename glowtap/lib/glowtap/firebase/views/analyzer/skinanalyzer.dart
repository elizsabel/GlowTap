import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/firebase/constant/appcolor.dart';

class SkinAnalyzerPage extends StatefulWidget {
  const SkinAnalyzerPage({super.key});

  @override
  State<SkinAnalyzerPage> createState() => _SkinAnalyzerPageState();
}

class _SkinAnalyzerPageState extends State<SkinAnalyzerPage> {
  int questionIndex = 0;
  List<String> answers = [];

  final List<Map<String, dynamic>> questions = [
    {
      "q": "Bagaimana kondisi kulitmu saat bangun tidur?",
      "options": [
        "Kering & terasa ketarik",
        "Normal saja",
        "Berminyak di T-zone",
        "Berminyak seluruh wajah",
      ],
    },
    {
      "q": "Apa masalah utama yang kamu rasakan saat ini?",
      "options": [
        "Kulit kusam",
        "Berjerawat",
        "Pori besar",
        "Garis halus / aging",
      ],
    },
    {
      "q": "Seberapa sering kamu menggunakan sunscreen?",
      "options": ["Setiap hari", "Kadang-kadang", "Jarang", "Tidak pernah"],
    },
  ];

  // Tentukan hasil berdasarkan jawaban nomor 1
  String getResultType() {
    switch (answers[0]) {
      case "Kering & terasa ketarik":
        return "Kering";
      case "Normal saja":
        return "Normal";
      case "Berminyak di T-zone":
        return "Kombinasi";
      default:
        return "Berminyak";
    }
  }

  // Rekomendasi treatment GlowTap
  String getRecommendation() {
    switch (getResultType()) {
      case "Kering":
        return "✨ Profhilo Skin Booster";
      case "Normal":
        return "🧬 DNA Salmon Injection";
      case "Kombinasi":
        return "🌱 Rejuran Healer";
      default:
        return "🎀 Botox Micro Toxin (Glow Botox)";
    }
  }

  void showResult() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "✨ Hasil Skin Analyzer ✨",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Appcolor.button1,
                ),
              ),
              const SizedBox(height: 14),

              Text(
                "Jenis Kulitmu: ${getResultType()}",
                style: TextStyle(
                  fontSize: 16,
                  color: Appcolor.textBrownSoft,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Appcolor.softPinkPastel,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  "Rekomendasi Treatment:\n${getRecommendation()}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Appcolor.button1,
                  ),
                ),
              ),

              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolor.button1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    "Oke, mengerti 💗",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void selectAnswer(String answer) {
    answers.add(answer);

    if (questionIndex < questions.length - 1) {
      setState(() => questionIndex++);
    } else {
      showResult();
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = questions[questionIndex];

    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Appcolor.button1,
        centerTitle: true,
        title: const Text(
          "Skin Analyzer",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pertanyaan ${questionIndex + 1} dari ${questions.length}",
              style: TextStyle(color: Appcolor.textBrownSoft),
            ),
            const SizedBox(height: 18),

            // CARD PERTANYAAN
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                data["q"],
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Appcolor.textBrownSoft,
                ),
              ),
            ),

            const SizedBox(height: 22),

            // LIST PILIHAN
            ...data["options"].map<Widget>((opt) {
              return Center(
                child: InkWell(
                  onTap: () => selectAnswer(opt),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Appcolor.button1.withOpacity(.3),
                      ),
                    ),
                    child: Text(
                      opt,
                      style: TextStyle(
                        fontSize: 15,
                        color: Appcolor.textBrownSoft,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
