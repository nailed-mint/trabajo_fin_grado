import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final logger = Logger();

class DB {
  static Database? _database;

  static Future<Database> _openDB() async {
    if (_database != null) return _database!;

    String path = join(await getDatabasesPath(), 'database.db');
    String dbCreationScript =
        await rootBundle.loadString('assets/db/init_database.sql');

    _database = await openDatabase(
      path,
      onCreate: (db, version) async {
        try {
          await db.execute(dbCreationScript);
          logger.i('Database created successfully');
        } catch (e) {
          logger.e('Error creating database: $e');
        }
      },
      version: 1,
    );

    return _database!;
  }

  // CRUD ======================================================================
  static Future<void> create({
    required String table,
    required Map<String, dynamic> item,
  }) async {
    Database database = await _openDB();

    await database.insert(table, item);
  }

  static Future<List<Map<String, dynamic>>> read({
    required String table,
    Map<String, dynamic>? filters,
    int? limit,
  }) async {
    Map<String, dynamic> mappedFilters = _mapFilters(filters: filters);

    Database database = await _openDB();

    return database.query(
      table,
      where: mappedFilters["where"],
      whereArgs: mappedFilters["whereArgs"],
      limit: limit,
    );
  }

  static Future<void> update({
    required String table,
    required Map<String, dynamic> values,
    Map<String, dynamic>? filters,
  }) async {
    Map<String, dynamic> mappedFilters = _mapFilters(filters: filters);

    Database database = await _openDB();

    await database.update(
      table,
      values,
      where: mappedFilters["where"],
      whereArgs: mappedFilters["whereArgs"],
    );
  }

  static Future<void> delete({
    required String table,
    Map<String, dynamic>? filters,
  }) async {
    Map<String, dynamic> mappedFilters = _mapFilters(filters: filters);

    Database database = await _openDB();

    await database.delete(
      table,
      where: mappedFilters["where"],
      whereArgs: mappedFilters["whereArgs"],
    );
  }

  // QOL METHODS ===============================================================
  static Map<String, dynamic> _mapFilters({Map<String, dynamic>? filters}) {
    Map<String, dynamic> res = {
      "where": null,
      "whereArgs": null,
    };

    if (filters == null) {
      return res;
    }

    List<String> where = [];

    for (var entry in filters.entries) {
      String key = entry.key;
      dynamic value = entry.value;
      where.add("$key = ?");
      res["whereArgs"]!.add(value);
    }

    res["where"] = where.join("AND");

    return res;
  }

  // TODO: metodo para revisar la integridad de los datos antes de insertarlos
  // en la db
}
