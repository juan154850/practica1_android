import 'package:flutter/material.dart';

class NoteCalculatorPage extends StatefulWidget {
  const NoteCalculatorPage({super.key});

  @override
  State<NoteCalculatorPage> createState() => _NoteCalculatorPageState();
}

class _NoteCalculatorPageState extends State<NoteCalculatorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora nota final',
            style: TextStyle(color: Colors.black)),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Text("Contenido de la app"),
        ),
      ),
    );
  }
}
