import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../businessLogic/blocs/QuizBLoC.dart';
import '../../businessLogic/events/QuizEvent.dart';
import '../../businessLogic/states/QuizState.dart';
import '../pages/ResultPage.dart';

class QuizAppBLoC extends StatelessWidget {
  final Map<String, dynamic> theme;

  const QuizAppBLoC({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizBloc()..add(LoadQuestions(theme)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(theme['theme']),
          centerTitle: true,
          backgroundColor: Colors.purpleAccent,
        ),
        body: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) {
            if (state is QuizLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is QuizLoaded) {
              final currentQuestion = state.questions[state.currentQuestionIndex];
              final userAnswer = state.answers[state.currentQuestionIndex];
              const textColor = Colors.white;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  Image.asset(
                    'assets/images/${theme['theme']}.png',
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
                          style:  ButtonStyle(
                            backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
                              if (userAnswer == null) return null;
                              if (userAnswer == "True" && currentQuestion['isCorrect'] == true) {
                                return Colors.green;
                              }
                              if (userAnswer == "True" && currentQuestion['isCorrect'] == false) {
                                return Colors.red;
                              }
                              return null;
                            }),
                            fixedSize: WidgetStateProperty.all(const Size(130, 50)), // Button size
                            side: WidgetStateProperty.resolveWith<BorderSide?>((states) {
                              return userAnswer == null
                                  ? const BorderSide(color: Colors.pinkAccent)
                                  : null; // Add border when no answer is selected
                            }),
                          ),
                          onPressed: userAnswer == null
                              ? () {
                                  context.read<QuizBloc>().add(SubmitAnswer(true));
                                }
                              : null,
                          child: Text("True", style: TextStyle(color: userAnswer == null ? Colors.black : Colors.white,)),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
                              if (userAnswer == null) return null;
                              if (userAnswer == "False" && currentQuestion['isCorrect'] == false) {
                                return Colors.green;
                              }
                              if (userAnswer == "False" && currentQuestion['isCorrect'] == true) {
                                return Colors.red;
                              }
                              return null;
                            }),
                            fixedSize: WidgetStateProperty.all(const Size(130, 50)), // Button size
                            side: WidgetStateProperty.resolveWith<BorderSide?>((states) {
                              return userAnswer == null
                                  ? const BorderSide(color: Colors.pinkAccent)
                                  : null; // Add border when no answer is selected
                            }),
                          ),
                          onPressed: userAnswer == null
                              ? () {
                                  context.read<QuizBloc>().add(SubmitAnswer(false));
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
                        onPressed: state.currentQuestionIndex > 0
                            ? () {
                                context.read<QuizBloc>().add(PreviousQuestion());
                              }
                            : null,
                        label: const Text("Previous", style: TextStyle(color: textColor)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purpleAccent,
                          minimumSize: const Size(140, 40),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: state.currentQuestionIndex < state.questions.length - 1
                            ? () {
                                context.read<QuizBloc>().add(NextQuestion());
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
            } else if (state is QuizCompleted) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultPage(score: state.score),
                  ),
                );
              });
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: Text('Something went wrong!'));
            }
          },
        ),
      ),
    );
  }
}