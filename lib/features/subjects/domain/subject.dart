class Subject {
  const Subject({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
  });

  final String id;
  final String name;
  final String description;
  final String icon;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    id: json['id'] as String? ?? '',
    name: json['name'] as String? ?? 'Matière',
    description: json['description'] as String? ?? '',
    icon: json['icon'] as String? ?? 'school',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'icon': icon,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Subject &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

abstract interface class SubjectRepository {
  Future<List<Subject>> getSubjects();
  Future<Subject> getSubject(String id);
}
