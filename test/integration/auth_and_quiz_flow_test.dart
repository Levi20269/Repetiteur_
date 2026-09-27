import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mon_repetiteur/core/localization/app_localizations.dart';
import 'package:mon_repetiteur/core/providers.dart';
import 'package:mon_repetiteur/core/router/app_router.dart';
import 'package:mon_repetiteur/features/auth/domain/auth_user.dart';

void main() {
  testWidgets('Parcours d’évaluation complet : Accueil -> Quiz -> Résolution de questions',
      (tester) async {
    const testUser = AuthUser(
      id: 'quiz-user',
      name: 'Thomas',
      email: 'thomas@test.fr',
      level: 2,
      xp: 200,
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

    // Navigation vers l'onglet Quiz
    await tester.tap(find.text('Quiz'));
    await tester.pumpAndSettle();

    expect(find.text('Quiz d’évaluation'), findsOneWidget);
    expect(find.textContaining('Grand Quiz : Analyse & Fonctions'), findsOneWidget);

    // Démarrage du quiz
    await tester.tap(find.textContaining('Grand Quiz : Analyse & Fonctions'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Question 1'), findsOneWidget);
    expect(find.text('Choisissez la bonne réponse :'), findsOneWidget);
  });
}
