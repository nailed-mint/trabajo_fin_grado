class Gameplay {
  // CLASS ATTRIBUTES ==========================================================
  static const String tableName = "gameplay";

  // OBJECT ATTRIBUTES =========================================================
  int _id;
  int _gameId;
  int _childId;
  int _resultId;

  // CONSTRUCTORS ==============================================================
  Gameplay({
    required int id,
    required int gameId,
    required int childId,
    required int resultId,
  })  : _resultId = resultId,
        _childId = childId,
        _gameId = gameId,
        _id = id;

  // GETTERS ===================================================================
  int get id => _id;
  int get gameId => _gameId;
  int get childId => _childId;
  int get resultId => _resultId;

  // SETTERS ===================================================================
  // TODO: asegurar la integridad de la base de datos antes de modificar nada
  set id(int value) {
    _id = value;
  }

  set gameId(int value) {
    _gameId = value;
  }

  set childId(int value) {
    _childId = value;
  }

  set resultId(int value) {
    _resultId = value;
  }

  // METHODS ===================================================================
  Map<String, dynamic> toMap() => {
        "id": _id,
        "gameId": _gameId,
        "childId": _childId,
        "resultId": _resultId,
      };
}
