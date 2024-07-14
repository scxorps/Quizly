import 'package:flutter/material.dart';
import 'app_brain.dart';
import 'reviewanswers.dart';
import 'quizly.dart';

AppBrain appBrain = AppBrain();

class QuizFinishedPage extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;
  final List<bool?> userAnswers;
  final List<bool> answerCorrectness;

  const QuizFinishedPage({
    required this.correctAnswers,
    required this.totalQuestions,
    required this.userAnswers,
    required this.answerCorrectness,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Finished'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Quiz Finished!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Correct Answers: $correctAnswers / $totalQuestions',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewAnswersPage(
                      userAnswers: userAnswers,
                      answerCorrectness: answerCorrectness,
                    ),
                  ),
                );
              },
              child: Text('Review Answers'),
            ),
            ElevatedButton(
              onPressed: () {
                appBrain.reset();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Quizly(),
                  ),
                );
              },
              child: Text('Restart Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}