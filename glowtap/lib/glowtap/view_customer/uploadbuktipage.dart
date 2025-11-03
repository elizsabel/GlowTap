import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/database/history_service.dart';

class UploadBuktiPage extends StatefulWidget {
  final int index; // index riwayat yang harus diperbarui
  const UploadBuktiPage({super.key, required this.index});

  @override
  State<UploadBuktiPage> createState() => _UploadBuktiPageState();
}

class _UploadBuktiPageState extends State<UploadBuktiPage> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  Future<void> _save() async {
    if (_image == null) return;

    // Simpan status pembayaran → menunggu konfirmasi admin
    await HistoryService.updateHistory(widget.index, {
      "treatment": HistoryService.getHistory()[widget.index]["treatment"]!,
      "date": HistoryService.getHistory()[widget.index]["date"]!,
      "status": "Menunggu Verifikasi Pembayaran",
      "bukti": _image!.path, // simpan path gambar
    });

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Bukti pembayaran berhasil diunggah ✅")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        centerTitle: true,
        title: const Text("Upload Bukti Pembayaran", style: TextStyle(color: Colors.white)),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Silahkan unggah bukti transfer / pembayaran QRIS.",
              style: TextStyle(color: Appcolor.textBrownSoft, fontSize: 14),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 230,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Appcolor.textBrownLight.withOpacity(0.3)),
                ),
                child: _image == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.upload_rounded, size: 50, color: Appcolor.button1),
                          const SizedBox(height: 8),
                          Text("Tap untuk upload bukti", style: TextStyle(color: Appcolor.textBrownSoft)),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.file(_image!, fit: BoxFit.cover),
                      ),
              ),
            ),

            const SizedBox(height: 26),

            ElevatedButton(
              onPressed: _image == null ? null : _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolor.button1,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text("Upload dan Simpan", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
