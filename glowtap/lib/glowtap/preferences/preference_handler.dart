import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:glowtap/glowtap/model/customer_model.dart';

class PreferenceHandler {
  static const String isLogin = "isLogin";
  static const String userKey = "userData";
  static const String isId = "isId";

  // Simpan status login
  static Future<void> saveLogin(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(isLogin, value);
  }

  // Ambil status login
  static Future<bool> getLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLogin) ?? false;
  }

  // Simpan data user
  static Future<void> saveUser(CustomerModel user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(userKey, user.toJson());
  }

  // Ambil data user
  static Future<CustomerModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(userKey);
    if (json == null) return null;
    return CustomerModel.fromJson(json);
  }

  // 

  // Hapus seluruh session
  static Future<void> removeLogin() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(isLogin);
    prefs.remove(userKey);
  }
}
