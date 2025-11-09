import 'dart:convert';
import 'package:glowtap/glowtap/dokter/doctormodelpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:glowtap/glowtap/model/customermodelpage.dart';

class PreferenceHandler {
  static const String isLogin = "isLogin";
  static const String userKey = "userData";

  // ✅ PAKAI SATU KEY INI UNTUK DOKTER
  static const String doctorKey = "doctorLoginData";

  // ================= CUSTOMER ================= //

  // Simpan status login customer
  static Future<void> saveLogin(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLogin, value);
  }

  // Ambil status login customer
  static Future<bool> getLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLogin) ?? false;
  }

  // Simpan data customer
  static Future<void> saveUser(CustomerModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userKey, user.toJson());
  }

  // Ambil data customer
  static Future<CustomerModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(userKey);
    if (data == null) return null;
    return CustomerModel.fromJson(data);
  }

  // Hapus data customer
  static Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userKey);
  }

  // ================= DOKTER ================= //

  // Simpan data dokter login
  static Future<void> saveDoctor(DoctorModel doctor) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(doctorKey, doctor.toJson());
  }

  // Ambil data dokter login
  static Future<DoctorModel?> getDoctor() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(doctorKey);
    if (data == null) return null;
    return DoctorModel.fromJson(data);
  }

  // Hapus session dokter
  static Future<void> removeDoctor() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(doctorKey);
  }

  // ================= CLEAR SESSION ================= //
  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(isLogin);   // status login customer
    await prefs.remove(userKey);   // data customer
    await prefs.remove(doctorKey); // data dokter
  }

  static Future<void> toggleFavoriteEducation(String title) async {
  final prefs = await SharedPreferences.getInstance();
  final list = prefs.getStringList("favEdu") ?? [];
  if (list.contains(title)) {
    list.remove(title);
  } else {
    list.add(title);
  }
  await prefs.setStringList("favEdu", list);
}

static Future<bool> isFavoriteEducation(String title) async {
  final prefs = await SharedPreferences.getInstance();
  final list = prefs.getStringList("favEdu") ?? [];
  return list.contains(title);
}

static Future<List<String>> getFavoriteEducations() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList("favEdu") ?? [];
}

}
