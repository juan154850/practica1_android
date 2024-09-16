import 'package:flutter/material.dart';

class NoteCalculatorPage extends StatefulWidget {
  const NoteCalculatorPage({super.key});

  @override
  State<NoteCalculatorPage> createState() => _NoteCalculatorPageState();
}

class _NoteCalculatorPageState extends State<NoteCalculatorPage> {
  bool isCalculating = false;
  double laboratory = 0.0;
  double firstProject = 0.0;
  double secondProject = 0.0;
  double finalProject = 0.0;

  double calculateFinalNote(double laboratory, double firstProject,
      double secondProject, double finalProject) {
    setState(() {
      isCalculating = true;
    });

    double result;
    if ((laboratory != 0) &&
        (firstProject != 0) &&
        (secondProject != 0) &&
        (finalProject != 0)) {
      result = (laboratory * 0.6) +
          (firstProject * 0.1) +
          (secondProject * 0.08) +
          (finalProject * 0.25);
    } else {
      result = 0.0;
    }

    setState(() {
      isCalculating = false;
    });

    return result;
  }

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
          child: Column(
            children: [
              SizedBox(height: 20.0),
              //input de la primera nota
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nota de laboratorio',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
