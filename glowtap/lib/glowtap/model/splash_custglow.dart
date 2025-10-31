import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    isLoginFunction();
  }

  isLoginFunction() async {
    Future.delayed(Duration(seconds: 3)).then((value) async {
      var isLogin = await PreferenceHandler.getLogin();
      print(isLogin);
      if (isLogin != null && isLogin == true) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Bottom_CustGlow()),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginCustGlow()),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset(AppImage.splashimage)),
          Text(
            "GlowTap",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
