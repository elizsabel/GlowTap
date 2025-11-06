import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/views/booking/bookingpage.dart';

class DetailTreatmentPage extends StatelessWidget {
  final Map<String, dynamic> data;
  const DetailTreatmentPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    //  Fallback aman
    // final List<dynamic> benefits =
    data["benefit"] is List ? data["benefit"] : ["Tidak ada informasi manfaat"];
    final String duration = data["duration"] ?? "±45 menit";
    final String painLevel = data["painLevel"] ?? "Ringan";

    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        centerTitle: true,
        title: Text(
          data["title"],
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(data["emoji"], style: const TextStyle(fontSize: 78)),
            const SizedBox(height: 16),

            Text(
              data["title"],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Appcolor.textBrownSoft,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              data["description"],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Appcolor.textBrownSoft.withOpacity(.75),
              ),
            ),

            const SizedBox(height: 30),

            // DETAIL
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.fromBorderSide(
                  BorderSide(color: Appcolor.textBrownLight.withOpacity(.25)),
                ),
              ),
              child: Text(
                data["detail"],
                style: TextStyle(
                  color: Appcolor.textBrownSoft.withOpacity(.9),
                  height: 1.45,
                  fontSize: 14,
                ),
              ),
            ),

            const SizedBox(height: 26),

            // BENEFIT  Fallback aman
            // Container(
            //   width: double.infinity,
            //   padding: const EdgeInsets.all(18),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(18),
            //     border: Border.fromBorderSide(BorderSide(color: Appcolor.textBrownLight.withOpacity(.25))),
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text("Manfaat 🌸",
            //           style: TextStyle(
            //             fontSize: 17,
            //             fontWeight: FontWeight.w600,
            //             color: Appcolor.textBrownSoft,
            //           )),
            //       const SizedBox(height: 8),
            //       ...benefits.map((item) => Padding(
            //             padding: const EdgeInsets.only(bottom: 4),
            //             child: Text("• $item",
            //                 style: TextStyle(
            //                   fontSize: 14,
            //                   color: Appcolor.textBrownSoft.withOpacity(.9),
            //                 )),
            //           )),
            //     ],
            //   ),
            // ),

            // const SizedBox(height: 26),

            // DURATION 
            _infoBox("Durasi Treatment", duration),

            const SizedBox(height: 26),

            // PAINLEVEL 
            _infoBox("Tingkat Rasa Sakit", painLevel),

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
                    data["price"],
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

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Bookingpage(
                      treatmentName: data["title"],
                      treatmentPrice: data["price"],
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
        border: Border.fromBorderSide(BorderSide()),
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
