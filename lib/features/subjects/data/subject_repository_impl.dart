import '../../../core/cache/hive_cache.dart';
import '../../../core/constants/demo_data.dart';
import '../../../core/error/app_exception.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/network_info.dart';
import '../domain/subject.dart';

abstract interface class SubjectRemoteDataSource {
  Future<List<Subject>> getSubjects();
  Future<Subject> getSubject(String id);
}

class SubjectApiDataSource implements SubjectRemoteDataSource {
  SubjectApiDataSource(this._api);
  final ApiClient _api;

  @override
  Future<List<Subject>> getSubjects() async =>
      (await _api.getList('/subjects'))
          .map((e) => Subject.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();

  @override
  Future<Subject> getSubject(String id) async =>
      Subject.fromJson(await _api.getMap('/subjects/$id'));
}

class SubjectDemoDataSource implements SubjectRemoteDataSource {
  const SubjectDemoDataSource();

  @override
  Future<List<Subject>> getSubjects() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return DemoData.subjects;
  }

  @override
  Future<Subject> getSubject(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final subject = DemoData.subjects.where((s) => s.id == id).firstOrNull;
    if (subject == null) {
      throw const AppException('Cette matière est introuvable.');
    }
    return subject;
  }
}

class SubjectRepositoryImpl implements SubjectRepository {
  SubjectRepositoryImpl({
    required SubjectRemoteDataSource remote,
    required JsonCache cache,
    required NetworkInfo network,
  })  : _remote = remote,
        _cache = cache,
        _network = network;

  static const _cacheKey = 'subjects';
  final SubjectRemoteDataSource _remote;
  final JsonCache _cache;
  final NetworkInfo _network;

  @override
  Future<List<Subject>> getSubjects() async {
    final isOnline = await _network.isConnected;
    if (isOnline) {
      try {
        final subjects = await _remote.getSubjects();
        await _cache.writeList(
          _cacheKey,
          subjects.map((e) => e.toJson()).toList(),
        );
        return subjects;
      } catch (e) {
        // En cas d'erreur de requête API, tenter de lire le cache
        final cached = await _cache.readList(_cacheKey);
        if (cached != null && cached.isNotEmpty) {
          return cached.map(Subject.fromJson).toList();
        }
        rethrow;
      }
    }

    final cached = await _cache.readList(_cacheKey);
    if (cached != null && cached.isNotEmpty) {
      return cached.map(Subject.fromJson).toList();
    }

    // Si aucun cache n'existe encore et hors-ligne, proposer les matières pré-intégrées
    await _cache.writeList(
      _cacheKey,
      DemoData.subjects.map((e) => e.toJson()).toList(),
    );
    return DemoData.subjects;
  }

  @override
  Future<Subject> getSubject(String id) async {
    final all = await getSubjects();
    return all.firstWhere(
      (subject) => subject.id == id,
      orElse: () => throw const AppException('Cette matière est introuvable.'),
    );
  }
}
