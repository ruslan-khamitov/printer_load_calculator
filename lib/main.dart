import 'package:flutter/material.dart';
import 'package:printer_calculator/printer_calculator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Расчёт загрузки принтера',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PrinterCalculator(),
    );
  }
}