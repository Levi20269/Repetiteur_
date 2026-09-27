import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/auth_screens.dart';
import '../../features/courses/presentation/course_screens.dart';
import '../../features/exercises/presentation/correction_screen.dart';
import '../../features/exercises/presentation/exercise_screens.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/progress/presentation/progress_screen.dart';
import '../../features/quiz/presentation/quiz_screens.dart';
import '../../features/subjects/presentation/subject_screens.dart';

final appRouter = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    GoRoute(path: '/', builder: (_, _) => const DashboardScreen()),
    GoRoute(path: '/login', builder: (_, _) => const LoginScreen()),
    GoRoute(path: '/register', builder: (_, _) => const RegisterScreen()),
    GoRoute(path: '/dashboard', builder: (_, _) => const DashboardScreen()),
    GoRoute(
      path: '/courses',
      builder: (_, state) =>
          CoursesScreen(subjectId: state.uri.queryParameters['subjectId']),
    ),
    GoRoute(
      path: '/courses/:id',
      builder: (_, state) =>
          CourseDetailScreen(id: state.pathParameters['id']!),
    ),
    GoRoute(path: '/subjects', builder: (_, _) => const SubjectsScreen()),
    GoRoute(
      path: '/subjects/:id',
      builder: (_, state) =>
          SubjectDetailScreen(id: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/exercises',
      builder: (_, state) =>
          ExercisesScreen(subjectId: state.uri.queryParameters['subjectId']),
    ),
    GoRoute(
      path: '/exercises/:id',
      builder: (_, state) =>
          ExerciseDetailScreen(id: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/corrections/:id',
      builder: (_, state) =>
          CorrectionDetailScreen(id: state.pathParameters['id']!),
    ),
    GoRoute(path: '/quiz', builder: (_, _) => const QuizzesScreen()),
    GoRoute(
      path: '/quiz/:id',
      builder: (_, state) => QuizPlayScreen(id: state.pathParameters['id']!),
    ),
    GoRoute(path: '/progress', builder: (_, _) => const ProgressScreen()),
    GoRoute(path: '/profile', builder: (_, _) => const ProfileScreen()),
  ],
  errorBuilder: (_, _) =>
      const Scaffold(body: Center(child: Text('Page introuvable.'))),
);
