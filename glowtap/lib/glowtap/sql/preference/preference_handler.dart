import 'package:shared_preferences/shared_preferences.dart';
import 'package:glowtap/glowtap/sql/model/customermodelpage.dart';

class PreferenceHandler {
  // Key basic login
  static const String isLogin = "isLogin";
  static const String userKey = "userData";

  // ================= CUSTOMER SESSION ================= //

  // Simpan status login customer
  static Future<void> saveLogin(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLogin, value);
  }

  // Ambil status login
  static Future<bool> getLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLogin) ?? false;
  }

  // Simpan data customer
  static Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userKey, user.toJson());
  }

  // Ambil data customer
  static Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(userKey);

    if (raw == null) return null;

    return UserModel.fromJson(raw);
  }

  // Hapus data customer
  static Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userKey);
    await prefs.remove(isLogin);
  }

  // Hapus semua session user (logout total)
  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(isLogin);
    await prefs.remove(userKey);
  }

  // ================= FAVORIT EDUCATION ================= //

  static const String favEduKey = "favEdu";

  // Toggle favorite education (add/remove)
  static Future<void> toggleFavoriteEducation(String title) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(favEduKey) ?? [];

    if (list.contains(title)) {
      list.remove(title);
    } else {
      list.add(title);
    }

    await prefs.setStringList(favEduKey, list);
  }

  // Cek apakah education favorit
  static Future<bool> isFavoriteEducation(String title) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(favEduKey) ?? [];
    return list.contains(title);
  }

  // Ambil semua favorit education
  static Future<List<String>> getFavoriteEducations() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(favEduKey) ?? [];
  }
}
