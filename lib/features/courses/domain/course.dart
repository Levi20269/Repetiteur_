class Course {
  const Course({
    required this.id,
    required this.subjectId,
    required this.title,
    required this.chapter,
    required this.level,
    required this.objectives,
    required this.summary,
    required this.keyConcepts,
    required this.examples,
    required this.associatedExerciseIds,
  });

  final String id;
  final String subjectId;
  final String title;
  final String chapter;
  final String level;
  final List<String> objectives;
  final String summary;
  final List<String> keyConcepts;
  final List<String> examples;
  final List<String> associatedExerciseIds;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json['id'] as String? ?? '',
        subjectId: json['subjectId'] as String? ?? '',
        title: json['title'] as String? ?? '',
        chapter: json['chapter'] as String? ?? '',
        level: json['level'] as String? ?? '',
        objectives: List<String>.from(json['objectives'] as List? ?? const []),
        summary: json['summary'] as String? ?? '',
        keyConcepts: List<String>.from(json['keyConcepts'] as List? ?? const []),
        examples: List<String>.from(json['examples'] as List? ?? const []),
        associatedExerciseIds:
            List<String>.from(json['associatedExerciseIds'] as List? ?? const []),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'subjectId': subjectId,
        'title': title,
        'chapter': chapter,
        'level': level,
        'objectives': objectives,
        'summary': summary,
        'keyConcepts': keyConcepts,
        'examples': examples,
        'associatedExerciseIds': associatedExerciseIds,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Course &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title;

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
}

abstract interface class CourseRepository {
  Future<List<Course>> getCourses({String? subjectId});
  Future<Course> getCourse(String id);
}
