import 'package:sqflite/sqflite.dart';

import 'package:trabajo_fin_grado/models/match.dart';
import 'package:trabajo_fin_grado/services/database_service.dart';

class MatchProvider {
  final tableName = 'match';

  Future<void> createTable(Database database) async {
    await database.execute("""
    CREATE TABLE IF NOT EXISTS $tableName (
      'id' INTEGER,
      'createdOn' INTEGER DEFAULT (strftime('%s', 'now')),
      'gameId' INTEGER,
      'reportId' INTEGER,
      'duration' INTEGER,
      'hits' INTEGER,
      'errors' INTEGER,
      PRIMARY KEY('id' AUTOINCREMENT),
      FOREIGN KEY('gameId') REFERENCES 'game'('id'),
      FOREIGN KEY('reportId') REFERENCES 'report'('id')
    );
    """);
  }

  Future<int> create({required Match match}) async {
    final database = await DatabaseService().database;
    return await database.insert(tableName, match.toMap());
  }

  Future<List<Match>> readAll() async {
    final database = await DatabaseService().database;
    final matches = await database.query(tableName);
    return matches.map((e) => Match.fromSqfliteDatabase(e)).toList();
  }

  Future<Match> readById(int id) async {
    final database = await DatabaseService().database;
    final match = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return Match.fromSqfliteDatabase(match.first);
  }

  Future<List<Match>> readByDate(DateTime date) async {
    final database = await DatabaseService().database;
    final matches = await database.query(
      tableName,
      where: 'createdOn > ?',
      whereArgs: [date.millisecondsSinceEpoch ~/ 1000],
    );
    return matches.map((e) => Match.fromSqfliteDatabase(e)).toList();
  }

  Future<List<Match>> readUnreported() async {
    final database = await DatabaseService().database;
    final matches = await database.query(
      tableName,
      where: 'reportId IS NULL',
    );
    return matches.map((e) => Match.fromSqfliteDatabase(e)).toList();
  }

  Future<int> update({required Match match}) async {
    final database = await DatabaseService().database;
    return await database.update(
      tableName,
      match.toMap(),
      where: 'id = ?',
      whereArgs: [match.id],
    );
  }

  Future<void> delete(int id) async {
    final database = await DatabaseService().database;
    await database.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteByDate(DateTime date) async {
    final database = await DatabaseService().database;
    await database.delete(
      tableName,
      where: 'createdOn > ? AND reportId IS NULL',
      whereArgs: [date.millisecondsSinceEpoch ~/ 1000],
    );
  }
}
