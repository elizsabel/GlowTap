import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glowtap/constant/appcolor.dart';
import 'package:glowtap/navigation/bottom_custglow.dart';
import 'package:glowtap/glowtap/database/db_helper.dart';
import 'package:glowtap/glowtap/preferences/preference_handler.dart';
import 'package:glowtap/glowtap/view_customer/registerpage.dart';

class LoginCustGlow extends StatefulWidget {
  const LoginCustGlow({super.key});
  static const id = "/loginCustGlow";

  @override
  State<LoginCustGlow> createState() => _LoginCustGlowState();
}

class _LoginCustGlowState extends State<LoginCustGlow> {
  // Controller input email dan password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Untuk visibility password
  bool isVisibility = false;

  // Custom Font
  final fontcustom = 'Josefin';

  // Form key untuk validasi
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackground(), // Background Image
          buildLoginForm(), // Layer Box Login
        ],
      ),
    );
  }

  // ====================== LOGIN PROCESS ======================
  login() async {
    if (_formKey.currentState!.validate()) {
      // Cek ke database
      final data = await DbHelper.loginUser(
        email: emailController.text,
        password: passwordController.text,
      );

      if (data != null) {
        // Simpan status login & data user
        await PreferenceHandler.saveLogin(true);
        await PreferenceHandler.saveUser(data);

        // Jika berhasil login pindah ke home (Bottom Navigation)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomCustGlow()),
        );
      } else {
        // Jika data tidak ditemukan
        Fluttertoast.showToast(msg: "Email atau password salah");
      }
    }
  }

  // ====================== UI LAYER LOGIN BOX ======================
  SafeArea buildLoginForm() {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(
            right: 20,
            left: 20,
            bottom: 30,
            top: 250,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5).withOpacity(0.9),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Appcolor.pink1.withOpacity(0.4),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                height(14),
                Text(
                  "Selamat Datang ✨",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: fontcustom,
                    fontWeight: FontWeight.bold,
                    color: Appcolor.rosegoldDark,
                  ),
                ),
                height(6),
                Text(
                  "Masuk untuk melanjutkan",
                  style: TextStyle(color: Appcolor.textBrownSoft, fontSize: 14),
                ),
                height(24),

                // ====================== EMAIL FIELD ======================
                buildTextField(
                  hintText: "Masukkan email",
                  icon: Icon(
                    Icons.email_outlined,
                    color: Appcolor.textBrownSoft,
                  ),
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) return "Email tidak boleh kosong";
                    if (!value.contains('@')) return "Email tidak valid";
                    return null;
                  },
                ),
                height(14),

                // ====================== PASSWORD FIELD ======================
                buildTextField(
                  hintText: "Masukkan password",
                  icon: Icon(Icons.lock_outline, color: Appcolor.textBrownSoft),
                  isPassword: true,
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) return "Password tidak boleh kosong";
                    if (value.length < 6) return "Password minimal 6 karakter";
                    return null;
                  },
                ),
                height(4),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Lupa Password?",
                      style: TextStyle(
                        color: Appcolor.rosegoldDark,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),

                // ================== LOGIN BUTTON ==================
                LoginButton(text: "Masuk", onPressed: login),
                height(10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Belum punya akun?"),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => RegisterCustglow()),
                      ),
                      child: Text(
                        "Daftar Sekarang",
                        style: TextStyle(
                          color: Appcolor.rosegoldDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                height(12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ====================== BACKGROUND ======================
  Container buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/backgroundd.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // ====================== REUSABLE FUNCTIONS ======================
  TextFormField buildTextField({
    required String hintText,
    required Icon icon,
    bool isPassword = false,
    required TextEditingController controller,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: isPassword ? !isVisibility : false,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon,
        filled: true,
        fillColor: Appcolor.softPinkPastel,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: isPassword
            ? IconButton(
                onPressed: () => setState(() => isVisibility = !isVisibility),
                icon: Icon(
                  isVisibility ? Icons.visibility : Icons.visibility_off,
                ),
              )
            : null,
      ),
    );
  }

  SizedBox height(double size) => SizedBox(height: size);
  SizedBox width(double size) => SizedBox(width: size);
}

// ====================== LOGIN BUTTON WIDGET ======================
class LoginButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;

  const LoginButton({super.key, this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Appcolor.button1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
