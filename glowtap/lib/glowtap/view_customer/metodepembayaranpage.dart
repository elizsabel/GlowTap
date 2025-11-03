import 'package:flutter/material.dart';
import 'package:glowtap/constant/appcolor.dart';

class MetodePembayaranPage extends StatelessWidget {
  final String totalPrice;
  const MetodePembayaranPage({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(backgroundColor: Appcolor.button1, centerTitle: true, title: const Text("Metode Pembayaran", style: TextStyle(color: Colors.white))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Total Pembayaran", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Appcolor.textBrownSoft)),
          const SizedBox(height: 6),
          Text(totalPrice, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Appcolor.textBrownSoft)),

          const SizedBox(height: 24),
          const Text("Hanya tersedia Pembayaran", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),

          const SizedBox(height: 16),
          _pay(context, Icons.home_outlined, "COD (Bayar di Tempat)", "Bayar saat treatment dilakukan.", "COD"),
          const SizedBox(height: 14),
          // _pay(context, Icons.qr_code_2_rounded, "QRIS", "Scan QR semua e-wallet.", "QRIS"),
          // const SizedBox(height: 14),
          // _pay(context, Icons.account_balance_outlined, "Transfer Bank", "BCA • Mandiri • BNI • BRI", "Transfer"),
        ]),
      ),
    );
  }

  Widget _pay(BuildContext context, IconData i, String title, String sub, String value){
    return InkWell(
      onTap: ()=> Navigator.pop(context, value),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Appcolor.textBrownLight.withOpacity(0.3))),
        child: Row(children:[
          Icon(i, size: 34, color: Appcolor.button1), const SizedBox(width: 14),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
            Text(title, style: TextStyle(fontWeight: FontWeight.w700, color: Appcolor.textBrownSoft)),
            Text(sub, style: TextStyle(fontSize: 12, color: Appcolor.textBrownSoft.withOpacity(.7))),
          ]),
        ]),
      ),
    );
  }
}
