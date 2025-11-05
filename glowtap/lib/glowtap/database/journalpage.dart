import 'package:flutter/material.dart';
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
    loadData();
  }

  void loadData() async {
    journals = await DbHelper.getJournal();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Skin Journal ✨")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => AddJournalPage()));
          loadData();
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: journals.length,
        itemBuilder: (_, i) {
          final j = journals[i];
          return ListTile(
            title: Text(j.date),
            subtitle: Text(j.note),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                DbHelper.deleteJournal(j.id!);
                loadData();
              },
            ),
            onTap: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (_) => AddJournalPage(journal: j)));
              loadData();
            },
          );
        },
      ),
    );
  }
}
