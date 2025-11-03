import 'package:flutter/material.dart';
import 'package:glowtap/constant/appcolor.dart';

class PilihLokasiPage extends StatefulWidget {
  const PilihLokasiPage({super.key});

  @override
  State<PilihLokasiPage> createState() => _PilihLokasiPageState();
}

class _PilihLokasiPageState extends State<PilihLokasiPage> {
  String? selectedCity;
  final detailAddressC = TextEditingController();

  final List<String> cityList = [
    "Jakarta Selatan",
    "Jakarta Barat",
    "Jakarta Pusat",
    "Jakarta Timur",
    "Jakarta Utara",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        centerTitle: true,
        title: const Text("Pilih Lokasi Rumah", style: TextStyle(color: Colors.white)),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            // Dropdown Kota
            DropdownButtonFormField(
              decoration: _input("Pilih Kota/Kecamatan"),
              value: selectedCity,
              items: cityList.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v)=> setState(()=> selectedCity = v),
            ),

            const SizedBox(height: 16),

            // Alamat detail
            TextField(
              controller: detailAddressC,
              maxLines: 2,
              decoration: _input("Alamat lengkap (nama jalan, blok, nomor rumah)"),
            ),

            const Spacer(),

            // Tombol Simpan
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedCity == null || detailAddressC.text.isEmpty
                    ? null
                    : (){
                        Navigator.pop(context, "$selectedCity - ${detailAddressC.text}");
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolor.button1,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text("Simpan Lokasi", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _input(String label) => InputDecoration(
    labelText: label,
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
  );
}
