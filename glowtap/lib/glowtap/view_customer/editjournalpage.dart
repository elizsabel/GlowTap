import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/database/db_helper.dart';
import 'package:glowtap/glowtap/view_customer/journalmodel.dart';

class EditJournalPage extends StatefulWidget {
  final JournalModel? journal; // null = tambah baru, not null = edit

  const EditJournalPage({super.key, this.journal});

  @override
  State<EditJournalPage> createState() => _EditJournalPageState();
}

class _EditJournalPageState extends State<EditJournalPage> {
  final TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.journal != null) {
      contentController.text = widget.journal!.content;
    }
  }

  void save() async {
    if (contentController.text.trim().isEmpty) return;

    final now = DateTime.now();
    final date = "${now.day}/${now.month}/${now.year}";

    if (widget.journal == null) {
      // Tambah baru
      await DbHelper.addJournal(
        JournalModel(
          content: contentController.text.trim(),
          date: date,
        ),
      );
    } else {
      // Edit
      await DbHelper.updateJournal(
        JournalModel(
          id: widget.journal!.id,
          content: contentController.text.trim(),
          date: widget.journal!.date,
        ),
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.journal == null ? "Tambah Catatan" : "Edit Catatan"),
        backgroundColor: Colors.pink.shade300,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: TextField(
          controller: contentController,
          maxLines: null,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Tulis catatan kulit kamu di sini...",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey.shade500),
          ),
          style: const TextStyle(fontSize: 16, height: 1.4),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink.shade300,
        onPressed: save,
        child: const Icon(Icons.check),
      ),
    );
  }
}
