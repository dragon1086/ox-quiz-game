import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'quiz_screen.dart';
import 'quiz_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuizProvider(),
      child: MaterialApp(
        title: 'OX 퀴즈 게임',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const QuizScreen(),
      ),
    );
  }
}