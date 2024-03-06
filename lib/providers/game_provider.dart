import 'package:sqflite/sqflite.dart';

import 'package:trabajo_fin_grado/models/game.dart';
import 'package:trabajo_fin_grado/services/database_service.dart';

class GameProvider {
  final tableName = 'game';

  // TABLE SETUP ===============================================================
  Future<void> createTable(Database database) async {
    await database.execute("""
      CREATE TABLE IF NOT EXISTS $tableName (
        'id' INTEGER,
        'name' TEXT,
        'icon' INTEGER,
        'description' TEXT,
        PRIMARY KEY('id' AUTOINCREMENT)
      );
      """);
  }

  Future<void> insertStaticData(Database database) async {
    await database.insert(tableName, {
      'id': 1,
      'name': 'Encuentra las diferencias',
      'icon': 32386,
      'description':
          '¡Encuentra todas las diferencias entre las dos imágenes para ganar!',
    });
    await database.insert(tableName, {
      'id': 2,
      'name': 'Empareja la silueta',
      'icon': 32324,
      'description': '¡Descubre cuál es la silueta de cada imagen!',
    });
  }

  // CRUD ======================================================================
  Future<int> create({required Game game}) async {
    final database = await DatabaseService().database;
    return await database.insert(tableName, game.toMap());
  }

  Future<List<Game>> readAll() async {
    final database = await DatabaseService().database;
    final games = await database.query(tableName);
    return games.map((e) => Game.fromSqfliteDatabase(e)).toList();
  }

  Future<Game> readById(int id) async {
    final database = await DatabaseService().database;
    final game = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return Game.fromSqfliteDatabase(game.first);
  }

  Future<int> update({required Game game}) async {
    final database = await DatabaseService().database;
    return await database.update(
      tableName,
      game.toMap(),
      where: 'id = ?',
      whereArgs: [game.id],
      conflictAlgorithm: ConflictAlgorithm.rollback,
    );
  }

  Future<void> delete(int id) async {
    final database = await DatabaseService().database;
    await database.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
