import 'package:glowtap/glowtap/model/customer_model.dart';
import 'package:glowtap/glowtap/view_customer/journalmodel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static const tableCustomer = 'Customer';
  static const tableHistory = 'History';

  // Mendapatkan database (getter)
  static Future<Database> db() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'GlowTap.db'),
      version: 2,
      onCreate: (db, version) async {
        await db.execute("""
          CREATE TABLE $tableCustomer(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
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
            status TEXT
          )
        """);

        await db.execute("""
          CREATE TABLE Journal(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT,
            note TEXT
          )
        """);

        
      },
    );
  }

  // ========== CUSTOMER CRUD ==========

  static Future<void> registerUser(CustomerModel user) async {
    final dbs = await db();
    await dbs.insert(
      tableCustomer,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<CustomerModel?> loginUser({
    required String email,
    required String password,
  }) async {
    final dbs = await db(); // ✅ perbaikan: pakai db()
    final results = await dbs.query(
      tableCustomer, // ✅ perbaikan: pakai tabel Customer
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (results.isNotEmpty) {
      return CustomerModel.fromMap(results.first);
    } else {
      return null;
    }
  }

  static Future<List<CustomerModel>> getAllCustomer() async {
    final dbs = await db();
    final results = await dbs.query(tableCustomer);
    return results.map((e) => CustomerModel.fromMap(e)).toList();
  }

  static Future<void> updateCustomer(CustomerModel customer) async {
    final dbs = await db();
    await dbs.update(
      tableCustomer,
      customer.toMap(),
      where: "id = ?",
      whereArgs: [customer.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteCustomer(int id) async {
    final dbs = await db();
    await dbs.delete(tableCustomer, where: "id = ?", whereArgs: [id]);
  }

  // ========== HISTORY CRUD ==========

  static Future<int> addHistory({
    required String treatment,
    required String date,
    required String status,
  }) async {
    final dbs = await db();
    return await dbs.insert(tableHistory, {
      'treatment': treatment,
      'date': date,
      'status': status,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getHistory() async {
    final dbs = await db();
    return await dbs.query(tableHistory, orderBy: "id DESC");
  }

  static Future<int> updateHistoryStatus(int id, String status) async {
    final dbs = await db();
    return await dbs.update(
      tableHistory,
      {'status': status},
      where: "id = ?",
      whereArgs: [id],

    );
  }

// ========== JOURNAL CRUD ==========

static Future<int> addJournal(JournalModel journal) async {
  final dbs = await db();
  return await dbs.insert('Journal', journal.toMap());
}

static Future<List<JournalModel>> getJournal() async {
  final dbs = await db();
  final res = await dbs.query('Journal', orderBy: "id DESC");
  return res.map((e) => JournalModel.fromMap(e)).toList();
}

static Future<int> updateJournal(JournalModel journal) async {
  final dbs = await db();
  return await dbs.update(
    'Journal',
    journal.toMap(),
    where: "id = ?",
    whereArgs: [journal.id],
  );
}

static Future<int> deleteJournal(int id) async {
  final dbs = await db();
  return await dbs.delete('Journal', where: "id = ?", whereArgs: [id]);
}



  static Future<int> deleteHistory(int id) async {
    final dbs = await db();
    return await dbs.delete(tableHistory, where: "id = ?", whereArgs: [id]);
  }
}
