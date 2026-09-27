class Quiz {
  const Quiz({
    required this.id,
    required this.title,
    required this.subjectId,
    required this.exerciseIds,
    this.durationMinutes = 5,
  });

  final String id;
  final String title;
  final String subjectId;
  final List<String> exerciseIds;
  final int durationMinutes;

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        id: json['id'] as String? ?? '',
        title: json['title'] as String? ?? '',
        subjectId: json['subjectId'] as String? ?? '',
        exerciseIds:
            List<String>.from(json['exerciseIds'] as List? ?? const []),
        durationMinutes: (json['durationMinutes'] as num?)?.toInt() ?? 5,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subjectId': subjectId,
        'exerciseIds': exerciseIds,
        'durationMinutes': durationMinutes,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Quiz &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title;

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
}

abstract interface class QuizRepository {
  Future<List<Quiz>> getQuizzes({String? subjectId});
  Future<Quiz> getQuiz(String id);
}
