import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/firebase/constant/appcolor.dart';
import 'package:glowtap/glowtap/firebase/models_firebase/historyfirebasemodel.dart';
import 'package:glowtap/glowtap/firebase/preference_firebase/preference_handler_firebase.dart';
import 'package:glowtap/glowtap/firebase/service/history_firebase.dart';
import 'package:glowtap/glowtap/firebase/views/booking_firebase/booking_firebasepage.dart';
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
    _loadUid();
  }

  Future<void> _loadUid() async {
    final token = await PreferenceHandlerFirebase.getToken();
    setState(() {
      uid = token ?? "";
    });
  }

  // CHAT ADMIN
  Future<void> chatAdmin(HistoryFirebaseModel item) async {
    final phone = "6289604091424";

    final message = """
Halo GlowTap 👋

Saya ingin bertanya mengenai pesanan saya.

🧖 Treatment : ${item.treatment}
📅 Tanggal   : ${item.date}
⏰ Jam       : ${item.time}
📍 Lokasi    : ${item.address}

Catatan:
${item.note.isEmpty ? 'Tidak ada catatan' : item.note}

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

  // BATALKAN
  Future<void> cancelBooking(HistoryFirebaseModel item) async {
    await HistoryFirebaseService.updateStatus(item.id!, "Dibatalkan");
  }

  // RESCHEDULE
  void reschedule(HistoryFirebaseModel item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookingFirebasePage(
          treatmentName: item.treatment,
          treatmentPrice: item.price,
        ),
      ),
    );
  }

  // HAPUS
  Future<void> deleteBooking(HistoryFirebaseModel item) async {
    await HistoryFirebaseService.deleteHistory(item.id!);
  }

  @override
  Widget build(BuildContext context) {
    if (uid.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Colors.pink)),
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

      // *** FIX DI SINI → GUNAKAN getHistory() BUKAN getBookingByUid() ***
      body: StreamBuilder<List<HistoryFirebaseModel>>(
        stream: HistoryFirebaseService.getHistory(uid),

        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Terjadi kesalahan saat memuat data 😢",
                style: TextStyle(color: Appcolor.textBrownSoft),
              ),
            );
          }

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

                    if (item.status == "Dijadwalkan")
                      Wrap(
                        spacing: 10,
                        children: [
                          ElevatedButton(
                            onPressed: () => chatAdmin(item),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text("Chat Admin 💬"),
                          ),
                          ElevatedButton(
                            onPressed: () => reschedule(item),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Appcolor.button1,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text("Ubah Jadwal ✨"),
                          ),
                          ElevatedButton(
                            onPressed: () => cancelBooking(item),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text("Batalkan"),
                          ),
                        ],
                      ),

                    if (item.status == "Selesai" ||
                        item.status == "Dibatalkan")
                      ElevatedButton(
                        onPressed: () => deleteBooking(item),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
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
