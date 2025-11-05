import 'package:flutter/material.dart';
import 'package:glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/database/db_helper.dart';
import 'package:glowtap/glowtap/view_customer/bookingpage.dart';

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

  // ✅ Konfirmasi Hapus
  void deleteHistory(int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        backgroundColor: Colors.white,
        title: Text(
          "Hapus Riwayat?",
          style: TextStyle(
            color: Appcolor.textBrownSoft,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          "Riwayat ini akan dihapus permanen ya 💗",
          style: TextStyle(color: Appcolor.textBrownSoft),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Batal",
              style: TextStyle(color: Appcolor.textBrownSoft),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await DbHelper.deleteHistory(id);
              loadHistory();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade400,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text("Hapus"),
          ),
        ],
      ),
    );
  }

  // ✅ Konfirmasi Batalkan Pesanan
  void cancelHistory(int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        backgroundColor: Colors.white,
        title: Text(
          "Batalkan Pesanan?",
          style: TextStyle(
            color: Appcolor.textBrownSoft,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          "Beautician tidak akan datang ke lokasi ya 💗",
          style: TextStyle(color: Appcolor.textBrownSoft),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Kembali",
              style: TextStyle(color: Appcolor.textBrownSoft),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await DbHelper.updateHistoryStatus(id, "Dibatalkan");
              loadHistory();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade400,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text("Batalkan"),
          ),
        ],
      ),
    );
  }

  void reschedule(Map<String, dynamic> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Bookingpage(
          treatmentName: data["treatment"],
          treatmentPrice: data["price"] ?? "-",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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

      body: histories.isEmpty
          ? Center(
              child: Text(
                "Belum ada riwayat treatment 💗",
                style: TextStyle(color: Appcolor.textBrownSoft),
              ),
            )
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
                    border: Border.all(
                      color: Appcolor.textBrownLight.withOpacity(.25),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Treatment Title
                      Text(
                        item["treatment"],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Appcolor.textBrownSoft,
                        ),
                      ),

                      const SizedBox(height: 4),

                      // Date + Status
                      Text(
                        "${item["date"]} • ${item["status"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: Appcolor.textBrownSoft.withOpacity(.7),
                        ),
                      ),

                      const SizedBox(height: 14),

                      // ✅ BUTTON AREA
                      if (item["status"] == "Dijadwalkan")
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () => reschedule(item),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Appcolor.button1,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text("Ubah Jadwal ✨"),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () => cancelHistory(item["id"]),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.deepOrangeAccent.shade200,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text("Batalkan"),
                            ),
                          ],
                        ),

                      if (item["status"] == "Selesai")
                        ElevatedButton(
                          onPressed: () => deleteHistory(item["id"]),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade400,
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
            ),
    );
  }
}
