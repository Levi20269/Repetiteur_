// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'My Tutor';

  @override
  String get welcome => 'Hello';

  @override
  String get readyToLearn => 'Ready for your study session?';

  @override
  String completedExercises(int count) {
    return '$count completed';
  }

  @override
  String successRate(int rate) {
    return '$rate% success';
  }

  @override
  String level(int level) {
    return 'Level $level';
  }

  @override
  String get mySubjects => 'Your Subjects';

  @override
  String get myCourses => 'Your Courses';

  @override
  String get seeAll => 'See all';

  @override
  String get navHome => 'Home';

  @override
  String get navCourses => 'Courses';

  @override
  String get navExercises => 'Exercises';

  @override
  String get navQuiz => 'Quiz';

  @override
  String get navProgress => 'Progress';

  @override
  String get navProfile => 'Profile';

  @override
  String get courseDetail => 'Course Details';

  @override
  String get courseObjectives => 'Chapter Objectives';

  @override
  String get courseSummary => 'Course Summary';

  @override
  String get courseKeyConcepts => 'Key Concepts';

  @override
  String get courseExamples => 'Practical Examples';

  @override
  String get associatedExercises => 'Associated Exercises';

  @override
  String get startExercises => 'Practice this course';

  @override
  String get startQuiz => 'Start Quiz';

  @override
  String get question => 'Question';

  @override
  String get chooseAnswer => 'Choose the correct answer:';

  @override
  String get validateAnswer => 'Submit my answer';

  @override
  String get validating => 'Submitting...';

  @override
  String get congratulations => 'Well done! Great answer';

  @override
  String get wrongAnswer => 'Not quite...';

  @override
  String get explanation => 'Educational Explanation';

  @override
  String get detailedCorrection => 'Detailed Correction';

  @override
  String get retry => 'Try again';

  @override
  String get viewProgress => 'View my progress';

  @override
  String get averageScore => 'Average Score';

  @override
  String get completed => 'Completed';

  @override
  String get recentHistory => 'Recent Activity';

  @override
  String get myProfile => 'My Profile';

  @override
  String get language => 'Display Language';

  @override
  String get french => 'French';

  @override
  String get english => 'English';

  @override
  String get clearCache => 'Clear local cache';

  @override
  String get clearCacheSubtitle => 'Resets local storage';

  @override
  String get cacheCleared => 'Local cache refreshed successfully.';

  @override
  String get logout => 'Log out';

  @override
  String get demoMode => 'Demo / Local Mode';

  @override
  String get cloudMode => 'Connected to Firebase';

  @override
  String get noSubjects => 'No subjects available at the moment.';

  @override
  String get noCourses => 'No courses available at the moment.';

  @override
  String get noExercises => 'No exercises available at the moment.';

  @override
  String get noProgress => 'You have not completed any exercises yet.';

  @override
  String get startAnExercise => 'Start an exercise';

  @override
  String get errorOccurred => 'An issue occurred';

  @override
  String get tryAgain => 'Try again';

  @override
  String get quizTitle => 'Assessment Quiz';

  @override
  String get quizFinished => 'Quiz completed!';

  @override
  String quizScore(int score) {
    return 'Your score: $score%';
  }

  @override
  String get backToDashboard => 'Back to Dashboard';
}
