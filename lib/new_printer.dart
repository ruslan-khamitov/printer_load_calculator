import 'package:flutter/material.dart';
import 'package:printer_calculator/models/printer.dart';
import 'package:printer_calculator/printer_result.dart';

class NewPrinter extends StatefulWidget {
  @override
  _NewPrinterState createState() => _NewPrinterState();
}

class _NewPrinterState extends State<NewPrinter> {
  Printer newPrinter;

  final _formKey = GlobalKey<FormState>();
  String name;
  String speed;
  String resource;
  String price;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Расчёт загрузки нового принтера'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Название принтера',
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Введите название принтера';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Скорость принтера (кол-во листов в минуту)',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Укажите скорость принтера';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        speed = value;
                      });
                    },

                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Ресурс картриджа (кол-во листов)',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Укажите ресурс картриджа';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        resource = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Стоимость картриджа',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Укажите стоимость картриджа';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        price = value;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: OutlineButton(
                        child: Text('Расчитать загрузку'),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            newPrinter = Printer(
                              name: name,
                              lpm: int.parse(speed),
                              cartridgeResource: int.parse(resource),
                              cartridgePrice: double.parse(price),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PrinterResult(
                                  printer: newPrinter,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  )
                ],
              )
            ),
          )
        ],
      ),
    );
  }
}