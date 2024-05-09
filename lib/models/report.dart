class Report {
  final int? id;
  final DateTime? createdOn;
  final String? userName;

  const Report({
    this.id,
    this.createdOn,
    this.userName,
  });

  factory Report.fromSqfliteDatabase(Map<String, dynamic> map) => Report(
        id: map['id']?.toInt() ?? 0,
        createdOn:
            DateTime.fromMillisecondsSinceEpoch((map['createdOn'] ?? 0) * 1000),
        userName: map['userName']?.toString() ?? '',
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdOn': (createdOn?.millisecondsSinceEpoch ?? 1) ~/ 1000,
      'userName': userName,
    };
  }
}
