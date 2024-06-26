import 'package:sqflite/sqflite.dart';

import 'package:trabajo_fin_grado/models/report.dart';
import 'package:trabajo_fin_grado/services/database_service.dart';

class ReportProvider {
  final tableName = 'report';

  Future<void> createTable(Database database) async {
    await database.execute("""
      CREATE TABLE IF NOT EXISTS $tableName (
        'id' INTEGER,
        'createdOn' INTEGER DEFAULT (strftime('%s', 'now')),
        'userName' TEXT,
        PRIMARY KEY('id' AUTOINCREMENT)
      );
      """);
  }

  Future<int> create({required Report report}) async {
    final database = await DatabaseService().database;
    return await database.insert(tableName, report.toMap());
  }

  Future<List<Report>> readAll() async {
    final database = await DatabaseService().database;
    final reports = await database.query(tableName);
    return reports.map((e) => Report.fromSqfliteDatabase(e)).toList();
  }

  Future<Report> readById(int id) async {
    final database = await DatabaseService().database;
    final report = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return Report.fromSqfliteDatabase(report.first);
  }

  Future<int> update({required Report report}) async {
    final database = await DatabaseService().database;
    return await database.update(
      tableName,
      report.toMap(),
      where: 'id = ?',
      whereArgs: [report.id],
      conflictAlgorithm: ConflictAlgorithm.rollback,
    );
  }

  Future<void> delete(int id) async {
    final database = await DatabaseService().database;
    await database.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
