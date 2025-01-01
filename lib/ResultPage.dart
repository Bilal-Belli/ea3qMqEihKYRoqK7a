import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final int score;
  const ResultPage({super.key, required this.score});
  String _getComment() {
    if (score == 5) {
      return "Excellent !";
    } else if (score >= 4) {
      return "Well done";
    } else {
      return "Can do better";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Results", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Score : $score / 5",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              _getComment(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                minimumSize: const Size(140, 40),
              ),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              label: const Text(
                "Home",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}