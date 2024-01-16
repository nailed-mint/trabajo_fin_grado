class Report {
  int id;
  int childId;
  int familyId;
  List<int> resultId;

  Report({
    this.id,
    this.childId,
    this.familyId,
    this.resultId,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "childId": childId,
        "familyId": familyId,
        "resultId": resultId,
      };
}
