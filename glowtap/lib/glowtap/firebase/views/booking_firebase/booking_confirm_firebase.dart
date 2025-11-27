import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/firebase/constant/appcolor.dart';
import 'package:glowtap/glowtap/firebase/models_firebase/historyfirebasemodel.dart';
import 'package:glowtap/glowtap/firebase/preference_firebase/preference_handler_firebase.dart';
import 'package:glowtap/glowtap/firebase/service/history_firebase.dart';
import 'package:glowtap/glowtap/firebase/nav_firebase/bottomnavfirebase.dart';

class BookingConfirmFirebasePage extends StatelessWidget {
  final String treatmentName;
  final String treatmentPrice;
  final String selectedDate;
  final String selectedTime;
  final String address;
  final String note;
  final String customerPhone;

  const BookingConfirmFirebasePage({
    super.key,
    required this.treatmentName,
    required this.treatmentPrice,
    required this.selectedDate,
    required this.selectedTime,
    required this.address,
    required this.note,
    required this.customerPhone,
  });

  Future<void> _saveBooking(BuildContext context) async {
    print("=== SAVE BOOKING TERPANGGIL ===");

    final uid = await PreferenceHandlerFirebase.getToken();

    print("UID: $uid");
    print("DATE: $selectedDate");
    print("TIME: $selectedTime");
    print("ADDRESS: $address");

    if (uid == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("User tidak ditemukan 😢")));
      return;
    }

    final isoDate =
        "${selectedDate.split('/')[2]}-${selectedDate.split('/')[1]}-${selectedDate.split('/')[0]}";

    final booking = HistoryFirebaseModel(
      uid: uid,
      treatment: treatmentName,
      doctor: "GlowTap",
      doctorPhone: "-",
      customerPhone: customerPhone,
      date: isoDate,
      time: selectedTime,
      price: treatmentPrice,
      address: address,
      note: note,
      status: "Dijadwalkan",
    );

    await HistoryFirebaseService.addBooking(booking);

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Pemesanan berhasil! GlowTap akan menghubungi kamu 💗"),
      ),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const BottomNavFirebase()),
      (route) => false,
    );
  }

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
            _info("Treatment", treatmentName),
            const SizedBox(height: 14),
            _info("Harga", treatmentPrice),
            const SizedBox(height: 14),
            _info("Tanggal & Waktu", "$selectedDate • $selectedTime"),
            const SizedBox(height: 14),
            _info("Alamat", address),
            const SizedBox(height: 14),
            if (note.isNotEmpty) _info("Catatan", note),
            const Spacer(),
            ElevatedButton(
              onPressed: () => _saveBooking(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolor.button1,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                "Buat Pesanan 🛍️",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _info(String title, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
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
