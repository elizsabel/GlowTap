import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/views/auth/loginpage.dart';
import 'package:glowtap/navigation/bottom_custglow.dart';

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

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginCustGlow()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      body: Center(
        child: FadeTransition(
          opacity: _fade,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // LOGO
              Image.asset("assets/images/glowtaptn.png", width: 300),

              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}
