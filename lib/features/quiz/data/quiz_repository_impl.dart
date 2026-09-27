import '../../../core/constants/pedagogical_content.dart';
import '../../../core/error/app_exception.dart';
import '../domain/quiz.dart';

abstract interface class QuizRemoteDataSource {
  Future<List<Quiz>> getQuizzes({String? subjectId});
  Future<Quiz> getQuiz(String id);
}

class QuizDemoDataSource implements QuizRemoteDataSource {
  const QuizDemoDataSource();

  @override
  Future<List<Quiz>> getQuizzes({String? subjectId}) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    if (subjectId == null) return PedagogicalContent.quizzes;
    return PedagogicalContent.quizzes
        .where((q) => q.subjectId == subjectId)
        .toList();
  }

  @override
  Future<Quiz> getQuiz(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    final quiz = PedagogicalContent.quizzes.where((q) => q.id == id).firstOrNull;
    if (quiz == null) {
      throw const AppException('Ce quiz est introuvable.');
    }
    return quiz;
  }
}

class QuizRepositoryImpl implements QuizRepository {
  QuizRepositoryImpl({required QuizRemoteDataSource remote})
      : _remote = remote;

  final QuizRemoteDataSource _remote;

  @override
  Future<List<Quiz>> getQuizzes({String? subjectId}) =>
      _remote.getQuizzes(subjectId: subjectId);

  @override
  Future<Quiz> getQuiz(String id) => _remote.getQuiz(id);
}
