import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/firebase/constant/appcolor.dart';
import 'package:glowtap/glowtap/sql/preference/preference_handler.dart';
import 'package:glowtap/glowtap/sql/views/auth/loginpage.dart';

// ROUTES
import 'package:glowtap/glowtap/sql/navigation/bottompage.dart';

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

    final customer = await PreferenceHandler.getUser(); // hanya cek customer

    if (!mounted) return;

    if (customer != null) {
      // ✅ Customer sudah login → langsung ke Home Bottom Nav
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BottomNavPage()),
      );
    } else {
      // ❌ Belum login → ke Login Customer
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginCustGlow()),
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
          child: Image.asset("assets/images/glowtaptn.png", width: 260),
        ),
      ),
    );
  }
}
