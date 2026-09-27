import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mon_repetiteur/core/cache/hive_cache.dart';
import 'package:mon_repetiteur/core/error/app_exception.dart';
import 'package:mon_repetiteur/core/network/network_info.dart';
import 'package:mon_repetiteur/features/subjects/data/subject_repository_impl.dart';
import 'package:mon_repetiteur/features/subjects/domain/subject.dart';

class _RemoteMock extends Mock implements SubjectRemoteDataSource {}

class _CacheMock extends Mock implements JsonCache {}

class _NetworkMock extends Mock implements NetworkInfo {}

void main() {
  late _RemoteMock remote;
  late _CacheMock cache;
  late _NetworkMock network;
  late SubjectRepositoryImpl repository;

  setUp(() {
    remote = _RemoteMock();
    cache = _CacheMock();
    network = _NetworkMock();
    repository = SubjectRepositoryImpl(
      remote: remote,
      cache: cache,
      network: network,
    );
  });

  test(
    'récupère les matières depuis l’API et les met en cache en ligne',
    () async {
      const subjects = [
        Subject(
          id: 'maths',
          name: 'Mathématiques',
          description: 'Algèbre',
          icon: 'calculate',
        ),
      ];
      when(() => network.isConnected).thenAnswer((_) async => true);
      when(remote.getSubjects).thenAnswer((_) async => subjects);
      when(() => cache.writeList(any(), any())).thenAnswer((_) async {});

      final result = await repository.getSubjects();

      expect(result, subjects);
      verify(remote.getSubjects).called(1);
      verify(() => cache.writeList('subjects', [subjects.first.toJson()]))
          .called(1);
    },
  );

  test('utilise le cache quand le réseau est indisponible', () async {
    when(() => network.isConnected).thenAnswer((_) async => false);
    when(() => cache.readList('subjects')).thenAnswer(
      (_) async => [
        {
          'id': 'fr',
          'name': 'Français',
          'description': 'Lecture',
          'icon': 'menu_book',
        },
      ],
    );

    final result = await repository.getSubjects();

    expect(result.single.name, 'Français');
    verifyNever(remote.getSubjects);
  });

  test(
    'propage une erreur réseau compréhensible au lieu de données erronées',
    () async {
      when(() => network.isConnected).thenAnswer((_) async => true);
      when(remote.getSubjects)
          .thenThrow(const AppException('Impossible de joindre le serveur.'));
      when(() => cache.readList('subjects')).thenAnswer((_) async => null);

      await expectLater(repository.getSubjects(), throwsA(isA<AppException>()));
      verify(remote.getSubjects).called(1);
    },
  );
}
