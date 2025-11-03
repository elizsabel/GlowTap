import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/database/history_service.dart';
import 'package:glowtap/constant/appcolor.dart';

class RiwayatPesananPage extends StatefulWidget {
  const RiwayatPesananPage({super.key});

  @override
  State<RiwayatPesananPage> createState() => _RiwayatPesananPageState();
}

class _RiwayatPesananPageState extends State<RiwayatPesananPage> {
  // List penyimpanan data riwayat pesanan
  List<Map<String, String>> history = [];

  // Controller untuk input form (Tambah/Edit)
  final TextEditingController treatmentC = TextEditingController();
  final TextEditingController dateC = TextEditingController();
  final TextEditingController statusC = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadHistory(); // Load data ketika halaman pertama kali dibuka
  }

  // Ambil data dari storage (SharedPreferences melalui HistoryService)
  Future<void> _loadHistory() async {
    await HistoryService.loadHistory();
    setState(() => history = HistoryService.getHistory());
  }

  // ================== POPUP TAMBAH / EDIT RIWAYAT ==================
  void _openForm({int? index}) {
    // Jika edit → preload data ke input
    if (index != null) {
      treatmentC.text = history[index]["treatment"]!;
      dateC.text = history[index]["date"]!;
      statusC.text = history[index]["status"]!;
    } else {
      // Jika tambah baru → kosongkan
      treatmentC.clear();
      dateC.clear();
      statusC.clear();
    }

    // Popup form
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Appcolor.softPinkPastel,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          index == null ? "Tambah Riwayat" : "Edit Riwayat",
          style: TextStyle(color: Appcolor.textBrownSoft, fontWeight: FontWeight.w700),
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
          // Tombol batal
          TextButton(
            onPressed: ()=>Navigator.pop(context),
            child: Text("Batal", style: TextStyle(color: Appcolor.textBrownSoft)),
          ),

          // Tombol simpan
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Appcolor.button1),
            onPressed: () async {
              // Jika tambah → simpan data baru
              if (index == null) {
                await HistoryService.addHistory(
                  treatment: treatmentC.text,
                  date: dateC.text,
                  status: statusC.text.isEmpty ? "Menunggu Konfirmasi" : statusC.text,
                );
              } else {
                // Jika edit → update data
                await HistoryService.updateHistory(index, {
                  "treatment": treatmentC.text,
                  "date": dateC.text,
                  "status": statusC.text,
                });
              }

              await _loadHistory(); // Refresh tampilan data
              Navigator.pop(context); // Tutup popup
            },
            child: const Text("Simpan", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // Dropdown status pesanan di popup
  Widget _statusDropdown() {
    final items = ["Menunggu Konfirmasi", "Dijadwalkan", "Selesai", "Dibatalkan"];

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField(
        value: statusC.text.isEmpty ? null : statusC.text,
        decoration: _inputDecoration("Status"),
        items: items.map((e)=>DropdownMenuItem(value:e, child: Text(e))).toList(),
        onChanged: (v)=> statusC.text = v ?? "",
      ),
    );
  }

  // Input field reusable untuk treatment & tanggal
  Widget _textInput(String label, TextEditingController c) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: c,
        decoration: _inputDecoration(label),
      ),
    );
  }

  // Gaya form input
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

  // Warna status badge
  Color _statusColor(String status) {
    switch (status) {
      case "Menunggu Konfirmasi": return Colors.orangeAccent;
      case "Dijadwalkan": return Colors.blueAccent;
      case "Selesai": return Colors.green;
      case "Dibatalkan": return Colors.redAccent;
      default: return Appcolor.button1;
    }
  }

  // ================== UI MAIN ==================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        centerTitle: true,
        title: const Text("Riwayat Pesanan", style: TextStyle(color: Colors.white)),
      ),

      // Tombol tambah
      floatingActionButton: FloatingActionButton(
        backgroundColor: Appcolor.button1,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => _openForm(),
      ),

      // Jika belum ada riwayat
      body: history.isEmpty
          ? Center(child: Text("Belum ada riwayat pesanan 💗", style: TextStyle(color: Appcolor.textBrownSoft)))

          // Jika ada → tampilkan list
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
                      BoxShadow(color: Colors.black12.withOpacity(0.08), blurRadius: 8, offset: const Offset(0, 3))
                    ],
                  ),

                  // Isi card pesanan
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item["treatment"]!, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      Text(item["date"]!, style: TextStyle(color: Appcolor.textBrownSoft)),
                      const SizedBox(height: 12),

                      // Badge status
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _statusColor(item["status"]!).withOpacity(0.18),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(item["status"]!,
                          style: TextStyle(color: _statusColor(item["status"]!), fontWeight: FontWeight.w700)),
                      ),

                      const SizedBox(height: 16),

                      // Tombol Edit | Batalkan | Hapus
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _actionBtn("Edit", Icons.edit_outlined, Appcolor.button1, () => _openForm(index: i)),
                          _actionBtn("Batalkan", Icons.cancel_outlined, Colors.orangeAccent, () async {
                            await HistoryService.updateHistory(i, {
                              "treatment": item["treatment"]!,
                              "date": item["date"]!,
                              "status": "Dibatalkan",
                            });
                            await _loadHistory();
                          }),
                          _actionBtn("Hapus", Icons.delete_outline, Colors.redAccent, () async {
                            await HistoryService.deleteHistory(i);
                            await _loadHistory();
                          }),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  // Widget tombol aksi kecil (reusable)
  Widget _actionBtn(String label, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
