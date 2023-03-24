// ignore_for_file: unused_local_variable, unnecessary_brace_in_string_interps

import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/Budget.dart';



const String nameDB = "BudgetDB.db";
const String tableName = "Budget";
String createTable = '''CREATE TABLE ${tableName} (
    ${BudgetID.id} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${BudgetID.plmin} TEXT,
    ${BudgetID.number} REAL,
    ${BudgetID.valute} TEXT,
    ${BudgetID.category} TEXT,
    ${BudgetID.nameNumber} TEXT,
    ${BudgetID.description} TEXT,
    ${BudgetID.datetime} TEXT
    )''';

/*   final int id; // id для базы данных
  final String PlMin; // знак расхода / дохода
  final double Number; // сумма для расхода / дохода
  final String Valute; // валюта
  final String Category; // Категория
  final String NameNumber; // название расхода / дохода
  final String Description; // Описание на что потратил или получил сумму
  final DateTime dateTime; // дата публикации */

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    Directory doc = await getApplicationDocumentsDirectory();
    String path = join(doc.path, nameDB);

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(createTable);
    });
  }

  // добавление данных
  insert(ModelBudget modelBudget) async {
    Database db = await database;
    final id = await db.insert(tableName, modelBudget.toJson());
    print("CREATED DATA VALUES !!!");
    return modelBudget.copy(id: id);
  }

  // чтение данных
  Future<List<ModelBudget>> getTable() async {
    Database db = await database;
    final orderBy = '${BudgetID.datetime} DESC';
    // final orderBy = '${BudgetID.datetime} ASC';
    // final res =
    //     await db.rawQuery('SELECT * FROM $tableName ORDER BY $orderBy');
    var res = await db.query(tableName, orderBy: orderBy);
    // List<ModelBudget> list = res.isNotEmpty
    //     ? res.map((Map<String, dynamic> dbRes) {
    //         return ModelBudget(
    //             id: dbRes[BudgetID.id],
    //             PlMin: dbRes[BudgetID.plmin],
    //             Number: dbRes[BudgetID.number],
    //             Valute: dbRes[BudgetID.valute],
    //             Category: dbRes[BudgetID.category],
    //             NameNumber: dbRes[BudgetID.nameNumber],
    //             Description: dbRes[BudgetID.description],
    //             dateTime: dbRes[BudgetID.datetime]);
    //       }).toList()
    //     : [];
    print("DATA " +
        res.toList().toString());
    return res.map((json) => ModelBudget.fromJson(json)).toList();
  }

  Future<ModelBudget> readModel(int id) async {
    final db = await database;

    final maps = await db.query(
      tableName,
      columns: BudgetID.values,
      where: '${BudgetID.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ModelBudget.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  // изменение данных
  updateRow(ModelBudget modelBudget) async {
    final db = await database;
    var updateID = db.update(tableName, modelBudget.toJson(),
        where: "${BudgetID.id} = ?", whereArgs: [modelBudget.id]);
    return updateID;
  }

  // удаление данных
  deleteRow(int id) async {
    final db = await database;
    var deleteID =
        db.delete(tableName, where: "${BudgetID.id} = ?", whereArgs: [id]);
    return deleteID;
  }

  Future close() async {
    final db = await database;

    db.close();
  }
}
