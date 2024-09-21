import 'package:flutter/material.dart';

class NoteCalculatorPage extends StatefulWidget {
  const NoteCalculatorPage({super.key});

  @override
  State<NoteCalculatorPage> createState() => _NoteCalculatorPageState();
}

class _NoteCalculatorPageState extends State<NoteCalculatorPage> {
  final _laboratory = TextEditingController();
  final _firstNote = TextEditingController();
  final _secondNote = TextEditingController();
  final _finalProjectNote = TextEditingController();
  double _finalNote = 0;

  bool _error = false;
  String _errorMessage = '';

  bool _calculateNotePressed = false;

  bool _validateNotes() {
    if (_laboratory.text.isEmpty ||
        double.parse(_laboratory.text.replaceAll(',', '.')) < 0 ||
        double.parse(_laboratory.text.replaceAll(',', '.')) > 5) {
      setState(() {
        _error = true;
        _errorMessage =
            'Por favor verifique el valor ingresado para la nota de laboratorio';
      });
      return false;
    }
    if (_firstNote.text.isEmpty ||
        double.parse(_firstNote.text.replaceAll(',', '.')) < 0 ||
        double.parse(_firstNote.text.replaceAll(',', '.')) > 5) {
      setState(() {
        _error = true;
        _errorMessage =
            'Por favor verifique el valor ingresado para la primera entrega del proyecto final';
      });
      return false;
    }
    if (_secondNote.text.isEmpty ||
        double.parse(_secondNote.text.replaceAll(',', '.')) < 0 ||
        double.parse(_secondNote.text.replaceAll(',', '.')) > 5) {
      setState(() {
        _error = true;
        _errorMessage =
            'Por favor verifique el valor ingresado para la segunda entrega del proyecto final';
      });
      return false;
    }
    if (_finalProjectNote.text.isEmpty ||
        double.parse(_finalProjectNote.text.replaceAll(',', '.')) < 0 ||
        double.parse(_finalProjectNote.text.replaceAll(',', '.')) > 5) {
      setState(() {
        _error = true;
        _errorMessage =
            'Por favor verifique el valor ingresado para la entrega del proyecto final';
      });
      return false;
    }
    setState(() {
      _error = false;
      _errorMessage = '';
    });
    return true;
  }

  void _calculateFinalNote() {
    setState(() {
      _calculateNotePressed = true;
      if (!_validateNotes()) {
        _finalNote = 0;
        return;
      }
      final laboratory = double.parse(_laboratory.text.replaceAll(',', '.'));
      final firstNote = double.parse(_firstNote.text.replaceAll(',', '.'));
      final secondNote = double.parse(_secondNote.text.replaceAll(',', '.'));
      final finalProjectNote =
          double.parse(_finalProjectNote.text.replaceAll(',', '.'));
      final finalNote = ((laboratory * 0.6) +
          (firstNote * 0.1) +
          (secondNote * 0.05) +
          (finalProjectNote * 0.25));
      _finalNote = (double.parse(finalNote.toStringAsFixed(2)));
    });
  }

  @override
  void dispose() {
    _laboratory.dispose();
    _firstNote.dispose();
    _secondNote.dispose();
    _finalProjectNote.dispose();
    super.dispose();
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 80,
                  height: 80,
                ),
                const SizedBox(height: 26),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Laboratorio (60%)',
                    prefixIcon: Icon(Icons.science),
                    helperText: '* Nota entre 0 y 5 ',
                  ),
                  keyboardType: TextInputType.number,
                  controller: _laboratory,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Primera entrega proyecto final (10%)',
                    helperText: '* Nota entre 0 y 5 ',
                    prefixIcon: Icon(Icons.assignment),
                  ),
                  keyboardType: TextInputType.number,
                  controller: _firstNote,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Segunda entrega proyecto final (5%)',
                    helperText: '* Nota entre 0 y 5 ',
                    prefixIcon: Icon(Icons.assignment),
                  ),
                  keyboardType: TextInputType.number,
                  controller: _secondNote,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Entrega proyecto final (25%)',
                    helperText: '* Nota entre 0 y 5 ',
                    prefixIcon: Icon(Icons.assignment),
                  ),
                  keyboardType: TextInputType.number,
                  controller: _finalProjectNote,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _calculateFinalNote,
                  child: const Text('Calcular nota final'),
                ),
                const SizedBox(height: 16),
                Text(
                  _error && _calculateNotePressed
                      ? _errorMessage
                      : 'Nota final: $_finalNote',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: _error ? 14 : 24,
                    color: _error
                        ? Colors.red
                        : _finalNote >= 3
                            ? Colors.green
                            : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
