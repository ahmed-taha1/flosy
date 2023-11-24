import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../Model/Expense.dart';

class DataBaseHelper {
  static Database? _instance;

  static Future<Database> getInstance() async {
    _instance ??= await _initialDB();
    return _instance!;
  }

  static _initialDB() async {
    String dBPath = await getDatabasesPath();
    String path = join(dBPath, 'ExpenseApp.db');
    Database myDB = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpdate);
    return myDB;
  }

  static _onUpdate(Database db, int oldVersion, int newVersion) async {

  }

  static _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE "RowData"(
        "id" INTEGER PRIMARY KEY NOT NULL ,
        "amount" REAL,
        "description" TEXT,
        "isIncome" INTEGER,
        "date" TEXT
      )
    ''');
  }

  static read() async {
    Database myDB = await getInstance();
    List<Map> response = await myDB.rawQuery('''
      SELECT * FROM "RowData"
      ORDER BY id DESC;
    ''');
    List<RowData> rowData = [];
    for (var element in response) {
      rowData.add(RowData(
          date: element['date'] ?? Date.getDate(),
          isIncome: element['isIncome'] == 1 ? true : false,
          amount: element['amount'],
          description: element['description'],
          id: element['id']));
    }
    return rowData;
  }

  static Future<int> insert(RowData rowData) async {
    Database myDB = await getInstance();
    try {
      if (rowData.amount < 0) {
        throw 0;
      }
      var response = await myDB.rawInsert('''
        INSERT INTO "RowData" (
          "amount", "description", "isIncome", "date")
        VALUES(
          ${rowData.amount},
          "${rowData.description}",
          ${rowData.isIncome == true ? 1 : 0},
          "${rowData.date}")
      ''');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static delete(int id) async {
    Database myDB = await getInstance();
    try {
      var response = await myDB.rawDelete('''
        DELETE FROM "RowData" WHERE id = $id
      ''');
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
