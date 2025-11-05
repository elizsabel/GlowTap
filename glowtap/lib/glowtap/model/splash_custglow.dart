import 'package:flutter/material.dart';
import 'package:glowtap/constant/appimage.dart';
import 'package:glowtap/navigation/bottom_custglow.dart';
import 'package:glowtap/glowtap/preferences/preference_handler.dart';
import 'package:glowtap/glowtap/view_customer/loginpage.dart';

class SplashCustglow extends StatefulWidget {
  const SplashCustglow({super.key});

  @override
  State<SplashCustglow> createState() => _SplashCustglowState();
}

class _SplashCustglowState extends State<SplashCustglow> {

  @override
  void initState() {
    super.initState();
    _navigateUser(); // Panggil fungsi pengecekan login
  }

  /// ================================
  /// CEK STATUS LOGIN & NAVIGASI OTOMATIS
  /// ================================
  Future<void> _navigateUser() async {
    // Delay splash selama 3 detik
    await Future.delayed(const Duration(seconds: 3));

    // Ambil nilai login dari SharedPreferences
    bool? isLogin = await PreferenceHandler.getLogin();
    print("Login Status: $isLogin");

    // Jika user sudah login → Langsung masuk ke beranda
    if (isLogin == true) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const BottomNavPage()),
        (route) => false,
      );
    } 
    // Jika belum login → Masuk ke halaman login
    else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginCustGlow()),
        (route) => false,
      );
    }
  }

  /// ================================
  /// UI SPLASH SCREEN
  /// ================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            /// LOGO / IMAGE SPLASH
            Image.asset(
              AppImage.splashimage,
              width: 300,
              height: 300,
            ),
            const SizedBox(height: 18),

            /// TEXT BRAND
            const Text(
              "GlowTap",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF7EFE9),
              ),
            ),

            const SizedBox(height: 8),

            /// TAGLINE HALUS ✨
            const Text(
              "Glow from Home ✨",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFFC47A78),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
