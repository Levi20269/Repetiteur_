import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mon_repetiteur/core/localization/app_localizations.dart';
import 'package:mon_repetiteur/core/providers.dart';
import 'package:mon_repetiteur/features/auth/domain/auth_user.dart';
import 'package:mon_repetiteur/features/profile/presentation/profile_screen.dart';
import 'package:mon_repetiteur/features/progress/domain/progress_entry.dart';

void main() {
  testWidgets('affiche le profil avec le sélecteur de langue et l’XP',
      (tester) async {
    const user = AuthUser(
      id: 'u-1',
      name: 'Sarah Connor',
      email: 'sarah@test.fr',
      level: 3,
      xp: 280,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentUserProvider.overrideWithValue(user),
          progressProvider.overrideWith((ref) => Future.value(<ProgressEntry>[])),
        ],
        child: const MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: ProfileScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Sarah Connor'), findsOneWidget);
    expect(find.text('sarah@test.fr'), findsOneWidget);
    expect(find.text('Français'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
    expect(find.text('Se déconnecter'), findsOneWidget);
  });
}
