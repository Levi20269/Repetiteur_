import 'dart:async';
import '../domain/auth_repository.dart';
import '../domain/auth_user.dart';

class DemoAuthRepository implements AuthRepository {
  DemoAuthRepository({AuthUser? initialUser})
      : _currentUser = initialUser ??
            const AuthUser(
              id: 'demo-user-1',
              name: 'Élève',
              email: 'eleve@monrepetiteur.fr',
              level: 1,
              xp: 150,
            );

  AuthUser? _currentUser;
  final StreamController<AuthUser?> _controller =
      StreamController<AuthUser?>.broadcast();

  @override
  AuthUser? get currentUser => _currentUser;

  @override
  Stream<AuthUser?> authStateChanges() async* {
    yield _currentUser;
    yield* _controller.stream;
  }

  @override
  Future<AuthUser> signIn({
    required String email,
    String password = '',
  }) async {
    final rawName = email.contains('@') ? email.split('@').first : email;
    final formattedName = rawName.trim().isEmpty
        ? 'Élève'
        : rawName.trim()[0].toUpperCase() + rawName.trim().substring(1);

    _currentUser = AuthUser(
      id: 'user-${email.hashCode.abs()}',
      name: formattedName,
      email: email.contains('@') ? email.trim() : '$email@monrepetiteur.fr',
      level: 1,
      xp: 150,
    );
    _controller.add(_currentUser);
    return _currentUser!;
  }

  @override
  Future<AuthUser> register({
    required String name,
    required String email,
    String password = '',
  }) async {
    _currentUser = AuthUser(
      id: 'user-${email.hashCode.abs()}',
      name: name.trim().isEmpty ? 'Élève' : name.trim(),
      email: email.contains('@') ? email.trim() : '$email@monrepetiteur.fr',
      level: 1,
      xp: 50,
    );
    _controller.add(_currentUser);
    return _currentUser!;
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
    _controller.add(null);
  }

  @override
  Future<AuthUser?> getUserProfile() async => _currentUser;
}
