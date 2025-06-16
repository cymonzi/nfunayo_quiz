import 'package:flutter/material.dart';
import '../daily_quiz.dart'; // Make sure this path points to your actual DailyQuizScreen

class QuizRoute extends StatelessWidget {
  const QuizRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const DailyQuizScreen(
      userName: '', // Pass actual username if available later
    );
  }
}
