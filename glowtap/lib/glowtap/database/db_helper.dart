import 'package:glowtap/glowtap/model/customer_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static const tableCustomer = 'Customer';
  static Future<Database> db() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'GlowTap.db'),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE $tableCustomer(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, phone TEXT, city TEXT, password TEXT)",
        );
      },
      version: 1,
    );
  }

  static Future<void> registerUser(CustomerModel user) async {
    final dbs = await db();
    //Insert adalah fungsi untuk menambahkan data (CREATE)
    await dbs.insert(
      tableCustomer,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(user.toMap());
  }

  static Future<CustomerModel?> loginUser({
    required String email,
    required String password,
  }) async {
    final dbs = await db();
    //query adalah fungsi untuk menampilkan data (READ)
    final List<Map<String, dynamic>> results = await dbs.query(
      tableCustomer,
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (results.isNotEmpty) {
      return CustomerModel.fromMap(results.first);
    }
    return null;
  }

  //GET CUSTOMER
  static Future<List<CustomerModel>> getAllCustomer() async {
    final dbs = await db();
    final List<Map<String, dynamic>> results = await dbs.query(tableCustomer);
    print(results.map((e) => CustomerModel.fromMap(e)).toList());
    return results.map((e) => CustomerModel.fromMap(e)).toList();
  }

  //UPDATE DATA
  static Future<void> updateCustomer(CustomerModel customer) async {
    final dbs = await db();
    //Insert adalah fungsi untuk menambahkan data (CREATE)
    await dbs.update(
      tableCustomer,
      customer.toMap(),
      where: "id = ?",
      whereArgs: [customer.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(customer.toMap());
  }

  //DELETE DATA
  static Future<void> deleteCustomer(int id) async {
    final dbs = await db();
    //Insert adalah fungsi untuk menambahkan data (CREATE)
    await dbs.delete(tableCustomer, where: "id = ?", whereArgs: [id]);
  }
}
