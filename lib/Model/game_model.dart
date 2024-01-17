class Game {
  // CLASS ATTRIBUTES ==========================================================
  static const String tableName = "game";

  // OBJECT ATTRIBUTES =========================================================
  int _id;
  String _name;
  List<int>? _gameplayId;

  // CONSTRUCTORS ==============================================================
  Game({
    required int id,
    required String name,
    List<int>? gameplayId,
  })  : _gameplayId = gameplayId,
        _name = name,
        _id = id;

  // GETTERS ===================================================================
  int get id => _id;
  String get name => _name;
  List<int>? get gameplayId => _gameplayId;

  // SETTERS ===================================================================
  // TODO: asegurar la integridad de la base de datos antes de modificar nada
  set id(int value) {
    _id = value;
  }

  set name(String value) {
    _name = value;
  }

  set gameplayId(List<int>? value) {
    _gameplayId = value;
  }

  // METHODS ===================================================================
  Map<String, dynamic> toMap() => {
        "id": _id,
        "name": _name,
        "gameplayId": _gameplayId,
      };
}
