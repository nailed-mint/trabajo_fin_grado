import 'package:trabajo_fin_grado/Model/user_model.dart';

class Child extends User {
  // CLASS ATTRIBUTES ==========================================================
  static const String tableName = "child";

  // OBJECT ATTRIBUTES =========================================================
  int _familyId;
  List<int>? _gameplayId;
  List<int>? _reportId;

  // CONSTRUCTORS ==============================================================
  Child({
    required super.id,
    required super.userType,
    required super.name,
    required super.surname,
    required int familyId,
    List<int>? gameplayId,
    List<int>? reportId,
  })  : _reportId = reportId,
        _gameplayId = gameplayId,
        _familyId = familyId;

  // GETTERS ===================================================================
  int get familyId => _familyId;
  List<int>? get gameplayId => _gameplayId;
  List<int>? get reportId => _reportId;

  // SETTERS ===================================================================
  // TODO: asegurar la integridad de la base de datos antes de modificar nada
  set familyId(int value) {
    _familyId = value;
  }

  set gameplayId(List<int>? value) {
    _gameplayId = value;
  }

  set reportId(List<int>? value) {
    _reportId = value;
  }

  // METHODS ===================================================================
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> res = super.toMap();
    res.addAll(<String, dynamic>{
      "familyId": _familyId,
      "gameplayId": _gameplayId,
      "reportId": _reportId,
    });
    return res;
  }
}
