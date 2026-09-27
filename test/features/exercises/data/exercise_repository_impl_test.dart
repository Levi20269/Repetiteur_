import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mon_repetiteur/core/cache/hive_cache.dart';
import 'package:mon_repetiteur/core/network/network_info.dart';
import 'package:mon_repetiteur/features/exercises/data/exercise_repository_impl.dart';
import 'package:mon_repetiteur/features/exercises/domain/exercise.dart';

class _RemoteMock extends Mock implements ExerciseRemoteDataSource {}

class _CacheMock extends Mock implements JsonCache {}

class _NetworkMock extends Mock implements NetworkInfo {}

void main() {
  late _RemoteMock remote;
  late _CacheMock cache;
  late _NetworkMock network;
  late ExerciseRepositoryImpl repository;

  setUp(() {
    remote = _RemoteMock();
    cache = _CacheMock();
    network = _NetworkMock();
    repository = ExerciseRepositoryImpl(
      remote: remote,
      cache: cache,
      network: network,
    );
  });

  test('récupère les exercices depuis la source distante en mode connecté', () async {
    const exercises = [
      Exercise(
        id: 'ex-1',
        subjectId: 'maths',
        question: 'Combien font 2 + 2 ?',
        answers: ['3', '4', '5'],
        explanation: '2 + 2 = 4',
      ),
    ];
    when(() => network.isConnected).thenAnswer((_) async => true);
    when(() => remote.getExercises(subjectId: null))
        .thenAnswer((_) async => exercises);
    when(() => cache.writeList(any(), any())).thenAnswer((_) async {});

    final result = await repository.getExercises();

    expect(result.length, 1);
    expect(result.first.id, 'ex-1');
    verify(() => remote.getExercises(subjectId: null)).called(1);
    verify(() => cache.writeList('exercises', [exercises.first.toJson()]))
        .called(1);
  });

  test('utilise le cache en mode hors connexion', () async {
    when(() => network.isConnected).thenAnswer((_) async => false);
    when(() => cache.readList('exercises')).thenAnswer(
      (_) async => [
        {
          'id': 'ex-offline',
          'subjectId': 'francais',
          'question': 'Trouvez le verbe',
          'answers': ['courir', 'table'],
          'explanation': 'courir est une action',
        }
      ],
    );

    final result = await repository.getExercises();

    expect(result.length, 1);
    expect(result.first.question, 'Trouvez le verbe');
    verifyNever(() => remote.getExercises());
  });
}

