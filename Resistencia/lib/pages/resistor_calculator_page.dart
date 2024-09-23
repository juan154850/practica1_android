import 'package:flutter/material.dart';

class ResistorCalculatorPage extends StatefulWidget {
  const ResistorCalculatorPage({Key? key}) : super(key: key);

  @override
  State<ResistorCalculatorPage> createState() => _ResistorCalculatorPageState();
}

class _ResistorCalculatorPageState extends State<ResistorCalculatorPage> {
  // Variables para almacenar la selección de las bandas
  Color? band1;
  Color? band2;
  Color? band3; // Solo se usa en resistencias de 5 o 6 bandas
  Color? multiplier;
  Color? tolerance; // Solo se usa en resistencias de 5 o 6 bandas
  Color? tempCoefficient; // Solo se usa en resistencias de 6 bandas
  double resistanceValue = 0.0;
  double tolerancia = 0.0;
  double ppm = 0.0;

  // Cantidad de bandas seleccionada (4, 5 o 6)
  int numberOfBands = 4;

  // Colores personalizados para oro y plata
  final Color gold = const Color(0xFFFFD700); // Color oro
  final Color silver = const Color(0xFFC0C0C0); // Color plata

  // Lista de colores disponibles para las bandas 1, 2, y 3 (si existe)
  final List<Color> bandColors = [
    Colors.black,
    Colors.brown,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.grey,
    Colors.white,
  ];

  // Lista de colores disponibles para el multiplicador (incluye oro y plata)
  final List<Color> multiplierColors = [
    Colors.black,
    Colors.brown,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.grey,
    Colors.white,
    const Color(0xFFFFD700), // Oro
    const Color(0xFFC0C0C0), // Plata
  ];

  // Lista de colores disponibles para la tolerancia (solo en resistencias de 4-5 bandas)
  final List<Color> toleranceColors = [
    const Color(0xFFFFD700), // Oro (5%)
    const Color(0xFFC0C0C0), // Plata (10%)
    Colors.brown, // 1%
    Colors.red, // 2%
    Colors.green, // 0.5%
    Colors.blue, // 0.25%
    Colors.purple, // 0.1%
    Colors.grey, // 0.05%
  ];

  // Lista de colores para el coeficiente de temperatura (solo en resistencias de 6 bandas)
  final List<Color> tempCoefficientColors = [
    Colors.brown, // 100 ppm
    Colors.red, // 50 ppm
    Colors.orange, // 15 ppm
    Colors.yellow, // 25 ppm
  ];

  // Mapa de valores asociados a cada color
  final Map<Color, int> colorValues = {
    Colors.black: 0,
    Colors.brown: 1,
    Colors.red: 2,
    Colors.orange: 3,
    Colors.yellow: 4,
    Colors.green: 5,
    Colors.blue: 6,
    Colors.purple: 7,
    Colors.grey: 8,
    Colors.white: 9,
  };

  // Mapa de multiplicadores asociados a los colores (incluye oro y plata)
  final Map<Color, double> multiplierValues = {
    Colors.black: 1,
    Colors.brown: 10,
    Colors.red: 100,
    Colors.orange: 1000,
    Colors.yellow: 10000,
    Colors.green: 100000,
    Colors.blue: 1000000,
    Colors.purple: 10000000,
    Colors.grey: 100000000,
    Colors.white: 1000000000,
    const Color(0xFFFFD700): 0.1, // Oro
    const Color(0xFFC0C0C0): 0.01, // Plata
  };

  final Map<Color, double> tol = {
    Colors.brown: 1,
    Colors.red: 2,
    Colors.green: 0.5,
    Colors.blue: 0.25,
    Colors.purple: 0.1,
    Colors.grey: 0.05,
  };

  final Map<Color, double> tc = {
    Colors.brown: 100,
    Colors.red: 50,
    Colors.orange: 15,
    Colors.yellow: 25
  };

  // Función para calcular el valor de la resistencia
  void calculateResistance() {
    if (band1 != null && band2 != null && multiplier != null) {
      int digit1 = colorValues[band1]!;
      int digit2 = colorValues[band2]!;
      double multiplierValue = multiplierValues[multiplier]!;

      // Para resistencias de 4 bandas
      if (numberOfBands == 4) {
        resistanceValue = (digit1 * 10 + digit2) * multiplierValue;
        // Actualiza tolerancia solo en resistencias de 4 bandas
        if (tolerance != null) {
          tolerancia = tol[tolerance]!;
        }
      }

      // Para resistencias de 5 bandas
      else if (numberOfBands == 5 && band3 != null) {
        int digit3 = colorValues[band3]!;
        resistanceValue =
            (digit1 * 100 + digit2 * 10 + digit3) * multiplierValue;
        // Actualiza tolerancia solo en resistencias de 5 bandas
        if (tolerance != null) {
          tolerancia = tol[tolerance]!;
        }
      }

      // Para resistencias de 6 bandas
      else if (numberOfBands == 6 && band3 != null) {
        int digit3 = colorValues[band3]!;
        resistanceValue =
            (digit1 * 100 + digit2 * 10 + digit3) * multiplierValue;
        // Actualiza tolerancia y ppm en resistencias de 6 bandas
        if (tolerance != null) {
          tolerancia = tol[tolerance]!;
        }
        if (tempCoefficient != null) {
          ppm = tc[tempCoefficient]!;
        }
      }

      // Actualiza el estado para reflejar los cambios en la interfaz
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Resistencias'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text('Selecciona el número de bandas'),
              DropdownButton<int>(
                value: numberOfBands,
                items: [4, 5, 6].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value bandas'),
                  );
                }).toList(),
                onChanged: (int? newValue) {
                  setState(() {
                    numberOfBands = newValue!;
                    band3 = null;
                    tolerance = null;
                    tempCoefficient = null;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              // Dropdowns para las bandas de colores
              const Text('Banda 1'),
              DropdownButton<Color>(
                value: band1,
                items: bandColors.map((Color color) {
                  return DropdownMenuItem<Color>(
                    value: color,
                    child: Container(
                      width: 100,
                      height: 20,
                      color: color,
                    ),
                  );
                }).toList(),
                onChanged: (Color? newValue) {
                  setState(() {
                    band1 = newValue;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              const Text('Banda 2'),
              DropdownButton<Color>(
                value: band2,
                items: bandColors.map((Color color) {
                  return DropdownMenuItem<Color>(
                    value: color,
                    child: Container(
                      width: 100,
                      height: 20,
                      color: color,
                    ),
                  );
                }).toList(),
                onChanged: (Color? newValue) {
                  setState(() {
                    band2 = newValue;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              // Banda 3 solo si es 5 o 6 bandas
              if (numberOfBands > 4)
                Column(
                  children: [
                    const Text('Banda 3'),
                    DropdownButton<Color>(
                      value: band3,
                      items: bandColors.map((Color color) {
                        return DropdownMenuItem<Color>(
                          value: color,
                          child: Container(
                            width: 100,
                            height: 20,
                            color: color,
                          ),
                        );
                      }).toList(),
                      onChanged: (Color? newValue) {
                        setState(() {
                          band3 = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),

              // Multiplicador
              const Text('Multiplicador'),
              DropdownButton<Color>(
                value: multiplier,
                items: multiplierColors.map((Color color) {
                  return DropdownMenuItem<Color>(
                    value: color,
                    child: Container(
                      width: 100,
                      height: 20,
                      color: color,
                    ),
                  );
                }).toList(),
                onChanged: (Color? newValue) {
                  setState(() {
                    multiplier = newValue;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              // Tolerancia para 4, 5 y 6 bandas
              if (numberOfBands > 3)
                Column(
                  children: [
                    const Text('Tolerancia'),
                    DropdownButton<Color>(
                      value: tolerance,
                      items: toleranceColors.map((Color color) {
                        return DropdownMenuItem<Color>(
                          value: color,
                          child: Container(
                            width: 100,
                            height: 20,
                            color: color,
                          ),
                        );
                      }).toList(),
                      onChanged: (Color? newValue) {
                        setState(() {
                          tolerance = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),

              // Coeficiente de temperatura solo si es una resistencia de 6 bandas
              if (numberOfBands == 6)
                Column(
                  children: [
                    const Text('Coeficiente de temperatura'),
                    DropdownButton<Color>(
                      value: tempCoefficient,
                      items: tempCoefficientColors.map((Color color) {
                        return DropdownMenuItem<Color>(
                          value: color,
                          child: Container(
                            width: 100,
                            height: 20,
                            color: color,
                          ),
                        );
                      }).toList(),
                      onChanged: (Color? newValue) {
                        setState(() {
                          tempCoefficient = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),

              // Botón para calcular
              ElevatedButton(
                onPressed: calculateResistance,
                child: const Text('Calcular'),
              ),
              const SizedBox(height: 16.0),

              // Mostrar el valor              de la resistencia calculada

              Text(
                'Valor de la resistencia: ${resistanceValue.toStringAsFixed(2)} Ω '
                '${tolerance != null ? "Tolerancia: ${tolerancia.toString()}%" : ""} '
                '${numberOfBands == 6 && tempCoefficient != null ? "Coeficiente de temperatura: ${ppm.toString()} ppm" : ""}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
