import 'package:flutter/material.dart';
// import 'package:glowtap/glowtap/booking_custglow.dart';
import 'package:glowtap/glowtap/view_customer/pilihdokterpage.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Map<String, dynamic>> treatmentData = [
    {
      "icon": Icons.water_drop,
      "title": "DNA Salmon Injection",
      "description":
          "Regenerasi kulit dengan DNA salmon untuk wajah lebih kenyal dan cerah",
      "price": "Rp 850.000",
    },
    {
      "icon": Icons.spa,
      "title": "Profhilo Skin Booster",
      "description":
          "Hidrasi mendalam dengan hyaluronic acid untuk kulit glowing maksimal",
      "price": "Rp 3.200.000",
    },
    {
      "icon": Icons.health_and_safety_outlined,
      "title": "Rejuran Healing",
      "description":
          "Perbaikan tekstur kulit dan pori-pori dengan PN (Polynucleotide)",
      "price": "Rp 1.950.000",
    },
    {
      "icon": Icons.brush,
      "title": "Botox Anti-Wrinkle",
      "description":
          "Hilangkan garis halus dan kerutan untuk tampilan awet muda",
      "price": "Rp 1.200.000 / area",
    },
  ];

  void handleBooking(BuildContext context, String name) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PilihDokterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6EDEB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // HEADER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                decoration: const BoxDecoration(
                  color: Color(0xFFE8A8A1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selamat Datang",
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Hai, Elizsabel ✨",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Siap glowing hari ini?",
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // TITLE
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Treatment Populer",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF5A4A48),
                      ),
                    ),
                    Text(
                      "Dipercaya oleh ribuan wanita Indonesia",
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 15,
                        color: const Color(0xFF5A4A48).withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // SCROLL LIST
              SizedBox(
                height: 320,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: treatmentData.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 14),
                  itemBuilder: (context, i) {
                    final t = treatmentData[i];
                    return TreatmentCard(
                      icon: t["icon"],
                      title: t["title"],
                      description: t["description"],
                      price: t["price"],
                      onBooking: () => handleBooking(context, t["title"]),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // INFO CARD
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6EDEB),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text(
                      "💉 Treatment oleh Dokter Profesional",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF5A4A48),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Semua dokter kami telah tersertifikasi dan berpengalaman",
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 14,
                        color: const Color(0xFF5A4A48).withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

/// ========================================
/// TREATMENT CARD COMPONENT
/// ========================================
class TreatmentCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String price;
  final VoidCallback onBooking;

  const TreatmentCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.price,
    required this.onBooking,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 52, color: const Color(0xFF5A4A48)),
          const SizedBox(height: 14),

          Text(
            title,
            style: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: "Nunito",
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),

          const Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE8A8A1),
                  foregroundColor: const Color(0xFF5A4A48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: onBooking,
                child: const Text("Book"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
