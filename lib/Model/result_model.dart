class Result {
  // CLASS ATTRIBUTES ==========================================================
  static const String tableName = "result";

  // OBJECT ATTRIBUTES =========================================================
  int _id;
  int _gameplayId;
  int? _reportId;
  int _duration; // in seconds
  int _hitsNumber;
  int _missesNumber;

  // CONSTRUCTORS ==============================================================
  Result({
    required int id,
    required int gameplayId,
    int? reportId,
    required int duration,
    required int hitsNumber,
    required int missesNumber,
  })  : _missesNumber = missesNumber,
        _hitsNumber = hitsNumber,
        _duration = duration,
        _reportId = reportId,
        _gameplayId = gameplayId,
        _id = id;

  // GETTERS ===================================================================
  int get id => _id;
  int get gameplayId => _gameplayId;
  int? get reportId => _reportId;
  int get duration => _duration;
  int get hitsNumber => _hitsNumber;
  int get missesNumber => _missesNumber;

  // SETTERS ===================================================================
  // TODO: asegurar la integridad de la base de datos antes de modificar nada
  set id(int value) {
    _id = value;
  }

  set gameplayId(int value) {
    _gameplayId = value;
  }

  set reportId(int? value) {
    _reportId = value;
  }

  set duration(int value) {
    _duration = value;
  }

  set hitsNumber(int value) {
    _hitsNumber = value;
  }

  set missesNumber(int value) {
    _missesNumber = value;
  }

  // METHODS ===================================================================
  Map<String, dynamic> toMap() => {
        "id": _id,
        "gameplayId": _gameplayId,
        "reportId": _reportId,
        "duration": _duration,
        "hitsNumber": _hitsNumber,
        "missesNumber": _missesNumber,
      };
}
