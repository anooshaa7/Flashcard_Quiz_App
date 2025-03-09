import 'package:flashcardquiz/views/view-score.dart';
import 'package:flutter/material.dart';
import 'package:flashcardquiz/views/start_quiz.dart';
import '../components/round_btn.dart';
import 'add_flashcard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> flashcards = [];
  Map<String, dynamic>? quizResults; // Store quiz results here

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Text(
                'Knowledge is Power – Let’s Unlock It',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Image.asset('images/quiz1.png'),
              const Text(
                'Crack Every Quiz, One Card at a Time!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FlashCardScreen(),
                        ),
                      );
                      if (result != null) {
                        setState(() {
                          flashcards.addAll(result);
                        });
                      }
                    },
                    child: RoundButton(
                      text: 'Add FlashCard',
                      image: Image.asset('images/quiz3.png', height: height * .07),
                    ),
                  ),
                  InkWell(
                    onTap: flashcards.isNotEmpty
                        ? () async {
                      final results = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizScreen(flashcards: flashcards)),
                          );
                          if (results != null) {
                        setState(() {
                          quizResults = results; // Store quiz results
                        });
                      }
                    }
                        : null,
                    child: RoundButton(
                      text: 'Start Quiz',
                      image: Image.asset('images/start-quiz.png', height: height * .07),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: quizResults != null
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewScoreScreen(
                        obtainedMarks: quizResults!['obtainedMarks'],
                        totalMarks: quizResults!['totalMarks'],
                        incorrectAnswers: quizResults!['incorrectAnswers'],
                      ),
                    ),
                  );
                }
                    : null,
                child: RoundButton(
                  text: 'View Score',
                  image: Image.asset('images/score.png', height: height * .07),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}