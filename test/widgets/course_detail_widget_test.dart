import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mon_repetiteur/core/localization/app_localizations.dart';
import 'package:mon_repetiteur/core/providers.dart';
import 'package:mon_repetiteur/features/courses/domain/course.dart';
import 'package:mon_repetiteur/features/courses/presentation/course_screens.dart';

void main() {
  testWidgets('affiche les détails d’un cours avec ses objectifs et son résumé',
      (tester) async {
    const testCourse = Course(
      id: 'test-course-1',
      subjectId: 'maths',
      title: 'Limites et Continuité',
      chapter: 'Chapitre 1 : Analyse',
      level: 'Terminale',
      objectives: ['Comprendre les limites'],
      summary: 'Résumé détaillé de la leçon.',
      keyConcepts: ['Concept Clé 1'],
      examples: ['Exemple Pratique 1'],
      associatedExerciseIds: ['math-1'],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          courseProvider('test-course-1')
              .overrideWith((ref) => Future.value(testCourse)),
        ],
        child: const MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: CourseDetailScreen(id: 'test-course-1'),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Limites et Continuité'), findsOneWidget);
    expect(find.text('Chapitre 1 : Analyse'), findsOneWidget);
    expect(find.text('Comprendre les limites'), findsOneWidget);
    expect(find.text('Résumé détaillé de la leçon.'), findsOneWidget);
    expect(find.text('Concept Clé 1'), findsOneWidget);
  });
}
