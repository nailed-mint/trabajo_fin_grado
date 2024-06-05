class Game {
  final int id;
  final String name;
  final int icon;
  final String description;

  const Game({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
  });

  factory Game.fromSqfliteDatabase(Map<String, dynamic> map) => Game(
        id: map['id']?.toInt() ?? 0,
        name: map['name'] ?? '',
        icon: map['icon'] ?? 3418,
        description: map['description'] ?? '',
      );

  Map<String, dynamic> toMap() =>
      {'id': id, 'name': name, 'icon': icon, 'description': description};
}
