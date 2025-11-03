import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryService {
  static List<Map<String, String>> _history = [];

  static Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('history_data');
    if (data != null) {
      List decoded = jsonDecode(data);
      _history = decoded.map((e) => Map<String, String>.from(e)).toList();
    }
  }

  static Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('history_data', jsonEncode(_history));
  }

  static List<Map<String, String>> getHistory() => _history;

  static Future<void> addHistory({
    required String treatment,
    required String date,
    required String status,
  }) async {
    _history.add({"treatment": treatment, "date": date, "status": status});
    await _saveHistory();
  }

  static Future<void> updateHistory(int index, Map<String, String> newData) async {
    _history[index] = newData;
    await _saveHistory();
  }

  static Future<void> deleteHistory(int index) async {
    _history.removeAt(index);
    await _saveHistory();
  }
}
