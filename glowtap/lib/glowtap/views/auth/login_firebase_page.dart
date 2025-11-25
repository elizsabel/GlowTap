import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glowtap/glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/service/firebase.dart';
import 'package:glowtap/glowtap/preferences/preference_handler_firebase.dart';
import 'package:glowtap/navigation/bottomnavfirebase.dart';
import 'package:glowtap/glowtap/views/auth/register_firebase_page.dart';

class LoginCustFirebase extends StatefulWidget {
  const LoginCustFirebase({super.key});
  static const id = "/loginCustFirebase";

  @override
  State<LoginCustFirebase> createState() => _LoginCustFirebaseState();
}

class _LoginCustFirebaseState extends State<LoginCustFirebase> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isVisibility = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [buildBackground(), buildLoginForm()]),
    );
  }

  // ================= LOGIN LOGIC FINAL =================
  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      try {
        // 1. LOGIN
        final user = await FirebaseSevice.loginUser(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        if (user == null) {
          Fluttertoast.showToast(msg: "Email atau password salah");
          return;
        }

        // 2. SAVE LOGIN SESSION
        await PreferenceHandlerFirebase.saveLogin(true);
        await PreferenceHandlerFirebase.saveUserFirebase(user);

       

        Fluttertoast.showToast(msg: "Berhasil masuk 💗");

        // 4. NAVIGATE TO HOME
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const BottomNavFirebase()),
        );
      } catch (e) {
        Fluttertoast.showToast(msg: "Gagal masuk: $e");
      }
    }
  }

  // ====================== UI ======================
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
              color: const Color(0xFFF5F5F5).withOpacity(0.9),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Appcolor.pink1.withOpacity(0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 14),
                Text(
                  "Selamat Datang ✨",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Appcolor.rosegoldDark,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Masuk untuk melanjutkan",
                  style: TextStyle(color: Appcolor.textBrownSoft, fontSize: 14),
                ),
                const SizedBox(height: 24),

                // EMAIL
                buildTextField(
                  hintText: "Masukkan email",
                  icon: const Icon(Icons.email_outlined),
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) return "Email tidak boleh kosong";
                    if (!value.contains('@')) return "Email tidak valid";
                    return null;
                  },
                ),
                const SizedBox(height: 14),

                // PASSWORD
                buildTextField(
                  hintText: "Masukkan password",
                  icon: const Icon(Icons.lock_outline),
                  isPassword: true,
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) return "Password tidak boleh kosong";
                    if (value.length < 6) return "Minimal 6 karakter";
                    return null;
                  },
                ),
                const SizedBox(height: 4),

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

                // LOGIN BUTTON
                LoginButton(text: "Masuk", onPressed: login),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Belum punya akun?"),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterCustFirebase(),
                        ),
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
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
}

// ====================== LOGIN BUTTON ======================
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
