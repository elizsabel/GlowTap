import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/database/db_helper.dart';
import 'package:glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/view_customer/akunpage.dart';
import 'package:glowtap/navigation/bottom_custglow.dart';

class RiwayatPesananPage extends StatefulWidget {
  const RiwayatPesananPage({super.key});

  @override
  State<RiwayatPesananPage> createState() => _RiwayatPesananPageState();
}

class _RiwayatPesananPageState extends State<RiwayatPesananPage> {
  List<Map<String, dynamic>> history = [];

  final TextEditingController treatmentC = TextEditingController();
  final TextEditingController dateC = TextEditingController();
  final TextEditingController statusC = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final data = await DbHelper.getHistory();
    setState(() => history = data);
  }

  // ================== POPUP TAMBAH / EDIT RIWAYAT ==================
  void _openForm({Map<String, dynamic>? item}) {
    if (item != null) {
      treatmentC.text = item["treatment"];
      dateC.text = item["date"];
      statusC.text = item["status"];
    } else {
      treatmentC.clear();
      dateC.clear();
      statusC.clear();
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Appcolor.softPinkPastel,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          item == null ? "Tambah Riwayat" : "Edit Riwayat",
          style: TextStyle(
            color: Appcolor.textBrownSoft,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _textInput("Treatment", treatmentC),
            _textInput("Tanggal • Waktu", dateC),
            _statusDropdown(),
          ],
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
            style: ElevatedButton.styleFrom(backgroundColor: Appcolor.button1),
            onPressed: () async {
              if (item == null) {
                await DbHelper.addHistory(
                  treatment: treatmentC.text,
                  date: dateC.text,
                  status: statusC.text.isEmpty
                      ? "Menunggu Konfirmasi"
                      : statusC.text,
                );
              } else {
                await DbHelper.updateHistoryStatus(item["id"], statusC.text);
              }
              await _loadHistory();
              Navigator.pop(context);
            },
            child: const Text("Simpan", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _statusDropdown() {
    final items = [
      "Menunggu Konfirmasi",
      "Dijadwalkan",
      "Selesai",
      "Dibatalkan",
    ];
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField(
        value: statusC.text.isEmpty ? null : statusC.text,
        decoration: _inputDecoration("Status"),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (v) => statusC.text = v ?? "",
      ),
    );
  }

  Widget _textInput(String label, TextEditingController c) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(controller: c, decoration: _inputDecoration(label)),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Appcolor.textBrownLight.withOpacity(0.3)),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case "Menunggu Konfirmasi":
        return Colors.orangeAccent;
      case "Dijadwalkan":
        return Colors.blueAccent;
      case "Selesai":
        return Colors.green;
      case "Dibatalkan":
        return Colors.redAccent;
      default:
        return Appcolor.button1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        centerTitle: true,
        title: const Text(
          "Riwayat Pesanan",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const BottomCustGlow(index: 3)),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Appcolor.button1,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => _openForm(),
      ),
      body: history.isEmpty
          ? Center(
              child: Text(
                "Belum ada riwayat pesanan 💗",
                style: TextStyle(color: Appcolor.textBrownSoft),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: history.length,
              itemBuilder: (context, i) {
                final item = history[i];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["treatment"],
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item["date"],
                        style: TextStyle(color: Appcolor.textBrownSoft),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _statusColor(item["status"]).withOpacity(0.18),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          item["status"],
                          style: TextStyle(
                            color: _statusColor(item["status"]),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _actionBtn(
                            "Edit Jadwal",
                            Icons.edit_outlined,
                            Appcolor.button1,
                            () => _openForm(item: item),
                          ),
                          // _actionBtn("Batalkan", Icons.cancel_outlined, Colors.orangeAccent, () async {
                          //   await DbHelper.updateHistoryStatus(item["id"], "Dibatalkan");
                          //   await _loadHistory();
                          // }),
                          _actionBtn(
                            "Hapus",
                            Icons.delete_outline,
                            Colors.redAccent,
                            () async {
                              await DbHelper.deleteHistory(item["id"]);
                              await _loadHistory();
                            },
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

  Widget _actionBtn(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
