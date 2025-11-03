import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/view_customer/riwayatpesananpage.dart';

class AkunPage extends StatelessWidget {
  const AkunPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCEDE9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8A8A1),
        centerTitle: true,
        title: const Text("Akun Saya", style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ListTile(
            leading: const Icon(Icons.history, color: Color(0xFF5C4A4A)),
            title: const Text("Riwayat Pesanan", style: TextStyle(fontWeight: FontWeight.w600)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const RiwayatPesananPage()));
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.settings, color: Color(0xFF5C4A4A)),
            title: const Text("Pengaturan", style: TextStyle(fontWeight: FontWeight.w600)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const RiwayatPesananPage()));
            },
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.logout, color: Color(0xFF5C4A4A)),
            title: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
