import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/error/app_exception.dart';
import '../domain/auth_repository.dart';
import '../domain/auth_user.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._auth, this._firestore);

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  @override
  AuthUser? get currentUser {
    final user = _auth.currentUser;
    if (user == null) return null;
    return AuthUser(
      id: user.uid,
      name: user.displayName ?? user.email?.split('@').first ?? 'Élève',
      email: user.email ?? '',
    );
  }

  @override
  Stream<AuthUser?> authStateChanges() => _auth.authStateChanges().map((user) {
        if (user == null) return null;
        return AuthUser(
          id: user.uid,
          name: user.displayName ?? user.email?.split('@').first ?? 'Élève',
          email: user.email ?? '',
        );
      });

  @override
  Future<AuthUser> signIn({
    required String email,
    String password = '',
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = credential.user!;
      final profile = await getUserProfile();
      return profile ??
          AuthUser(
            id: user.uid,
            name: user.displayName ?? user.email?.split('@').first ?? 'Élève',
            email: user.email ?? '',
          );
    } on FirebaseAuthException catch (error) {
      throw AppException(_message(error), cause: error);
    }
  }

  @override
  Future<AuthUser> register({
    required String name,
    required String email,
    String password = '',
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = credential.user!;
      await user.updateDisplayName(name.trim());
      await _firestore.collection('users').doc(user.uid).set({
        'name': name.trim(),
        'email': email.trim(),
        'level': 1,
        'xp': 0,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return AuthUser(
        id: user.uid,
        name: name.trim(),
        email: email.trim(),
        level: 1,
        xp: 0,
      );
    } on FirebaseAuthException catch (error) {
      throw AppException(_message(error), cause: error);
    }
  }

  @override
  Future<void> signOut() => _auth.signOut();

  @override
  Future<AuthUser?> getUserProfile() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    try {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        return AuthUser(
          id: user.uid,
          name: (data['name'] as String?) ?? user.displayName ?? 'Élève',
          email: (data['email'] as String?) ?? user.email ?? '',
          level: (data['level'] as num?)?.toInt() ?? 1,
          xp: (data['xp'] as num?)?.toInt() ?? 0,
        );
      }
    } catch (_) {
      // Ignorer l'erreur Firestore et se baser sur FirebaseAuth
    }
    return AuthUser(
      id: user.uid,
      name: user.displayName ?? user.email?.split('@').first ?? 'Élève',
      email: user.email ?? '',
    );
  }

  String _message(FirebaseAuthException error) => switch (error.code) {
    'invalid-email' => 'Cette adresse e-mail n’est pas valide.',
    'user-not-found' ||
    'wrong-password' ||
    'invalid-credential' => 'E-mail ou mot de passe incorrect.',
    'email-already-in-use' => 'Un compte existe déjà avec cet e-mail.',
    'weak-password' => 'Le mot de passe doit contenir au moins 6 caractères.',
    _ => 'Impossible de réaliser cette opération. Réessayez.',
  };
}
