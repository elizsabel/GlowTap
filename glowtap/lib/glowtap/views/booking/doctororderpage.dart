import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/database/db_helper.dart';
import 'package:glowtap/glowtap/preferences/preference_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorOrdersPage extends StatefulWidget {
  const DoctorOrdersPage({super.key, this.openChat = false});
  final bool openChat;

  @override
  State<DoctorOrdersPage> createState() => _DoctorOrdersPageState();
}

class _DoctorOrdersPageState extends State<DoctorOrdersPage> {
  List<Map<String, dynamic>> orders = [];

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  void loadOrders() async {
    final doctor = await PreferenceHandler.getDoctor();
    if (doctor == null) return;

    orders = await DbHelper.getHistoryByDoctorPhone(doctor.phone);
    setState(() {});
  }

  void chatPatient(String phone, String treatment, String date, String address) async {
    String cleanPhone = phone.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanPhone.startsWith("0")) cleanPhone = "62${cleanPhone.substring(1)}";

    final message = Uri.encodeComponent(
      "Hai kak 👋\n"
      "Saya dokter untuk treatment *$treatment* dari GlowTap 💗\n\n"
      "📅 Tanggal: $date\n"
      "📍 Lokasi: $address\n\n"
      "Saya akan segera menghubungi kakak ya ✨"
    );

    final url = Uri.parse("https://wa.me/$cleanPhone?text=$message");
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  void updateStatus(int id, String status) async {
    await DbHelper.updateHistoryStatus(id, status);
    loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        centerTitle: true,
        title: const Text("Jadwal Treatment", style: TextStyle(color: Colors.white)),
      ),

      body: orders.isEmpty
          ? Center(child: Text("Belum ada pesanan 💗", style: TextStyle(color: Appcolor.textBrownSoft)))
          : ListView.builder(
              padding: const EdgeInsets.all(18),
              itemCount: orders.length,
              itemBuilder: (_, i) {
                final o = orders[i];
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
                      Text(o["treatment"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Appcolor.textBrownSoft)),
                      const SizedBox(height: 6),
                      Text("Tanggal: ${o["date"]} • ${o["time"]}", style: TextStyle(color: Appcolor.textBrownSoft.withOpacity(.7))),
                      Text("Alamat: ${o["address"]}", style: TextStyle(color: Appcolor.textBrownSoft.withOpacity(.7))),
                      const SizedBox(height: 14),

                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => chatPatient(o["customerPhone"], o["treatment"], o["date"], o["address"]),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text("Chat Pasien 💬"),
                          ),

                          const SizedBox(width: 10),

                          PopupMenuButton<String>(
                            onSelected: (status) => updateStatus(o["id"], status),
                            itemBuilder: (_) => const [
                              PopupMenuItem(value: "Dokter OTW", child: Text("🚗 Dokter OTW")),
                              PopupMenuItem(value: "Sedang Treatment", child: Text("💉 Sedang Treatment")),
                              PopupMenuItem(value: "Selesai", child: Text("✅ Selesai")),
                              PopupMenuItem(value: "Dibatalkan", child: Text("❌ Dibatalkan")),
                            ],
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              decoration: BoxDecoration(color: Appcolor.button1, borderRadius: BorderRadius.circular(12)),
                              child: const Text("Update Status ✨", style: TextStyle(color: Colors.white)),
                            ),
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
