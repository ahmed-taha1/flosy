import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DataBaseHelper {
  static Database? _instance;

  static Future<Database> getInstance() async {
    _instance ??= await _initialDB();
    return _instance!;
  }

  static _initialDB() async {
    String dBPath = await getDatabasesPath();
    String path = join(dBPath, 'Flosy.db');
    Database myDB = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpdate);
    return myDB;
  }

  static _onUpdate(Database db, int oldVersion, int newVersion) async {

  }

  static _onCreate(Database db, int version) async {
    try {
      await db.execute('''
      CREATE TABLE "Expense"(
        "id" INTEGER PRIMARY KEY NOT NULL,
        "amount" REAL,
        "description" TEXT,
        "type" INTEGER,
        "date" TEXT
      )''');
      await db.execute('''
      CREATE TABLE "Wish"(
        "id" INTEGER PRIMARY KEY NOT NULL,
        "name" TEXT
      )
    ''');
    } catch(e){
      rethrow;
    }
  }

  static read(String query) async {
    Database myDB = await getInstance();
    List<Map> response = await myDB.rawQuery(query);
    return response;
  }

  static Future<int> insert(String query) async {
    Database myDB = await getInstance();
    try {
      var response = await myDB.rawInsert(query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static delete(String query) async {
    Database myDB = await getInstance();
    try {
      var response = await myDB.rawDelete(query);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
