import 'package:trabajo_fin_grado/Model/user_model.dart';

class Professional extends User {
  static const String tableName = "professional";

  String email;

  Professional({
    required super.id,
    required super.userType,
    required super.name,
    required super.surname,
    required this.email,
  }) {
    if (!isValidEmail(email)) {
      throw ArgumentError('Invalid email format');
    }
  }

  bool isValidEmail(String email) {
    final RegExp regex =
        RegExp(r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
    return regex.hasMatch(email);
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> res = super.toMap();
    res.addAll(<String, dynamic>{
      "email": email,
    });
    return res;
  }
}
