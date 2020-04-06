import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:printer_calculator/models/printer.dart';
import 'package:printer_calculator/new_printer.dart';
import 'package:printer_calculator/printer_result.dart';

class PrinterCalculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PrinterCalculatorState();
  }
}

class _PrinterCalculatorState extends State<PrinterCalculator> {
  List<Printer> printers = [
    Printer(
      name: 'Canon PIXMA MG2540S',
      lpm: 8,
      cartridgeResource: 180,
      cartridgePrice: 1299,
      img: 'assets/pixma.jpg',
    ),
    Printer(
      name: 'HP LaserJet Pro MFP M28w',
      lpm: 18,
      cartridgeResource: 1000,
      cartridgePrice: 4200,
      img: 'assets/hp.jpg',
    ),
    Printer(
      name: 'Xerox WorkCentre 3025BI',
      lpm: 20,
      cartridgeResource: 1500,
      cartridgePrice: 3850,
      img: 'assets/xerox.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Расчёт загрузки принтера'),
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: Text('Выберите принтер:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          CarouselSlider(
            autoPlay: true,
            aspectRatio: 2,
            height: 200,
            pauseAutoPlayOnTouch: Duration(seconds: 5),
            enlargeCenterPage: true,
            items: printers.map((printer) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            printer.img,
                            height: 100,
                          ),
                          Text(
                            printer.name,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          OutlineButton(
                            child: Text('Расчитать загрузку'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PrinterResult(
                                            printer: printer,
                                          )));
                            },
                          )
                        ],
                      ));
                },
              );
            }).toList(),
          ),
          Center(
            child: OutlineButton(
              child: Text('Посчитать загрузку для нового принтера'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewPrinter(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
