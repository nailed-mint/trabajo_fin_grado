enum UserType {
  child,
  family,
  professional,
}

class User {
  // CLASS ATTRIBUTES ==========================================================
  static const String tableName = "user";

  // OBJECT ATTRIBUTES =========================================================
  int _id;
  UserType _userType;
  String _name;
  String _surname;

  // CONSTRUCTORS ==============================================================
  User({
    required int id,
    required UserType userType,
    required String name,
    required String surname,
  })  : _surname = surname,
        _name = name,
        _userType = userType,
        _id = id;

  // GETTERS ===================================================================
  int get id => _id;
  UserType get userType => _userType;
  String get name => _name;
  String get surname => _surname;

  // SETTERS ===================================================================
  // TODO: asegurar la integridad de la base de datos antes de modificar nada
  set id(int value) {
    _id = value;
  }

  set userType(UserType value) {
    _userType = value;
  }

  set name(String value) {
    _name = value;
  }

  set surname(String value) {
    _surname = value;
  }

  // METHODS ===================================================================
  Map<String, dynamic> toMap() => {
        "id": _id,
        "userType": _userType.toString(),
        "name": _name,
        "firstSurname": _surname,
      };
}
