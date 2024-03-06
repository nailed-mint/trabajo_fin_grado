import 'package:sqflite/sqflite.dart';

import 'package:trabajo_fin_grado/models/user.dart';
import 'package:trabajo_fin_grado/services/database_service.dart';

class UserProvider {
  final tableName = 'user';

  // TABLE SETUP ===============================================================
  Future<void> createTable(Database database) async {
    await database.execute("""
    CREATE TABLE IF NOT EXISTS $tableName (
      "id" INTEGER,
      "name" TEXT,
      "type" TEXT,
      "email" TEXT,
      PRIMARY KEY("id" AUTOINCREMENT)
    );
    """);
  }

  Future<void> insertStaticData(Database database) async {}

  // CRUD ======================================================================
  Future<int> create({required User user}) async {
    final database = await DatabaseService().database;
    return await database.insert(tableName, user.toMap());
  }

  Future<List<User>> readAll() async {
    final database = await DatabaseService().database;
    final users = await database.query(tableName);
    return users.map((e) => User.fromSqfliteDatabase(e)).toList();
  }

  Future<User> readById(int id) async {
    final database = await DatabaseService().database;
    final user = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return User.fromSqfliteDatabase(user.first);
  }

  Future<int> update({required User user}) async {
    final database = await DatabaseService().database;
    return await database.update(
      tableName,
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
      conflictAlgorithm: ConflictAlgorithm.rollback,
    );
  }

  Future<void> delete(int id) async {
    final database = await DatabaseService().database;
    await database.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
