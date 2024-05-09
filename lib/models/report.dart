class Report {
  final int? id;
  final DateTime? createdOn;
  final String? emissionDate;

  const Report({
    this.id,
    this.createdOn,
    this.emissionDate,
  });

  factory Report.fromSqfliteDatabase(Map<String, dynamic> map) => Report(
        id: map['id']?.toInt() ?? 0,
        createdOn:
            DateTime.fromMillisecondsSinceEpoch((map['createdOn'] ?? 0) * 1000),
        userId: map['userId']?.toInt() ?? 0,
        emissionDate: map['emissionDate'] ?? '',
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdOn': (createdOn?.millisecondsSinceEpoch ?? 1) ~/ 1000,
      'emissionDate': emissionDate,
    };
  }
}
