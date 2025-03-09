import 'package:flashcardquiz/components/elevated_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'home_screen.dart';
class FlashCardScreen extends StatefulWidget {
  @override
  _FlashCardScreenState createState() => _FlashCardScreenState();
}

class _FlashCardScreenState extends State<FlashCardScreen> {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();
  final List<Map<String, String>> localFlashcards = [];

  void addFlashcard() {
    if (subjectController.text.isNotEmpty && questionController.text.isNotEmpty && answerController.text.isNotEmpty) {
      setState(() {
        localFlashcards.add({
          'subject': subjectController.text,
          'question': questionController.text,
          'answer': answerController.text.toLowerCase(),
        });
        questionController.clear();
        answerController.clear();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Mind Mapping', style: TextStyle(
          fontWeight: FontWeight.bold
        ),),
          centerTitle: true,
          leading: IconButton(onPressed: (){
            Navigator.pop(context , localFlashcards);
          }, icon: Icon(CupertinoIcons.back)),
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: subjectController,
               decoration: InputDecoration(
                 hintText: 'Enter Subject',
                 prefixIcon: Icon(CupertinoIcons.book_circle_fill),
                 focusedBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(10),
                   borderSide: BorderSide(color: Colors.greenAccent)
                 )
               ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: questionController,
                decoration: InputDecoration(
                    hintText: 'Enter Question',
                    prefixIcon: Icon(CupertinoIcons.question),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.greenAccent)
                    )
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: answerController,
                decoration: InputDecoration(
                    hintText: 'Enter Answer',
                    prefixIcon: Icon(CupertinoIcons.pencil_ellipsis_rectangle),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.greenAccent)
                    )
                ),
              ),
              const SizedBox(height: 30),
              ElevatedBtn(
                  onPressed: addFlashcard,
                  child: Text('Save FlashCard')),
            ],
          ),
        ),
      ),
    );
  }
}
