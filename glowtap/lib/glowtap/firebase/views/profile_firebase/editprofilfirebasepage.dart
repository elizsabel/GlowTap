import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/firebase/constant/appcolor.dart';
import 'package:glowtap/glowtap/firebase/models_firebase/userfirebasemodelpage.dart';
import 'package:glowtap/glowtap/firebase/preference_firebase/preference_handler_firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfilFirebasePage extends StatefulWidget {
  final UserFirebaseModel user;

  const EditProfilFirebasePage({super.key, required this.user});

  @override
  State<EditProfilFirebasePage> createState() => _EditProfilFirebasePageState();
}

class _EditProfilFirebasePageState extends State<EditProfilFirebasePage> {
  final nameC = TextEditingController();
  final phoneC = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    nameC.text = widget.user.name ?? "";
    phoneC.text = widget.user.phone ?? "";
  }

  Future<void> saveProfile() async {
    setState(() => loading = true);

    final uid = widget.user.uid!;
    await FirebaseFirestore.instance.collection("users").doc(uid).update({
      "name": nameC.text.trim(),
      "phone": phoneC.text.trim(),
      "updatedAt": DateTime.now().toIso8601String(),
    });

    final updatedSnap = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get();

    final updated = UserFirebaseModel.fromMap({
      "uid": uid,
      ...updatedSnap.data()!,
    });

    await PreferenceHandlerFirebase.saveUserFirebase(updated);

    if (!mounted) return;

    setState(() => loading = false);
    Navigator.pop(context, true);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profil berhasil diperbarui 🎀")),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            Center(
              child: CircleAvatar(
                radius: 48,
                backgroundColor: Appcolor.button1.withOpacity(.9),
                child: Text(
                  (widget.user.name ?? "?")[0].toUpperCase(),
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
            const SizedBox(height: 32),

            loading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.pink),
                  )
                : ElevatedButton(
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

  Widget _field(String label, TextEditingController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                color: Appcolor.textBrownSoft,
                fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextField(
          controller: c,
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
