import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../error/app_exception.dart';

/// Ajoute le Firebase ID token aux requêtes de l'API Cloud Functions.
class FirebaseAuthInterceptor extends Interceptor {
  FirebaseAuthInterceptor(this._auth);

  final FirebaseAuth _auth;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final user = _auth.currentUser;
    if (user != null) {
      final token = await user.getIdToken();
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}

class ApiClient {
  ApiClient({required String baseUrl, required FirebaseAuth auth})
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 12),
          receiveTimeout: const Duration(seconds: 15),
          headers: const {'Accept': 'application/json'},
        ),
      ) {
    _dio.interceptors.add(FirebaseAuthInterceptor(auth));
  }

  final Dio _dio;

  Future<List<dynamic>> getList(String path) async {
    try {
      final response = await _dio.get<dynamic>(path);
      final data = response.data;
      if (data is List<dynamic>) return data;
      throw const AppException('Réponse du serveur invalide.');
    } on DioException catch (error) {
      throw _friendlyDioError(error);
    }
  }

  Future<Map<String, dynamic>> getMap(String path) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(path);
      return response.data ?? <String, dynamic>{};
    } on DioException catch (error) {
      throw _friendlyDioError(error);
    }
  }

  Future<Map<String, dynamic>> postMap(
    String path,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(path, data: body);
      return response.data ?? <String, dynamic>{};
    } on DioException catch (error) {
      throw _friendlyDioError(error);
    }
  }

  AppException _friendlyDioError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.receiveTimeout) {
      return AppException(
        'Impossible de joindre le serveur. Vérifiez votre connexion.',
        cause: error,
      );
    }
    if (error.response?.statusCode == 401) {
      return AppException(
        'Votre session a expiré. Veuillez vous reconnecter.',
        cause: error,
      );
    }
    return AppException(
      'Le service est temporairement indisponible. Réessayez.',
      cause: error,
    );
  }
}
