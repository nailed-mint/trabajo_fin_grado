class Gameplay {
  static const String tableName = "gameplay";

  int id;
  int gameId;
  int childId;
  int resultId;

  Gameplay({
    required this.id,
    required this.gameId,
    required this.childId,
    required this.resultId,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "gameId": gameId,
        "childId": childId,
        "resultId": resultId,
      };
}
