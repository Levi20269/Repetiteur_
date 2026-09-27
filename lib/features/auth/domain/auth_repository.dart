import 'auth_user.dart';

abstract interface class AuthRepository {
  Stream<AuthUser?> authStateChanges();
  AuthUser? get currentUser;
  Future<AuthUser> signIn({required String email, String password = ''});
  Future<AuthUser> register({
    required String name,
    required String email,
    String password = '',
  });
  Future<void> signOut();
  Future<AuthUser?> getUserProfile();
}
