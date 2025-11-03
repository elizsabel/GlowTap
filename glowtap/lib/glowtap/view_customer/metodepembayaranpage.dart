import 'package:flutter/material.dart';
import 'package:glowtap/constant/appcolor.dart';

class MetodePembayaranPage extends StatelessWidget {
  final String totalPrice;
  const MetodePembayaranPage({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        centerTitle: true,
        title: const Text(
          "Metode Pembayaran",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Pembayaran",
              style: TextStyle(
                color: Appcolor.textBrownSoft,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              totalPrice,
              style: TextStyle(
                color: Appcolor.textBrownSoft,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            InkWell(
              onTap: () {
                print("== DIPILIH: COD =="); // DEBUG
                Navigator.pop(context, "COD"); // ✅ INI PENTING
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Appcolor.textBrownLight.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.home_outlined,
                      size: 34,
                      color: Appcolor.button1,
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "COD (Bayar di Tempat)",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Appcolor.textBrownSoft,
                          ),
                        ),
                        Text(
                          "Bayar saat treatment dilakukan.",
                          style: TextStyle(
                            fontSize: 12,
                            color: Appcolor.textBrownSoft.withOpacity(.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
