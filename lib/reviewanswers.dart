// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'app_brain.dart';
import 'quizly.dart';

class ReviewAnswersPage extends StatefulWidget {
  final List<bool?> userAnswers;
  final List<bool> answerCorrectness;

  const ReviewAnswersPage({
    required this.userAnswers,
    required this.answerCorrectness,
  });

  @override
  State<ReviewAnswersPage> createState() => _ReviewAnswersPageState();
}

class _ReviewAnswersPageState extends State<ReviewAnswersPage> {
  int currentQuestionIndex = 0;
  final AppBrain _appBrain = AppBrain();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Answers'),
      ),
      body: Container(
        color: Colors.grey[350], // Light grey background for the entire body
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter, // Align to the top
                  child: _buildQuestionDetails(),
                ),
              ),
              const SizedBox(height: 20), // Add space between question details and navigation buttons
              _buildNavigationButtons(), // Navigation buttons now placed separately
              const SizedBox(height: 20), // Add space between navigation buttons and Restart Quiz button
              _buildRestartButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: currentQuestionIndex > 0
                ? () {
                    setState(() {
                      currentQuestionIndex--;
                    });
                  }
                : null,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 252, 252, 252)), // Set color for the Previous button
              padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
              textStyle: WidgetStateProperty.all(
                const TextStyle(fontSize: 18),
              ),
            ),
            child: const Text('Previous'),
          ),
        ),
        const SizedBox(width: 20), // Add space between the buttons
        Expanded(
          child: ElevatedButton(
            onPressed: currentQuestionIndex < widget.userAnswers.length - 1
                ? () {
                    setState(() {
                      currentQuestionIndex++;
                    });
                  }
                : null,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Color.fromARGB(204, 150, 247, 182)), // Set color for the Next button
              padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
              textStyle: WidgetStateProperty.all(
                const TextStyle(fontSize: 18),
              ),
            ),
            child: const Text('Next'),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionDetails() {
    final currentQuestion = _appBrain.getSpecificQuestionAnswer(currentQuestionIndex);
    final isCorrect = widget.answerCorrectness[currentQuestionIndex];
    final userAnswer = widget.userAnswers[currentQuestionIndex];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start, // Align items to the top
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (currentQuestion['image'].isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Image.asset(
              currentQuestion['image'],
              width: 350, // Set the width to the screen width
              fit: BoxFit.contain,
            ),
          ),
        const SizedBox(height: 16.0),
        Container(
          height: 70,
          child: Text(
            currentQuestion['question'],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 50.0), // Add some space between the question and the answer
        Container(
          height: 120, // Fixed height for user answer and correct answer section
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 300, // Set a fixed width for the user answer
                child: Text(
                  'Your answer: ${userAnswer == true ? 'true' : 'false'}',
                  style: TextStyle(
                    color: isCorrect ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: 300,
                height: 80, // Set a fixed width for the correct answer
                child: Text(
                  'Correct answer: ${currentQuestion['answer'] ? 'true' : 'false'}',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRestartButton() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Theme.of(context).primaryColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
        child: TextButton(
          onPressed: () {
            _appBrain.reset();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Quizly()),
              (route) => false,
            );
          },
          child: const Text(
            'Restart Quiz',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
