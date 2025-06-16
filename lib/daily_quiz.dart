import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../models/quiz_question.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

class DailyQuizScreen extends StatefulWidget {
  final String userName;

  const DailyQuizScreen({super.key, required this.userName});

  @override
  State<DailyQuizScreen> createState() => _DailyQuizScreenState();
}

class _DailyQuizScreenState extends State<DailyQuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _quizCompleted = false;
  bool _answerSelected = false;
  String? _selectedOption;
  List<QuizQuestion> _questions = [];
  bool _started = false;
  int _questionsPerDay = 3;
  int _quizFrequency = 1; // Number of times per day
  int _timeLeft = 15; // Timer duration in seconds
  Timer? _timer; // Timer instance

  @override
  void initState() {
    super.initState();
  }

  Future<void> _loadQuizQuestions() async {
    final questions = [
      QuizQuestion(
        question: "What is the purpose of a budget?",
        options: [
          "To track income and expenses",
          "To increase spending",
          "To avoid saving money",
          "To ignore financial goals",
        ],
        correctAnswer: "To track income and expenses",
      ),
      QuizQuestion(
        question: "Which of the following is a fixed expense?",
        options: ["Rent", "Groceries", "Entertainment", "Electricity bill"],
        correctAnswer: "Rent",
      ),
      QuizQuestion(
        question: "What does 'emergency fund' mean?",
        options: [
          "Money saved for unexpected expenses",
          "Money spent on vacations",
          "Money borrowed from friends",
          "Money invested in stocks",
        ],
        correctAnswer: "Money saved for unexpected expenses",
      ),
      QuizQuestion(
        question: "What is the best way to reduce debt?",
        options: [
          "Pay more than the minimum payment",
          "Ignore the debt",
          "Take on more loans",
          "Spend more on credit cards",
        ],
        correctAnswer: "Pay more than the minimum payment",
      ),
      QuizQuestion(
        question: "What is a good savings rate for your income?",
        options: ["20%", "50%", "5%", "80%"],
        correctAnswer: "20%",
      ),
      QuizQuestion(
        question: "Which of the following is a variable expense?",
        options: ["Groceries", "Rent", "Insurance", "Mortgage"],
        correctAnswer: "Groceries",
      ),
      QuizQuestion(
        question: "What is the primary benefit of saving money?",
        options: [
          "To prepare for emergencies",
          "To spend more on luxuries",
          "To avoid paying taxes",
          "To borrow less money",
        ],
        correctAnswer: "To prepare for emergencies",
      ),
      QuizQuestion(
        question: "How can you avoid impulse buying?",
        options: [
          "Create a shopping list",
          "Carry extra cash",
          "Shop without a plan",
          "Buy items on credit",
        ],
        correctAnswer: "Create a shopping list",
      ),
      QuizQuestion(
        question: "What is the recommended percentage of income to save?",
        options: ["10%", "30%", "50%", "70%"],
        correctAnswer: "10%",
      ),
      QuizQuestion(
        question: "Why is it important to track your expenses?",
        options: [
          "To identify unnecessary spending",
          "To increase your income",
          "To avoid paying bills",
          "To borrow more money",
        ],
        correctAnswer: "To identify unnecessary spending",
      ),
      QuizQuestion(
        question:
            "Which of the following is an example of a charitable expense?",
        options: [
          "Donating to a local church",
          "Buying groceries",
          "Paying rent",
          "Saving for retirement",
        ],
        correctAnswer: "Donating to a local church",
      ),
      QuizQuestion(
        question: "What is the best way to manage a loan?",
        options: [
          "Pay on time and avoid penalties",
          "Ignore the loan",
          "Take another loan to pay it off",
          "Spend the loan on luxuries",
        ],
        correctAnswer: "Pay on time and avoid penalties",
      ),
      QuizQuestion(
        question: "Why is it important to save for school fees in Uganda?",
        options: [
          "To avoid last-minute borrowing",
          "To spend on luxuries",
          "To avoid paying taxes",
          "To increase your income",
        ],
        correctAnswer: "To avoid last-minute borrowing",
      ),
      QuizQuestion(
        question: "What is the best way to save money on transport in Uganda?",
        options: [
          "Use public transport like taxis or boda bodas",
          "Buy a new car",
          "Walk long distances daily",
          "Take multiple loans for transport",
        ],
        correctAnswer: "Use public transport like taxis or boda bodas",
      ),
      QuizQuestion(
        question: "Why is it important to save for medical emergencies?",
        options: [
          "To avoid financial stress during emergencies",
          "To spend on luxuries",
          "To avoid paying taxes",
          "To borrow more money",
        ],
        correctAnswer: "To avoid financial stress during emergencies",
      ),
    ];

    // Shuffle the questions to make them random
    questions.shuffle();

    // Limit the number of questions based on _questionsPerDay
    setState(() => _questions = questions.take(_questionsPerDay).toList());
  }

  void _selectAnswer(String selectedOption) {
    if (_answerSelected) return;

    setState(() {
      _selectedOption = selectedOption;
      _answerSelected = true;

      if (selectedOption == _questions[_currentQuestionIndex].correctAnswer) {
        _score += 2; // Add 2 points for each correct answer
      }
    });

    _stopTimer(); // Stop the timer when an answer is selected
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _answerSelected = false;
        _selectedOption = null;
      });
      _startTimer(); // Restart the timer for the next question
    } else {
      setState(() => _quizCompleted = true);
      _stopTimer(); // Stop the timer when the quiz is completed
    }
  }

  Color _getOptionColor(String option) {
    if (!_answerSelected) return Colors.blue;

    final correct = _questions[_currentQuestionIndex].correctAnswer;
    if (option == correct) return Colors.green;
    if (option == _selectedOption) return Colors.red;
    return Colors.grey;
  }

  Widget _buildStartScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nfunayo Quiz!"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              width: 200,
              child: Lottie.asset('assets/animations/tick.json'),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "Set your daily quiz preferences",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("How many questions would you like to answer today?"),
            DropdownButton<int>(
              value: _questionsPerDay,
              onChanged:
                  (value) => setState(() => _questionsPerDay = value ?? 3),
              items:
                  [3, 5, 6, 7, 10]
                      .map(
                        // ignore: avoid_types_as_parameter_names
                        (num) => DropdownMenuItem(
                          value: num,
                          child: Text("$num Questions"),
                        ),
                      )
                      .toList(),
            ),
            const SizedBox(height: 10),
            const Text("How many times do you want to play per day?"),
            DropdownButton<int>(
              value: _quizFrequency,
              onChanged: (value) => setState(() => _quizFrequency = value ?? 1),
              items:
                  [1, 2, 3]
                      .map(
                        // ignore: avoid_types_as_parameter_names
                        (num) => DropdownMenuItem(
                          value: num,
                          child: Text("$num times/day"),
                        ),
                      )
                      .toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.play_arrow),
              label: const Text("Start Quiz"),
              onPressed: () async {
                await _loadQuizQuestions();
                setState(() {
                  _started = true;
                });
                _startTimer(); // Start the countdown timer
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_started) return _buildStartScreen();

    if (_questions.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_quizCompleted) {
      final bool passed =
          _score >= (_questions.length); // Pass if 50% or more correct

      return Scaffold(
        appBar: AppBar(
          title: const Text("Quiz Results"),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display animation based on pass/fail
              SizedBox(
                height: 200,
                child:
                    passed
                        ? Lottie.asset(
                          'assets/animations/trophy.json',
                          fit: BoxFit.contain,
                        )
                        : Lottie.asset(
                          'assets/animations/lost.json',
                          fit: BoxFit.contain,
                        ),
              ),
              const SizedBox(height: 20),
              // Display congratulatory or motivational message
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  passed
                      ? "Congratulations! 🎉 You passed the quiz!"
                      : "Don't give up! 💪 Try again to improve your score!",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Show the final accumulated points
              Text(
                "You scored $_score points.",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              // Retry or Finish buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _quizCompleted = false;
                        _currentQuestionIndex = 0;
                        _score = 0;
                        _answerSelected = false;
                        _selectedOption = null;
                        _startTimer(); // Restart the timer
                      });
                    },
                    child: const Text("Retry"),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _quizCompleted = false;
                        _currentQuestionIndex = 0;
                        _score = 0;
                        _answerSelected = false;
                        _selectedOption = null;
                        _started = false; // Return to the start screen
                      });
                    },
                    child: const Text("Finish"),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Quiz"),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              _started = false; // Return to the start screen
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 8.0,
              percent: (_currentQuestionIndex + 1) / _questions.length,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Lottie.asset('assets/animations/avatarx.json'),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Progress",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              progressColor: Colors.blue,
              backgroundColor: Colors.grey[300]!,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.lightbulb, color: Colors.amber),
                  SizedBox(width: 10),
                  Expanded(child: Text("Tip: Think like a money master 💰")),
                ],
              ),
            ),
            const SizedBox(height: 16),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder:
                  (Widget child, Animation<double> animation) =>
                      ScaleTransition(scale: animation, child: child),
              child: Text(
                "Q${_currentQuestionIndex + 1}/${_questions.length}: ${currentQuestion.question}",
                key: ValueKey(_currentQuestionIndex),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...currentQuestion.options.map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                  onPressed: () => _selectAnswer(option),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _getOptionColor(option),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        option,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      if (_answerSelected)
                        Icon(
                          option ==
                                  _questions[_currentQuestionIndex]
                                      .correctAnswer
                              ? Icons.check_circle
                              : (option == _selectedOption
                                  ? Icons.cancel
                                  : Icons.circle),
                          color:
                              option ==
                                      _questions[_currentQuestionIndex]
                                          .correctAnswer
                                  ? Colors.greenAccent
                                  : (option == _selectedOption
                                      ? Colors.redAccent
                                      : Colors.transparent),
                        ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 12),
            if (_answerSelected)
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text("Next"),
                  onPressed: _nextQuestion,
                ),
              ),
            Text(
              "Time Left: $_timeLeft seconds",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  void _startTimer() {
    _timeLeft = 30; // Reset timer to 30 seconds for each question
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft == 0) {
        _stopTimer();
        setState(() {
          _answerSelected = true; // Automatically mark the question as answered
        });
      } else {
        setState(() => _timeLeft--);
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
