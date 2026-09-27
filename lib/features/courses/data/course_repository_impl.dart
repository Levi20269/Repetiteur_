import '../../../core/cache/hive_cache.dart';
import '../../../core/constants/pedagogical_content.dart';
import '../../../core/error/app_exception.dart';
import '../../../core/network/network_info.dart';
import '../domain/course.dart';

abstract interface class CourseRemoteDataSource {
  Future<List<Course>> getCourses({String? subjectId});
  Future<Course> getCourse(String id);
}

class CourseDemoDataSource implements CourseRemoteDataSource {
  const CourseDemoDataSource();

  @override
  Future<List<Course>> getCourses({String? subjectId}) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    if (subjectId == null) return PedagogicalContent.courses;
    return PedagogicalContent.courses
        .where((c) => c.subjectId == subjectId)
        .toList();
  }

  @override
  Future<Course> getCourse(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    final course =
        PedagogicalContent.courses.where((c) => c.id == id).firstOrNull;
    if (course == null) {
      throw const AppException('Ce cours est introuvable.');
    }
    return course;
  }
}

class CourseRepositoryImpl implements CourseRepository {
  CourseRepositoryImpl({
    required CourseRemoteDataSource remote,
    required JsonCache cache,
    required NetworkInfo network,
  })  : _remote = remote,
        _cache = cache,
        _network = network;

  static const _cacheKey = 'courses';
  final CourseRemoteDataSource _remote;
  final JsonCache _cache;
  final NetworkInfo _network;

  @override
  Future<List<Course>> getCourses({String? subjectId}) async {
    final isOnline = await _network.isConnected;
    if (isOnline) {
      try {
        final courses = await _remote.getCourses(subjectId: subjectId);
        if (subjectId == null) {
          await _cache.writeList(
            _cacheKey,
            courses.map((e) => e.toJson()).toList(),
          );
        }
        return courses;
      } catch (_) {}
    }

    final cached = await _cache.readList(_cacheKey);
    if (cached != null && cached.isNotEmpty) {
      final all = cached.map(Course.fromJson).toList();
      return subjectId == null
          ? all
          : all.where((c) => c.subjectId == subjectId).toList();
    }

    await _cache.writeList(
      _cacheKey,
      PedagogicalContent.courses.map((e) => e.toJson()).toList(),
    );
    return subjectId == null
        ? PedagogicalContent.courses
        : PedagogicalContent.courses
            .where((c) => c.subjectId == subjectId)
            .toList();
  }

  @override
  Future<Course> getCourse(String id) async {
    final all = await getCourses();
    return all.firstWhere(
      (c) => c.id == id,
      orElse: () => throw const AppException('Ce cours est introuvable.'),
    );
  }
}
