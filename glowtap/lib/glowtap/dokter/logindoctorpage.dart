import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/database/db_helper.dart';
import 'package:glowtap/glowtap/preferences/preference_handler.dart';
import 'package:glowtap/glowtap/registerdoctorpage.dart';
import 'package:glowtap/glowtap/views/booking/doctorhomepage.dart';

class LoginDoctorPage extends StatefulWidget {
  const LoginDoctorPage({super.key});

  @override
  State<LoginDoctorPage> createState() => _LoginDoctorPageState();
}

class _LoginDoctorPageState extends State<LoginDoctorPage> {
  final phoneC = TextEditingController();
  final passC = TextEditingController();

  void login() async {
    final doctor = await DbHelper.loginDoctor(
      phone: phoneC.text,
      password: passC.text,
    );

    if (doctor == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Akun dokter tidak ditemukan 😢")),
      );
      return;
    }

    await PreferenceHandler.saveDoctor(doctor);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const DoctorHomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Appcolor.textBrownSoft,
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // TITLE
              Text(
                "GlowTap Dokter 🩺",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Appcolor.textBrownSoft,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Masuk untuk mulai melayani pasien 💗",
                style: TextStyle(
                  fontSize: 14,
                  color: Appcolor.textBrownSoft.withOpacity(.7),
                ),
              ),

              const SizedBox(height: 40),

              // INPUT CARD
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Appcolor.textBrownLight.withOpacity(.25)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _field("Nomor WhatsApp Dokter", phoneC),
                    const SizedBox(height: 18),
                    _field("Password", passC, password: true),
                    const SizedBox(height: 30),

                    // LOGIN BUTTON
                    ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolor.button1,
                        minimumSize: const Size(double.infinity, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text("Masuk ✨", style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // GO TO REGISTER
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterDoctorPage()),
                  );
                },
                child: Text(
                  "Belum punya akun dokter? Daftar disini 🩺",
                  style: TextStyle(
                    color: Appcolor.button1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController c, {bool password = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
              color: Appcolor.textBrownSoft,
              fontWeight: FontWeight.w600,
            )),
        const SizedBox(height: 6),
        TextField(
          controller: c,
          obscureText: password,
          decoration: InputDecoration(
            filled: true,
            fillColor: Appcolor.softPinkPastel,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}
