// main.dart
import 'package:flutter/material.dart';
import 'quizly.dart';

void main() {
  runApp(QuizlyApp());
}

class QuizlyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizly',
      home: Quizly(),
    );
  }
}