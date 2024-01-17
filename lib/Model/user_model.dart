enum UserType {
  child,
  family,
  professional,
}

class User {
  static const String tableName = "user";

  int id;
  UserType userType;
  String name;
  String surname;

  User({
    required this.id,
    required this.userType,
    required this.name,
    required this.surname,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "userType": userType.toString(),
        "name": name,
        "firstSurname": surname,
      };
}
