import 'package:flutter/material.dart';
import 'exampage.dart';

class Quizly extends StatelessWidget {
  const Quizly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[350],
        appBar: AppBar(
          title: const Text('Quizly'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ExamPage(), // Ensure ExamPage starts with the first question
        ),
      ),
    );
  }
}