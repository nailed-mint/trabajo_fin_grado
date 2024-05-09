class Match {
  final int? id;
  final DateTime? createdOn;
  final int? gameId;
  final int? reportId;
  final int? duration;
  final int? hits;
  final int? errors;

  const Match({
    this.id,
    this.createdOn,
    this.gameId,
    this.reportId,
    this.duration,
    this.hits,
    this.errors,
  });

  factory Match.fromSqfliteDatabase(Map<String, dynamic> map) => Match(
        id: map['id']?.toInt() ?? 0,
        createdOn:
            DateTime.fromMillisecondsSinceEpoch((map['createdOn'] ?? 0) * 1000),
        gameId: map['gameId']?.toInt() ?? 0,
        reportId: map['reportId']?.toInt() ?? 0,
        duration: map['duration']?.toInt() ?? -1,
        hits: map['duration']?.toInt() ?? 0,
        errors: map['errors']?.toInt() ?? 0,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdOn': (createdOn?.millisecondsSinceEpoch ?? 1) ~/ 1000,
      'gameId': gameId,
      'reportId': reportId,
      'duration': duration,
      'hits': hits,
      'errors': errors,
    };
  }
}
