import 'dart:math';
import 'package:flutter/material.dart';
import 'ResultPage.dart';

class QuizzPage extends StatefulWidget {
  final Map<String, dynamic> theme;

  const QuizzPage({super.key, required this.theme});

  @override
  QuizPageState createState() => QuizPageState();
}

class QuizPageState extends State<QuizzPage> {
  late List<dynamic> questions;
  int currentQuestionIndex = 0;
  List<String?> answers = List.filled(5, null); // List of answers

  @override
  void initState() {
    super.initState();
    questions = _getRandomQuestions(widget.theme['questions']);
  }

  List<dynamic> _getRandomQuestions(List<dynamic> allQuestions) {
    final random = Random();
    final List<dynamic> selectedQuestions = [];
    while (selectedQuestions.length < 5) {
      final question = allQuestions[random.nextInt(allQuestions.length)];
      if (!selectedQuestions.contains(question)) {
        selectedQuestions.add(question);
      }
    }
    return selectedQuestions;
  }

  void _submitAnswer(bool userChoice) {
    setState(() {
      answers[currentQuestionIndex] = userChoice ? "True" : "False";
    });
    if (answers.every((a) => a != null)) {
      Future.delayed(const Duration(seconds: 2), () {
        int score = 0;
        for (int i = 0; i < answers.length; i++) {
          if ((answers[i] == "True" && questions[i]['isCorrect'] == true) ||
              (answers[i] == "False" && questions[i]['isCorrect'] == false)) {
            score++;
          }
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(score: score),
          ),
        );
      });
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          if (currentQuestionIndex < questions.length - 1) {
            currentQuestionIndex++;
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.white;

    final currentQuestion = questions[currentQuestionIndex];
    final userAnswer = answers[
    currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.theme['theme']}", style: const TextStyle(color: Colors.white)
        ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Image.asset(
                'assets/images/${widget.theme['theme']}.png',
                height: 150,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  currentQuestion['questionText'],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: userAnswer == null
                            ? null
                            : (userAnswer == "True" &&
                            currentQuestion['isCorrect'] == true)
                            ? Colors
                            .green
                            : (userAnswer == "True" &&
                            currentQuestion['isCorrect'] == false)
                            ? Colors
                            .red
                            : null,
                        minimumSize: const Size(130, 50),
                        side: userAnswer == null
                            ? const BorderSide(
                            color: Colors
                                .pinkAccent)
                            : BorderSide.none,
                      ),
                      onPressed: userAnswer == null
                          ? () => _submitAnswer(true)
                          : () {},
                      child: Text(
                        "True",
                        style: TextStyle(
                          color: userAnswer == null ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: userAnswer == null
                            ? null
                            : (userAnswer == "False" && currentQuestion['isCorrect'] == false)
                            ? Colors.green
                            : (userAnswer == "False" && currentQuestion['isCorrect'] == true)
                            ? Colors.red
                            : null,
                        minimumSize: const Size(130, 50),
                        side: userAnswer == null
                            ? const BorderSide(color: Colors.pinkAccent)
                            : BorderSide.none,
                      ),
                      onPressed: userAnswer == null ? () => _submitAnswer(false) : () {},
                      child: Text(
                        "False",
                        style: TextStyle(
                          color: userAnswer == null ? Colors.black : Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: currentQuestionIndex > 0
                        ? () {
                      setState(() {
                        currentQuestionIndex--;
                      });
                    }
                        : null,
                    icon: Icon(Icons.arrow_back, color: textColor),
                    label: Text(
                      "Previous",
                      style: TextStyle(color: textColor),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      minimumSize: const Size(140, 40),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: currentQuestionIndex < 9
                        ? () {
                      setState(() {
                        currentQuestionIndex++;
                      });
                    }
                        : null,
                    label: Text(
                      "Next",
                      style: TextStyle(color: textColor),
                    ),
                    icon: Icon(Icons.arrow_forward, color: textColor),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      minimumSize: const Size(140, 40),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}