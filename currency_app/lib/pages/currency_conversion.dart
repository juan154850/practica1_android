import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  final _amountController = TextEditingController();
  String _fromCurrency = 'MXN';
  String _toCurrency = 'COP';
  double? result;
  bool _isLoading = false;
  final formatter = NumberFormat("#,##0.00", "es_MX");
  final List<String> _currencies = ['USD', 'MXN', 'COP'];

  Future<void> _convertCurrency() async {
    if (_amountController.text.isEmpty ||
        double.tryParse(_amountController.text) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Por favor, ingrese un valor numérico válido.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    String apikey = "bad3ab9f1703d1673f27ba2e";
    String apiUrl =
        "https://v6.exchangerate-api.com/v6/$apikey/latest/$_fromCurrency";

    final resp = await http.get(Uri.parse(apiUrl));
    if (resp.statusCode == 200) {
      final rates = json.decode(resp.body)['conversion_rates'];
      setState(() {
        result =
            double.parse(_amountController.text) * (rates[_toCurrency] ?? 1.0);
      });
    } else {
      throw Exception('Failed to load exchange rate');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversión de monedas'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                    labelText: 'Cantidad a convertir',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(16)),
                style: const TextStyle(fontSize: 24),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    value: _fromCurrency,
                    items: _currencies.map((String currency) {
                      return DropdownMenuItem<String>(
                        value: currency,
                        child: Text(currency),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _fromCurrency = newValue!;
                      });
                    },
                  ),
                  const Text(
                    '  ->  ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButton<String>(
                    value: _toCurrency,
                    items: _currencies.map((String currency) {
                      return DropdownMenuItem<String>(
                        value: currency,
                        child: Text(currency),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _toCurrency = newValue!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: _convertCurrency,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Convertir',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        )),
              if (result != null)
                Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      '${_amountController.text} $_fromCurrency = ${formatter.format(result)} $_toCurrency',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
