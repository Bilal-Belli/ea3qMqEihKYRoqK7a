import 'package:flutter/material.dart';
import 'ProfileHomePage.dart';
import 'QuizzApp.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Combined App',
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.white;
    return Scaffold(
      appBar: AppBar(
        title: const Text('TP1', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfileHomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                ),
                label: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Profile Card',
                    style: TextStyle(fontSize: 18, color: textColor),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 300,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QuizzApp()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                ),
                label: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Quiz',
                    style: TextStyle(fontSize: 18, color: textColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}