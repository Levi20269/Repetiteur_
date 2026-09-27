import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mon_repetiteur/core/localization/app_localizations.dart';
import 'package:mon_repetiteur/core/providers.dart';
import 'package:mon_repetiteur/features/exercises/domain/exercise.dart';
import 'package:mon_repetiteur/features/exercises/presentation/correction_screen.dart';

void main() {
  testWidgets('affiche la correction détaillée et l’explication d’un exercice',
      (tester) async {
    const exercise = Exercise(
      id: 'ex-cor-1',
      subjectId: 'maths',
      question: 'Combien font 3/4 + 1/2 ?',
      answers: ['5/4', '4/6', '1'],
      correctAnswer: '5/4',
      explanation: 'On met au même dénominateur : 1/2 = 2/4 donc 3/4 + 2/4 = 5/4.',
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          exerciseProvider('ex-cor-1')
              .overrideWith((ref) => Future.value(exercise)),
        ],
        child: const MaterialApp(
          locale: Locale('fr'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: CorrectionDetailScreen(id: 'ex-cor-1'),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Correction détaillée'), findsOneWidget);
    expect(find.text('Combien font 3/4 + 1/2 ?'), findsOneWidget);
    expect(find.text('5/4'), findsOneWidget);
    expect(
      find.text('On met au même dénominateur : 1/2 = 2/4 donc 3/4 + 2/4 = 5/4.'),
      findsOneWidget,
    );
  });
}
