enum UserType {
  child,
  family,
  professional,
}

class User {
  int id;
  UserType userType;
  String name;
  String surname;

  User({
    this.id,
    this.userType,
    this.name,
    this.surname,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "userType": userType,
        "name": name,
        "firstSurname": surname,
      };
}
