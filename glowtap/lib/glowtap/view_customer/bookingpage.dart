import 'package:flutter/material.dart';
import 'package:glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/database/db_helper.dart';
import 'package:glowtap/glowtap/view_customer/metodepembayaranpage.dart';
import 'package:glowtap/glowtap/view_customer/riwayatpesananpage.dart';
import 'package:glowtap/glowtap/view_customer/uploadbuktipage.dart';

class BookingPage extends StatefulWidget {
  final String treatmentName;
  final String treatmentPrice;

  const BookingPage({
    super.key,
    required this.treatmentName,
    required this.treatmentPrice,
  });

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String? selectedDoctor;
  DateTime? selectedDate;
  String? selectedTime;

  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  final List<String> doctorList = [
    "dr. Citra Anindya",
    "dr. Fadhila Ayu",
    "dr. Maya Putri",
  ];

  final List<String> timeSlots = ["09:00", "11:00", "13:00", "15:00", "17:00"];

  @override
  Widget build(BuildContext context) {
    final ready =
        selectedDoctor != null &&
        selectedDate != null &&
        selectedTime != null &&
        addressController.text.isNotEmpty &&
        phoneController.text.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFFCEDE9),
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        centerTitle: true,
        title: Text(
          "Booking ${widget.treatmentName}",
          style: const TextStyle(color: Colors.white),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _section(
            title: "Pilih Dokter",
            child: DropdownButtonFormField(
              value: selectedDoctor,
              decoration: _input("Pilih Dokter"),
              items: doctorList
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => selectedDoctor = v),
            ),
          ),

          _section(
            title: "Pilih Tanggal",
            child: GestureDetector(
              onTap: _selectDate,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: _box(),
                child: Text(
                  selectedDate == null
                      ? "DD / MM / YYYY"
                      : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                ),
              ),
            ),
          ),

          _section(
            title: "Pilih Waktu",
            child: Wrap(
              spacing: 10,
              children: timeSlots
                  .map(
                    (time) => ChoiceChip(
                      label: Text(time),
                      selected: selectedTime == time,
                      selectedColor: Appcolor.button1,
                      onSelected: (_) => setState(() => selectedTime = time),
                      labelStyle: TextStyle(
                        color: selectedTime == time
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),

          _section(
            title: "Alamat Rumah",
            child: TextField(
              controller: addressController,
              decoration: _input("Masukkan alamat lengkap"),
            ),
          ),
          _section(
            title: "No. Telepon",
            child: TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: _input("08xxxxxxxxxx"),
            ),
          ),

          const SizedBox(height: 28),
          ElevatedButton(
            onPressed: ready ? _showSummary : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Appcolor.button1,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text(
              "Lanjut ke Pembayaran",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // ========= RINGKASAN =========
  void _showSummary() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SummaryRow(label: "Treatment", value: widget.treatmentName),
            SummaryRow(label: "Dokter", value: selectedDoctor!),
            SummaryRow(
              label: "Tanggal",
              value:
                  "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
            ),
            SummaryRow(label: "Waktu", value: selectedTime!),
            SummaryRow(label: "Alamat", value: addressController.text),
            SummaryRow(label: "Telepon", value: phoneController.text),
            SummaryRow(label: "Harga", value: widget.treatmentPrice),

            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);

                final metode = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        MetodePembayaranPage(totalPrice: widget.treatmentPrice),
                  ),
                );

                print("Metode dipilih: $metode");

                if (metode == "COD") {
                  await DbHelper.addHistory(
                    treatment: widget.treatmentName,
                    date:
                        "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year} • $selectedTime",
                    status: "Menunggu Konfirmasi",
                  );

                  final hasil = await DbHelper.getHistory();
                  print("ISI DATABASE SEKARANG = $hasil");

                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const RiwayatPesananPage(),
                    ),
                    (route) => false,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolor.button1,
              ),
              child: const Text(
                "Konfirmasi & Simpan",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========= UI HELPER =========
  Widget _section({required String title, required Widget child}) => Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Appcolor.softPinkPastel,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Appcolor.textBrownSoft,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    ),
  );

  InputDecoration _input(String label) => InputDecoration(
    labelText: label,
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  );
  BoxDecoration _box() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Appcolor.textBrownLight.withOpacity(0.3)),
  );
  // Widget _summary(String a, String b)=>Padding(padding: const EdgeInsets.only(bottom: 8), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children:[Text(a), Text(b, style: const TextStyle(fontWeight: FontWeight.w600))]));
  void _selectDate() async {
    final d = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      initialDate: DateTime.now(),
    );
    if (d != null) setState(() => selectedDate = d);
  }
}

class SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const SummaryRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
