import 'package:flutter/material.dart';

class AlamatPage extends StatefulWidget {
  const AlamatPage({super.key});

  @override
  State<AlamatPage> createState() => _AlamatPageState();
}

class _AlamatPageState extends State<AlamatPage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController teleponController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController catatanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCEDE9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8A8A1),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Alamat Home Service",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(label: "Nama Penerima", controller: namaController),

            const SizedBox(height: 16),

            _buildTextField(
              label: "Nomor Telepon",
              controller: teleponController,
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 16),

            _buildTextField(
              label: "Alamat Lengkap",
              controller: alamatController,
              maxLines: 3,
            ),

            const SizedBox(height: 16),

            _buildTextField(
              label: "Catatan Tambahan (Opsional)",
              controller: catatanController,
              maxLines: 2,
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  
                  // TODO: Lanjut ke Halaman Pembayaran
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE8A8A1),
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

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF5C4A4A),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFFF0D4CF)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFFE8A8A1)),
            ),
          ),
        ),
      ],
    );
  }
}
