import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mon_repetiteur/core/cache/hive_cache.dart';
import 'package:mon_repetiteur/core/network/network_info.dart';
import 'package:mon_repetiteur/features/courses/data/course_repository_impl.dart';
import 'package:mon_repetiteur/features/courses/domain/course.dart';

class _RemoteMock extends Mock implements CourseRemoteDataSource {}

class _CacheMock extends Mock implements JsonCache {}

class _NetworkMock extends Mock implements NetworkInfo {}

void main() {
  late _RemoteMock remote;
  late _CacheMock cache;
  late _NetworkMock network;
  late CourseRepositoryImpl repository;

  setUp(() {
    remote = _RemoteMock();
    cache = _CacheMock();
    network = _NetworkMock();
    repository = CourseRepositoryImpl(
      remote: remote,
      cache: cache,
      network: network,
    );
  });

  test('récupère la liste des cours depuis la source distante en mode connecté',
      () async {
    const courses = [
      Course(
        id: 'c-1',
        subjectId: 'maths',
        title: 'Limites et continuité',
        chapter: 'Chapitre 1',
        level: 'Terminale',
        objectives: ['Comprendre les limites'],
        summary: 'Résumé du cours',
        keyConcepts: ['Notion 1'],
        examples: ['Exemple 1'],
        associatedExerciseIds: ['math-1'],
      ),
    ];
    when(() => network.isConnected).thenAnswer((_) async => true);
    when(() => remote.getCourses(subjectId: null))
        .thenAnswer((_) async => courses);
    when(() => cache.writeList(any(), any())).thenAnswer((_) async {});

    final result = await repository.getCourses();

    expect(result.length, 1);
    expect(result.first.title, 'Limites et continuité');
    verify(() => remote.getCourses(subjectId: null)).called(1);
    verify(() => cache.writeList('courses', [courses.first.toJson()])).called(1);
  });

  test('récupère un cours par son identifiant avec succès', () async {
    const course = Course(
      id: 'c-1',
      subjectId: 'maths',
      title: 'Limites et continuité',
      chapter: 'Chapitre 1',
      level: 'Terminale',
      objectives: ['Comprendre les limites'],
      summary: 'Résumé du cours',
      keyConcepts: ['Notion 1'],
      examples: ['Exemple 1'],
      associatedExerciseIds: ['math-1'],
    );
    when(() => network.isConnected).thenAnswer((_) async => true);
    when(() => remote.getCourses(subjectId: null))
        .thenAnswer((_) async => [course]);
    when(() => cache.writeList(any(), any())).thenAnswer((_) async {});

    final result = await repository.getCourse('c-1');

    expect(result.id, 'c-1');
    expect(result.chapter, 'Chapitre 1');
  });
}
