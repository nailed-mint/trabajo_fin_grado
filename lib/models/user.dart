class User {
  final int? id;
  final String name;
  final String type;
  final String? email;

  const User({
    this.id,
    required this.name,
    required this.type,
    this.email,
  });

  factory User.fromSqfliteDatabase(Map<String, dynamic> map) => User(
        id: map['id']?.toInt() ?? 0,
        name: map['name'] ?? '',
        type: map['type'] ?? '',
        email: map['email'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'email': email,
    };
  }
}
