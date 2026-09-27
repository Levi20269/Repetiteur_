class ProgressEntry {
  const ProgressEntry({
    required this.id,
    required this.exerciseId,
    required this.score,
    required this.completedAt,
    this.subjectId,
    this.questionSummary,
  });

  final String id;
  final String exerciseId;
  final int score;
  final DateTime completedAt;
  final String? subjectId;
  final String? questionSummary;

  factory ProgressEntry.fromJson(Map<String, dynamic> json) => ProgressEntry(
    id: json['id'] as String? ?? '',
    exerciseId: json['exerciseId'] as String? ?? '',
    score: (json['score'] as num?)?.toInt() ?? 0,
    completedAt:
        DateTime.tryParse(json['completedAt'] as String? ?? '') ??
        DateTime.now(),
    subjectId: json['subjectId'] as String?,
    questionSummary: json['questionSummary'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'exerciseId': exerciseId,
    'score': score,
    'completedAt': completedAt.toIso8601String(),
    if (subjectId != null) 'subjectId': subjectId,
    if (questionSummary != null) 'questionSummary': questionSummary,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgressEntry &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          exerciseId == other.exerciseId &&
          score == other.score;

  @override
  int get hashCode => id.hashCode ^ exerciseId.hashCode ^ score.hashCode;
}

class SubmissionResult {
  const SubmissionResult({
    required this.id,
    required this.score,
    required this.isCorrect,
    this.explanation,
  });

  final String id;
  final int score;
  final bool isCorrect;
  final String? explanation;

  factory SubmissionResult.fromJson(Map<String, dynamic> json) =>
      SubmissionResult(
        id: json['id'] as String? ?? '',
        score: (json['score'] as num?)?.toInt() ?? 0,
        isCorrect:
            json['isCorrect'] as bool? ??
            ((json['score'] as num?)?.toInt() == 100),
        explanation: json['explanation'] as String?,
      );
}

abstract interface class ProgressRepository {
  Future<List<ProgressEntry>> getProgress();
  Future<SubmissionResult> submitProgress({
    required String exerciseId,
    required String answer,
  });
}
