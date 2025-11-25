import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/model/historyfirebasemodel.dart';
import 'package:glowtap/glowtap/preferences/preference_handler_firebase.dart';
import 'package:glowtap/glowtap/service/history_firebase.dart';
import 'package:glowtap/glowtap/views/booking/booking_firebasepage.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryFirebasePage extends StatefulWidget {
  const HistoryFirebasePage({super.key});

  @override
  State<HistoryFirebasePage> createState() => _HistoryFirebasePageState();
}

class _HistoryFirebasePageState extends State<HistoryFirebasePage> {
  String uid = "";

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final token = await PreferenceHandlerFirebase.getToken();
    setState(() {
      uid = token ?? "";
    });
  }

  Future<void> _chatAdmin(HistoryFirebaseModel item) async {
    final String treatment = item.treatment;
    final String date = item.date;
    final String time = item.time;
    final String address = item.address;
    final String note = item.note;

    String phone = "6289604091424"; // Nomor admin GlowTap

    final message = """
Halo GlowTap 👋

Saya ingin bertanya mengenai pesanan saya.

🧖 Treatment : $treatment
📅 Tanggal : $date
⏰ Jam : $time
📍 Lokasi : $address

Catatan:
${note.isEmpty ? 'Tidak ada catatan' : note}

Mohon bantuannya ya 💗
""";

    final url = Uri.parse(
      "https://wa.me/$phone?text=${Uri.encodeComponent(message)}",
    );

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tidak dapat membuka WhatsApp 😭")),
      );
    }
  }

  Future<void> _cancelHistory(HistoryFirebaseModel item) async {
    if (item.id == null) return;
    await HistoryFirebaseService.updateStatus(item.id!, "Dibatalkan");
  }

  void _reschedule(HistoryFirebaseModel item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookingFirebasepage(
          treatmentName: item.treatment,
          treatmentPrice: item.price,
        ),
      ),
    );
  }

  Future<void> _deleteHistory(HistoryFirebaseModel item) async {
    if (item.id == null) return;
    await HistoryFirebaseService.deleteHistory(item.id!);
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text(
          "Riwayat Pemesanan",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<HistoryFirebaseModel>>(
        stream: HistoryFirebaseService.getBookingByUid(uid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.pink),
            );
          }

          final histories = snapshot.data!;
          if (histories.isEmpty) {
            return Center(
              child: Text(
                "Belum ada riwayat treatment 💗",
                style: TextStyle(color: Appcolor.textBrownSoft),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(18),
            itemCount: histories.length,
            itemBuilder: (_, i) {
              final item = histories[i];

              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Appcolor.textBrownLight.withOpacity(.25),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.treatment,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "GlowTap",
                      style: TextStyle(
                        color: Appcolor.textBrownSoft.withOpacity(.8),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${item.date} • ${item.time}",
                      style: TextStyle(
                        color: Appcolor.textBrownSoft.withOpacity(.7),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.status,
                      style: TextStyle(
                        color: Colors.pink.shade400,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // ACTION BUTTONS
                    if (item.status == "Dijadwalkan")
                      Wrap(
                        spacing: 10,
                        children: [
                          ElevatedButton(
                            onPressed: () => _chatAdmin(item),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text("Chat Admin 💬"),
                          ),
                          ElevatedButton(
                            onPressed: () => _reschedule(item),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Appcolor.button1,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text("Ubah Jadwal ✨"),
                          ),
                          ElevatedButton(
                            onPressed: () => _cancelHistory(item),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange.shade400,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text("Batalkan"),
                          ),
                        ],
                      ),
                    if (item.status == "Selesai" ||
                        item.status == "Dibatalkan")
                      ElevatedButton(
                        onPressed: () => _deleteHistory(item),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Hapus"),
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
