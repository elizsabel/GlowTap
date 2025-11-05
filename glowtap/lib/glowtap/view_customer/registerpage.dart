import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/model/customer_model.dart';
import 'package:glowtap/glowtap/database/db_helper.dart';

class RegisterCustglow extends StatefulWidget {
  const RegisterCustglow({super.key});
  static const id = "/registercust";

  @override
  State<RegisterCustglow> createState() => _RegisterCustGlowState();
}

class _RegisterCustGlowState extends State<RegisterCustglow> {
  // Controller untuk menampung input pengguna
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Untuk visibility input password
  bool isVisibility = false;

  // Key untuk validasi form
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackground(), // background gambar
          buildFormLayer(),  // box form register
        ],
      ),
    );
  }

  /// ===================== UI LAYER REGISTER BOX =====================
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
                  offset: Offset(0, 4),
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

                  SizedBox(height: 12),
                  Text("Isi data dengan benar ya 💗",
                      style: TextStyle(color: Appcolor.textBrownSoft)),

                  SizedBox(height: 22),

                  // Input Nama
                  buildTitle("Nama Lengkap"),
                  buildTextField(
                    hintText: "Masukkan nama kamu",
                    icon: Icons.person_outline,
                    controller: nameController,
                    validator: (value) =>
                        value!.isEmpty ? "Nama tidak boleh kosong" : null,
                  ),

                  SizedBox(height: 14),

                  // Input No HP
                  buildTitle("No. Handphone"),
                  buildTextField(
                    hintText: "Masukkan nomor handphone",
                    icon: Icons.phone_outlined,
                    controller: phoneController,
                    validator: (value) =>
                        value!.length < 11 ? "Minimal 11 digit" : null,
                  ),

                  SizedBox(height: 14),

                  // Input Email
                  buildTitle("Email"),
                  buildTextField(
                    hintText: "Masukkan email kamu",
                    icon: Icons.email_outlined,
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) return "Email tidak boleh kosong";
                      if (!value.contains("@")) return "Email tidak valid";
                      return null;
                    },
                  ),

                  SizedBox(height: 14),

                  // Input Password
                  buildTitle("Password"),
                  buildTextField(
                    hintText: "Masukkan password",
                    icon: Icons.lock_outline,
                    controller: passwordController,
                    isPassword: true,
                    validator: (value) =>
                        value!.length < 6 ? "Minimal 6 karakter" : null,
                  ),

                  SizedBox(height: 22),

                  // Tombol Register
                  RegisterButton(
                    text: "Daftar Sekarang",
                    onPressed: registerUser,
                  ),

                  SizedBox(height: 16),

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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// ===================== REGISTER FUNCTION =====================
  void registerUser() async {
    if (_formKey.currentState!.validate()) {
      final CustomerModel data = CustomerModel(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
      );

      await DbHelper.registerUser(data);
      Fluttertoast.showToast(msg: "Pendaftaran berhasil 💗");
      Navigator.pop(context);
    }
  }

  /// ===================== REUSABLE WIDGET =====================
  Widget buildTitle(String text) => Align(
        alignment: Alignment.centerLeft,
        child: Text(text,
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Appcolor.textBrownSoft)),
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
                icon: Icon(isVisibility ? Icons.visibility : Icons.visibility_off),
              )
            : null,
      ),
    );
  }

  /// Background UI
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

/// ===================== REGISTER BUTTON =====================
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(text,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }
}
