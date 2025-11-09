import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/database/db_helper.dart';
import 'package:glowtap/glowtap/dokter/doctormodelpage.dart';
import 'package:glowtap/glowtap/constant/appcolor.dart';

class RegisterDoctorPage extends StatefulWidget {
  const RegisterDoctorPage({super.key});

  @override
  State<RegisterDoctorPage> createState() => _RegisterDoctorPageState();
}

class _RegisterDoctorPageState extends State<RegisterDoctorPage> {
  final nameC = TextEditingController();
  final specialtyC = TextEditingController();
  final phoneC = TextEditingController();
  final passC = TextEditingController();

  void register() async {
    if (nameC.text.isEmpty ||
        specialtyC.text.isEmpty ||
        phoneC.text.isEmpty ||
        passC.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lengkapi semua data ya 💗")),
      );
      return;
    }

    final doctor = DoctorModel(
      name: nameC.text.trim(),
      specialty: specialtyC.text.trim(),
      licenseNo: "-",        
      phone: phoneC.text.trim(),
      password: passC.text.trim(),
      area: "Belum diatur", 
      price: "Belum diatur",
      bio: "Belum ada deskripsi",
      rating: 5.0,
    );

    await DbHelper.addDoctor(doctor);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Akun Dokter Berhasil Dibuat ✨")),
    );

    Navigator.pop(context);
  }

  Widget inputField(String label, TextEditingController c, {bool pass = false}) {
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
          obscureText: pass,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
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
              Text(
                "Daftar Dokter GlowTap 🩺",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Appcolor.textBrownSoft,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Bergabung membantu pasien cantik dari rumah 💗",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Appcolor.textBrownSoft.withOpacity(.7),
                ),
              ),
              const SizedBox(height: 36),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Appcolor.textBrownLight.withOpacity(.25)),
                ),
                child: Column(
                  children: [
                    inputField("Nama Dokter", nameC),
                    const SizedBox(height: 16),
                    inputField("Spesialisasi", specialtyC),
                    const SizedBox(height: 16),
                    inputField("Nomor WhatsApp", phoneC),
                    const SizedBox(height: 16),
                    inputField("Password", passC, pass: true),
                    const SizedBox(height: 24),

                    ElevatedButton(
                      onPressed: register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolor.button1,
                        minimumSize: const Size(double.infinity, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text("Daftar ✨", style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
