import 'package:flutter/material.dart';
import 'package:glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/database/db_helper.dart';
import 'package:glowtap/glowtap/view_customer/journalmodel.dart';

class AddJournalPage extends StatefulWidget {
  final JournalModel? journal;
  const AddJournalPage({super.key, this.journal});

  @override
  State<AddJournalPage> createState() => _AddJournalPageState();
}

class _AddJournalPageState extends State<AddJournalPage> {
  final noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.journal != null) {
      noteController.text = widget.journal!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6FA),
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
              "Tulis cerita kulitmu hari ini 🌷",
              style: TextStyle(
                color: Appcolor.textBrownSoft,
                fontWeight: FontWeight.w600,
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
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Contoh:\nKulit terasa lebih lembab setelah treatment kemarin 💗",
                ),
              ),
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: () async {
                if (widget.journal == null) {
                  await DbHelper.addJournal(
                    JournalModel(
                      date: DateTime.now().toString().split(" ").first,
                      content: noteController.text,
                    ),
                  );
                } else {
                  await DbHelper.updateJournal(
                    JournalModel(
                      id: widget.journal!.id,
                      date: widget.journal!.date,
                      content: noteController.text,
                    ),
                  );
                }
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF8CB8),
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text("Simpan Catatan ✨",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
