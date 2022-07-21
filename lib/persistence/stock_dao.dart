import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/stock.dart';

// OKAY --------------------------
class StockDao {
  // Inicializar informações e valores para a base de dados
  static const _databaseName = "stock.db";
  static const _databaseVersion = 1;
  static const table = "stock";
  static const _id = "_id";
  static const _name = "name";
  static const _code = "code";
  static const _quantity = "quantity";
  static const _mode = "mode";
  static const _email = "email";
  static const _datetime = "datetime";

  // Tornar a classe Singleton
  StockDao._privateConstructor();

  static final StockDao instance = StockDao._privateConstructor();

  static Database? _database;

  // Retornar base de dados caso já exista, se não, criar uma
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Inicializar base de dados na pasta de documentos
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // Criar tabela para a base de dados
  Future _onCreate(Database db, int version) async {
    await db.execute("""
CREATE TABLE $table ($_id TEXT PRIMARY KEY,
$_name TEXT NOT NULL,
$_code INTEGER NOT NULL,
$_quantity INTEGER NOT NULL,
$_mode TEXT NOT NULL,
$_email TEXT NOT NULL,
$_datetime TEXT NOT NULL
)
""");
  }

  static Future<int> insert(Stock stock) async {
    var result = 0;
    try {
      stock.id != null;
      Database db = await instance.database;
      result = await db.insert(table, Map.from(stock.getStock()));
    } on Exception {
      return 0;
    }
    return result;
  }

  static Future<List<Stock>> findAll(String mode) async {
    List<Stock> items;
    try {
      final Database db = await instance.database;
      var result =
          await db.query(table, where: '$_mode = ?', whereArgs: [mode]);
      items = _toList(result);
    } on Exception {
      return [];
    }
    return items;
  }

  static Future<bool> verifyId(String code) async {
    List<Stock> items;
    try {
      final Database db = await instance.database;
      List<dynamic> whereArguments = [code];
      var result =
          await db.query(table, where: '$_code = ?', whereArgs: whereArguments);
      items = _toList(result);
    } on Exception {
      return false;
    }
    return (items.isNotEmpty);
  }

  static List<Stock> _toList(List<Map<String, dynamic>> result) {
    final List<Stock> items = [];
    for (Map<String, dynamic> row in result) {
      final Stock stock = Stock(row[_id], row[_name], row[_code],
          row[_quantity], row[_mode], row[_email], row[_datetime]);
      items.add(stock);
    }
    return items;
  }

  static Future<int> remove(String id) async {
    var result = 0;
    try {
      Database db = await instance.database;
      result = await db.delete(table, where: "$_id = ?", whereArgs: [id]);
    } on Exception {
      return 0;
    }
    return result;
  }
}
