import 'package:flutter_test/flutter_test.dart';
import 'package:mon_repetiteur/features/progress/domain/progress_entry.dart';

void main() {
  group('Logique Métier & Calculs de Progression', () {
    test('calcul correct du score moyen et du taux de réussite', () {
      final entries = [
        ProgressEntry(
          id: '1',
          exerciseId: 'ex-1',
          score: 100,
          completedAt: DateTime.now(),
        ),
        ProgressEntry(
          id: '2',
          exerciseId: 'ex-2',
          score: 100,
          completedAt: DateTime.now(),
        ),
        ProgressEntry(
          id: '3',
          exerciseId: 'ex-3',
          score: 0,
          completedAt: DateTime.now(),
        ),
      ];

      final total = entries.length;
      final successes = entries.where((e) => e.score >= 50).length;
      final average =
          (entries.map((e) => e.score).reduce((a, b) => a + b) / total).round();

      expect(total, 3);
      expect(successes, 2);
      expect(average, 67);
    });

    test('calcul du niveau d’expérience (XP) et du palier suivant', () {
      const baseUserXp = 150;
      const completedExercisesCount = 4; // 4 * 50 XP = 200 XP
      const totalXp = baseUserXp + (completedExercisesCount * 50); // 350 XP

      final currentLevel = (totalXp / 100).floor() + 1; // Niveau 4
      final remainingXpForNextLevel = 100 - (totalXp % 100); // 50 XP restants

      expect(totalXp, 350);
      expect(currentLevel, 4);
      expect(remainingXpForNextLevel, 50);
    });

    test('instanciation et parsing JSON de SubmissionResult', () {
      final json = {
        'id': 'sub-1',
        'score': 100,
        'isCorrect': true,
        'explanation': 'Excellente réponse !',
      };

      final result = SubmissionResult.fromJson(json);

      expect(result.id, 'sub-1');
      expect(result.score, 100);
      expect(result.isCorrect, isTrue);
      expect(result.explanation, 'Excellente réponse !');
    });
  });
}
