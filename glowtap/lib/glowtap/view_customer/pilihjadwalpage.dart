import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/view_customer/alamatpage.dart';

class PilihJadwalPage extends StatefulWidget {
  const PilihJadwalPage({super.key});

  @override
  State<PilihJadwalPage> createState() => _PilihJadwalPageState();
}

class _PilihJadwalPageState extends State<PilihJadwalPage> {
  DateTime? selectedDate;
  String? selectedTime;

  final List<String> availableTimes = [
    "09:00",
    "10:30",
    "13:00",
    "15:00",
    "17:00",
    "19:00",
  ];

  Future<void> pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      initialDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFE8A8A1),
              onPrimary: Colors.white,
              onSurface: Color(0xFF5C4A4A),
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCEDE9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8A8A1),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Pilih Jadwal",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tanggal Perawatan",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5C4A4A),
              ),
            ),

            const SizedBox(height: 10),

            GestureDetector(
              onTap: pickDate,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFF0D4CF)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate == null
                          ? "Pilih tanggal"
                          : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                      style: const TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 15,
                        color: Color(0xFF5C4A4A),
                      ),
                    ),
                    const Icon(Icons.calendar_month, color: Color(0xFF5C4A4A)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              "Pilih Jam",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5C4A4A),
              ),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: availableTimes.map((time) {
                final bool isSelected = selectedTime == time;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTime = time;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 18,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFE8A8A1)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFF0D4CF)),
                    ),
                    child: Text(
                      time,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF5C4A4A),
                        fontFamily: "Nunito",
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (selectedDate == null || selectedTime == null)
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) =>  
                          AlamatPage()),
                        );
                        // TODO: Lanjut ke Halaman Isi Alamat
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE8A8A1),
                  disabledBackgroundColor: const Color(0xFFEECFCC),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Lanjutkan",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
