import '../../../core/cache/hive_cache.dart';
import '../../../core/constants/demo_data.dart';
import '../../../core/error/app_exception.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/network_info.dart';
import '../domain/progress_entry.dart';

abstract interface class ProgressRemoteDataSource {
  Future<List<ProgressEntry>> getProgress();
  Future<SubmissionResult> submitProgress({
    required String exerciseId,
    required String answer,
  });
}

class ProgressApiDataSource implements ProgressRemoteDataSource {
  ProgressApiDataSource(this._api);
  final ApiClient _api;

  @override
  Future<List<ProgressEntry>> getProgress() async {
    final values = await _api.getList('/progress');
    return values
        .map((e) => ProgressEntry.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  @override
  Future<SubmissionResult> submitProgress({
    required String exerciseId,
    required String answer,
  }) async {
    final res = await _api.postMap('/progress', {
      'exerciseId': exerciseId,
      'answer': answer,
    });
    return SubmissionResult.fromJson(res);
  }
}

class ProgressDemoDataSource implements ProgressRemoteDataSource {
  ProgressDemoDataSource();

  final List<ProgressEntry> _inMemoryProgress = [];

  @override
  Future<List<ProgressEntry>> getProgress() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return List.unmodifiable(_inMemoryProgress);
  }

  @override
  Future<SubmissionResult> submitProgress({
    required String exerciseId,
    required String answer,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final exercise = DemoData.exercises.where((e) => e.id == exerciseId).firstOrNull;
    final isCorrect = exercise != null && exercise.correctAnswer == answer;
    final score = isCorrect ? 100 : 0;
    final entry = ProgressEntry(
      id: 'demo-prog-${DateTime.now().millisecondsSinceEpoch}',
      exerciseId: exerciseId,
      score: score,
      completedAt: DateTime.now(),
      subjectId: exercise?.subjectId,
      questionSummary: exercise?.question,
    );
    _inMemoryProgress.insert(0, entry);

    return SubmissionResult(
      id: entry.id,
      score: score,
      isCorrect: isCorrect,
      explanation: exercise?.explanation ?? 'Exercice complété.',
    );
  }
}

class ProgressRepositoryImpl implements ProgressRepository {
  ProgressRepositoryImpl({
    required ProgressRemoteDataSource remote,
    required JsonCache cache,
    required NetworkInfo network,
  })  : _remote = remote,
        _cache = cache,
        _network = network;

  static const _cacheKey = 'progress';
  final ProgressRemoteDataSource _remote;
  final JsonCache _cache;
  final NetworkInfo _network;

  @override
  Future<List<ProgressEntry>> getProgress() async {
    final isOnline = await _network.isConnected;
    if (isOnline) {
      try {
        final items = await _remote.getProgress();
        await _cache.writeList(
          _cacheKey,
          items.map((e) => e.toJson()).toList(),
        );
        return items;
      } catch (e) {
        final cached = await _cache.readList(_cacheKey);
        if (cached != null) {
          return cached.map(ProgressEntry.fromJson).toList();
        }
        rethrow;
      }
    }

    final cached = await _cache.readList(_cacheKey);
    if (cached != null) {
      return cached.map(ProgressEntry.fromJson).toList();
    }
    return [];
  }

  @override
  Future<SubmissionResult> submitProgress({
    required String exerciseId,
    required String answer,
  }) async {
    final isOnline = await _network.isConnected;
    if (!isOnline && _remote is! ProgressDemoDataSource) {
      throw const AppException(
        'L’envoi de votre réponse requiert une connexion Internet.',
      );
    }
    final result = await _remote.submitProgress(
      exerciseId: exerciseId,
      answer: answer,
    );
    // Rafraîchir le cache local avec la nouvelle progression si possible
    try {
      final updated = await _remote.getProgress();
      await _cache.writeList(
        _cacheKey,
        updated.map((e) => e.toJson()).toList(),
      );
    } catch (_) {}
    return result;
  }
}
