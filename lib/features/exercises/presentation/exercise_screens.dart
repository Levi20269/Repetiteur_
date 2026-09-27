import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/providers.dart';
import '../../../core/widgets/async_view.dart';
import '../../progress/domain/progress_entry.dart';
import '../../subjects/presentation/subject_screens.dart';
import '../domain/exercise.dart';

class ExercisesScreen extends ConsumerWidget {
  const ExercisesScreen({this.subjectId, super.key});
  final String? subjectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final exercises = ref.watch(exercisesProvider(subjectId));
    final subjects = ref.watch(subjectsProvider).asData?.value ?? [];
    final currentSubject =
        subjects.where((s) => s.id == subjectId).firstOrNull;

    return AppPageScaffold(
      title: currentSubject != null
          ? '${l10n.navExercises} : ${currentSubject.name}'
          : l10n.navExercises,
      currentIndex: 2,
      body: exercises.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => AsyncErrorView(
          error: error,
          onRetry: () => ref.invalidate(exercisesProvider(subjectId)),
        ),
        data: (items) {
          if (items.isEmpty) {
            return EmptyView(
              l10n.noExercises,
              icon: Icons.quiz_outlined,
            );
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(exercisesProvider(subjectId)),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (_, index) => _ExerciseTile(
                exercise: items[index],
                subjectName: subjects
                    .where((s) => s.id == items[index].subjectId)
                    .firstOrNull
                    ?.name,
              ),
            ),
          );
        },
      ),
    );
  }
}

class ExerciseDetailScreen extends ConsumerStatefulWidget {
  const ExerciseDetailScreen({required this.id, super.key});
  final String id;

  @override
  ConsumerState<ExerciseDetailScreen> createState() =>
      _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends ConsumerState<ExerciseDetailScreen> {
  String? _selectedAnswer;
  bool _submitting = false;

  Future<void> _submit(Exercise exercise) async {
    if (_selectedAnswer == null) return;
    setState(() => _submitting = true);

    try {
      final result = await ref
          .read(progressRepositoryProvider)
          .submitProgress(
            exerciseId: widget.id,
            answer: _selectedAnswer!,
          );

      ref.invalidate(progressProvider);

      if (!mounted) return;
      _showResultSheet(context, result, exercise);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  void _showResultSheet(
    BuildContext context,
    SubmissionResult result,
    Exercise exercise,
  ) {
    final l10n = AppLocalizations.of(context);

    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        final isSuccess = result.isCorrect;
        final color =
            isSuccess ? const Color(0xFF1B873F) : const Color(0xFFD32F2F);

        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isSuccess ? Icons.check_circle : Icons.cancel,
                      color: color,
                      size: 36,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isSuccess ? l10n.congratulations : l10n.wrongAnswer,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: color,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isSuccess
                              ? 'Score : 100% (+50 XP)'
                              : 'Score : 0% - Réessayez pour progresser',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (result.explanation != null &&
                  result.explanation!.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.lightbulb_outline,
                            size: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l10n.explanation,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(result.explanation!),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
              TextButton.icon(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  context.go('/corrections/${exercise.id}');
                },
                icon: const Icon(Icons.menu_book),
                label: Text(l10n.detailedCorrection),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        setState(() => _selectedAnswer = null);
                      },
                      child: Text(l10n.retry),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        context.go('/progress');
                      },
                      child: Text(l10n.viewProgress),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navExercises),
      ),
      body: ref.watch(exerciseProvider(widget.id)).when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => AsyncErrorView(
              error: error,
              onRetry: () => ref.invalidate(exerciseProvider(widget.id)),
            ),
            data: (exercise) => SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      elevation: 0,
                      color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.help_outline_rounded,
                                  size: 20,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  l10n.question,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              exercise.question,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      l10n.chooseAnswer,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView(
                        children: exercise.answers.map((answer) {
                          final isSelected = _selectedAnswer == answer;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Semantics(
                              selected: isSelected,
                              button: true,
                              label: 'Choix : $answer',
                              child: InkWell(
                                onTap: _submitting
                                    ? null
                                    : () => setState(() => _selectedAnswer = answer),
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected
                                          ? Theme.of(context).colorScheme.primary
                                          : Theme.of(context).colorScheme.outlineVariant,
                                      width: isSelected ? 2 : 1,
                                    ),
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3)
                                        : Theme.of(context).colorScheme.surface,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: isSelected
                                                ? Theme.of(context).colorScheme.primary
                                                : Theme.of(context).colorScheme.outline,
                                            width: isSelected ? 6 : 2,
                                          ),
                                          color: isSelected
                                              ? Theme.of(context).colorScheme.primary
                                              : Colors.transparent,
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Text(
                                          answer,
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                fontWeight: isSelected
                                                    ? FontWeight.w600
                                                    : FontWeight.normal,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Semantics(
                      button: true,
                      label: l10n.validateAnswer,
                      child: FilledButton.icon(
                        onPressed: _selectedAnswer == null || _submitting
                            ? null
                            : () => _submit(exercise),
                        icon: _submitting
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.check_circle_outline),
                        label: Text(_submitting ? l10n.validating : l10n.validateAnswer),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}

class _ExerciseTile extends StatelessWidget {
  const _ExerciseTile({
    required this.exercise,
    this.subjectName,
  });

  final Exercise exercise;
  final String? subjectName;

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.6),
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Icon(
              Icons.quiz_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          title: Text(
            exercise.question,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              subjectName ?? 'Exercice à choix multiple',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () => context.go('/exercises/${exercise.id}'),
        ),
      );
}
