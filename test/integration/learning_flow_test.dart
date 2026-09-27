import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mon_repetiteur/core/localization/app_localizations.dart';
import 'package:mon_repetiteur/core/providers.dart';
import 'package:mon_repetiteur/core/router/app_router.dart';
import 'package:mon_repetiteur/features/auth/domain/auth_user.dart';

void main() {
  testWidgets('Parcours d’apprentissage complet : Accueil -> Cours -> Détail -> Exercice',
      (tester) async {
    const testUser = AuthUser(
      id: 'integration-user',
      name: 'Emma',
      email: 'emma@test.fr',
      level: 1,
      xp: 100,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentUserProvider.overrideWithValue(testUser),
        ],
        child: MaterialApp.router(
          routerConfig: appRouter,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Vérification de la page d'accueil
    expect(find.textContaining('Emma'), findsOneWidget);
    expect(find.text('Vos cours'), findsOneWidget);

    // Navigation vers l'onglet Cours
    await tester.tap(find.text('Cours'));
    await tester.pumpAndSettle();

    expect(find.text('Limites et Continuité'), findsOneWidget);

    // Ouverture du détail du cours
    await tester.tap(find.text('Limites et Continuité'));
    await tester.pumpAndSettle();

    expect(find.text('Détail du cours'), findsOneWidget);
    expect(find.text('Objectifs du chapitre'), findsOneWidget);
    expect(find.text('S’entraîner sur ce cours'), findsOneWidget);
  });
}
