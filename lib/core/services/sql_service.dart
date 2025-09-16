import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDbService {
  static Database? db;
  static Future<void> getDb({required String dbName}) async {
    db == null ? db = await initDb(dbName: dbName) : null;
  }

  static Future<Database?> initDb({required String dbName}) async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, '$dbName.db');
    Database myDb = await openDatabase(path, version: 1, onCreate: _createDb);
    return myDb;
  }

  static FutureOr<void> _createDb(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute('''
CREATE TABLE cart (
  product_id INTEGER PRIMARY KEY,
  Pname TEXT,
  Pimg TEXT,
  Pprice REAL,
  Pquantity INTEGER
)
''');
    await batch.commit();
  }

  static Future<List<Map<String, dynamic>>?> readData(String sql) async {
    Database? myDb = db;
    var response = await myDb?.rawQuery(sql);
    return response;
  }

  static Future<int?> insertData(String sql, List<Object?> params) async {
    Database? myDb = db;
    var response = await myDb?.rawInsert(sql, params);
    return response;
  }

  static Future<int?> updateData(String sql) async {
    Database? myDb = db;
    var response = await myDb?.rawUpdate(sql);
    return response;
  }

  static Future<int?> deleteData(String sql) async {
    Database? myDb = db;
    var response = await myDb?.rawDelete(sql);
    return response;
  }
}
