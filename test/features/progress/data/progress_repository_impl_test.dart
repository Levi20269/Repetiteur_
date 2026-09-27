import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mon_repetiteur/core/cache/hive_cache.dart';
import 'package:mon_repetiteur/core/network/network_info.dart';
import 'package:mon_repetiteur/features/progress/data/progress_repository_impl.dart';
import 'package:mon_repetiteur/features/progress/domain/progress_entry.dart';

class _RemoteMock extends Mock implements ProgressRemoteDataSource {}

class _CacheMock extends Mock implements JsonCache {}

class _NetworkMock extends Mock implements NetworkInfo {}

void main() {
  late _RemoteMock remote;
  late _CacheMock cache;
  late _NetworkMock network;
  late ProgressRepositoryImpl repository;

  setUp(() {
    remote = _RemoteMock();
    cache = _CacheMock();
    network = _NetworkMock();
    repository = ProgressRepositoryImpl(
      remote: remote,
      cache: cache,
      network: network,
    );
  });

  test('récupère l’historique des progrès et met en cache', () async {
    final entries = [
      ProgressEntry(
        id: 'p-1',
        exerciseId: 'math-1',
        score: 100,
        completedAt: DateTime.now(),
      ),
    ];
    when(() => network.isConnected).thenAnswer((_) async => true);
    when(remote.getProgress).thenAnswer((_) async => entries);
    when(() => cache.writeList(any(), any())).thenAnswer((_) async {});

    final result = await repository.getProgress();

    expect(result.length, 1);
    expect(result.first.score, 100);
    verify(remote.getProgress).called(1);
  });

  test('soumet une réponse et retourne le résultat de score', () async {
    const submission = SubmissionResult(
      id: 'p-new',
      score: 100,
      isCorrect: true,
      explanation: 'Parfait !',
    );
    when(() => network.isConnected).thenAnswer((_) async => true);
    when(() => remote.submitProgress(exerciseId: 'math-1', answer: '56'))
        .thenAnswer((_) async => submission);
    when(remote.getProgress).thenAnswer((_) async => []);
    when(() => cache.writeList(any(), any())).thenAnswer((_) async {});

    final result = await repository.submitProgress(
      exerciseId: 'math-1',
      answer: '56',
    );

    expect(result.isCorrect, isTrue);
    expect(result.score, 100);
    expect(result.explanation, 'Parfait !');
  });
}

