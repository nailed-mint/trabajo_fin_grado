import 'package:trabajo_fin_grado/Model/child_model.dart';
import 'package:trabajo_fin_grado/Model/user_model.dart';
import 'package:trabajo_fin_grado/db/db.dart';

Future<Child> createChild({required Map<String, dynamic> child}) async {
  DB.create(table: Child.tableName, item: child);

  return Child(
    id: child["id"],
    userType: UserType.child,
    name: child["name"],
    surname: child["surname"],
    familyId: child["familyId"],
    gameplayId: child["gameplayId"] ? child["gameplayId"] : null,
    reportId: child["reportId"] ? child["reportId"] : null,
  );
}

Future<List<Child>> listChild({Map<String, dynamic>? filters}) async {
  List<Map<String, dynamic>> queryResult = await DB.read(
    table: Child.tableName,
    filters: filters,
  );

  List<Child> result = [];

  for (Map<String, Object?> item in queryResult) {
    result.add(Child.fromMap(item));
  }

  return result;
}

Future<Child> readChild({Map<String, dynamic>? filters}) async {
  List<Map<String, Object?>> queryResult = await DB.read(
    table: Child.tableName,
    filters: filters,
    limit: 1,
  );
  Map<String, dynamic> res = queryResult[0];

  return Child.fromMap(res);
}

Future<Child> updateChild({
  required int childId,
  required Map<String, dynamic> changes,
}) async {
  Map<String, int> filters = {"id": childId};
  DB.update(table: Child.tableName, values: changes, filters: filters);

  List<Map<String, dynamic>> mappedChild = await DB.read(
    table: Child.tableName,
    filters: filters,
    limit: 1,
  );

  Map<String, dynamic> res = mappedChild[0];

  return Child(
    id: res["id"],
    userType: res["userType"],
    name: res["name"],
    surname: res["surname"],
    familyId: res["familyId"],
    gameplayId: res["gameplayId"],
    reportId: res["reportId"],
  );
}

void deleteChild({required int childId}) {
  DB.delete(table: Child.tableName, filters: {"id": childId});
}
