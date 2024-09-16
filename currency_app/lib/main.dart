import 'package:flutter/material.dart';
import 'pages/currency_conversion.dart';

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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          primarySwatch: Colors.teal,
          useMaterial3: true,
          ),
      home: const CurrencyConverterPage(),
    );
  }
}
