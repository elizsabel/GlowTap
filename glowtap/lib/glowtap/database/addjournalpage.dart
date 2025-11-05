import 'package:flutter/material.dart';
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
      noteController.text = widget.journal!.note;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.journal != null ? "Edit Catatan" : "Tambah Catatan")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: noteController,
              decoration: const InputDecoration(hintText: "Tulis catatan perkembangan kulitmu..."),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (widget.journal == null) {
                  await DbHelper.addJournal(
                    JournalModel(date: DateTime.now().toString(), note: noteController.text),
                  );
                } else {
                  await DbHelper.updateJournal(
                    JournalModel(id: widget.journal!.id, date: widget.journal!.date, note: noteController.text),
                  );
                }
                Navigator.pop(context);
              },
              child: const Text("Simpan"),
            )
          ],
        ),
      ),
    );
  }
}
