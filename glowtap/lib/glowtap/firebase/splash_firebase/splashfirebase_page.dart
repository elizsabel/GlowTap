import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/firebase/constant/appcolor.dart';
import 'package:glowtap/glowtap/firebase/preference_firebase/preference_handler_firebase.dart';
import 'package:glowtap/glowtap/firebase/service/addeducation_service.dart';
import 'package:glowtap/glowtap/firebase/nav_firebase/bottomnavfirebase.dart';
import 'package:glowtap/glowtap/firebase/views/auth_firebase/login_firebase_page.dart';

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

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();

    // ▶️ Jalankan seeder sekali saja
    seedDummyData();

    // ▶️ Lanjut cek login
    _checkSession();
  }

  /// ================
  /// SEEDER (aman)
  /// ================
  Future<void> seedDummyData() async {
    try {
      await EducationSeeder.uploadEducationItems();
      print("🔥 Education Seeder: BERHASIL");

      // Setelah berhasil → HAPUS pemanggilan seedDummyData() di initState
    } catch (e) {
      print("❌ Gagal upload dummy: $e");
    }
  }

  /// ================
  /// CEK SESSION LOGIN
  /// ================
  Future<void> _checkSession() async {
    await Future.delayed(const Duration(seconds: 2));

    final isLogin = await PreferenceHandlerFirebase.getLogin();

    if (!mounted) return;

    if (isLogin == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BottomNavFirebase()),
      );
    } else {
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
