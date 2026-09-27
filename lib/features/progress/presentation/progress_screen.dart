import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/providers.dart';
import '../../../core/widgets/async_view.dart';
import '../../subjects/presentation/subject_screens.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final progress = ref.watch(progressProvider);

    return AppPageScaffold(
      title: l10n.navProgress,
      currentIndex: 4,
      body: progress.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => AsyncErrorView(
          error: error,
          onRetry: () => ref.invalidate(progressProvider),
        ),
        data: (items) {
          if (items.isEmpty) {
            return EmptyView(
              l10n.noProgress,
              icon: Icons.insights_outlined,
              actionLabel: l10n.startAnExercise,
              onAction: () => context.go('/subjects'),
            );
          }

          final total = items.length;
          final successes = items.where((e) => e.score >= 50).length;
          final average = (items.map((e) => e.score).reduce((a, b) => a + b) / total).round();

          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(progressProvider),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // Cartes de statistiques globales
                Row(
                  children: [
                    Expanded(
                      child: _SummaryCard(
                        title: l10n.averageScore,
                        value: '$average %',
                        icon: Icons.trending_up,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _SummaryCard(
                        title: l10n.completed,
                        value: '$successes / $total',
                        icon: Icons.check_circle_outline,
                        color: const Color(0xFF1B873F),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                Text(
                  l10n.recentHistory,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),

                ...items.map(
                  (entry) => Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.5),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: entry.score >= 50
                            ? const Color(0xFFE8F5E9)
                            : const Color(0xFFFFEBEE),
                        child: Icon(
                          entry.score >= 50
                              ? Icons.check
                              : Icons.close,
                          color: entry.score >= 50
                              ? const Color(0xFF1B873F)
                              : const Color(0xFFD32F2F),
                        ),
                      ),
                      title: Text(
                        entry.questionSummary ?? 'Exercice ${entry.exerciseId}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        _formatDate(entry.completedAt),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 12,
                        ),
                      ),
                      trailing: ScoreBadge(score: entry.score),
                      onTap: () => context.go('/corrections/${entry.exerciseId}'),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 1) return 'À l’instant';
    if (diff.inMinutes < 60) return 'Il y a ${diff.inMinutes} min';
    if (diff.inHours < 24) return 'Il y a ${diff.inHours}h';
    return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year} à ${dt.hour}h${dt.minute.toString().padLeft(2, '0')}';
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(icon, color: color, size: 20),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
}
