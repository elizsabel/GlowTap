import 'package:flutter/material.dart';
import 'package:glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/model/customer_model.dart';
import 'package:glowtap/glowtap/preferences/preference_handler.dart';
import 'package:glowtap/glowtap/view_customer/editprofilpage.dart';
import 'package:glowtap/glowtap/view_customer/loginpage.dart';

class AkunPage extends StatefulWidget {
  const AkunPage({super.key});

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  Future<CustomerModel?> _getUser() async {
    return await PreferenceHandler.getUser();
  }

  String _initial(String? name) {
    if (name == null || name.trim().isEmpty) return "?";
    final parts = name.trim().split(" ");
    if (parts.length >= 2) return (parts[0][0] + parts[1][0]).toUpperCase();
    return parts[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        centerTitle: true,
        title: const Text("Profil Saya", style: TextStyle(color: Colors.white)),
      ),
      body: FutureBuilder<CustomerModel?>(
        future: _getUser(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = snapshot.data!;

          return Center(
            child: Column(
              children: [
                const SizedBox(height: 40),

                CircleAvatar(
                  radius: 48,
                  backgroundColor: Appcolor.button1.withOpacity(.85),
                  child: Text(
                    _initial(user.name),
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                Text(
                  user.name.isEmpty ? "-" : user.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Appcolor.textBrownSoft,
                  ),
                ),

                Text(
                  user.email,
                  style: TextStyle(
                    fontSize: 14,
                    color: Appcolor.textBrownSoft.withOpacity(.7),
                  ),
                ),

                if (user.phone.isNotEmpty)
                  Text(
                    user.phone,
                    style: TextStyle(
                      fontSize: 14,
                      color: Appcolor.textBrownSoft.withOpacity(.7),
                    ),
                  ),

                const SizedBox(height: 30),

                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(.08),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _menuButton(
                        icon: Icons.person_outline,
                        label: "Edit Profil",
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const EditProfilPage(),
                            ),
                          );

                          if (result == true) {
                            setState(
                              () {},
                            ); // ✅ LANGSUNG REFRESH TANPA PINDAH TAB
                          }
                        },
                      ),
                      const Divider(),
                      _menuButton(
                        icon: Icons.logout_outlined,
                        label: "Logout",
                        onTap: () async {
                          await PreferenceHandler.clearSession();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginCustGlow(),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _menuButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: Appcolor.button1),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Appcolor.textBrownSoft,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Appcolor.textBrownSoft.withOpacity(.5),
            ),
          ],
        ),
      ),
    );
  }
}
