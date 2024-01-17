class Game {
  static const String tableName = "game";

  int id;
  String name;
  List<int>? gameplayId;

  Game({
    required this.id,
    required this.name,
    this.gameplayId,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "gameplayId": gameplayId,
      };
}
