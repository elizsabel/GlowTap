import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/dokter/logindoctorpage.dart';
import 'package:glowtap/glowtap/views/auth/loginpage.dart';

class SelectRolePage extends StatelessWidget {
  const SelectRolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Masuk Sebagai",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF8E6E6B),
                ),
              ),
              const SizedBox(height: 40),

              // CUSTOMER BUTTON
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginCustGlow()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolor.button1,
                  minimumSize: const Size.fromHeight(55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text("Customer 💗", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),

              const SizedBox(height: 16),

              // DOCTOR BUTTON
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginDoctorPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(55),
                  side: BorderSide(color: Appcolor.button1, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  "Dokter 🩺",
                  style: TextStyle(color: Appcolor.button1, fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
