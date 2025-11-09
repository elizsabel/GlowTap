import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/database/db_helper.dart';
import 'package:glowtap/glowtap/dokter/doctormodelpage.dart';

class DoctorUpsertPage extends StatefulWidget {
  final DoctorModel? data;
  const DoctorUpsertPage({super.key, this.data});

  @override
  State<DoctorUpsertPage> createState() => _DoctorUpsertPageState();
}

class _DoctorUpsertPageState extends State<DoctorUpsertPage> {
  final nameC = TextEditingController();
  final specC = TextEditingController();
  final licenseC = TextEditingController();
  final phoneC = TextEditingController();
  final passC = TextEditingController();
  final areaC = TextEditingController();
  final priceC = TextEditingController();
  final bioC = TextEditingController();
  final ratingC = TextEditingController(text: "5.0");

  @override
  void initState() {
    super.initState();
    final d = widget.data;
    if (d != null) {
      nameC.text = d.name;
      specC.text = d.specialty;
      licenseC.text = d.licenseNo;
      phoneC.text = d.phone;
      passC.text = d.password; // ✅ password ikut
      areaC.text = d.area;
      priceC.text = d.price;
      bioC.text = d.bio;
      ratingC.text = d.rating.toStringAsFixed(1);
    }
  }

  Future<void> save() async {
    if (nameC.text.isEmpty || specC.text.isEmpty || phoneC.text.isEmpty || passC.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pastikan semua data terisi ✨")),
      );
      return;
    }

    final rating = double.tryParse(ratingC.text.trim()) ?? 5.0;

    final doc = DoctorModel(
      id: widget.data?.id,
      name: nameC.text.trim(),
      specialty: specC.text.trim(),
      licenseNo: licenseC.text.trim(),
      phone: phoneC.text.trim(),
      password: passC.text.trim(), // ✅ penting
      area: areaC.text.trim(),
      price: priceC.text.trim(),
      bio: bioC.text.trim(),
      rating: rating.clamp(0.0, 5.0),
    );

    if (widget.data == null) {
      await DbHelper.addDoctor(doc);
    } else {
      await DbHelper.updateDoctor(doc);
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  InputDecoration deco(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        title: Text(widget.data == null ? "Tambah Dokter" : "Edit Dokter",
            style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(controller: nameC, decoration: deco("Nama dokter")),
          const SizedBox(height: 10),
          TextField(controller: specC, decoration: deco("Spesialisasi / fokus (mis. Aesthetic Doctor)")),
          const SizedBox(height: 10),
          TextField(controller: licenseC, decoration: deco("No STR / Lisensi")),
          const SizedBox(height: 10),
          TextField(controller: phoneC, keyboardType: TextInputType.phone, decoration: deco("No WhatsApp")),
          const SizedBox(height: 10),
          TextField(controller: passC, obscureText: true, decoration: deco("Password Akun Login Dokter")),
          const SizedBox(height: 10),
          TextField(controller: areaC, decoration: deco("Area layanan (mis. Jakarta - Depok)")),
          const SizedBox(height: 10),
          TextField(controller: priceC, decoration: deco("Harga (contoh: Rp 1.200.000)")),
          const SizedBox(height: 10),
          TextField(controller: ratingC, keyboardType: TextInputType.number, decoration: deco("Rating (0.0 - 5.0)")),
          const SizedBox(height: 10),
          TextField(controller: bioC, maxLines: 5, decoration: deco("Bio singkat / pengalaman")),
          const SizedBox(height: 18),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Appcolor.button1,
              minimumSize: const Size.fromHeight(48),
            ),
            onPressed: save,
            child: const Text("Simpan", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
