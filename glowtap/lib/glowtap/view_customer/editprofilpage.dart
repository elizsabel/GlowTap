import 'package:flutter/material.dart';
import 'package:glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/model/customer_model.dart';
import 'package:glowtap/glowtap/preferences/preference_handler.dart';
import 'package:glowtap/glowtap/database/db_helper.dart';

class EditProfilPage extends StatefulWidget {
  const EditProfilPage({super.key});

  @override
  State<EditProfilPage> createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  CustomerModel? user;

  final nameC = TextEditingController();
  final phoneC = TextEditingController();
  final passC = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    user = await PreferenceHandler.getUser();
    if (user != null) {
      nameC.text = user!.name;
      phoneC.text = user!.phone;
      passC.text = user!.password;
    }
    setState(() {});
  }

  // Ambil inisial nama
  String _getInitial(String name) {
    final parts = name.trim().split(" ");
    if (parts.length > 1) return (parts[0][0] + parts[1][0]).toUpperCase();
    return parts[0][0].toUpperCase();
  }

  void saveProfile() async {
    if (user == null) return;

    final updated = CustomerModel(
      id: user!.id,
      name: nameC.text,
      email: user!.email, // tidak diubah
      phone: phoneC.text,
      password: passC.text,
    );

    await DbHelper.updateCustomer(updated);
    await PreferenceHandler.saveUser(updated);

    if (!mounted) return;
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profil berhasil diperbarui ✨")),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("Edit Profil 🎀", style: TextStyle(color: Appcolor.textBrownSoft)),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            const SizedBox(height: 10),

            // Avatar
            Center(
              child: CircleAvatar(
                radius: 48,
                backgroundColor: Appcolor.button1.withOpacity(.9),
                child: Text(
                  _getInitial(user!.name),
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            _field("Nama Lengkap", nameC),
            const SizedBox(height: 16),

            _field("Nomor Handphone", phoneC),
            const SizedBox(height: 16),

            _field("Password", passC, isPass: true),
            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolor.button1,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                "Simpan Perubahan ✨",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController c, {bool isPass = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
              color: Appcolor.textBrownSoft,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            )),
        const SizedBox(height: 6),
        TextField(
          controller: c,
          obscureText: isPass,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
