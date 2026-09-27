import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In fr, this message translates to:
  /// **'Mon Répétiteur'**
  String get appTitle;

  /// No description provided for @welcome.
  ///
  /// In fr, this message translates to:
  /// **'Bonjour'**
  String get welcome;

  /// No description provided for @readyToLearn.
  ///
  /// In fr, this message translates to:
  /// **'Prêt(e) pour votre session d’entraînement ?'**
  String get readyToLearn;

  /// No description provided for @completedExercises.
  ///
  /// In fr, this message translates to:
  /// **'{count} terminés'**
  String completedExercises(int count);

  /// No description provided for @successRate.
  ///
  /// In fr, this message translates to:
  /// **'{rate}% réussite'**
  String successRate(int rate);

  /// No description provided for @level.
  ///
  /// In fr, this message translates to:
  /// **'Niveau {level}'**
  String level(int level);

  /// No description provided for @mySubjects.
  ///
  /// In fr, this message translates to:
  /// **'Vos matières'**
  String get mySubjects;

  /// No description provided for @myCourses.
  ///
  /// In fr, this message translates to:
  /// **'Vos cours'**
  String get myCourses;

  /// No description provided for @seeAll.
  ///
  /// In fr, this message translates to:
  /// **'Tout voir'**
  String get seeAll;

  /// No description provided for @navHome.
  ///
  /// In fr, this message translates to:
  /// **'Accueil'**
  String get navHome;

  /// No description provided for @navCourses.
  ///
  /// In fr, this message translates to:
  /// **'Cours'**
  String get navCourses;

  /// No description provided for @navExercises.
  ///
  /// In fr, this message translates to:
  /// **'Exercices'**
  String get navExercises;

  /// No description provided for @navQuiz.
  ///
  /// In fr, this message translates to:
  /// **'Quiz'**
  String get navQuiz;

  /// No description provided for @navProgress.
  ///
  /// In fr, this message translates to:
  /// **'Progrès'**
  String get navProgress;

  /// No description provided for @navProfile.
  ///
  /// In fr, this message translates to:
  /// **'Profil'**
  String get navProfile;

  /// No description provided for @courseDetail.
  ///
  /// In fr, this message translates to:
  /// **'Détail du cours'**
  String get courseDetail;

  /// No description provided for @courseObjectives.
  ///
  /// In fr, this message translates to:
  /// **'Objectifs du chapitre'**
  String get courseObjectives;

  /// No description provided for @courseSummary.
  ///
  /// In fr, this message translates to:
  /// **'Résumé du cours'**
  String get courseSummary;

  /// No description provided for @courseKeyConcepts.
  ///
  /// In fr, this message translates to:
  /// **'Notions importantes'**
  String get courseKeyConcepts;

  /// No description provided for @courseExamples.
  ///
  /// In fr, this message translates to:
  /// **'Exemples d’application'**
  String get courseExamples;

  /// No description provided for @associatedExercises.
  ///
  /// In fr, this message translates to:
  /// **'Exercices associés'**
  String get associatedExercises;

  /// No description provided for @startExercises.
  ///
  /// In fr, this message translates to:
  /// **'S’entraîner sur ce cours'**
  String get startExercises;

  /// No description provided for @startQuiz.
  ///
  /// In fr, this message translates to:
  /// **'Lancer le Quiz'**
  String get startQuiz;

  /// No description provided for @question.
  ///
  /// In fr, this message translates to:
  /// **'Question'**
  String get question;

  /// No description provided for @chooseAnswer.
  ///
  /// In fr, this message translates to:
  /// **'Choisissez la bonne réponse :'**
  String get chooseAnswer;

  /// No description provided for @validateAnswer.
  ///
  /// In fr, this message translates to:
  /// **'Valider ma réponse'**
  String get validateAnswer;

  /// No description provided for @validating.
  ///
  /// In fr, this message translates to:
  /// **'Validation...'**
  String get validating;

  /// No description provided for @congratulations.
  ///
  /// In fr, this message translates to:
  /// **'Bravo ! Excellente réponse'**
  String get congratulations;

  /// No description provided for @wrongAnswer.
  ///
  /// In fr, this message translates to:
  /// **'Pas tout à fait...'**
  String get wrongAnswer;

  /// No description provided for @explanation.
  ///
  /// In fr, this message translates to:
  /// **'Explication pédagogique'**
  String get explanation;

  /// No description provided for @detailedCorrection.
  ///
  /// In fr, this message translates to:
  /// **'Correction détaillée'**
  String get detailedCorrection;

  /// No description provided for @retry.
  ///
  /// In fr, this message translates to:
  /// **'Recommencer'**
  String get retry;

  /// No description provided for @viewProgress.
  ///
  /// In fr, this message translates to:
  /// **'Voir mes progrès'**
  String get viewProgress;

  /// No description provided for @averageScore.
  ///
  /// In fr, this message translates to:
  /// **'Score moyen'**
  String get averageScore;

  /// No description provided for @completed.
  ///
  /// In fr, this message translates to:
  /// **'Réussis'**
  String get completed;

  /// No description provided for @recentHistory.
  ///
  /// In fr, this message translates to:
  /// **'Historique récent'**
  String get recentHistory;

  /// No description provided for @myProfile.
  ///
  /// In fr, this message translates to:
  /// **'Mon Profil'**
  String get myProfile;

  /// No description provided for @language.
  ///
  /// In fr, this message translates to:
  /// **'Langue d\'affichage'**
  String get language;

  /// No description provided for @french.
  ///
  /// In fr, this message translates to:
  /// **'Français'**
  String get french;

  /// No description provided for @english.
  ///
  /// In fr, this message translates to:
  /// **'Anglais'**
  String get english;

  /// No description provided for @clearCache.
  ///
  /// In fr, this message translates to:
  /// **'Vider le cache local'**
  String get clearCache;

  /// No description provided for @clearCacheSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Réinitialise le stockage local'**
  String get clearCacheSubtitle;

  /// No description provided for @cacheCleared.
  ///
  /// In fr, this message translates to:
  /// **'Cache local actualisé avec succès.'**
  String get cacheCleared;

  /// No description provided for @logout.
  ///
  /// In fr, this message translates to:
  /// **'Se déconnecter'**
  String get logout;

  /// No description provided for @demoMode.
  ///
  /// In fr, this message translates to:
  /// **'Mode Démo / Local'**
  String get demoMode;

  /// No description provided for @cloudMode.
  ///
  /// In fr, this message translates to:
  /// **'Connecté à Firebase'**
  String get cloudMode;

  /// No description provided for @noSubjects.
  ///
  /// In fr, this message translates to:
  /// **'Aucune matière disponible pour le moment.'**
  String get noSubjects;

  /// No description provided for @noCourses.
  ///
  /// In fr, this message translates to:
  /// **'Aucun cours disponible pour le moment.'**
  String get noCourses;

  /// No description provided for @noExercises.
  ///
  /// In fr, this message translates to:
  /// **'Aucun exercice disponible pour le moment.'**
  String get noExercises;

  /// No description provided for @noProgress.
  ///
  /// In fr, this message translates to:
  /// **'Vous n’avez pas encore complété d’exercice.'**
  String get noProgress;

  /// No description provided for @startAnExercise.
  ///
  /// In fr, this message translates to:
  /// **'Commencer un exercice'**
  String get startAnExercise;

  /// No description provided for @errorOccurred.
  ///
  /// In fr, this message translates to:
  /// **'Un problème est survenu'**
  String get errorOccurred;

  /// No description provided for @tryAgain.
  ///
  /// In fr, this message translates to:
  /// **'Réessayer'**
  String get tryAgain;

  /// No description provided for @quizTitle.
  ///
  /// In fr, this message translates to:
  /// **'Quiz d’évaluation'**
  String get quizTitle;

  /// No description provided for @quizFinished.
  ///
  /// In fr, this message translates to:
  /// **'Quiz terminé !'**
  String get quizFinished;

  /// No description provided for @quizScore.
  ///
  /// In fr, this message translates to:
  /// **'Votre score : {score}%'**
  String quizScore(int score);

  /// No description provided for @backToDashboard.
  ///
  /// In fr, this message translates to:
  /// **'Retour au tableau de bord'**
  String get backToDashboard;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
