import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/database/db_helper.dart';
import 'package:glowtap/glowtap/dokter/doctormodelpage.dart';
import 'package:glowtap/glowtap/preferences/preference_handler.dart';

class DoctorSchedulePage extends StatefulWidget {
  const DoctorSchedulePage({super.key});

  @override
  State<DoctorSchedulePage> createState() => _DoctorSchedulePageState();
}

class _DoctorSchedulePageState extends State<DoctorSchedulePage> {
  List<Map<String, dynamic>> history = [];
  DoctorModel? doctor;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // ✅ Ambil data booking sesuai dokter login
  Future<void> loadData() async {
    doctor = await PreferenceHandler.getDoctor();
    if (doctor != null) {
      final result = await DbHelper.getHistoryByDoctorPhone(doctor!.phone);
      setState(() {
        history = result;
      });
    }
  }

  // ✅ Update status pesanan
  void updateStatus(int id, String status) async {
    await DbHelper.updateHistoryStatus(id, status);
    loadData(); // refresh tampilan
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        title: const Text("Jadwal & Pesanan"),
        backgroundColor: Appcolor.button1,
      ),
      body: history.isEmpty
          ? const Center(
              child: Text(
                "Belum ada pesanan dari customer 💗",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: history.length,
              itemBuilder: (context, i) {
                final item = history[i];
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
                        item["treatment"] ?? "-",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        item["customerPhone"] ?? "-",
                        style: TextStyle(
                          color: Appcolor.textBrownSoft,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${item["date"]} • ${item["time"]}",
                        style: TextStyle(
                          color: Appcolor.textBrownSoft.withOpacity(.7),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item["status"] ?? "-",
                        style: TextStyle(
                          color: Colors.pink.shade400,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // 🔘 Tombol aksi update status
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () =>
                                updateStatus(item["id"], "Selesai"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.greenAccent.shade700,
                            ),
                            child: const Text("Selesai"),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () =>
                                updateStatus(item["id"], "Dibatalkan"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                            ),
                            child: const Text("Batal"),
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
