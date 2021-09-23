import 'dart:io';
import 'package:redshop/services/flower_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseManager {
  static final _dbName = "Database.db";

  DatabaseManager._privateConstructor();
  static final DatabaseManager instance = DatabaseManager._privateConstructor();
  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(""" CREATE TABLE basket (
      id INTEGER ,
      count INTEGER,
      )
    """);
  }

  Future<List<DBFlower>?> fetchAllFlowers() async {
    Database database = _database!;
    List<Map<String, dynamic>> maps = await database.query('Basket');
    if (maps.isNotEmpty) {
      return maps.map((map) => DBFlower.fromDbMap(map)).toList();
    }
    return null;
  }

  Future<int> addFlowers(DBFlower dbFlower) async {
    Database database = _database!;
    return database.insert('basket', dbFlower.toDbMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateFlowers(DBFlower, newdbFlower) async {
    Database database = _database!;
    return database.update('basket', newdbFlower.toDbMap(),
        where: 'id = ?',
        whereArgs: [newdbFlower.count],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> deleteFlowers(int id) async {
    Database database = _database!;
    return database.delete('basket', where: 'id = ?', whereArgs: [id]);
  }
}
