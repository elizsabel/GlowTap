import 'package:glowtap/glowtap/sql/model/customermodelpage.dart';
import 'package:glowtap/glowtap/sql/model/journalmodel.dart';
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
      version: 7, // ⬅️ UPDATE VERSION
      onCreate: (db, version) async {
        // CUSTOMER
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

        // HISTORY
        await db.execute("""
        CREATE TABLE $tableHistory(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          treatment TEXT,
          doctor TEXT,
          doctorPhone TEXT,
          customerPhone TEXT,
          date TEXT,
          time TEXT,
          price TEXT,
          address TEXT,
          note TEXT,
          status TEXT
        )
        """);

        // JOURNAL
        await db.execute("""
        CREATE TABLE $tableJournal(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          note TEXT,
          date TEXT
        )
        """);
      },

      // Jika sebelumnya ada tabel dokter → hapus otomatis
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 7) {
          await db.execute("DROP TABLE IF EXISTS Doctor");
        }
      },
    );
  }

  // =====================================================
  // CUSTOMER
  // =====================================================

  static Future<void> registerUser(UserModel user) async {
    final dbs = await db();
    await dbs.insert(
      tableCustomer,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<UserModel?> loginUser({
    required String email,
    required String password,
  }) async {
    final dbs = await db();
    final result = await dbs.query(
      tableCustomer,
      where: "email = ? AND password = ?",
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }
    return null;
  }

  static Future<void> updateCustomer(UserModel customer) async {
    final dbs = await db();
    await dbs.update(
      tableCustomer,
      customer.toMap(),
      where: "id = ?",
      whereArgs: [customer.id],
    );
  }

  // =====================================================
  // HISTORY
  // =====================================================

  static Future<int> addHistory({
    required String treatment,
    required String doctor,
    required String doctorPhone,
    required String customerPhone,
    required String date,
    required String time,
    required String price,
    required String address,
    required String note,
    required String status,
  }) async {
    final dbs = await db();
    return dbs.insert(tableHistory, {
      'treatment': treatment,
      'doctor': doctor,
      'doctorPhone': doctorPhone,
      'customerPhone': customerPhone,
      'date': date,
      'time': time,
      'price': price,
      'address': address,
      'note': note,
      'status': status,
    });
  }

  static Future<List<Map<String, dynamic>>> getHistory() async {
    final dbs = await db();
    return dbs.query(tableHistory, orderBy: "id DESC");
  }

  static Future<int> updateHistoryStatus(int id, String status) async {
    final dbs = await db();
    return dbs.update(
      tableHistory,
      {'status': status},
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<int> deleteHistory(int id) async {
    final dbs = await db();
    return dbs.delete(
      tableHistory,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // =====================================================
  // JOURNAL
  // =====================================================

  static Future<int> addJournal(JournalModel j) async {
    final dbs = await db();
    return dbs.insert(tableJournal, j.toMap());
  }

  static Future<List<JournalModel>> getJournal() async {
    final dbs = await db();
    final result = await dbs.query(tableJournal, orderBy: "id DESC");
    return result.map((e) => JournalModel.fromMap(e)).toList();
  }

  static Future<int> updateJournal(JournalModel j) async {
    final dbs = await db();
    return dbs.update(
      tableJournal,
      j.toMap(),
      where: "id = ?",
      whereArgs: [j.id],
    );
  }

  static Future<int> deleteJournal(int id) async {
    final dbs = await db();
    return dbs.delete(
      tableJournal,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
