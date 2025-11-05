import 'package:flutter/material.dart';
import 'package:glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/database/db_helper.dart';
import 'package:glowtap/glowtap/view_customer/editjournalpage.dart';
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

  void delete(int id) async {
    await DbHelper.deleteJournal(id);
    loadJournal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Journal Skin"),
        backgroundColor: Appcolor.button1,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Appcolor.button1,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const EditJournalPage()),
          );
          loadJournal();
        },
        child: const Icon(Icons.add),
      ),
      body: journals.isEmpty
          ? const Center(child: Text("Belum ada catatan 📔"))
          : ListView.builder(
              itemCount: journals.length,
              itemBuilder: (context, i) {
                final j = journals[i];
                return ListTile(
                  title: Text(
                    j.content,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(j.date),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditJournalPage(journal: j),
                      ),
                    );
                    loadJournal();
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => delete(j.id!),
                  ),
                );
              },
            ),
    );
  }
}
