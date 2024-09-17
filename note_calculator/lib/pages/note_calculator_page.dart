import 'package:flutter/material.dart';

class MyWidgetPage extends StatefulWidget {
  const MyWidgetPage({super.key});

  @override
  State<MyWidgetPage> createState() => _MyWidgetPageState();
}

class _MyWidgetPageState extends State<MyWidgetPage> {
  final _laboratory = TextEditingController();
  final _firstNote = TextEditingController();
  double _finalNote = 0;

  void _calculateFinalNote() {
    if (_laboratory.text.isEmpty ||
        double.parse(_laboratory.text) < 0 ||
        double.parse(_laboratory.text) > 5) {
      _finalNote = 0;
      return;
    }
    final laboratory = double.parse(_laboratory.text);
    final firstNote = double.parse(_firstNote.text);
    final finalNote = ((laboratory * 0.6)+(firstNote * 0.1));
    //dejar con 2 decimales
    setState(() {
      _finalNote = (double.parse(finalNote.toStringAsFixed(2)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora nota final'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Laboratorio (60%)',
                ),
                keyboardType: TextInputType.number,
                controller: _laboratory,
                //minimo 0 maximo 5
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un valor';
                  }
                  if (double.parse(value) < 0 || double.parse(value) > 5) {
                    return 'La nota debe ser un valor entre 0 y 5';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Primera entrega proyecto final (10%)',
                ),
                keyboardType: TextInputType.number,
                controller: _firstNote,
                //minimo 0 maximo 5
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un valor';
                  }
                  if (double.parse(value) < 0 || double.parse(value) > 5) {
                    return 'La nota debe ser un valor entre 0 y 5';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _calculateFinalNote,
                child: const Text('Calcular nota final'),
              ),
              const SizedBox(height: 16),
              Text(
                'Nota final: $_finalNote',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
