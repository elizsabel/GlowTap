import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/dokter/logindoctorpage.dart';
import 'package:glowtap/glowtap/editprofildoctor.dart';
import 'package:glowtap/glowtap/preferences/preference_handler.dart';

class AkunDokterPage extends StatefulWidget {
  const AkunDokterPage({super.key});

  @override
  State<AkunDokterPage> createState() => _AkunDokterPageState();
}

class _AkunDokterPageState extends State<AkunDokterPage> {
  Future<void> _logout() async {
    await PreferenceHandler.removeDoctor();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginDoctorPage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        title: const Text("Akun Dokter"),
        backgroundColor: Appcolor.pink1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 60, color: Colors.pinkAccent),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Profil Dokter GlowTap",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),

            // 🔹 Tombol Edit Profil
            ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text("Edit Profil Dokter"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditDoctorProfilePage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolor.button1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),

            const SizedBox(height: 16),

            // 🔹 Tombol Logout
            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
              onPressed: _logout,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
