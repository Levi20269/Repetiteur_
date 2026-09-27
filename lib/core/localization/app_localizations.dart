import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(const Locale('fr'));
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('fr'),
    Locale('en'),
  ];

  static final Map<String, Map<String, String>> _localizedValues = {
    'fr': {
      'appTitle': 'Mon Répétiteur',
      'welcome': 'Bonjour',
      'readyToLearn': 'Prêt(e) pour votre session d’entraînement ?',
      'mySubjects': 'Vos matières',
      'myCourses': 'Vos cours',
      'seeAll': 'Tout voir',
      'navHome': 'Accueil',
      'navCourses': 'Cours',
      'navExercises': 'Exercices',
      'navQuiz': 'Quiz',
      'navProgress': 'Progrès',
      'navProfile': 'Profil',
      'courseDetail': 'Détail du cours',
      'courseObjectives': 'Objectifs du chapitre',
      'courseSummary': 'Résumé du cours',
      'courseKeyConcepts': 'Notions importantes',
      'courseExamples': 'Exemples d’application',
      'associatedExercises': 'Exercices associés',
      'startExercises': 'S’entraîner sur ce cours',
      'startQuiz': 'Lancer le Quiz',
      'question': 'Question',
      'chooseAnswer': 'Choisissez la bonne réponse :',
      'validateAnswer': 'Valider ma réponse',
      'validating': 'Validation...',
      'congratulations': 'Bravo ! Excellente réponse',
      'wrongAnswer': 'Pas tout à fait...',
      'explanation': 'Explication pédagogique',
      'detailedCorrection': 'Correction détaillée',
      'retry': 'Recommencer',
      'viewProgress': 'Voir mes progrès',
      'averageScore': 'Score moyen',
      'completed': 'Réussis',
      'recentHistory': 'Historique récent',
      'myProfile': 'Mon Profil',
      'language': 'Langue d\'affichage',
      'french': 'Français',
      'english': 'Anglais',
      'clearCache': 'Vider le cache local',
      'clearCacheSubtitle': 'Réinitialise le stockage local',
      'cacheCleared': 'Cache local actualisé avec succès.',
      'logout': 'Se déconnecter',
      'demoMode': 'Mode Démo / Local',
      'cloudMode': 'Connecté à Firebase',
      'noSubjects': 'Aucune matière disponible pour le moment.',
      'noCourses': 'Aucun cours disponible pour le moment.',
      'noExercises': 'Aucun exercice disponible pour le moment.',
      'noProgress': 'Vous n’avez pas encore complété d’exercice.',
      'startAnExercise': 'Commencer un exercice',
      'errorOccurred': 'Un problème est survenu',
      'tryAgain': 'Réessayer',
      'quizTitle': 'Quiz d’évaluation',
      'quizFinished': 'Quiz terminé !',
      'backToDashboard': 'Retour au tableau de bord',
    },
    'en': {
      'appTitle': 'My Tutor',
      'welcome': 'Hello',
      'readyToLearn': 'Ready for your study session?',
      'mySubjects': 'Your Subjects',
      'myCourses': 'Your Courses',
      'seeAll': 'See all',
      'navHome': 'Home',
      'navCourses': 'Courses',
      'navExercises': 'Exercises',
      'navQuiz': 'Quiz',
      'navProgress': 'Progress',
      'navProfile': 'Profile',
      'courseDetail': 'Course Details',
      'courseObjectives': 'Chapter Objectives',
      'courseSummary': 'Course Summary',
      'courseKeyConcepts': 'Key Concepts',
      'courseExamples': 'Practical Examples',
      'associatedExercises': 'Associated Exercises',
      'startExercises': 'Practice this course',
      'startQuiz': 'Start Quiz',
      'question': 'Question',
      'chooseAnswer': 'Choose the correct answer:',
      'validateAnswer': 'Submit my answer',
      'validating': 'Submitting...',
      'congratulations': 'Well done! Great answer',
      'wrongAnswer': 'Not quite...',
      'explanation': 'Educational Explanation',
      'detailedCorrection': 'Detailed Correction',
      'retry': 'Try again',
      'viewProgress': 'View my progress',
      'averageScore': 'Average Score',
      'completed': 'Completed',
      'recentHistory': 'Recent Activity',
      'myProfile': 'My Profile',
      'language': 'Display Language',
      'french': 'French',
      'english': 'English',
      'clearCache': 'Clear local cache',
      'clearCacheSubtitle': 'Resets local storage',
      'cacheCleared': 'Local cache refreshed successfully.',
      'logout': 'Log out',
      'demoMode': 'Demo / Local Mode',
      'cloudMode': 'Connected to Firebase',
      'noSubjects': 'No subjects available at the moment.',
      'noCourses': 'No courses available at the moment.',
      'noExercises': 'No exercises available at the moment.',
      'noProgress': 'You have not completed any exercises yet.',
      'startAnExercise': 'Start an exercise',
      'errorOccurred': 'An issue occurred',
      'tryAgain': 'Try again',
      'quizTitle': 'Assessment Quiz',
      'quizFinished': 'Quiz completed!',
      'backToDashboard': 'Back to Dashboard',
    },
  };

  String get appTitle => _get('appTitle');
  String get welcome => _get('welcome');
  String get readyToLearn => _get('readyToLearn');
  String completedExercises(int count) => locale.languageCode == 'en' ? '$count completed' : '$count terminés';
  String successRate(int rate) => locale.languageCode == 'en' ? '$rate% success' : '$rate% réussite';
  String level(int lvl) => locale.languageCode == 'en' ? 'Level $lvl' : 'Niveau $lvl';
  String get mySubjects => _get('mySubjects');
  String get myCourses => _get('myCourses');
  String get seeAll => _get('seeAll');
  String get navHome => _get('navHome');
  String get navCourses => _get('navCourses');
  String get navExercises => _get('navExercises');
  String get navQuiz => _get('navQuiz');
  String get navProgress => _get('navProgress');
  String get navProfile => _get('navProfile');
  String get courseDetail => _get('courseDetail');
  String get courseObjectives => _get('courseObjectives');
  String get courseSummary => _get('courseSummary');
  String get courseKeyConcepts => _get('courseKeyConcepts');
  String get courseExamples => _get('courseExamples');
  String get associatedExercises => _get('associatedExercises');
  String get startExercises => _get('startExercises');
  String get startQuiz => _get('startQuiz');
  String get question => _get('question');
  String get chooseAnswer => _get('chooseAnswer');
  String get validateAnswer => _get('validateAnswer');
  String get validating => _get('validating');
  String get congratulations => _get('congratulations');
  String get wrongAnswer => _get('wrongAnswer');
  String get explanation => _get('explanation');
  String get detailedCorrection => _get('detailedCorrection');
  String get retry => _get('retry');
  String get viewProgress => _get('viewProgress');
  String get averageScore => _get('averageScore');
  String get completed => _get('completed');
  String get recentHistory => _get('recentHistory');
  String get myProfile => _get('myProfile');
  String get language => _get('language');
  String get french => _get('french');
  String get english => _get('english');
  String get clearCache => _get('clearCache');
  String get clearCacheSubtitle => _get('clearCacheSubtitle');
  String get cacheCleared => _get('cacheCleared');
  String get logout => _get('logout');
  String get demoMode => _get('demoMode');
  String get cloudMode => _get('cloudMode');
  String get noSubjects => _get('noSubjects');
  String get noCourses => _get('noCourses');
  String get noExercises => _get('noExercises');
  String get noProgress => _get('noProgress');
  String get startAnExercise => _get('startAnExercise');
  String get errorOccurred => _get('errorOccurred');
  String get tryAgain => _get('tryAgain');
  String get quizTitle => _get('quizTitle');
  String get quizFinished => _get('quizFinished');
  String quizScore(int score) => locale.languageCode == 'en' ? 'Your score: $score%' : 'Votre score : $score%';
  String get backToDashboard => _get('backToDashboard');

  String _get(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['fr']?[key] ??
        key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['fr', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
