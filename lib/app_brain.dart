// ignore_for_file: prefer_final_fields

import 'question.dart';

class AppBrain {
  int _qn = 0;

  List<Question> _questions = [
    Question(q: 'THERE ARE 8 PLANETS IN OUR SOLAR SYSTEM', i: 'images/image-1.jpg', a: true),
    Question(q: 'cats eat meat', i: 'images/image-2.jpg', a: true),
    Question(q: 'china is located in africa', i: 'images/image-3.jpg', a: false),
    Question(q: 'the earth is flat', i: 'images/image-4.jpg', a: false),
    Question(q: 'humans could survive without eating meat', i: 'images/image-5.jpg', a: true),
    Question(q: 'the sun turns around the earth and the earth turns around the moon', i: 'images/image-6.jpg', a: false),
    Question(q: 'animals do not feel pain', i: 'images/image-7.jpg', a: false),
  ];

  void nextQuestion() {
    if (_qn < _questions.length - 1) {
      _qn++;
    }
  }

  String getQuestionText() {
    return _questions[_qn].questionText;
  }

  String getQuestionImage() {
    return _questions[_qn].questionImage;
  }

  bool getQuestionAnswer() {
    return _questions[_qn].questionAnswer;
  }

  Map<String, dynamic> getSpecificQuestionAnswer(int index) {
    return {
      'question': _questions[index].questionText,
      'image': _questions[index].questionImage,
      'answer': _questions[index].questionAnswer,
    };
  }

  bool isFinished() {
    if (_qn >= _questions.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _qn = 0;
  }

  int totalQuestions() {
    return _questions.length;
  }
}