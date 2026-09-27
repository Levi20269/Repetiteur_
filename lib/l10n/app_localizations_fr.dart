// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Mon Répétiteur';

  @override
  String get welcome => 'Bonjour';

  @override
  String get readyToLearn => 'Prêt(e) pour votre session d’entraînement ?';

  @override
  String completedExercises(int count) {
    return '$count terminés';
  }

  @override
  String successRate(int rate) {
    return '$rate% réussite';
  }

  @override
  String level(int level) {
    return 'Niveau $level';
  }

  @override
  String get mySubjects => 'Vos matières';

  @override
  String get myCourses => 'Vos cours';

  @override
  String get seeAll => 'Tout voir';

  @override
  String get navHome => 'Accueil';

  @override
  String get navCourses => 'Cours';

  @override
  String get navExercises => 'Exercices';

  @override
  String get navQuiz => 'Quiz';

  @override
  String get navProgress => 'Progrès';

  @override
  String get navProfile => 'Profil';

  @override
  String get courseDetail => 'Détail du cours';

  @override
  String get courseObjectives => 'Objectifs du chapitre';

  @override
  String get courseSummary => 'Résumé du cours';

  @override
  String get courseKeyConcepts => 'Notions importantes';

  @override
  String get courseExamples => 'Exemples d’application';

  @override
  String get associatedExercises => 'Exercices associés';

  @override
  String get startExercises => 'S’entraîner sur ce cours';

  @override
  String get startQuiz => 'Lancer le Quiz';

  @override
  String get question => 'Question';

  @override
  String get chooseAnswer => 'Choisissez la bonne réponse :';

  @override
  String get validateAnswer => 'Valider ma réponse';

  @override
  String get validating => 'Validation...';

  @override
  String get congratulations => 'Bravo ! Excellente réponse';

  @override
  String get wrongAnswer => 'Pas tout à fait...';

  @override
  String get explanation => 'Explication pédagogique';

  @override
  String get detailedCorrection => 'Correction détaillée';

  @override
  String get retry => 'Recommencer';

  @override
  String get viewProgress => 'Voir mes progrès';

  @override
  String get averageScore => 'Score moyen';

  @override
  String get completed => 'Réussis';

  @override
  String get recentHistory => 'Historique récent';

  @override
  String get myProfile => 'Mon Profil';

  @override
  String get language => 'Langue d\'affichage';

  @override
  String get french => 'Français';

  @override
  String get english => 'Anglais';

  @override
  String get clearCache => 'Vider le cache local';

  @override
  String get clearCacheSubtitle => 'Réinitialise le stockage local';

  @override
  String get cacheCleared => 'Cache local actualisé avec succès.';

  @override
  String get logout => 'Se déconnecter';

  @override
  String get demoMode => 'Mode Démo / Local';

  @override
  String get cloudMode => 'Connecté à Firebase';

  @override
  String get noSubjects => 'Aucune matière disponible pour le moment.';

  @override
  String get noCourses => 'Aucun cours disponible pour le moment.';

  @override
  String get noExercises => 'Aucun exercice disponible pour le moment.';

  @override
  String get noProgress => 'Vous n’avez pas encore complété d’exercice.';

  @override
  String get startAnExercise => 'Commencer un exercice';

  @override
  String get errorOccurred => 'Un problème est survenu';

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get quizTitle => 'Quiz d’évaluation';

  @override
  String get quizFinished => 'Quiz terminé !';

  @override
  String quizScore(int score) {
    return 'Votre score : $score%';
  }

  @override
  String get backToDashboard => 'Retour au tableau de bord';
}
