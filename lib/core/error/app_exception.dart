/// Exception métier affichable, sans exposer les détails techniques à l'élève.
class AppException implements Exception {
  const AppException(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() => message;
}
