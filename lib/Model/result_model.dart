class Result {
  static const String tableName = "result";

  int id;
  int gameplayId;
  int? reportId;
  int duration; // in seconds
  int hitsNumber;
  int missesNumber;

  Result({
    required this.id,
    required this.gameplayId,
    this.reportId,
    required this.duration,
    required this.hitsNumber,
    required this.missesNumber,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "gameplayId": gameplayId,
        "reportId": reportId,
        "duration": duration,
        "hitsNumber": hitsNumber,
        "missesNumber": missesNumber,
      };
}
