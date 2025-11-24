import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/database/db_helper.dart';
import 'package:glowtap/navigation/bottompage.dart';

class BookingConfirmPage extends StatelessWidget {
  final String treatmentName;
  final String treatmentPrice;
  final String selectedDate;
  final String selectedTime;
  final String address;
  final String note;
  final String customerPhone;

  const BookingConfirmPage({
    super.key,
    required this.treatmentName,
    required this.treatmentPrice,
    required this.selectedDate,
    required this.selectedTime,
    required this.address,
    required this.note,
    required this.customerPhone,
  });

  // ==========================================
  // SIMPAN KE HISTORY
  // ==========================================
  Future<void> _saveBooking(BuildContext context) async {
    await DbHelper.addHistory(
      treatment: treatmentName,
      doctor: "GlowTap Therapist",   // <─ otomatis
      doctorPhone: "-",              // <─ tidak ada dokter
      customerPhone: customerPhone,
      date: selectedDate,
      time: selectedTime,
      price: treatmentPrice,
      address: address,
      note: note,
      status: "Dijadwalkan",
    );

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Pesanan berhasil dibuat ✨ GlowTap akan menghubungi kamu 💗"),
      ),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const BottomNavPage()),
      (route) => false,
    );
  }

  // ==========================================
  // UI
  // ==========================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        centerTitle: true,
        title: const Text(
          "Konfirmasi Pemesanan",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoBox("Treatment", treatmentName),
            const SizedBox(height: 14),

            _infoBox("Harga", treatmentPrice),
            const SizedBox(height: 14),

            _infoBox("Tanggal & Waktu", "$selectedDate • $selectedTime"),
            const SizedBox(height: 14),

            _infoBox("Alamat", address),
            const SizedBox(height: 14),

            if (note.isNotEmpty) _infoBox("Catatan", note),
            const SizedBox(height: 14),

            _infoBox("Metode Pembayaran", "COD (Bayar di tempat)"),
            const Spacer(),

            ElevatedButton(
              onPressed: () => _saveBooking(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolor.button1,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                "Buat Pesanan 🛍️",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoBox(String title, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Appcolor.textBrownLight.withOpacity(.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Appcolor.textBrownSoft.withOpacity(.7),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Appcolor.textBrownSoft,
            ),
          ),
        ],
      ),
    );
  }
}
