import 'package:test/test.dart';
import 'package:trabajo_fin_grado/Model/init_model.dart';

void main() {
  late int testId;
  late UserType testUserType;
  late String testName;
  late String testSurname;
  late int testFamilyId;
  late List<int> testGameplayId;
  late List<int> testReportId;
  late Child child;

  setUp(() {
    // Arrange values
    testId = 1;
    testUserType = UserType.child;
    testName = "Name";
    testSurname = "Surname";
    testFamilyId = 1;
    testGameplayId = [1, 2, 3];
    testReportId = [1, 2, 3, 4];

    // Create object
    child = Child(
      id: testId,
      userType: testUserType,
      name: testName,
      surname: testSurname,
      familyId: testFamilyId,
      gameplayId: testGameplayId,
      reportId: testReportId,
    );
  });

  group("[CLASS ATTRIBUTE]", () {
    test(
      "tableName value equals 'child'",
      () => expect(
        Child.tableName,
        equals("child"),
      ),
    );
  });

  group("[CONSTRUCTOR]", () {
    test("the object exists", () => expect(child != null, true));
    test(
      "the object created has the correct type",
      () => expect(child is Child, true),
    );
  });

  group("[GETTERS]", () {
    test("id getter", () => expect(child.id, testId));
    test("userType getter", () => expect(child.userType, testUserType));
    test("name getter", () => expect(child.name, testName));
    test("surname getter", () => expect(child.surname, testSurname));
    test("familyId getter", () => expect(child.familyId, testFamilyId));
    test("gameplayId getter", () => expect(child.gameplayId, testGameplayId));
    test("reportId getter", () => expect(child.reportId, testReportId));
  });

  group("[SETTERS]", () {
    test("id setter", () {
      testId = 1;
      child.id = testId;
      expect(child.id, testId);
    });
    test("userType setter", () {
      testUserType = UserType.family;
      child.userType = testUserType;
      expect(child.userType, testUserType);
    });
    test("name setter", () {
      testName = "OtherName";
      child.name = testName;
      expect(child.name, testName);
    });
    test("surname setter", () {
      testSurname = "AnotherSurname";
      child.surname = testSurname;
      expect(child.surname, testSurname);
    });
    test("familyId setter", () {
      testFamilyId = 201;
      child.familyId = testFamilyId;
      expect(child.familyId, testFamilyId);
    });
    test("gameplayId setter", () {
      testGameplayId = [3];
      child.gameplayId = testGameplayId;
      expect(child.gameplayId, testGameplayId);
    });
    test("reportId setter", () {
      testReportId = [];
      child.reportId = testReportId;
      expect(child.reportId, testReportId);
    });
  });

  group("[METHODS]", () {
    test("method toMap", () {
      Map<String, dynamic> testMap = {
        "id": testId,
        "userType": testUserType.toString(),
        "name": testName,
        "surname": testSurname,
        "familyId": testFamilyId,
        "gameplayId": testGameplayId,
        "reportId": testReportId,
      };

      Map<String, dynamic> map = child.toMap();

      expect(map.keys, testMap.keys);
      expect(map.values, testMap.values);

      expect(map["id"], testMap["id"]);
      expect(map["userType"], testMap["userType"]);
      expect(map["name"], testMap["name"]);
      expect(map["surname"], testMap["surname"]);
      expect(map["familyId"], testMap["familyId"]);
      expect(map["gameplayId"], testMap["gameplayId"]);
      expect(map["reportId"], testMap["reportId"]);
    });
  });
}
