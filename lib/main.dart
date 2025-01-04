import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'Question1/presentation/screens/QuizAppProviders.dart';
import 'Question2/presentation/pages/ThemeSelectionPageBLoC.dart';
import 'Question1/data/providers/QuizProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizProvider(),
      child: MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TP2', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
              width: 300,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                ),
                label: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Quiz avec Provider',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QuizAppProdivers(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 60,
              width: 300,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                ),
                label: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Quiz avec BLoC',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ThemeSelectionPageBLoC(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}