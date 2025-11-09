import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/dokter/doctormodelpage.dart';

class DoctorViewPage extends StatelessWidget {
  final DoctorModel data;
  const DoctorViewPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        title: const Text("Profil Dokter", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                CircleAvatar(radius: 30, backgroundColor: Appcolor.button1.withOpacity(.15), child: Text(data.name[0])),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(data.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Appcolor.textBrownSoft)),
                    Text("${data.specialty} • ⭐ ${data.rating.toStringAsFixed(1)}"),
                    Text(data.area),
                  ]),
                ),
              ]),
              const SizedBox(height: 12),
              Text("Harga: ${data.price}", style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              const Text("Tentang Dokter"),
              const SizedBox(height: 6),
              Text(data.bio),
            ]),
          ),
        ),
      ),
    );
  }
}
