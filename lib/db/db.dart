import 'dart:io';
import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  static Future<Database> _openDB() async {
    String path = join(await getDatabasesPath(), 'database.db');
    String dbCreationScript =
        await File('lib/db/init_database.sql').readAsString();

    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(dbCreationScript);
      },
      version: 1,
    );
  }

  static Future<void> insert(String tableName, dynamic item) async {
    Database database = await _openDB();

    await database.insert(tableName, item.toMap());
  }

  static Future<void> delete(String tableName, dynamic item) async {
    Database database = await _openDB();

    await database.delete(tableName, where: "id = ?", whereArgs: [item.id]);
  }

  static Future<void> update(String tableName, dynamic item) async {
    Database database = await _openDB();

    await database.update(
      tableName,
      item.toMap(),
      where: "id = ?",
      whereArgs: [item.id],
    );
  }

  static Future<List<Map<String, dynamic>>> list(
    String tableName,
    Type type,
  ) async {
    Database database = await _openDB();

    return database.query(tableName);
  }

  // TODO: encontrar una manera de mapear los filtros
  // Así, podría mejorar el método list para conseguir subsets de las tablas
  // Además, me permitiría implementar un método get genérico para todo
}
