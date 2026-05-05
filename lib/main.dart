
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const AgeCalculatorApp());
}

class AgeCalculatorApp extends StatelessWidget {
  const AgeCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Edad',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AgeCalculatorHomePage(),
    );
  }
}

class AgeCalculatorHomePage extends StatefulWidget {
  const AgeCalculatorHomePage({super.key});

  @override
  _AgeCalculatorHomePageState createState() => _AgeCalculatorHomePageState();
}

class _AgeCalculatorHomePageState extends State<AgeCalculatorHomePage> {
  DateTime? _birthDate;
  int? _years;
  int? _weeks;
  int? _days;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _birthDate = pickedDate;
        _calculateAge();
      });
    });
  }

  void _calculateAge() {
    if (_birthDate == null) {
      return;
    }
    final now = DateTime.now();
    final difference = now.difference(_birthDate!);

    _days = difference.inDays;
    _weeks = (_days! / 7).floor();
    _years = (_days! / 365.25).floor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Edad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ElevatedButton(
              onPressed: _presentDatePicker,
              child: const Text('Selecciona tu fecha de nacimiento'),
            ),
            const SizedBox(height: 20),
            if (_birthDate != null)
              Text(
                'Fecha de nacimiento: ${DateFormat.yMd().format(_birthDate!)}',
                style: const TextStyle(fontSize: 18),
              ),
            const SizedBox(height: 20),
            if (_years != null)
              Text(
                'Años: $_years',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            if (_weeks != null)
              Text(
                'Semanas: $_weeks',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            if (_days != null)
              Text(
                'Días: $_days',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
