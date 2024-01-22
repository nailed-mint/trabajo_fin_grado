import 'dart:io';

import 'package:test/test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

import 'package:trabajo_fin_grado/Model/init_model.dart';
import 'package:trabajo_fin_grado/db/db.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  tearDown(() async {
    String path = join(await getDatabasesPath(), "database.db");
    File dbFile = File(path);
    if (await dbFile.exists()) {
      await dbFile.delete();
    }
  });

  test("USER table", () async {
    await DB.insert(
      table: User.tableName,
      item: {
        "userType": "family",
        "name": "Javier",
        "surname": "Gómez García",
      },
    );

    List<Map<String, dynamic>> data = await DB.list(table: User.tableName);
    expect(
      data,
      [
        {
          "id": 1,
          "userType": "family",
          "name": "Javier",
          "surname": "Gómez García",
        }
      ],
    );

    await DB.update(
      table: User.tableName,
      values: {
        "userType": "family",
        "name": "Javilin",
        "surname": "Avocadocap",
      },
    );

    data = await DB.list(table: User.tableName);
    expect(
      data,
      [
        {
          "id": 1,
          "userType": "family",
          "name": "Javilin",
          "surname": "Avocadocap",
        }
      ],
    );

    await DB.delete(table: User.tableName);
  });

  // test("CHILD table", () {});
  // test("PROFESSIONAL table", () {});
  // test("GAME table", () {});
  // test("GAMEPLAY table", () {});
  // test("RESULT table", () => null);
  // test("REPORT table", () => null);
}
