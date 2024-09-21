import 'package:flutter/material.dart';
import 'pages/note_calculator_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Convertidor de monedas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 4, 44, 6)),
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const NoteCalculatorPage(),
    );
  }
}
