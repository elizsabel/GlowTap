import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/model/journalfirebasemodel.dart';
import 'package:glowtap/glowtap/preferences/preference_handler_firebase.dart';
import 'package:glowtap/glowtap/service/journal_firebase.dart';
import 'package:intl/intl.dart';

class JournalFirebasePage extends StatefulWidget {
  const JournalFirebasePage({super.key});

  @override
  State<JournalFirebasePage> createState() => _JournalFirebasePageState();
}

class _JournalFirebasePageState extends State<JournalFirebasePage> {
  String uid = "";

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  // Ambil UID dari SharedPreferences
  Future<void> loadUser() async {
    final token = await PreferenceHandlerFirebase.getToken();
    uid = token ?? "";
    setState(() {});
  }

  // Simpan ke Firestore dalam format ISO → gampang di-sort
  String getTodayIso() {
    return DateTime.now().toIso8601String();
  }

  // Tampilkan ke user pakai format cantik
  String formatPretty(String isoString) {
    try {
      final dt = DateTime.parse(isoString);
      return DateFormat("dd/MM/yyyy").format(dt);
    } catch (_) {
      return isoString;
    }
  }

  // Dialog tambah / edit journal
  void openJournalForm({JournalFirebaseModel? journal}) {
    final controller = TextEditingController(text: journal?.note ?? "");

    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                journal == null
                    ? "Tambah Catatan Journal"
                    : "Edit Catatan Journal",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Appcolor.textBrownSoft,
                ),
              ),
              const SizedBox(height: 14),

              TextField(
                controller: controller,
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
                    child: Text(
                      "Batal",
                      style: TextStyle(color: Appcolor.textBrownSoft),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolor.button1,
                    ),
                    onPressed: () async {
                      final text = controller.text.trim();
                      if (text.isEmpty) return;

                      if (journal == null) {
                        // CREATE
                        final newJournal = JournalFirebaseModel(
                          uid: uid,
                          date: getTodayIso(),
                          note: text,
                        );
                        await JournalFirebaseService.addJournal(newJournal);
                      } else {
                        // UPDATE
                        final updated = JournalFirebaseModel(
                          id: journal.id,
                          uid: journal.uid,
                          date: journal.date, // tetap pakai tanggal lama
                          note: text,
                        );
                        await JournalFirebaseService.updateJournal(updated);
                      }

                      Navigator.pop(context);
                    },
                    child: const Text("Simpan"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Konfirmasi hapus
  void deleteJournal(String id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Text(
          "Hapus Catatan?",
          style: TextStyle(color: Appcolor.textBrownSoft),
        ),
        content: const Text("Catatan ini akan dihapus permanen 💗"),
        actions: [
          TextButton(
            child: Text(
              "Batal",
              style: TextStyle(color: Appcolor.textBrownSoft),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Hapus"),
            onPressed: () async {
              Navigator.pop(context);
              await JournalFirebaseService.deleteJournal(id);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Kalau UID belum kebaca → loading dulu
    if (uid.isEmpty) {
      return Scaffold(
        backgroundColor: Appcolor.softPinkPastel,
        body: const Center(
          child: CircularProgressIndicator(color: Colors.pink),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        centerTitle: true,
        title: const Text(
          "Journal Kulitmu 💗",
          style: TextStyle(color: Colors.white),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Appcolor.button1,
        onPressed: () => openJournalForm(),
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: StreamBuilder<List<JournalFirebaseModel>>(
        stream: JournalFirebaseService.getJournals(uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Terjadi kesalahan saat memuat data 😢",
                style: TextStyle(color: Appcolor.textBrownSoft),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.pink),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "Belum ada catatan. Mulai cerita perjalanan kulitmu ✨",
                textAlign: TextAlign.center,
                style: TextStyle(color: Appcolor.textBrownSoft),
              ),
            );
          }

          final journals = snapshot.data!;
          print(journals.length);

          return ListView.builder(
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
                  border: Border.all(
                    color: Appcolor.textBrownLight.withOpacity(.25),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formatPretty(item.date),
                      style: TextStyle(
                        fontSize: 12,
                        color: Appcolor.textBrownSoft.withOpacity(.6),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.note,
                      style: TextStyle(
                        fontSize: 15,
                        color: Appcolor.textBrownSoft,
                      ),
                    ),
                    const SizedBox(height: 14),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => openJournalForm(journal: item),
                          child: Text(
                            "Edit",
                            style: TextStyle(color: Appcolor.button1),
                          ),
                        ),
                        TextButton(
                          onPressed: () => deleteJournal(item.id!),
                          child: Text(
                            "Hapus",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
