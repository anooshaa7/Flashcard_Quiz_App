import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_screen.dart';

class QuizScreen extends StatefulWidget {
  final List<Map<String, String>> flashcards;
  QuizScreen({required this.flashcards});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  int score = 0;
  int timeLeft = 30;
  Timer? timer;
  final TextEditingController answerController = TextEditingController();
  List<Map<String, String>> incorrectAnswers = []; // Track incorrect answers

  void checkAnswer() {
    final currentFlashcard = widget.flashcards[currentIndex];
    if (answerController.text.toLowerCase() == currentFlashcard['answer']) {
      score++;
    } else {
      // Add incorrect answer to the list
      incorrectAnswers.add({
        'question': currentFlashcard['question']!,
        'answer': currentFlashcard['answer']!,
      });
    }
    answerController.clear();
    nextQuestion();
  }

  void nextQuestion() {
    if (currentIndex < widget.flashcards.length - 1) {
      setState(() {
        currentIndex++;
        timeLeft = 30;
      });
      startTimer();
    } else {
      showResult();
    }
  }

  void showResult() {
    timer?.cancel();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Quiz Completed Successfully!'),
        duration: Duration(seconds: 2),
      ),
    );

    // Return quiz results to the previous screen (HomeScreen)
    Navigator.pop(context, {
      'obtainedMarks': score,
      'totalMarks': widget.flashcards.length,
      'incorrectAnswers': incorrectAnswers,
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        timer.cancel();
        nextQuestion();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.flashcards.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quiz')),
        body: const Center(child: Text('No Flashcards Available. Add Flashcards First.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Unlock the Power of Stats', style: TextStyle(
            fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Time left: $timeLeft sec',
              style: const TextStyle(fontSize: 18, color: Colors.red),
            ),
            const SizedBox(height: 10),
            Text(
              widget.flashcards[currentIndex]['question']!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: answerController,
              decoration: const InputDecoration(labelText: 'Your Answer'),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent.shade200,
                      foregroundColor: Colors.white
                  ),
                  onPressed: currentIndex > 0
                      ? () {
                    setState(() {
                      currentIndex--;
                      timeLeft = 30;
                    });
                    startTimer();
                  }
                      : null,
                  child: const Text('Previous'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent.shade200,
                      foregroundColor: Colors.white
                  ),
                  onPressed: checkAnswer,
                  child: Text(currentIndex < widget.flashcards.length - 1 ? 'Next' : 'Done'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}