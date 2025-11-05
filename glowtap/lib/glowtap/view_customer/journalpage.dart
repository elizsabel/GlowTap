import 'package:flutter/material.dart';
import 'package:glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/database/addjournalpage.dart';
import 'package:glowtap/glowtap/database/db_helper.dart';
import 'package:glowtap/glowtap/view_customer/journalmodel.dart';

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

  void deleteJournal(int id) async {
    await DbHelper.deleteJournal(id);
    loadJournal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6FA),
      appBar: AppBar(
        title: const Text("Skin Journal 🎀📖"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Appcolor.textBrownSoft,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Appcolor.button1,
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddJournalPage()));
          loadJournal();
        },
        child: const Icon(Icons.add, size: 28, color: Colors.white),
      ),

      body: journals.isEmpty
          ? Center(
              child: Text(
                "Belum ada catatan 💕\nYuk mulai tulis progres kulitmu ✨",
                textAlign: TextAlign.center,
                style: TextStyle(color: Appcolor.textBrownSoft),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(18),
              itemCount: journals.length,
              itemBuilder: (_, i) {
                final j = journals[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 18),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.pink.shade100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.shade100.withOpacity(.4),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TANGGAL
                      Text(
                        "📅 ${j.date}",
                        style: TextStyle(
                          color: Appcolor.textBrownSoft.withOpacity(.9),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // CATATAN
                      Text(
                        j.note,
                        style: TextStyle(
                          color: Appcolor.textBrownSoft,
                          fontSize: 16,
                          height: 1.4,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 14),

                      // TOMBOL EDIT & HAPUS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AddJournalPage(journal: j),
                                ),
                              );
                              loadJournal();
                            },
                            icon: const Icon(Icons.edit, size: 18),
                            label: const Text("Edit"),
                          ),
                          const SizedBox(width: 6),
                          TextButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text("Hapus Catatan?"),
                                  content: const Text(
                                      "Catatan ini akan dihapus permanen."),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Batal"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        deleteJournal(j.id!);
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "Hapus",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                            label: const Text("Hapus",
                                style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
