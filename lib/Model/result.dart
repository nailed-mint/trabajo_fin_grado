class Result {
  int id;
  int gameplayId;
  int reportId;
  Duration timeSpent;
  int hitsNumber;
  int missesNumber;

  Result({
    this.id,
    this.gameplayId,
    this.reportId,
    this.timeSpent,
    this.hitsNumber,
    this.missesNumber,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "gameplayId": gameplayId,
        "reportId": reportId,
        "timeSpent": timeSpent,
        "hitsNumber": hitsNumber,
        "missesNumber": missesNumber,
      };
}
