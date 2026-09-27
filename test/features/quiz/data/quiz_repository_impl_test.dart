import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mon_repetiteur/features/quiz/data/quiz_repository_impl.dart';
import 'package:mon_repetiteur/features/quiz/domain/quiz.dart';

class _QuizRemoteMock extends Mock implements QuizRemoteDataSource {}

void main() {
  late _QuizRemoteMock remote;
  late QuizRepositoryImpl repository;

  setUp(() {
    remote = _QuizRemoteMock();
    repository = QuizRepositoryImpl(remote: remote);
  });

  test('récupère la liste des quiz avec filtrage par matière', () async {
    const quizzes = [
      Quiz(
        id: 'q-1',
        title: 'Quiz Maths',
        subjectId: 'maths',
        exerciseIds: ['math-1', 'math-2'],
      ),
    ];
    when(() => remote.getQuizzes(subjectId: 'maths'))
        .thenAnswer((_) async => quizzes);

    final result = await repository.getQuizzes(subjectId: 'maths');

    expect(result.length, 1);
    expect(result.first.title, 'Quiz Maths');
    verify(() => remote.getQuizzes(subjectId: 'maths')).called(1);
  });

  test('récupère un quiz spécifique par son identifiant', () async {
    const quiz = Quiz(
      id: 'q-2',
      title: 'Quiz Français',
      subjectId: 'francais',
      exerciseIds: ['fr-1'],
      durationMinutes: 4,
    );
    when(() => remote.getQuiz('q-2')).thenAnswer((_) async => quiz);

    final result = await repository.getQuiz('q-2');

    expect(result.id, 'q-2');
    expect(result.durationMinutes, 4);
    verify(() => remote.getQuiz('q-2')).called(1);
  });
}
