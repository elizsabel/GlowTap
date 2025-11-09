import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:glowtap/glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/database/db_helper.dart';
import 'package:glowtap/glowtap/dokter/doctormodelpage.dart';
import 'package:glowtap/glowtap/preferences/preference_handler.dart';

class EditDoctorProfilePage extends StatefulWidget {
  const EditDoctorProfilePage({super.key});

  @override
  State<EditDoctorProfilePage> createState() => _EditDoctorProfilePageState();
}

class _EditDoctorProfilePageState extends State<EditDoctorProfilePage> {
  DoctorModel? doctor;

  final nameC = TextEditingController();
  final specialtyC = TextEditingController();
  final areaC = TextEditingController();
  final priceC = TextEditingController();
  final bioC = TextEditingController();

  File? pickedImage;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    doctor = await PreferenceHandler.getDoctor();
    if (doctor != null) {
      nameC.text = doctor!.name;
      specialtyC.text = doctor!.specialty;
      areaC.text = doctor!.area;
      priceC.text = doctor!.price;
      bioC.text = doctor!.bio;
    }
    setState(() {});
  }

  Future pickImage(ImageSource source) async {
    final picked = await ImagePicker().pickImage(source: source);
    if (picked == null) return;
    setState(() => pickedImage = File(picked.path));
  }

  void save() async {
    if (doctor == null) return;

    final updated = DoctorModel(
      id: doctor!.id,
      name: nameC.text.trim(),
      specialty: specialtyC.text.trim(),
      licenseNo: doctor!.licenseNo,
      phone: doctor!.phone,
      password: doctor!.password,
      area: areaC.text.trim(),
      price: priceC.text.trim(),
      bio: bioC.text.trim(),
      rating: doctor!.rating,
      photoUrl: pickedImage?.path ?? doctor!.photoUrl,
    );

    await DbHelper.updateDoctor(updated);
    await PreferenceHandler.saveDoctor(updated);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profil dokter berhasil diperbarui ✨")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (doctor == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        title: const Text("Profil Dokter", style: TextStyle(color: Colors.white)),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // FOTO PROFIL
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (_) => _photoPicker(),
                );
              },
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Appcolor.button1.withOpacity(.25),
                backgroundImage: pickedImage != null
                    ? FileImage(pickedImage!)
                    : (doctor!.photoUrl != null ? FileImage(File(doctor!.photoUrl!)) : null),
                child: pickedImage == null && doctor!.photoUrl == null
                    ? const Icon(Icons.camera_alt, size: 35, color: Colors.white)
                    : null,
              ),
            ),

            const SizedBox(height: 26),

            input("Nama Lengkap", nameC),
            input("Spesialisasi / Bidang", specialtyC),
            input("Area Layanan (Kota)", areaC),
            input("Harga Start From", priceC),
            input("Bio / Deskripsi", bioC, maxLines: 3),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: save,
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolor.button1,
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text("Simpan Perubahan ✨", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  Widget input(String label, TextEditingController c, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: c,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _photoPicker() {
    return Container(
      padding: const EdgeInsets.all(18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Pilih Foto", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ListTile(
            leading: const Icon(Icons.photo_camera),
            title: const Text("Kamera"),
            onTap: () {
              Navigator.pop(context);
              pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text("Gallery"),
            onTap: () {
              Navigator.pop(context);
              pickImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }
}
