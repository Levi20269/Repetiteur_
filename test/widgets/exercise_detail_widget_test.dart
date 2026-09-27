import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mon_repetiteur/core/localization/app_localizations.dart';
import 'package:mon_repetiteur/core/providers.dart';
import 'package:mon_repetiteur/features/exercises/domain/exercise.dart';
import 'package:mon_repetiteur/features/exercises/presentation/exercise_screens.dart';

void main() {
  testWidgets('affiche un exercice avec ses choix et sélectionne une réponse',
      (tester) async {
    const testExercise = Exercise(
      id: 'ex-widget-1',
      subjectId: 'maths',
      question: 'Combien font 7 x 8 ?',
      answers: ['48', '56', '64'],
      correctAnswer: '56',
      explanation: '7 x 8 = 56',
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          exerciseProvider('ex-widget-1')
              .overrideWith((ref) => Future.value(testExercise)),
        ],
        child: const MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: ExerciseDetailScreen(id: 'ex-widget-1'),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Combien font 7 x 8 ?'), findsOneWidget);
    expect(find.text('48'), findsOneWidget);
    expect(find.text('56'), findsOneWidget);
    expect(find.text('64'), findsOneWidget);

    // Sélection de la réponse '56'
    await tester.tap(find.text('56'));
    await tester.pumpAndSettle();

    expect(find.text('Valider ma réponse'), findsOneWidget);
  });
}
