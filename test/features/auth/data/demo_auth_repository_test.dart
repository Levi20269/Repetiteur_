import 'package:flutter_test/flutter_test.dart';
import 'package:mon_repetiteur/features/auth/data/demo_auth_repository.dart';

void main() {
  late DemoAuthRepository repository;

  setUp(() {
    repository = DemoAuthRepository();
  });

  test('signIn connecte un utilisateur sans exiger de mot de passe', () async {
    final user = await repository.signIn(
      email: 'alex',
    );

    expect(user.name, 'Alex');
    expect(repository.currentUser, isNotNull);
  });

  test('register crée un nouvel utilisateur', () async {
    final user = await repository.register(
      name: 'Sophie',
      email: 'sophie@test.fr',
    );

    expect(user.name, 'Sophie');
    expect(user.level, 1);
  });
}
