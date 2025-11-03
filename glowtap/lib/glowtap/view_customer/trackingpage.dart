import 'dart:async';
import 'package:flutter/material.dart';
import 'package:glowtap/constant/appcolor.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  double progress = 0.0;
  String status = "Dokter sedang menuju lokasi 🚗";

  // Simulasi perjalanan dokter
  void startTracking() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        progress += 0.1;

        if (progress >= 1.0) {
          progress = 1.0;
          status = "Dokter telah tiba 💗";
          timer.cancel();
        } else if (progress >= 0.6) {
          status = "Dokter hampir sampai 🏡";
        } else if (progress >= 0.10) {
          status = "Dokter dalam perjalanan 🚗";
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTracking();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        title: const Text("Tracking Dokter", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [

            // Ilustrasi Map
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 230,
                      child: Image.asset(
                        "assets/images/map_placeholder.png", // ganti nanti
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Status Text
            Text(
              status,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.w700,
                color: Appcolor.textBrownSoft
              ),
            ),
            const SizedBox(height: 20),

            // Progress Bar
            LinearProgressIndicator(
              value: progress,
              color: Appcolor.button1,
              backgroundColor: Colors.white,
              minHeight: 8,
              borderRadius: BorderRadius.circular(12),
            ),

            const SizedBox(height: 24),

            // Info
            Text(
              "Mohon tunggu ya ✨\nDokter sedang menuju lokasi kamu 💕",
              textAlign: TextAlign.center,
              style: TextStyle(color: Appcolor.textBrownSoft.withOpacity(.8)),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
