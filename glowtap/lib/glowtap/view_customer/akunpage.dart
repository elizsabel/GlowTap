import 'package:flutter/material.dart';
import 'package:glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/model/customer_model.dart';
import 'package:glowtap/glowtap/preferences/preference_handler.dart';
import 'package:glowtap/glowtap/view_customer/editprofilpage.dart';
import 'package:glowtap/glowtap/view_customer/riwayatpesananpage.dart';
import 'package:glowtap/glowtap/view_customer/loginpage.dart';

class AkunPage extends StatefulWidget {
  const AkunPage({super.key});

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  CustomerModel? user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final data = await PreferenceHandler.getUser();
    setState(() => user = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        centerTitle: true,
        title: const Text("Akun Saya", style: TextStyle(color: Colors.white)),
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 48,
                        backgroundImage: AssetImage(
                          "assets/images/artikel.png",
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        user!.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Appcolor.textBrownSoft,
                        ),
                      ),
                      Text(
                        user!.email,
                        style: TextStyle(
                          fontSize: 14,
                          color: Appcolor.textBrownSoft.withOpacity(.7),
                        ),
                      ),
                      Text(
                        user!.phone,
                        style: TextStyle(
                          fontSize: 14,
                          color: Appcolor.textBrownSoft.withOpacity(.7),
                        ),
                      ),
                      Text(
                        user!.city,
                        style: TextStyle(
                          fontSize: 14,
                          color: Appcolor.textBrownSoft.withOpacity(.7),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                _menuItem(
                  icon: Icons.history,
                  text: "Riwayat Pesanan",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RiwayatPesananPage(),
                    ),
                  ),
                ),

                _menuItem(
                  icon: Icons.edit_outlined,
                  text: "Edit Profil",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EditProfilPage()),
                  ),
                ),

                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () async {
                    await PreferenceHandler.removeLogin();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginCustGlow()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolor.rosegoldDark,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: Appcolor.button1, size: 26),
            const SizedBox(width: 14),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Appcolor.textBrownSoft,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Appcolor.textBrownSoft.withOpacity(.6),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
