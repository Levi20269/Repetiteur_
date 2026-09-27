import '../../../core/cache/hive_cache.dart';
import '../../../core/constants/demo_data.dart';
import '../../../core/error/app_exception.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/network_info.dart';
import '../domain/exercise.dart';

abstract interface class ExerciseRemoteDataSource {
  Future<List<Exercise>> getExercises({String? subjectId});
  Future<Exercise> getExercise(String id);
}

class ExerciseApiDataSource implements ExerciseRemoteDataSource {
  ExerciseApiDataSource(this._api);
  final ApiClient _api;

  @override
  Future<List<Exercise>> getExercises({String? subjectId}) async {
    final query = subjectId == null ? '' : '?subjectId=$subjectId';
    final values = await _api.getList('/exercises$query');
    return values
        .map((e) => Exercise.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  @override
  Future<Exercise> getExercise(String id) async =>
      Exercise.fromJson(await _api.getMap('/exercises/$id'));
}

class ExerciseDemoDataSource implements ExerciseRemoteDataSource {
  const ExerciseDemoDataSource();

  @override
  Future<List<Exercise>> getExercises({String? subjectId}) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    if (subjectId == null) return DemoData.exercises;
    return DemoData.exercises.where((e) => e.subjectId == subjectId).toList();
  }

  @override
  Future<Exercise> getExercise(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final exercise = DemoData.exercises.where((e) => e.id == id).firstOrNull;
    if (exercise == null) {
      throw const AppException('Cet exercice est introuvable.');
    }
    return exercise;
  }
}

class ExerciseRepositoryImpl implements ExerciseRepository {
  ExerciseRepositoryImpl({
    required ExerciseRemoteDataSource remote,
    required JsonCache cache,
    required NetworkInfo network,
  })  : _remote = remote,
        _cache = cache,
        _network = network;

  static const _cacheKey = 'exercises';
  final ExerciseRemoteDataSource _remote;
  final JsonCache _cache;
  final NetworkInfo _network;

  @override
  Future<List<Exercise>> getExercises({String? subjectId}) async {
    final isOnline = await _network.isConnected;
    if (isOnline) {
      try {
        final exercises = await _remote.getExercises(subjectId: subjectId);
        if (subjectId == null) {
          await _cache.writeList(
            _cacheKey,
            exercises.map((e) => e.toJson()).toList(),
          );
        }
        return exercises;
      } catch (e) {
        final cached = await _cache.readList(_cacheKey);
        if (cached != null && cached.isNotEmpty) {
          final all = cached.map(Exercise.fromJson).toList();
          return subjectId == null
              ? all
              : all.where((e) => e.subjectId == subjectId).toList();
        }
        rethrow;
      }
    }

    final cached = await _cache.readList(_cacheKey);
    if (cached != null && cached.isNotEmpty) {
      final all = cached.map(Exercise.fromJson).toList();
      return subjectId == null
          ? all
          : all.where((e) => e.subjectId == subjectId).toList();
    }

    // Pré-remplissage local avec les exercices par défaut
    await _cache.writeList(
      _cacheKey,
      DemoData.exercises.map((e) => e.toJson()).toList(),
    );
    return subjectId == null
        ? DemoData.exercises
        : DemoData.exercises.where((e) => e.subjectId == subjectId).toList();
  }

  @override
  Future<Exercise> getExercise(String id) async {
    final isOnline = await _network.isConnected;
    if (isOnline) {
      try {
        return await _remote.getExercise(id);
      } catch (_) {}
    }
    final exercises = await getExercises();
    return exercises.firstWhere(
      (e) => e.id == id,
      orElse: () => throw const AppException('Cet exercice est introuvable.'),
    );
  }
}
