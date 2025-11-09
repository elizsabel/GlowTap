import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/database/db_helper.dart';
import 'package:glowtap/glowtap/dokter/doctormodelpage.dart';
import 'package:glowtap/glowtap/views/booking/bookingpage.dart';

class DoctorPickerPage extends StatefulWidget {
  final String treatmentName;
  final String treatmentPrice;

  const DoctorPickerPage({
    super.key,
    required this.treatmentName,
    required this.treatmentPrice,
  });

  @override
  State<DoctorPickerPage> createState() => _DoctorPickerPageState();
}

class _DoctorPickerPageState extends State<DoctorPickerPage> {
  List<DoctorModel> doctors = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    doctors = await DbHelper.getDoctors();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        title: const Text("Pilih Dokter", style: TextStyle(color: Colors.white)),
        backgroundColor: Appcolor.button1,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: doctors.isEmpty
          ? const Center(child: Text("Belum ada dokter terdaftar"))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: doctors.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) {
                final d = doctors[i];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Bookingpage(
                          treatmentName: widget.treatmentName,
                          treatmentPrice: widget.treatmentPrice,
                          doctorName: d.name,
                          doctorPhone:d.phone,           // ✅ kirim ke booking
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Appcolor.textBrownLight.withOpacity(.25)),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: Appcolor.button1.withOpacity(.2),
                          child: Text(d.name[0]),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(d.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Appcolor.textBrownSoft)),
                              Text(d.specialty),
                              const SizedBox(height: 4),
                              Text("⭐ ${d.rating.toStringAsFixed(1)} • ${d.area}"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
