import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/database/db_helper.dart';
import 'package:glowtap/glowtap/views/booking/bookingpage.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> histories = [];

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  void loadHistory() async {
    histories = await DbHelper.getHistory();
    setState(() {});
  }

  // ✅ Chat WhatsApp Dokter (Pesan lengkap)
  void chatDoctor(Map<String, dynamic> item) async {
    String doctorName = item["doctor"] ?? "-";
    String phone = item["doctorPhone"] ?? item["doctorphone"] ?? "";
    String treatment = item["treatment"];
    String date = item["date"];
    String time = item["time"];
    String address = item["address"];
    String note = item["note"] ?? "-";

    // Format nomor → 0812 → 62812
    String cleanPhone = phone.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanPhone.startsWith("0")) {
      cleanPhone = "62${cleanPhone.substring(1)}";
    }

    final message = """
Hai dr. $doctorName ✨
Saya baru saja melakukan booking treatment melalui GlowTap 💗

🧖 Treatment : $treatment
📅 Tanggal : $date
⏰ Jam : $time
📍 Lokasi : $address

Catatan:
"${note.isEmpty ? 'Tidak ada catatan' : note}"

Mohon konfirmasinya ya dok 🌸
Terima kasih 🤍
""";

    final url = Uri.parse("https://wa.me/$cleanPhone?text=${Uri.encodeComponent(message)}");

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tidak dapat membuka WhatsApp 😭")),
      );
    }
  }

  // ✅ Batalkan pesanan
  void cancelHistory(int id) async {
    await DbHelper.updateHistoryStatus(id, "Dibatalkan");
    loadHistory();
  }

  // ✅ Ubah jadwal
  void reschedule(Map<String, dynamic> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Bookingpage(
          treatmentName: item["treatment"],
          treatmentPrice: item["price"] ?? "-",
          doctorName: item["doctor"] ?? "-",
          doctorPhone: item["doctorPhone"] ?? "-",
        ),
      ),
    );
  }

  // ✅ Hapus riwayat
  void deleteHistory(int id) async {
    await DbHelper.deleteHistory(id);
    loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        title: const Text("Riwayat Pemesanan", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),

      body: histories.isEmpty
          ? Center(
              child: Text("Belum ada riwayat treatment 💗",
                  style: TextStyle(color: Appcolor.textBrownSoft)))
          : ListView.builder(
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
                    border: Border.all(color: Appcolor.textBrownLight.withOpacity(.25)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item["treatment"],
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                      Text(item["doctor"] ?? "-",
                          style: TextStyle(color: Appcolor.textBrownSoft)),
                      const SizedBox(height: 4),

                      Text("${item["date"]} • ${item["time"]}",
                          style: TextStyle(color: Appcolor.textBrownSoft.withOpacity(.7))),

                      Text(item["status"],
                          style: TextStyle(
                              color: Colors.pink.shade400, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 14),

                      // ✅ Tombol Aksi
                      if (item["status"] == "Dijadwalkan")
                        Wrap(
                          spacing: 10,
                          children: [
                            ElevatedButton(
                              onPressed: () => chatDoctor(item),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              child: const Text("Chat Dokter 💬"),
                            ),
                            ElevatedButton(
                              onPressed: () => reschedule(item),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Appcolor.button1,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              child: const Text("Ubah Jadwal ✨"),
                            ),
                            ElevatedButton(
                              onPressed: () => cancelHistory(item["id"]),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange.shade400,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              child: const Text("Batalkan"),
                            ),
                          ],
                        ),

                      if (item["status"] == "Selesai" || item["status"] == "Dibatalkan")
                        ElevatedButton(
                          onPressed: () => deleteHistory(item["id"]),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text("Hapus"),
                        ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
