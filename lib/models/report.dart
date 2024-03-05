class Report {
  final int? id;
  final int? userId;
  final String? emissionDate;

  const Report({
    this.id,
    this.userId,
    this.emissionDate,
  });

  factory Report.fromSqfliteDatabase(Map<String, dynamic> map) => Report(
        id: map['id']?.toInt() ?? 0,
        userId: map['userId']?.toInt() ?? 0,
        emissionDate: map['emissionDate'] ?? '',
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'emissionDate': emissionDate,
    };
  }
}
