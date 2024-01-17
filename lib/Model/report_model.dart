class Report {
  static const String tableName = "report";

  int id;
  int childId;
  int familyId;
  List<int> resultId;

  Report({
    required this.id,
    required this.childId,
    required this.familyId,
    required this.resultId,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "childId": childId,
        "familyId": familyId,
        "resultId": resultId,
      };
}
