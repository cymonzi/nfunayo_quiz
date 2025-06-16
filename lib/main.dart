import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // ✅ Add this
import 'daily_quiz.dart'; // Import your screens or routes
import 'package:go_router/go_router.dart'; // Import GoRouter

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // ✅ Use the options
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      routes: [
        // Define the routes for your app here
        GoRoute(
          path: '/',
          builder: (context, state) => const DailyQuizScreen(userName: ''),
        ),
        // Add other routes as needed
      ],
    );

    return MaterialApp.router(
      routerConfig: router,
      title: 'Nfunayo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
