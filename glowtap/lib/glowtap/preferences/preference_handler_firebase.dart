import 'package:shared_preferences/shared_preferences.dart';
import 'package:glowtap/glowtap/model/userfirebasemodelpage.dart';

class PreferenceHandlerFirebase {
  static const String isLoginKey = "isLogin";
  static const String userFirebaseKey = "user_firebase";
  static const String userToken = "userToken";

  // LOGIN STATUS
  static Future<void> saveLogin(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLoginKey, value);
  }

  static Future<bool> getLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoginKey) ?? false;
  }

  // TOKEN
  static Future<void> saveToken(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userToken, uid);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userToken);
  }

  // USER SESSION
  static Future<void> saveUserFirebase(UserFirebaseModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userFirebaseKey, user.toJson());
  }

  static Future<UserFirebaseModel?> getUserFirebase() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(userFirebaseKey);

    if (raw == null) return null;

    return UserFirebaseModel.fromJson(raw);
  }

  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(isLoginKey);
    await prefs.remove(userFirebaseKey);
    await prefs.remove(userToken);
  }
}
