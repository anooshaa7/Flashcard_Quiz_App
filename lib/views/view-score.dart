import 'package:flashcardquiz/views/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ViewScoreScreen extends StatelessWidget {
  final int obtainedMarks;
  final int totalMarks;
  final List<Map<String, String>> incorrectAnswers;

  ViewScoreScreen({
    required this.obtainedMarks,
    required this.totalMarks,
    required this.incorrectAnswers,
  });
  String calculateGrade() {
    double percentage = (obtainedMarks / totalMarks) * 100;
    if (percentage >= 90) return 'A+';
    if (percentage >= 80) return 'A';
    if (percentage >= 70) return 'B';
    if (percentage >= 60) return 'C';
    if (percentage >= 50) return 'D';
    return 'F';
  }

  @override
  Widget build(BuildContext context) {
    double percentage = (obtainedMarks / totalMarks) * 100;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Progress', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.pop(context, HomeScreen());
        }, icon: Icon(CupertinoIcons.back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           Padding(
             padding: const EdgeInsets.all(10),
             child: Center(
               child: Card(
                 elevation: 2.0,
                 color: Colors.greenAccent.shade100,
                 child: Padding(
                   padding: const EdgeInsets.all(20),
                   child: Column(
                     children: [
                       Text(
                         'Obtained Marks: $obtainedMarks/$totalMarks',
                         style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                       ),
                       const SizedBox(height: 20),
                       Text(
                         'Percentage: ${percentage.toStringAsFixed(2)}%',
                         style: const TextStyle(fontSize: 20),
                       ),
                       const SizedBox(height: 20),
                       Text(
                         'Grade: ${calculateGrade()}',
                         style: const TextStyle(fontSize: 20),
                       ),
                     ],
                   ),
                 ),
               ),
             ),
           ),
            const SizedBox(height: 20),
            Divider(
              thickness: 5.0,
              color: Colors.black,
            ),
            if (incorrectAnswers.isNotEmpty)
              SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Incorrect Answers',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ...incorrectAnswers.map((answer) {
                      return ListTile(
                        title: Text('Question: ${answer['question']}', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),),
                        subtitle: Text('Answer: ${answer['answer']}', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),),
                      );
                    }).toList(),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}