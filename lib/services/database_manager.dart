import 'dart:io';

import 'package:redshop/services/flower_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseManager {
  static final _dbName = "database.db";

  DatabaseManager._privateConstructor();
  static final DatabaseManager instance = DatabaseManager._privateConstructor();
  Database? database;

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    if (database == null) {
      return openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
      ).then((database) => this.database = database);
    }
    return database!;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("""
          CREATE TABLE basket(
            id INTEGER,
            count INTEGER
          )
          """);
  }

  Future<List<DBFlower>> fetchAllFlowers() async {
    List<Map<String, dynamic>> maps = await database!.query('basket');
    print(maps);
    return maps.map((map) => DBFlower.fromDbMap(map)).toList();
  }

  Future<int> addFlowers(DBFlower dbFlower) async {
    return database!.insert('basket', dbFlower.toDbMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateFlowers(DBFlower newdbFlower) async {
    return database!.update(
      'basket',
      newdbFlower.toDbMap(),
      where: 'id = ?',
      whereArgs: [newdbFlower.id],
    );
  }

  Future<int> deleteFlowers(int id) async {
    return database!.delete('basket', where: 'id = ?', whereArgs: [id]);
  }

  Future deleteAllFlowers() async {
    return database!.delete('basket');
  }
}
