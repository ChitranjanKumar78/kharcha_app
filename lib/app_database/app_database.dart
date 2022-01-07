import 'package:kharcha_app/models/expenses_item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  AppDatabase._();
  static AppDatabase db = AppDatabase._();

  Future<Database> get database async {
    return await openDatabase(join(await getDatabasesPath(), "kharcha_app.db"),
        onCreate: (db, version) async {
      await db.execute(
          '''CREATE TABLE expenses_db_table (amount TEXT, date TEXT, details TEXT, expenseDate TEXT)''');
    }, version: 1);
  }

  Future<dynamic> getDatabaseList() async {
    final db = await database;
    var data = await db.query("expenses_db_table");
    if (data.isEmpty) {
      return null;
    } else {
      var dataList = List.from(data.toList().reversed);
      return dataList;
    }
  }

  //adding new row data
  addNewExpenseData(Expenses expenses) async {
    final db = await database;
    db.insert("expenses_db_table", expenses.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //updating any row data
  updateExpenseData(Expenses expenses) async {
    final db = await database;
    await db.update(
      'expenses_db_table',
      expenses.toMap(),
      where: 'date = ?',
      whereArgs: [expenses.getDate],
    );
  }

  //delete one record
  deleteExpenseData(Expenses expenses) async {
    final db = await database;
    await db.delete(
      'expenses_db_table',
      where: 'date = ?',
      whereArgs: [expenses.date],
    );
  }

  //deleting all records
  deleteAllData() async {
    final db = await database;
    await db.delete(
      'expenses_db_table',
    );
  }
}
