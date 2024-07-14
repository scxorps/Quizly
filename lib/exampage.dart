// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'app_brain.dart';
import 'answericons.dart';
import 'quizfinished.dart';

AppBrain appBrain = AppBrain();

class ExamPage extends StatefulWidget {
  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  List<Widget> answerResult = [];
  bool buttonsDisabled = false;
  List<bool?> userAnswers = [];
  List<bool> answerCorrectness = [];

  @override
  void initState() {
    super.initState();
    resetExam(); // Ensure the exam starts fresh when ExamPage initializes
  }

  void resetExam() {
    setState(() {
      userAnswers.clear();
      answerCorrectness.clear();
      answerResult.clear();
      buttonsDisabled = false;
      appBrain.reset(); // Reset the question index in AppBrain
    });
  }

  void checkAnswer(bool userAnswer) {
    bool correctAnswer = appBrain.getQuestionAnswer();
    setState(() {
      if (buttonsDisabled) return;

      userAnswers.add(userAnswer);
      answerCorrectness.add(userAnswer == correctAnswer);

      if (userAnswer == correctAnswer) {
        answerResult.insert(
          0,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Icon(Icons.check, color: Colors.green),
                SizedBox(width: 10),
                // Text(
                //   'Your answer is correct',
                //   style: TextStyle(color: Colors.green, fontSize: 18),
                // ),
              ],
            ),
          ),
        );
      } else {
        answerResult.insert(
          0,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Icon(Icons.close, color: Colors.red),
                SizedBox(width: 10),
                // Text(
                //   'Your answer is false',
                //   style: TextStyle(color: Colors.red, fontSize: 18),
                // ),
              ],
            ),
          ),
        );
      }
      buttonsDisabled = true;
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          answerResult.removeAt(0);
          buttonsDisabled = false;
          if (appBrain.isFinished()) {
            int correctAnswers = answerCorrectness.where((answer) => answer).length;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => QuizFinishedPage(
                  correctAnswers: correctAnswers,
                  totalQuestions: appBrain.totalQuestions(),
                  userAnswers: userAnswers,
                  answerCorrectness: answerCorrectness,
                ),
              ),
            );
          } else {
            appBrain.nextQuestion();
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 6,
          child: Column(
            children: [
              // AnswerIcons(
              //   userAnswers: userAnswers,
              //   answerCorrectness: answerCorrectness,
              // ),
              Image.asset(appBrain.getQuestionImage()),
              SizedBox(height: 20),
              Text(
                appBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: answerResult,
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
              child: Text(
                'true',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              onPressed: buttonsDisabled
                  ? null
                  : () {
                      checkAnswer(true);
                    },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 224, 53, 1),
                foregroundColor: Colors.white,
              ),
              child: Text(
                'false',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              onPressed: buttonsDisabled
                  ? null
                  : () {
                      checkAnswer(false);
                    },
            ),
          ),
        ),
      ],
    );
  }
}