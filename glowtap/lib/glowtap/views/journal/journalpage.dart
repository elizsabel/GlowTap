import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/database/db_helper.dart';
import 'package:glowtap/glowtap/model/journalmodel.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  List<JournalModel> journals = [];

  @override
  void initState() {
    super.initState();
    loadJournal();
  }

  void loadJournal() async {
    journals = await DbHelper.getJournal();
    setState(() {});
  }

  // ✅ Buka Form Tambah / Edit
  void openJournalForm({JournalModel? journal}) {
    final TextEditingController noteController =
        TextEditingController(text: journal?.note ?? "");

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                journal == null ? "Tambah Catatan Journal" : "Edit Catatan Journal",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Appcolor.textBrownSoft,
                ),
              ),
              const SizedBox(height: 14),

              TextField(
                controller: noteController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Tulis perkembangan kulitmu hari ini 💗",
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Batal", style: TextStyle(color: Appcolor.textBrownSoft)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolor.button1,
                    ),
                    onPressed: () async {
                      if (noteController.text.trim().isEmpty) return;

                      if (journal == null) {
                        // ✅ Tambah Data
                        await DbHelper.addJournal(
                          JournalModel(
                            date: DateTime.now().toString().substring(0, 16),
                            note: noteController.text.trim(),
                          ),
                        );
                      } else {
                        // ✅ Edit Data
                        await DbHelper.updateJournal(
                          JournalModel(
                            id: journal.id,
                            date: journal.date,
                            note: noteController.text.trim(),
                          ),
                        );
                      }

                      Navigator.pop(context);
                      loadJournal();
                    },
                    child: const Text("Simpan"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // ✅ Konfirmasi Hapus
  void confirmDelete(int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Text("Hapus Catatan?", style: TextStyle(color: Appcolor.textBrownSoft)),
        content: const Text("Catatan ini akan dihapus permanen 💗"),
        actions: [
          TextButton(
            child: Text("Batal", style: TextStyle(color: Appcolor.textBrownSoft)),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade400,
            ),
            child: const Text("Hapus"),
            onPressed: () async {
              Navigator.pop(context);
              await DbHelper.deleteJournal(id);
              loadJournal();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        title: const Text("Journal Kulitmu 💗", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Appcolor.button1,
        onPressed: () => openJournalForm(),
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: journals.isEmpty
          ? Center(
              child: Text(
                "Belum ada catatan.\nMulai cerita perjalanan kulitmu ✨",
                textAlign: TextAlign.center,
                style: TextStyle(color: Appcolor.textBrownSoft),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(18),
              itemCount: journals.length,
              itemBuilder: (_, i) {
                final item = journals[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Appcolor.textBrownLight.withOpacity(.25)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.date,
                          style: TextStyle(
                              fontSize: 12,
                              color: Appcolor.textBrownSoft.withOpacity(.6))),
                      const SizedBox(height: 6),
                      Text(item.note,
                          style: TextStyle(fontSize: 15, color: Appcolor.textBrownSoft)),
                      const SizedBox(height: 14),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => openJournalForm(journal: item),
                            child: Text("Edit", style: TextStyle(color: Appcolor.button1)),
                          ),
                          TextButton(
                            onPressed: () => confirmDelete(item.id!),
                            child: Text("Hapus",
                                style: TextStyle(color: Colors.red.shade400)),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
