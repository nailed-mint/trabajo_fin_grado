import 'package:trabajo_fin_grado/Model/user_model.dart';

class Professional extends User {
  // CLASS ATTRIBUTES ==========================================================
  static const String tableName = "professional";

  // OBJECT ATTRIBUTES =========================================================
  String _email;

  // CONSTRUCTORS ==============================================================
  Professional({
    required super.id,
    required super.userType,
    required super.name,
    required super.surname,
    required String email,
  }) : _email = email;

  // GETTERS ===================================================================
  String get email => _email;

  // SETTERS ===================================================================
  // TODO: asegurar la integridad de la base de datos antes de modificar nada
  set email(String value) {
    _email = isValidEmail(email)
        ? value
        : throw ArgumentError('Invalid email format');
  }

  // METHODS ===================================================================
  bool isValidEmail(String email) {
    final RegExp regex =
        RegExp(r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
    return regex.hasMatch(email);
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> res = super.toMap();
    res.addAll(<String, dynamic>{
      "email": _email,
    });
    return res;
  }
}
