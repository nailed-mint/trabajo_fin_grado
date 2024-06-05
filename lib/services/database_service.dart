import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:trabajo_fin_grado/providers/game_provider.dart';
import 'package:trabajo_fin_grado/providers/match_provider.dart';
import 'package:trabajo_fin_grado/providers/report_provider.dart';

class DatabaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = 'trabajo_fin_grado.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true,
    );
    return database;
  }

  Future<void> create(Database database, int version) async {
    await GameProvider().createTable(database);
    await ReportProvider().createTable(database);
    await MatchProvider().createTable(database);

    await GameProvider().insertStaticData(database);
  }
}
