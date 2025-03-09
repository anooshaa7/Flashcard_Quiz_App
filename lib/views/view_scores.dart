import 'package:flutter/material.dart';
class ViewScoresScreen extends StatelessWidget {
  final List<Map<String, String>> flashcards;
  ViewScoresScreen({required this.flashcards});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View Scores')),
      body: ListView.builder(
        itemCount: flashcards.length,
        itemBuilder: (context, index) {
          int totalScore = flashcards.length;
          int obtainedScore = (totalScore * 0.7).toInt(); // Example calculation
          double percentage = (obtainedScore / totalScore);
          return ListTile(
            title: Text('${flashcards[index]['subject']} - Score: $obtainedScore/$totalScore'),
            subtitle: LinearProgressIndicator(value: percentage, backgroundColor: Colors.grey, color: Colors.green),
          );
        },
      ),
    );
  }
}
