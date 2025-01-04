import 'package:flutter/material.dart';

class QuizProvider extends ChangeNotifier {
  List<dynamic> questions = [];
  int currentQuestionIndex = 0;
  List<String?> answers = List.filled(5, null);

  void setQuestions(List<dynamic> newQuestions) {
    questions = newQuestions;
    currentQuestionIndex = 0; // Ensure starting from the first question
    answers = List.filled(newQuestions.length, null); // Reset answers
    notifyListeners();
  }

  void submitAnswer(bool userChoice) {
    answers[currentQuestionIndex] = userChoice ? "True" : "False";
    notifyListeners();
  }

  bool isLastQuestion() {
    return currentQuestionIndex == questions.length - 1;
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      currentQuestionIndex--;
      notifyListeners();
    }
  }

  bool allQuestionsAnswered() {
    return answers.every((a) => a != null);
  }

  int calculateScore() {
    int score = 0;
    for (int i = 0; i < answers.length; i++) {
      if ((answers[i] == "True" && questions[i]['isCorrect'] == true) ||
          (answers[i] == "False" && questions[i]['isCorrect'] == false)) {
        score++;
      }
    }
    return score;
  }

  void resetQuiz() {
    questions = [];
    currentQuestionIndex = 0;
    answers = [];
    notifyListeners();
  }
}
