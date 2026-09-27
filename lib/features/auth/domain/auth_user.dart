class AuthUser {
  const AuthUser({
    required this.id,
    required this.name,
    required this.email,
    this.level = 1,
    this.xp = 0,
  });

  final String id;
  final String name;
  final String email;
  final int level;
  final int xp;

  AuthUser copyWith({
    String? id,
    String? name,
    String? email,
    int? level,
    int? xp,
  }) =>
      AuthUser(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        level: level ?? this.level,
        xp: xp ?? this.xp,
      );

  factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
    id: json['id'] as String? ?? '',
    name: json['name'] as String? ?? 'Élève',
    email: json['email'] as String? ?? '',
    level: (json['level'] as num?)?.toInt() ?? 1,
    xp: (json['xp'] as num?)?.toInt() ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'level': level,
    'xp': xp,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthUser &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email;

  @override
  int get hashCode => id.hashCode ^ email.hashCode;
}

