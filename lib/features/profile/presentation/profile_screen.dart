import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(currentUserProvider);
    final isDemo = ref.watch(isDemoModeProvider);
    final currentLocale = ref.watch(localeProvider);
    final progress = ref.watch(progressProvider).asData?.value ?? [];

    final completedCount = progress.length;
    final totalXp = (user?.xp ?? 0) + (completedCount * 50);
    final currentLevel = (totalXp / 100).floor() + 1;
    final progressInLevel = (totalXp % 100) / 100.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.myProfile),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // En-tête profil
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 46,
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  child: Text(
                    (user?.name ?? 'E').isNotEmpty
                        ? user!.name.substring(0, 1).toUpperCase()
                        : 'E',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Nv. $currentLevel',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              user?.name ?? 'Élève',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(
              user?.email ?? 'eleve@monrepetiteur.fr',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Barre d'expérience XP
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.6),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.level(currentLevel),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '$totalXp XP',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: progressInLevel,
                    borderRadius: BorderRadius.circular(8),
                    minHeight: 8,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Encore ${(100 - (totalXp % 100))} XP pour le niveau ${currentLevel + 1}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Sélecteur de langue (Français / Anglais)
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.6),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.language,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        l10n.language,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ChoiceChip(
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('🇫🇷 '),
                              Text('Français'),
                            ],
                          ),
                          selected: currentLocale.languageCode == 'fr',
                          onSelected: (selected) {
                            if (selected) {
                              ref.read(localeProvider.notifier).state =
                                  const Locale('fr');
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ChoiceChip(
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('🇬🇧 '),
                              Text('English'),
                            ],
                          ),
                          selected: currentLocale.languageCode == 'en',
                          onSelected: (selected) {
                            if (selected) {
                              ref.read(localeProvider.notifier).state =
                                  const Locale('en');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Statut et Cache
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.6),
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    isDemo ? Icons.wifi_off_outlined : Icons.cloud_done_outlined,
                    color: isDemo ? Colors.orange : const Color(0xFF1B873F),
                  ),
                  title: Text(isDemo ? l10n.demoMode : l10n.cloudMode),
                  subtitle: Text(
                    isDemo
                        ? 'Données locales intégrées et simulation'
                        : 'Synchronisation Cloud Functions & Firestore',
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.cleaning_services_outlined),
                  title: Text(l10n.clearCache),
                  subtitle: Text(l10n.clearCacheSubtitle),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    ref.invalidate(subjectsProvider);
                    ref.invalidate(progressProvider);
                    ref.invalidate(coursesProvider(null));
                    ref.invalidate(quizzesProvider);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.cacheCleared)),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Bouton Déconnexion
          Semantics(
            button: true,
            label: l10n.logout,
            child: OutlinedButton.icon(
              onPressed: () async {
                await ref.read(authRepositoryProvider).signOut();
                if (context.mounted) context.go('/login');
              },
              icon: const Icon(Icons.logout),
              label: Text(l10n.logout),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                foregroundColor: Theme.of(context).colorScheme.error,
                side: BorderSide(
                  color: Theme.of(context).colorScheme.error.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
