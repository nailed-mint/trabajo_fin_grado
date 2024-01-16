import 'package:trabajo_fin_grado/Model/user.dart';

class Child extends User {
  int familyId;
  List<int> gameplayId;
  List<int> reportId;

  Child({
    super.id,
    this.familyId,
    this.gameplayId,
    this.reportId,
  });

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> res = super.toMap();
    res.addAll(<String, dynamic>{
      "familyId": familyId,
      "gameplayId": gameplayId,
      "reportId": reportId,
    });
    return res;
  }
}
