import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/pedagogical_content.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/providers.dart';
import '../../../core/widgets/async_view.dart';
import '../../exercises/domain/exercise.dart';
import '../../subjects/presentation/subject_screens.dart';
import '../domain/quiz.dart';

class QuizzesScreen extends ConsumerWidget {
  const QuizzesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final quizzes = ref.watch(quizzesProvider);

    return AppPageScaffold(
      title: l10n.quizTitle,
      currentIndex: 3,
      body: quizzes.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => AsyncErrorView(
          error: error,
          onRetry: () => ref.invalidate(quizzesProvider),
        ),
        data: (items) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: items.length,
          itemBuilder: (context, index) => _QuizCard(quiz: items[index]),
        ),
      ),
    );
  }
}

class QuizPlayScreen extends ConsumerStatefulWidget {
  const QuizPlayScreen({required this.id, super.key});
  final String id;

  @override
  ConsumerState<QuizPlayScreen> createState() => _QuizPlayScreenState();
}

class _QuizPlayScreenState extends ConsumerState<QuizPlayScreen> {
  int _currentIndex = 0;
  final Map<int, String> _userAnswers = {};
  bool _completed = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ref.watch(quizProvider(widget.id)).when(
          loading: () => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
          error: (error, _) => Scaffold(
            appBar: AppBar(),
            body: AsyncErrorView(
              error: error,
              onRetry: () => ref.invalidate(quizProvider(widget.id)),
            ),
          ),
          data: (quiz) {
            final questions = PedagogicalContent.exercises
                .where((e) => quiz.exerciseIds.contains(e.id))
                .toList();

            if (questions.isEmpty) {
              return Scaffold(
                appBar: AppBar(),
                body: EmptyView(l10n.noExercises),
              );
            }

            if (_completed) {
              return _buildResultView(context, quiz, questions);
            }

            final currentExercise = questions[_currentIndex];
            final selectedAnswer = _userAnswers[_currentIndex];
            final progressValue = (_currentIndex + 1) / questions.length;

            return Scaffold(
              appBar: AppBar(
                title: Text(quiz.title),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(6),
                  child: LinearProgressIndicator(
                    value: progressValue,
                    minHeight: 6,
                  ),
                ),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Question ${_currentIndex + 1} / ${questions.length}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceVariant
                                  .withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.timer_outlined, size: 16),
                                const SizedBox(width: 4),
                                Text('${quiz.durationMinutes} min'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Card(
                        elevation: 0,
                        color: Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.2),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Text(
                            currentExercise.question,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        l10n.chooseAnswer,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView(
                          children: currentExercise.answers.map((ans) {
                            final isSelected = selectedAnswer == ans;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: InkWell(
                                onTap: () => setState(() {
                                  _userAnswers[_currentIndex] = ans;
                                }),
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected
                                          ? Theme.of(context).colorScheme.primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .outlineVariant,
                                      width: isSelected ? 2 : 1,
                                    ),
                                    color: isSelected
                                        ? Theme.of(context)
                                            .colorScheme
                                            .primaryContainer
                                            .withOpacity(0.3)
                                        : Colors.white,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        isSelected
                                            ? Icons.radio_button_checked
                                            : Icons.radio_button_off,
                                        color: isSelected
                                            ? Theme.of(context).colorScheme.primary
                                            : Colors.grey,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(child: Text(ans)),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Row(
                        children: [
                          if (_currentIndex > 0)
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () =>
                                    setState(() => _currentIndex--),
                                child: const Text('Précédent'),
                              ),
                            ),
                          if (_currentIndex > 0) const SizedBox(width: 12),
                          Expanded(
                            child: FilledButton(
                              onPressed: selectedAnswer == null
                                  ? null
                                  : () {
                                      if (_currentIndex < questions.length - 1) {
                                        setState(() => _currentIndex++);
                                      } else {
                                        setState(() => _completed = true);
                                      }
                                    },
                              child: Text(
                                _currentIndex < questions.length - 1
                                    ? 'Suivant'
                                    : 'Terminer le quiz',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
  }

  Widget _buildResultView(
    BuildContext context,
    Quiz quiz,
    List<Exercise> questions,
  ) {
    final l10n = AppLocalizations.of(context);
    int correctCount = 0;
    for (int i = 0; i < questions.length; i++) {
      if (_userAnswers[i] == questions[i].correctAnswer) {
        correctCount++;
      }
    }
    final score = ((correctCount / questions.length) * 100).round();
    final isSuccess = score >= 50;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.quizFinished)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: (isSuccess
                          ? const Color(0xFF1B873F)
                          : const Color(0xFFD32F2F))
                      .withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isSuccess ? Icons.emoji_events : Icons.refresh,
                  size: 64,
                  color: isSuccess
                      ? const Color(0xFF1B873F)
                      : const Color(0xFFD32F2F),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.quizScore(score),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              '$correctCount sur ${questions.length} réponses correctes',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 28),
            Text(
              'Détail des réponses :',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            ...List.generate(questions.length, (index) {
              final q = questions[index];
              final userAns = _userAnswers[index];
              final isAnsCorrect = userAns == q.correctAnswer;

              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .outlineVariant
                        .withOpacity(0.5),
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    isAnsCorrect ? Icons.check_circle : Icons.cancel,
                    color: isAnsCorrect
                        ? const Color(0xFF1B873F)
                        : const Color(0xFFD32F2F),
                  ),
                  title: Text(q.question, maxLines: 2),
                  subtitle: Text(
                    isAnsCorrect
                        ? 'Votre réponse : $userAns'
                        : 'Votre réponse : $userAns (Attendu : ${q.correctAnswer})',
                  ),
                ),
              );
            }),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => context.go('/dashboard'),
              icon: const Icon(Icons.home),
              label: Text(l10n.backToDashboard),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuizCard extends StatelessWidget {
  const _QuizCard({required this.quiz});
  final Quiz quiz;

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.6),
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Icon(
              Icons.quiz_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          title: Text(
            quiz.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '${quiz.exerciseIds.length} questions • ~${quiz.durationMinutes} min',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          trailing: const Icon(Icons.play_arrow_rounded, color: Colors.blue),
          onTap: () => context.go('/quiz/${quiz.id}'),
        ),
      );
}
