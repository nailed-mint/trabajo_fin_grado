class Report {
  // CLASS ATTRIBUTES ==========================================================
  static const String tableName = "report";

  // OBJECT ATTRIBUTES =========================================================
  int _id;
  int _childId;
  int _familyId;
  List<int> _resultId;

  // CONSTRUCTORS ==============================================================
  Report({
    required int id,
    required int childId,
    required int familyId,
    required List<int> resultId,
  })  : _resultId = resultId,
        _familyId = familyId,
        _childId = childId,
        _id = id;

  // GETTERS ===================================================================
  int get id => _id;
  int get childId => _childId;
  int get familyId => _familyId;
  List<int> get resultId => _resultId;

  // SETTERS ===================================================================
  // TODO: asegurar la integridad de la base de datos antes de modificar nada
  set id(int value) {
    _id = value;
  }

  set childId(int value) {
    _childId = value;
  }

  set familyId(int value) {
    _familyId = value;
  }

  set resultId(List<int> value) {
    _resultId = value;
  }

  // METHODS ===================================================================
  Map<String, dynamic> toMap() => {
        "id": _id,
        "childId": _childId,
        "familyId": _familyId,
        "resultId": _resultId,
      };
}
