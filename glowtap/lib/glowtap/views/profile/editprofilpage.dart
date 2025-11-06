import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/database/db_helper.dart';
import 'package:glowtap/glowtap/model/customermodelpage.dart';
import 'package:glowtap/glowtap/preferences/preference_handler.dart';

class EditProfilPage extends StatefulWidget {
  const EditProfilPage({super.key});

  @override
  State<EditProfilPage> createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  //  Menampung data user yang sedang login
  CustomerModel? user;

  //  Controller untuk mengisi dan mengambil input dari TextField
  final nameC = TextEditingController();
  final phoneC = TextEditingController();
  final passC = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUser(); //  Memanggil data user saat halaman dibuka pertama kali
  }

  //  Mengambil data user dari SharedPreferences dan menampilkannya ke TextField
  void loadUser() async {
    user = await PreferenceHandler.getUser();
    if (user != null) {
      nameC.text = user!.username;
      phoneC.text = user!.phone;
      passC.text = user!.password;
      setState(() {}); //  Update tampilan
    }
  }

  //  Fungsi untuk menyimpan perubahan profil
  void saveProfile() async {
    if (user == null) return;

    //  Membuat object CustomerModel yang sudah diperbarui
    final updated = CustomerModel(
      id: user!.id,
      username: user!.name,
      name: nameC.text.trim(),
      email: user!.email,
      phone: phoneC.text.trim(),
      password: passC.text.trim(),
    );

    //  Update ke SQLite
    await DbHelper.updateCustomer(updated);

    //  Update juga ke SharedPreferences agar data profil di halaman lain ikut berubah
    await PreferenceHandler.saveUser(updated);

    //  Kembali ke halaman sebelum ini & beri tanda berhasil untuk refresh
    if (!mounted) return;
    Navigator.pop(context, true);

    //  Notifikasi berhasil
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profil berhasil diperbarui ✨")),
    );
  }

  @override
  Widget build(BuildContext context) {
    //  Saat user belum terambil, tampilkan loading
    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Edit Profil 🎀",
          style: TextStyle(color: Appcolor.textBrownSoft),
        ),
      ),

      //  Isi halaman
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            //  Avatar menggunakan huruf pertama nama user
            Center(
              child: CircleAvatar(
                radius: 48,
                backgroundColor: Appcolor.button1.withOpacity(.9),
                child: Text(
                  user!.name.isNotEmpty ? user!.name[0].toUpperCase() : "?",
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            //  Field Nama
            _field("Nama Lengkap", nameC),

            const SizedBox(height: 16),

            //  Field Nomor HP
            _field("Nomor Handphone", phoneC),

            const SizedBox(height: 16),

            //  Field Password (disembunyikan)
            _field("Password", passC, isPass: true),

            const SizedBox(height: 32),

            //  Tombol Simpan
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
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //  Widget Custom untuk Form Input
  Widget _field(String label, TextEditingController c, {bool isPass = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label judul input
        Text(
          label,
          style: TextStyle(
            color: Appcolor.textBrownSoft,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),

        // TextField dengan style lembut GlowTap
        TextField(
          controller: c,
          obscureText: isPass, //  Menyembunyikan password
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
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
