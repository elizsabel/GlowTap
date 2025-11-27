import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/firebase/constant/appcolor.dart';
import 'package:glowtap/glowtap/firebase/views/booking_firebase/booking_firebasepage.dart';

class DetailFirebaseTreatmentPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailFirebaseTreatmentPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        centerTitle: true,
        title: const Text(
          "Detail Treatment",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(data["emoji"] ?? "✨", style: const TextStyle(fontSize: 78)),

            const SizedBox(height: 16),

            Text(
              data["title"] ?? "-",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Appcolor.textBrownSoft,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              data["description"] ?? "-",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Appcolor.textBrownSoft.withOpacity(.75),
              ),
            ),

            const SizedBox(height: 30),

            // DETAIL
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Appcolor.textBrownLight.withOpacity(.25),
                ),
              ),
              child: Text(
                data["detail"] ?? "-",
                style: TextStyle(
                  color: Appcolor.textBrownSoft.withOpacity(.9),
                  height: 1.45,
                  fontSize: 14,
                ),
              ),
            ),

            const SizedBox(height: 26),
            _infoBox("Durasi Treatment", data["duration"] ?? "-"),
            const SizedBox(height: 26),
            _infoBox("Tingkat Rasa Sakit", data["painLevel"] ?? "-"),
            const SizedBox(height: 26),

            // PRICE BOX
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Appcolor.button1.withOpacity(0.45),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  Text(
                    "Harga Treatment",
                    style: TextStyle(color: Appcolor.textBrownSoft),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    data["price"] ?? "-",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Appcolor.button1,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // BOOKING BUTTON
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookingFirebasePage(
                      treatmentName: data["title"] ?? "-",
                      treatmentPrice: data["price"] ?? "-",
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolor.button1,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                "Book Treatment Sekarang ✨",
                style: TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _infoBox(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Appcolor.textBrownLight.withOpacity(.25)),
      ),
      child: Text(
        "$label : $value",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Appcolor.textBrownSoft,
        ),
      ),
    );
  }
}
