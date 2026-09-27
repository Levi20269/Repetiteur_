import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/auth/data/demo_auth_repository.dart';
import '../features/auth/data/firebase_auth_repository.dart';
import '../features/auth/domain/auth_repository.dart';
import '../features/auth/domain/auth_user.dart';
import '../features/courses/data/course_repository_impl.dart';
import '../features/courses/domain/course.dart';
import '../features/exercises/data/exercise_repository_impl.dart';
import '../features/exercises/domain/exercise.dart';
import '../features/progress/data/progress_repository_impl.dart';
import '../features/progress/domain/progress_entry.dart';
import '../features/quiz/data/quiz_repository_impl.dart';
import '../features/quiz/domain/quiz.dart';
import '../features/subjects/data/subject_repository_impl.dart';
import '../features/subjects/domain/subject.dart';
import 'cache/hive_cache.dart';
import 'network/api_client.dart';
import 'network/network_info.dart';

const _apiUrl = String.fromEnvironment('API_BASE_URL');

final localeProvider = StateProvider<Locale>((ref) => const Locale('fr'));

final firebaseReadyProvider = Provider<bool>((_) => false);
final apiConfiguredProvider = Provider<bool>((_) => _apiUrl.isNotEmpty);

final isDemoModeProvider = StateProvider<bool>((ref) {
  final firebaseReady = ref.watch(firebaseReadyProvider);
  final apiConfigured = ref.watch(apiConfiguredProvider);
  return !firebaseReady || !apiConfigured;
});

final cacheProvider = Provider<JsonCache>(
  (_) => throw UnimplementedError('Cache non initialisé'),
);

final networkInfoProvider = Provider<NetworkInfo>(
  (_) => ConnectivityNetworkInfo(Connectivity()),
);

final demoAuthRepositoryProvider = Provider<DemoAuthRepository>(
  (_) => DemoAuthRepository(),
);

final demoProgressDataSourceProvider = Provider<ProgressDemoDataSource>(
  (_) => ProgressDemoDataSource(),
);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final isDemo = ref.watch(isDemoModeProvider);
  final firebaseReady = ref.watch(firebaseReadyProvider);

  if (isDemo || !firebaseReady) {
    return ref.watch(demoAuthRepositoryProvider);
  }

  try {
    return FirebaseAuthRepository(
      FirebaseAuth.instance,
      FirebaseFirestore.instance,
    );
  } catch (_) {
    return ref.watch(demoAuthRepositoryProvider);
  }
});

final authStateProvider = StreamProvider<AuthUser?>(
  (ref) => ref.watch(authRepositoryProvider).authStateChanges(),
);

final currentUserProvider = Provider<AuthUser?>(
  (ref) => ref.watch(authRepositoryProvider).currentUser,
);

final apiClientProvider = Provider<ApiClient?>((ref) {
  if (_apiUrl.isEmpty) return null;
  try {
    return ApiClient(baseUrl: _apiUrl, auth: FirebaseAuth.instance);
  } catch (_) {
    return null;
  }
});

final subjectRepositoryProvider = Provider<SubjectRepository>((ref) {
  final isDemo = ref.watch(isDemoModeProvider);
  final apiClient = ref.watch(apiClientProvider);
  final cache = ref.watch(cacheProvider);
  final network = ref.watch(networkInfoProvider);

  final SubjectRemoteDataSource remote =
      (isDemo || apiClient == null)
          ? const SubjectDemoDataSource()
          : SubjectApiDataSource(apiClient);

  return SubjectRepositoryImpl(
    remote: remote,
    cache: cache,
    network: network,
  );
});

final exerciseRepositoryProvider = Provider<ExerciseRepository>((ref) {
  final isDemo = ref.watch(isDemoModeProvider);
  final apiClient = ref.watch(apiClientProvider);
  final cache = ref.watch(cacheProvider);
  final network = ref.watch(networkInfoProvider);

  final ExerciseRemoteDataSource remote =
      (isDemo || apiClient == null)
          ? const ExerciseDemoDataSource()
          : ExerciseApiDataSource(apiClient);

  return ExerciseRepositoryImpl(
    remote: remote,
    cache: cache,
    network: network,
  );
});

final courseRepositoryProvider = Provider<CourseRepository>((ref) {
  final cache = ref.watch(cacheProvider);
  final network = ref.watch(networkInfoProvider);

  return CourseRepositoryImpl(
    remote: const CourseDemoDataSource(),
    cache: cache,
    network: network,
  );
});

final quizRepositoryProvider = Provider<QuizRepository>((ref) {
  return QuizRepositoryImpl(
    remote: const QuizDemoDataSource(),
  );
});

final progressRepositoryProvider = Provider<ProgressRepository>((ref) {
  final isDemo = ref.watch(isDemoModeProvider);
  final apiClient = ref.watch(apiClientProvider);
  final cache = ref.watch(cacheProvider);
  final network = ref.watch(networkInfoProvider);

  final ProgressRemoteDataSource remote =
      (isDemo || apiClient == null)
          ? ref.watch(demoProgressDataSourceProvider)
          : ProgressApiDataSource(apiClient);

  return ProgressRepositoryImpl(
    remote: remote,
    cache: cache,
    network: network,
  );
});

final subjectsProvider = FutureProvider<List<Subject>>(
  (ref) => ref.watch(subjectRepositoryProvider).getSubjects(),
);

final coursesProvider = FutureProvider.family<List<Course>, String?>(
  (ref, subjectId) =>
      ref.watch(courseRepositoryProvider).getCourses(subjectId: subjectId),
);

final courseProvider = FutureProvider.family<Course, String>(
  (ref, id) => ref.watch(courseRepositoryProvider).getCourse(id),
);

final quizzesProvider = FutureProvider<List<Quiz>>(
  (ref) => ref.watch(quizRepositoryProvider).getQuizzes(),
);

final quizProvider = FutureProvider.family<Quiz, String>(
  (ref, id) => ref.watch(quizRepositoryProvider).getQuiz(id),
);

final exercisesProvider = FutureProvider.family<List<Exercise>, String?>(
  (ref, subjectId) =>
      ref.watch(exerciseRepositoryProvider).getExercises(subjectId: subjectId),
);

final exerciseProvider = FutureProvider.family<Exercise, String>(
  (ref, id) => ref.watch(exerciseRepositoryProvider).getExercise(id),
);

final progressProvider = FutureProvider<List<ProgressEntry>>(
  (ref) => ref.watch(progressRepositoryProvider).getProgress(),
);
