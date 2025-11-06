import 'package:shared_preferences/shared_preferences.dart';
import 'package:glowtap/glowtap/model/customermodelpage.dart';

class PreferenceHandler {
  static const String isLogin = "isLogin";
  static const String userKey = "userData";

  // Simpan status login
  static Future<void> saveLogin(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLogin, value);
  }

  // Ambil status login
  static Future<bool> getLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLogin) ?? false;
  }

  // Simpan data user
  static Future<void> saveUser(CustomerModel user) async {
    final prefs = await SharedPreferences.getInstance();
    // Karena toJson() milik kamu sudah berbentuk String → simpan langsung
    await prefs.setString(userKey, user.toJson());
  }

  // Ambil data user
  static Future<CustomerModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(userKey);
    if (data == null) return null;
    return CustomerModel.fromJson(data);
  }

  // Hapus hanya data user
  static Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userKey);
  }

  // Hapus status login saja
  static Future<void> removeLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(isLogin);
  }

  // Bersihkan SEMUA session (opsional)
  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(isLogin);
    await prefs.remove(userKey);
  }
}
