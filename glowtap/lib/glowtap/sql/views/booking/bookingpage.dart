import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/firebase/constant/appcolor.dart';
import 'package:glowtap/glowtap/sql/preference/preference_handler.dart';
import 'package:glowtap/glowtap/sql/views/booking/bookingconfirmpage.dart';

class Bookingpage extends StatefulWidget {
  final String treatmentName;
  final String treatmentPrice;

  const Bookingpage({
    super.key,
    required this.treatmentName,
    required this.treatmentPrice,
  });

  @override
  State<Bookingpage> createState() => _BookingpageState();
}

class _BookingpageState extends State<Bookingpage> {
  DateTime? selectedDate;
  String? selectedTime;

  final TextEditingController alamatC = TextEditingController();
  final TextEditingController catatanC = TextEditingController();

  final List<String> timeSlots = [
    "09:00", "10:30", "13:00", "15:00", "17:00", "19:00",
  ];

  Future pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      initialDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: Appcolor.button1),
          ),
          child: child!,
        );
      },
    );

    if (date != null) setState(() => selectedDate = date);
  }

  void confirm() async {
    if (selectedDate == null || selectedTime == null || alamatC.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lengkapi jadwal & alamat dulu ya 💗")),
      );
      return;
    }

    final customer = await PreferenceHandler.getUser();
    final customerPhone = customer?.phone ?? "-";

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookingConfirmPage(
          treatmentName: widget.treatmentName,
          treatmentPrice: widget.treatmentPrice,
          customerPhone: customerPhone,
          selectedDate:
              "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
          selectedTime: selectedTime!,
          address: alamatC.text,
          note: catatanC.text,
        ),
      ),
    );
  }

  Widget inputField(String label, TextEditingController c,
      {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                color: Appcolor.textBrownSoft, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextField(
          controller: c,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        centerTitle: true,
        title: const Text("Atur Jadwal & Lokasi",
            style: TextStyle(color: Colors.white)),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----------------------------------
            // TANGGAL
            // ----------------------------------
            Text("Tanggal Treatment ✨",
                style: TextStyle(
                    color: Appcolor.textBrownSoft,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),

            InkWell(
              onTap: pickDate,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14)),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month, color: Colors.pink),
                    const SizedBox(width: 12),
                    Text(
                      selectedDate == null
                          ? "Pilih tanggal"
                          : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                      style: TextStyle(color: Appcolor.textBrownSoft),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ----------------------------------
            // PILIH JAM
            // ----------------------------------
            Text("Pilih Jam ⏰",
                style: TextStyle(
                    color: Appcolor.textBrownSoft,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: timeSlots.map((time) {
                final isSelected = time == selectedTime;
                return ChoiceChip(
                  label: Text(time),
                  selected: isSelected,
                  selectedColor: Appcolor.button1,
                  labelStyle: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : Appcolor.textBrownSoft),
                  onSelected: (_) => setState(() => selectedTime = time),
                );
              }).toList(),
            ),

            const SizedBox(height: 28),

            // ----------------------------------
            // ALAMAT + CATATAN
            // ----------------------------------
            inputField("Alamat Lengkap", alamatC),
            const SizedBox(height: 16),

            inputField("Catatan (Opsional)", catatanC, maxLines: 3),
            const SizedBox(height: 30),

            // ----------------------------------
            // INFORMASI PEMBAYARAN
            // ----------------------------------
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                    color: Appcolor.textBrownLight.withOpacity(.25)),
              ),
              child: Row(
                children: [
                  const Text("💗", style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Pembayaran dilakukan ketika tim GlowTap datang (COD) ✨",
                      style: TextStyle(
                          color: Appcolor.textBrownSoft,
                          fontSize: 14,
                          height: 1.4),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ----------------------------------
            // TOMBOL KONFIRMASI
            // ----------------------------------
            ElevatedButton(
              onPressed: confirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolor.button1,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text("Konfirmasi Pemesanan ✨",
                  style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
