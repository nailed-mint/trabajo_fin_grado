class Gameplay {
  static const String tableName = "gameplay";

  int id;
  int gameId;
  int childId;
  int resultId;

  Gameplay({
    this.id,
    this.gameId,
    this.childId,
    this.resultId,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "gameId": gameId,
        "childId": childId,
        "resultId": resultId,
      };
}
