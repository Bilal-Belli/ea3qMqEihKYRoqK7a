import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../screens/QuizAppBLoC.dart';

class ThemeSelectionPageBLoC extends StatefulWidget {
  const ThemeSelectionPageBLoC({super.key});

  @override
  _ThemeSelectionPageBLoCState createState() => _ThemeSelectionPageBLoCState();
}

class _ThemeSelectionPageBLoCState extends State<ThemeSelectionPageBLoC> {
  List<dynamic> themes = [];

  @override
  void initState() {
    super.initState();
    _loadThemes();
  }

  Future<void> _loadThemes() async {
    final String data = await rootBundle.loadString('assets/data/questions.json');
    final Map<String, dynamic> jsonResult = json.decode(data);
    setState(() {
      themes = jsonResult['themes'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme'),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: themes.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(
                  themes[index]['theme'],
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizAppBLoC(theme: themes[index]),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}