import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glowtap/glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/database/db_helper.dart';
import 'package:glowtap/glowtap/model/customer_model.dart';

class RegisterCustglow extends StatefulWidget {
  const RegisterCustglow({super.key});
  static const id = "/registercust";

  @override
  State<RegisterCustglow> createState() => _RegisterCustGlowState();
}

class _RegisterCustGlowState extends State<RegisterCustglow> {
  // Controller untuk input pengguna
  final TextEditingController usernameC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController phoneC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();

  bool isVisibility = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [buildBackground(), buildFormLayer()]),
    );
  }

  /// ===================== UI FORM =====================
  SafeArea buildFormLayer() {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 30),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Appcolor.pink1.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Daftar Akun ✨",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Appcolor.rosegoldDark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Isi data dengan benar ya 💗",
                    style: TextStyle(color: Appcolor.textBrownSoft),
                  ),

                  const SizedBox(height: 22),

                  // USERNAME
                  buildTitle("Username"),
                  buildTextField(
                    hintText: "Buat username unik",
                    icon: Icons.account_circle_outlined,
                    controller: usernameC,
                    validator: (v) =>
                        v!.isEmpty ? "Username tidak boleh kosong" : null,
                  ),
                  const SizedBox(height: 14),

                  // NAMA
                  buildTitle("Nama Lengkap"),
                  buildTextField(
                    hintText: "Masukkan nama lengkap",
                    icon: Icons.person_outline,
                    controller: nameC,
                    validator: (v) =>
                        v!.isEmpty ? "Nama tidak boleh kosong" : null,
                  ),
                  const SizedBox(height: 14),

                  // HP
                  buildTitle("No. Handphone"),
                  buildTextField(
                    hintText: "Masukkan nomor handphone",
                    icon: Icons.phone_outlined,
                    controller: phoneC,
                    validator: (v) =>
                        v!.length < 10 ? "Minimal 10 digit" : null,
                  ),
                  const SizedBox(height: 14),

                  // EMAIL
                  buildTitle("Email"),
                  buildTextField(
                    hintText: "Masukkan email",
                    icon: Icons.email_outlined,
                    controller: emailC,
                    validator: (v) {
                      if (v!.isEmpty) return "Email tidak boleh kosong";
                      if (!v.contains("@")) return "Email tidak valid";
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),

                  // PASSWORD
                  buildTitle("Password"),
                  buildTextField(
                    hintText: "Masukkan password",
                    icon: Icons.lock_outline,
                    controller: passC,
                    isPassword: true,
                    validator: (v) =>
                        v!.length < 6 ? "Minimal 6 karakter" : null,
                  ),
                  const SizedBox(height: 22),

                  RegisterButton(
                    text: "Daftar Sekarang",
                    onPressed: registerUser,
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Sudah punya akun?"),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Masuk",
                          style: TextStyle(
                            color: Appcolor.rosegoldDark,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// ===================== REGISTER LOGIC =====================
  void registerUser() async {
    if (_formKey.currentState!.validate()) {
      final user = CustomerModel(
        username: usernameC.text.trim(),
        name: nameC.text.trim(),
        email: emailC.text.trim(),
        phone: phoneC.text.trim(),
        password: passC.text.trim(),
      );

      await DbHelper.registerUser(user);

      Fluttertoast.showToast(msg: "Pendaftaran berhasil 💗");
      Navigator.pop(context);
    }
  }

  /// ===================== WIDGET REUSABLE =====================
  Widget buildTitle(String text) => Align(
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: Appcolor.textBrownSoft,
      ),
    ),
  );

  TextFormField buildTextField({
    required String hintText,
    required IconData icon,
    required TextEditingController controller,
    bool isPassword = false,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: isPassword ? !isVisibility : false,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: Appcolor.textBrownSoft),
        filled: true,
        fillColor: Appcolor.softPinkPastel,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        suffixIcon: isPassword
            ? IconButton(
                onPressed: () => setState(() => isVisibility = !isVisibility),
                icon: Icon(
                  isVisibility ? Icons.visibility : Icons.visibility_off,
                  color: Appcolor.textBrownSoft,
                ),
              )
            : null,
      ),
    );
  }

  Widget buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/backgroundd.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

/// ===================== BUTTON =====================
class RegisterButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;

  const RegisterButton({super.key, this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Appcolor.button1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
