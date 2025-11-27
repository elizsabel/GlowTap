import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/firebase/constant/appcolor.dart';
import 'package:glowtap/glowtap/sql/database/db_helper.dart';
import 'package:glowtap/glowtap/sql/model/journalmodel.dart';
import 'package:intl/intl.dart';

class AddJournalPage extends StatefulWidget {
  final JournalModel? journal;
  const AddJournalPage({super.key, this.journal});

  @override
  State<AddJournalPage> createState() => _AddJournalPageState();
}

class _AddJournalPageState extends State<AddJournalPage> {
  final TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Kalau sedang edit → isikan isi sebelumnya
    if (widget.journal != null) {
      noteController.text = widget.journal!.note;
    }
  }

  // ✅ Format tanggal rapi
  String getToday() {
    return DateFormat("dd/MM/yyyy").format(DateTime.now());
  }

  Future<void> saveJournal() async {
    if (noteController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tulis catatan dulu ya 💗")),
      );
      return;
    }

    if (widget.journal == null) {
      // Tambah data baru
      await DbHelper.addJournal(
        JournalModel(
          date: getToday(),
          note: noteController.text.trim(),
        ),
      );
    } else {
      // Update data lama
      await DbHelper.updateJournal(
        JournalModel(
          id: widget.journal!.id,
          date: widget.journal!.date,
          note: noteController.text.trim(),
        ),
      );
    }

    Navigator.pop(context, true); // Kembali & refresh list
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
                  hintText: "Contoh:\nHari ini kulitku terasa lebih glowing setelah rutin minum air 💗",
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
                    borderRadius: BorderRadius.circular(16)),
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
