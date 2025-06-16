import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'routes/quiz_route.dart';

final GoRouter router = GoRouter(
  initialLocation: '/quiz',
  routes: [
    GoRoute(
      path: '/quiz',
      builder: (BuildContext context, GoRouterState state) {
        return const QuizRoute();
      },
    ),
  ],
);
