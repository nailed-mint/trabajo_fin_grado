import 'package:trabajo_fin_grado/Model/user_model.dart';

class Child extends User {
  static const String tableName = "child";

  int familyId;
  List<int>? gameplayId;
  List<int>? reportId;

  Child({
    required super.id,
    required super.userType,
    required super.name,
    required super.surname,
    required this.familyId,
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
