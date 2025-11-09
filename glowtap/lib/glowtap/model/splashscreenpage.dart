import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/dokter/selectrolepage.dart';
import 'package:glowtap/glowtap/preferences/preference_handler.dart';

// ROUTES
import 'package:glowtap/glowtap/views/booking/doctorhomepage.dart';
import 'package:glowtap/glowtap/views/home/homepage.dart';

class SplashGlowTap extends StatefulWidget {
  const SplashGlowTap({super.key});

  @override
  State<SplashGlowTap> createState() => _SplashGlowTapState();
}

class _SplashGlowTapState extends State<SplashGlowTap>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    // ANIMASI LOGO
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();

    _checkSession();
  }

  Future<void> _checkSession() async {
    await Future.delayed(const Duration(seconds: 2)); // tunggu animasi

    final customer = await PreferenceHandler.getUser();
    final doctor = await PreferenceHandler.getDoctor();

    if (!mounted) return;

    if (doctor != null) {
      // ✅ Dokter sudah login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DoctorHomePage()),
      );
    } 
    else if (customer != null) {
      // ✅ Customer sudah login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } 
    else {
      // ✅ Belum login → tampilkan pilihan Customer / Dokter
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SelectRolePage()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      body: Center(
        child: FadeTransition(
          opacity: _fade,
          child: Image.asset(
            "assets/images/glowtaptn.png",
            width: 260,
          ),
        ),
      ),
    );
  }
}
