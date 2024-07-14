import 'package:flutter/material.dart';

class AnswerIcons extends StatelessWidget {
  final List<bool?> userAnswers;
  final List<bool> answerCorrectness;

  const AnswerIcons({
    required this.userAnswers,
    required this.answerCorrectness,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < userAnswers.length; i++)
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              answerCorrectness[i] ? Icons.check : Icons.close,
              color: answerCorrectness[i] ? Colors.green : Colors.red,
            ),
          ),
      ],
    );
  }
}