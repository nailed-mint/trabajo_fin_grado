import 'package:trabajo_fin_grado/Model/user_model.dart';

class Professional extends User {
  static const String tableName = "professional";

  String email;

  Professional({
    super.id,
    this.email,
  });

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> res = super.toMap();
    res.addAll(<String, dynamic>{
      "email": email,
    });
    return res;
  }
}
