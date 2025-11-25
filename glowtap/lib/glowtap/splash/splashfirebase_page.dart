import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/preferences/preference_handler.dart';
import 'package:glowtap/glowtap/views/auth/login_firebase_page.dart';
import 'package:glowtap/glowtap/views/auth/loginpage.dart';

// ROUTES
import 'package:glowtap/navigation/bottompage.dart';

class SplashFirebase extends StatefulWidget {
  const SplashFirebase({super.key});

  @override
  State<SplashFirebase> createState() => _SplashFirebaseState();
}

class _SplashFirebaseState extends State<SplashFirebase>
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
        MaterialPageRoute(builder: (_) => const LoginCustFirebase()),
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
