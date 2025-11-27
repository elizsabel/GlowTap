import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/firebase/constant/appcolor.dart';
import 'package:glowtap/glowtap/firebase/models_firebase/journalfirebasemodel.dart';
import 'package:glowtap/glowtap/firebase/preference_firebase/preference_handler_firebase.dart';
import 'package:glowtap/glowtap/firebase/service/journal_firebase.dart';
import 'package:intl/intl.dart';

class AddJournalFirebasePage extends StatefulWidget {
  final JournalFirebaseModel? journal;
  const AddJournalFirebasePage({super.key, this.journal});

  @override
  State<AddJournalFirebasePage> createState() => _AddJournalFirebasePageState();
}

class _AddJournalFirebasePageState extends State<AddJournalFirebasePage> {
  final TextEditingController noteController = TextEditingController();
  String? uidLogin;

  @override
  void initState() {
    super.initState();
    _loadUser();

    if (widget.journal != null) {
      noteController.text = widget.journal!.note;
    }
  }

  Future<void> _loadUser() async {
    final user = await PreferenceHandlerFirebase.getUserFirebase();
    setState(() {
      uidLogin = user?.uid;
    });
  }

  String getToday() {
    return DateFormat("dd/MM/yyyy").format(DateTime.now());
  }

  Future<void> saveJournal() async {
    if (noteController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Tulis catatan dulu ya 💗")));
      return;
    }

    if (uidLogin == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("User tidak ditemukan 😢")));
      return;
    }

    if (widget.journal == null) {
      final newJournal = JournalFirebaseModel(
        uid: uidLogin!,
        date: getToday(),
        note: noteController.text.trim(),
      );
      await JournalFirebaseService.addJournal(newJournal);
    } else {
      final updated = JournalFirebaseModel(
        id: widget.journal!.id,
        uid: widget.journal!.uid,
        date: widget.journal!.date,
        note: noteController.text.trim(),
      );
      await JournalFirebaseService.updateJournal(updated);
    }

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.journal == null ? "Tambah Catatan 🎀" : "Edit Catatan ✏️",
          style: TextStyle(color: Appcolor.textBrownSoft),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Cerita kulitmu hari ini 🌷",
              style: TextStyle(
                color: Appcolor.textBrownSoft,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.pink.shade100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.shade100.withOpacity(.4),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: noteController,
                maxLines: 6,
                style: TextStyle(color: Appcolor.textBrownSoft),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText:
                      "Contoh:\nHari ini kulitku terasa lebih glowing setelah rutin minum air 💗",
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: saveJournal,
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolor.button1,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                "Simpan Catatan ✨",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
