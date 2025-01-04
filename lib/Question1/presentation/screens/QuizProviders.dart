import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/ResultPage.dart';
import '../../data/providers/QuizProvider.dart';

class QuizProviders extends StatefulWidget {
  final Map<String, dynamic> theme;

  const QuizProviders({super.key, required this.theme});

  @override
  _QuizProvidersState createState() => _QuizProvidersState();
}

class _QuizProvidersState extends State<QuizProviders> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final quizProvider = Provider.of<QuizProvider>(context, listen: false);
      quizProvider.setQuestions(_getRandomQuestions(widget.theme['questions']));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.theme['theme']}" , style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<QuizProvider>(
            builder: (context, quizProvider, child) {
              if (quizProvider.questions.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              final currentQuestion = quizProvider.questions[quizProvider.currentQuestionIndex];
              final userAnswer = quizProvider.answers[quizProvider.currentQuestionIndex];
              const textColor = Colors.white;

              return Column(
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
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
                              final userAnswer = quizProvider.answers[quizProvider.currentQuestionIndex];
                              if (userAnswer == null) return null;
                              if (userAnswer == "True" && currentQuestion['isCorrect'] == true) return Colors.green;
                              if (userAnswer == "True" && currentQuestion['isCorrect'] == false) return Colors.red;
                              return null;
                            }),
                            fixedSize: WidgetStateProperty.all(const Size(130, 50)),
                            side: WidgetStateProperty.resolveWith<BorderSide?>((states) {
                              return userAnswer == null
                                  ? const BorderSide(color: Colors.purpleAccent)
                                  : null;
                            }),
                          ),
                          onPressed: userAnswer == null
                              ? () {
                            quizProvider.submitAnswer(true);
                            if (quizProvider.allQuestionsAnswered()) {
                              Future.delayed(const Duration(seconds: 2), () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ResultPage(score: quizProvider.calculateScore()),
                                  ),
                                );
                              });
                            } else {
                              Future.delayed(const Duration(seconds: 1), () {
                                quizProvider.nextQuestion();
                              });
                            }
                          }
                              : null,
                          child: Text("True", style: TextStyle(color: userAnswer == null ? Colors.black : Colors.white,)),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
                              final userAnswer = quizProvider.answers[quizProvider.currentQuestionIndex];
                              if (userAnswer == null) return null;
                              if (userAnswer == "False" && currentQuestion['isCorrect'] == false) return Colors.green;
                              if (userAnswer == "False" && currentQuestion['isCorrect'] == true) return Colors.red;
                              return null;
                            }),
                            fixedSize: WidgetStateProperty.all(const Size(130, 50)),
                            side: WidgetStateProperty.resolveWith<BorderSide?>((states) {
                              return userAnswer == null
                                  ? const BorderSide(color: Colors.purpleAccent)
                                  : null;
                            }),
                          ),
                          onPressed: userAnswer == null
                              ? () {
                            quizProvider.submitAnswer(true);
                            if (quizProvider.allQuestionsAnswered()) {
                              Future.delayed(const Duration(seconds: 2), () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ResultPage(score: quizProvider.calculateScore()),
                                  ),
                                );
                              });
                            } else {
                              Future.delayed(const Duration(seconds: 1), () {
                                quizProvider.nextQuestion();
                              });
                            }
                          }
                              : null,
                          child: Text("False", style: TextStyle(color: userAnswer == null ? Colors.black : Colors.white,)),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: quizProvider.currentQuestionIndex > 0
                            ? () {
                                quizProvider.previousQuestion();
                              }
                            : null,
                        label: const Text("Previous", style: TextStyle(color: textColor)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purpleAccent,
                          minimumSize: const Size(140, 40),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: quizProvider.currentQuestionIndex < 9
                            ? () {
                                quizProvider.nextQuestion();
                              }
                            : null,
                        label: const Text("Next", style: TextStyle(color: textColor)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purpleAccent,
                          minimumSize: const Size(140, 40),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
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
}