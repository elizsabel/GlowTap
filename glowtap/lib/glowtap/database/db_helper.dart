import 'package:glowtap/glowtap/model/customer_model.dart';
import 'package:glowtap/glowtap/view_customer/journalmodel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static const tableCustomer = 'Customer';
  static const tableHistory = 'History';
  static const tableJournal = 'Journal';

  static Future<Database> db() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'GlowTap.db'),
      version: 4,
      onCreate: (db, version) async {
        await db.execute("""
        CREATE TABLE $tableCustomer(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT,
          name TEXT,
          email TEXT,
          phone TEXT,
          password TEXT
        )
        """);

        await db.execute("""
        CREATE TABLE $tableHistory(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          treatment TEXT,
          date TEXT,
          time TEXT,
          price TEXT,
          address TEXT,
          note TEXT,
          status TEXT
        )
        """);

        await db.execute("""
        CREATE TABLE $tableJournal(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          content TEXT,
          date TEXT
        )
        """);
      },

      onUpgrade: (db, oldV, newV) async {
        await db.execute("""
        CREATE TABLE IF NOT EXISTS $tableJournal(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          content TEXT,
          date TEXT
        )
        """);
      },
    );
  }

  // CUSTOMER
  static Future<void> registerUser(CustomerModel user) async {
    final database = await db();
    await database.insert(tableCustomer, user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<CustomerModel?> loginUser({required String email, required String password}) async {
    final database = await db();
    final results = await database.query(
      tableCustomer,
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (results.isNotEmpty) return CustomerModel.fromMap(results.first);
    return null;
  }

  static Future<void> updateCustomer(CustomerModel customer) async {
    final database = await db();
    await database.update(tableCustomer, customer.toMap(), where: "id = ?", whereArgs: [customer.id]);
  }

  // HISTORY
  static Future<int> addHistory({
    required String treatment,
    required String date,
    required String time,
    required String price,
    required String address,
    required String note,
    required String status,
  }) async {
    final database = await db();
    return await database.insert(tableHistory, {
      'treatment': treatment,
      'date': date,
      'time': time,
      'price': price,
      'address': address,
      'note': note,
      'status': status,
    });
  }

  static Future<List<Map<String, dynamic>>> getHistory() async {
    final database = await db();
    return await database.query(tableHistory, orderBy: "id DESC");
  }

  static Future<int> updateHistoryStatus(int id, String status) async {
    final database = await db();
    return await database.update(tableHistory, {'status': status}, where: "id = ?", whereArgs: [id]);
  }

  static Future<int> deleteHistory(int id) async {
    final database = await db();
    return await database.delete(tableHistory, where: "id = ?", whereArgs: [id]);
  }

  // JOURNAL
  static Future<int> addJournal(JournalModel j) async {
    final database = await db();
    return await database.insert(tableJournal, j.toMap());
  }

  static Future<List<JournalModel>> getJournal() async {
    final database = await db();
    final result = await database.query(tableJournal, orderBy: "id DESC");
    return result.map((e) => JournalModel.fromMap(e)).toList();
  }

  static Future<int> updateJournal(JournalModel j) async {
    final database = await db();
    return await database.update(tableJournal, j.toMap(), where: "id = ?", whereArgs: [j.id]);
  }

  static Future<int> deleteJournal(int id) async {
    final database = await db();
    return await database.delete(tableJournal, where: "id = ?", whereArgs: [id]);
  }
}
