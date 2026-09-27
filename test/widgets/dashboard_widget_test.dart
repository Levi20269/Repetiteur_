import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mon_repetiteur/core/localization/app_localizations.dart';
import 'package:mon_repetiteur/core/providers.dart';
import 'package:mon_repetiteur/features/auth/domain/auth_user.dart';
import 'package:mon_repetiteur/features/progress/domain/progress_entry.dart';
import 'package:mon_repetiteur/features/subjects/domain/subject.dart';
import 'package:mon_repetiteur/features/subjects/presentation/subject_screens.dart';

void main() {
  testWidgets('affiche le tableau de bord avec le nom de l’élève et les matières',
      (tester) async {
    const user = AuthUser(
      id: 'u-1',
      name: 'Alexandre',
      email: 'alex@test.fr',
      level: 2,
      xp: 250,
    );

    const subjects = [
      Subject(
        id: 'maths',
        name: 'Mathématiques',
        description: 'Algèbre et analyse',
        icon: 'calculate',
      ),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentUserProvider.overrideWithValue(user),
          subjectsProvider.overrideWith((ref) => Future.value(subjects)),
          progressProvider.overrideWith((ref) => Future.value(<ProgressEntry>[])),
        ],
        child: const MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: DashboardScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.textContaining('Alexandre'), findsOneWidget);
    expect(find.text('Mathématiques'), findsOneWidget);
    expect(find.text('Vos matières'), findsOneWidget);
  });
}
