import 'package:flutter/material.dart';

class Question {
  final String questionText;
  final bool answer;

  Question(this.questionText, this.answer);
}

class QuizProvider extends ChangeNotifier {
  final List<Question> _questions = [
    Question('대한민국의 수도는 서울이다.', true),
    Question('지구는 태양계에서 세 번째로 큰 행성이다.', false),
    Question('인간의 심장은 주먹만한 크기이다.', true),
    Question('남극에도 우편번호가 있다.', true),
    Question('피라미드는 노예들이 만들었다.', false),
    Question('사람의 뼈는 206개이다.', true),
    Question('낙타의 혹에는 물이 저장되어 있다.', false),
    Question('모든 포유류는 땀샘이 있다.', false),
    Question('번개는 위에서 아래로 친다.', false),
    Question('사람의 손가락 지문은 평생 변하지 않는다.', true),
  ];

  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isAnswered = false;
  bool? _lastAnswerCorrect;

  List<Question> get questions => List.unmodifiable(_questions);
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  bool get isAnswered => _isAnswered;
  bool? get lastAnswerCorrect => _lastAnswerCorrect;
  bool get isLastQuestion => _currentQuestionIndex == _questions.length - 1;
  int get remainingQuestions => _questions.length - _currentQuestionIndex;

  void checkAnswer(bool userAnswer) {
    if (_isAnswered) return;

    final correctAnswer = _questions[_currentQuestionIndex].answer;
    _lastAnswerCorrect = userAnswer == correctAnswer;

    if (_lastAnswerCorrect!) {
      _score++;
    }

    _isAnswered = true;
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      _isAnswered = false;
      _lastAnswerCorrect = null;
      notifyListeners();
    }
  }

  void restartQuiz() {
    _questions.shuffle();
    _currentQuestionIndex = 0;
    _score = 0;
    _isAnswered = false;
    _lastAnswerCorrect = null;
    notifyListeners();
  }

  int get finalScore => ((_score / _questions.length) * 100).round();
}
