class Exercise {
  const Exercise({
    required this.id,
    required this.subjectId,
    required this.question,
    required this.answers,
    required this.explanation,
    this.correctAnswer,
  });

  final String id;
  final String subjectId;
  final String question;
  final List<String> answers;
  final String explanation;
  final String? correctAnswer;

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
    id: json['id'] as String? ?? '',
    subjectId: json['subjectId'] as String? ?? '',
    question: json['question'] as String? ?? '',
    answers: List<String>.from(json['answers'] as List? ?? const []),
    explanation: json['explanation'] as String? ?? '',
    correctAnswer: json['correctAnswer'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'subjectId': subjectId,
    'question': question,
    'answers': answers,
    'explanation': explanation,
    if (correctAnswer != null) 'correctAnswer': correctAnswer,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Exercise &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          subjectId == other.subjectId &&
          question == other.question;

  @override
  int get hashCode => id.hashCode ^ subjectId.hashCode ^ question.hashCode;
}

abstract interface class ExerciseRepository {
  Future<List<Exercise>> getExercises({String? subjectId});
  Future<Exercise> getExercise(String id);
}
