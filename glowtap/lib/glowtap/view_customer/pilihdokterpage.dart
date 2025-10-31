import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/view_customer/pilihjadwalpage.dart';

class PilihDokterPage extends StatefulWidget {
  const PilihDokterPage({super.key});

  @override
  State<PilihDokterPage> createState() => _PilihDokterPageState();
}

class _PilihDokterPageState extends State<PilihDokterPage> {
  String? selectedDoctor;

  final List<Map<String, String>> doctorList = [
    {
      "name": "dr. Citra Anindya",
      "info": "Dokter Estetika | 4 Tahun Pengalaman",
    },
    {
      "name": "dr. Fadhila Ayu",
      "info": "Dokter Kecantikan | Sertifikasi Injector",
    },
    {"name": "dr. Maya Putri", "info": "Estetik & Anti Aging Specialist"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCEDE9),
      appBar: AppBar(
        title: const Text(
          "Pilih Dokter",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFFE8A8A1),
        centerTitle: true,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Dokter Tersedia",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5C4A4A),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: doctorList.length,
                itemBuilder: (context, index) {
                  final doctor = doctorList[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFF0D4CF)),
                    ),
                    child: RadioListTile(
                      activeColor: const Color(0xFFE8A8A1),
                      value: doctor["name"],
                      groupValue: selectedDoctor,
                      onChanged: (value) {
                        setState(() {
                          selectedDoctor = value.toString();
                        });
                      },
                      title: Text(
                        doctor["name"]!,
                        style: const TextStyle(
                          color: Color(0xFF5C4A4A),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        doctor["info"]!,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                        ),
                      ),
                      secondary: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7D7D0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.person_outline,
                          color: Color(0xFF5C4A4A),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedDoctor == null
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PilihJadwalPage(),
                          ),
                        );

                        // → Lanjut halaman Jadwal
                      },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  backgroundColor: const Color(0xFFE8A8A1),
                  disabledBackgroundColor: const Color(0xFFEECFCC),
                ),
                child: const Text(
                  "Lanjutkan",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
