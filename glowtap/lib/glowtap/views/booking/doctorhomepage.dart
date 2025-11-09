import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/dokter/doctormodelpage.dart';
import 'package:glowtap/glowtap/editprofildoctor.dart';
import 'package:glowtap/glowtap/views/booking/doctororderpage.dart';
import 'package:glowtap/glowtap/preferences/preference_handler.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  DoctorModel? doctor;

  @override
  void initState() {
    super.initState();
    loadDoctor();
  }

  void loadDoctor() async {
    doctor = await PreferenceHandler.getDoctor();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        elevation: 0,
        title: const Text("Dashboard Dokter", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              doctor != null ? "Hai, dr. ${doctor!.name} ✨" : "Hai Dokter ✨",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Appcolor.textBrownSoft,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Selamat bertugas & tetap lembut 💗",
              style: TextStyle(color: Appcolor.textBrownSoft.withOpacity(.7)),
            ),

            const SizedBox(height: 30),

            _menuButton("📅 Jadwal & Pesanan", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const DoctorOrdersPage()));
            }),

            const SizedBox(height: 16),

            _menuButton("💬 Chat Pasien", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const DoctorOrdersPage(openChat: true)));
            }),

            const SizedBox(height: 16),

            _menuButton("👤 Profil Dokter", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const EditDoctorProfilePage()));
            }),
          ],
        ),
      ),
    );
  }

  Widget _menuButton(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Appcolor.textBrownLight.withOpacity(.25)),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Appcolor.textBrownSoft,
          ),
        ),
      ),
    );
  }
}
